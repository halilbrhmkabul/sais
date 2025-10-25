# SAIS - Oracle Sorun Giderme Rehberi

## 🔧 Hızlı Çözümler

### Hata: ORA-00942 - Tablo veya görüntü mevcut değil

#### Semptomlar
```
ORA-00942: tablo veya görüntü mevcut degil
JDBC exception executing SQL [...] from "SAIS_USER"."muracaat"
```

#### Kök Neden
Oracle'da tablo adları **case-sensitive** ve Hibernate naming strategy uyumsuzluğu:
- Hibernate: `"muracaat"` (küçük harf, tırnaklı) arıyor
- Oracle: `MURACAAT` (büyük harf) veya tablo yok

#### Çözüm 1: Tabloları Temizle ve Yeniden Oluştur (ÖNERİLEN)

```bash
# 1. Mevcut tabloları temizle
sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb @src/main/resources/database/oracle-cleanup.sql

# 2. application.yml'de globally_quoted_identifiers: true olduğunu kontrol et

# 3. Uygulamayı yeniden çalıştır
mvn spring-boot:run
```

#### Çözüm 2: Configuration Değişikliği

**application.yml**:
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: create-drop  # Geliştirme için
    properties:
      hibernate:
        globally_quoted_identifiers: true  # ÖNEMLI!
        default_schema: SAIS_USER
```

#### Çözüm 3: Manuel Tablo Kontrolü

```sql
-- Hangi tablolar var?
SELECT table_name FROM user_tables ORDER BY table_name;

-- Tablo adı case'i
SELECT table_name FROM user_tables WHERE UPPER(table_name) LIKE '%MURACAAT%';

-- Tablo yoksa, Hibernate DDL çalıştı mı kontrol et
-- Spring Boot loglarına bakın:
grep "create table" logs/spring.log
```

---

## 📋 Sık Karşılaşılan Hatalar

### 1. ORA-01017: invalid username/password

#### Semptomlar
```
ORA-01017: invalid username/password; logon denied
```

#### Çözüm
```sql
-- Kullanıcı var mı?
SELECT username, account_status FROM dba_users WHERE username = 'SAIS_USER';

-- Şifre sıfırla
ALTER USER SAIS_USER IDENTIFIED BY Sais_PDB_123;

-- Unlock et (gerekirse)
ALTER USER SAIS_USER ACCOUNT UNLOCK;
```

---

### 2. ORA-01950: no privileges on tablespace

#### Semptomlar
```
ORA-01950: no privileges on tablespace 'USERS'
```

#### Çözüm
```sql
-- Quota ver
ALTER USER SAIS_USER QUOTA UNLIMITED ON USERS;

-- Kontrol et
SELECT tablespace_name, bytes/1024/1024 AS mb_used, max_bytes/1024/1024 AS mb_max
FROM user_ts_quotas;
```

---

### 3. Listener Hatası

#### Semptomlar
```
IO Error: The Network Adapter could not establish the connection
```

#### Çözüm
```bash
# Listener durumu
lsnrctl status

# Listener başlat
lsnrctl start

# PDB durumu
sqlplus / as sysdba
SELECT name, open_mode FROM v$pdbs;

# PDB'yi aç
ALTER PLUGGABLE DATABASE orclpdb OPEN;
```

---

### 4. Sequence Hatası

#### Semptomlar
```
could not extract ResultSet
Table 'hibernate_sequence' doesn't exist
```

#### Çözüm
```sql
-- Hibernate sequence oluştur (gerekirse)
CREATE SEQUENCE hibernate_sequence START WITH 1 INCREMENT BY 50;

-- Veya entity'lerde sequence tanımla
@SequenceGenerator(name="my_seq", sequenceName="my_seq_name", allocationSize=1)
@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="my_seq")
```

---

### 5. Master Data Yüklenemedi

#### Semptomlar
```
Maddi durum bilgileri yüklenemedi
Tutanak bilgileri yüklenemedi
```

#### Kök Neden
Foreign key tablolar henüz oluşmamış veya master data yüklenmemiş.

#### Çözüm
```yaml
# application.yml
spring:
  jpa:
    defer-datasource-initialization: true  # ÖNEMLI!
  sql:
    init:
      mode: always
      data-locations: classpath:database/master-data.sql
      continue-on-error: true
```

```sql
-- Master data kontrol
SELECT COUNT(*) FROM yakinlik_kodu;  -- 12 olmalı
SELECT COUNT(*) FROM meslek;          -- 15 olmalı
SELECT COUNT(*) FROM ozel_statu;      -- 8 olmalı

-- Eksikse manuel yükle
@src/main/resources/database/master-data.sql
```

---

### 6. HikariCP Connection Timeout

#### Semptomlar
```
HikariPool-1 - Connection is not available, request timed out after 30000ms
```

#### Çözüm
```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 20  # Artır
      connection-timeout: 60000  # 60 saniye
      leak-detection-threshold: 60000
```

```sql
-- Aktif connection sayısı
SELECT COUNT(*) FROM v$session WHERE username = 'SAIS_USER';

-- Max connection limiti
SELECT value FROM v$parameter WHERE name = 'processes';
```

---

### 7. ORA-00955: name is already used

#### Semptomlar
```
ORA-00955: name is already used by an existing object
```

#### Çözüm
```bash
# Tüm tabloları temizle
sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb @src/main/resources/database/oracle-cleanup.sql

# Veya ddl-auto: create-drop kullan
```

---

## 🔍 Debug Stratejileri

### 1. Hibernate SQL Loglarını Aktifleştir

```yaml
logging:
  level:
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE
    org.springframework.jdbc.datasource.init: DEBUG
```

### 2. Oracle SQL Trace

```sql
-- Session için trace aktif et
ALTER SESSION SET sql_trace = TRUE;

-- Trace dosyası konumu
SELECT value FROM v$diag_info WHERE name = 'Default Trace File';
```

### 3. Spring Boot Actuator

```yaml
# pom.xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>

# application.yml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,env
```

```bash
# Health check
curl http://localhost:8080/sais/actuator/health

# Datasource bilgisi
curl http://localhost:8080/sais/actuator/metrics/hikaricp.connections.active
```

---

## 📊 Veritabanı Durumu Kontrol Komutları

### Tablo Kontrolü
```sql
-- Tüm tablolar
SELECT table_name FROM user_tables ORDER BY table_name;

-- Beklenen 27 tablo:
-- AILE_FERT, AILE_FERT_ENGEL_BILGISI, AILE_FERT_HASTALIK_BILGISI,
-- AILE_MADDI_DURUM, BORC_BILGISI, BORC_TURU, ENGELLI_TIPI,
-- GAYRIMENKUL_BILGISI, GELIR_BILGISI, GELIR_TURU, HASTALIK,
-- HESAP_BILGISI, KISI, MESLEK, MURACAAT, MURACAAT_DOKUMAN,
-- MURACAAT_YARDIM_TALEP, OZEL_STATU, PERSONEL, TUTANAK_BILGISI,
-- TUTANAK_GORSEL, YARDIM_ALT_TIPI, YARDIM_DILIMI, YARDIM_DONEMI,
-- YARDIM_KARAR, YARDIM_RED_SEBEBI, YAKINLIK_KODU

-- Tablo sayısı
SELECT COUNT(*) AS total_tables FROM user_tables;
```

### Constraint Kontrolü
```sql
-- Primary keys
SELECT constraint_name, table_name
FROM user_constraints
WHERE constraint_type = 'P'
ORDER BY table_name;

-- Foreign keys
SELECT constraint_name, table_name, r_constraint_name
FROM user_constraints
WHERE constraint_type = 'R'
ORDER BY table_name;

-- Unique constraints
SELECT constraint_name, table_name
FROM user_constraints
WHERE constraint_type = 'U'
ORDER BY table_name;
```

### Index Kontrolü
```sql
-- Tüm indexler
SELECT index_name, table_name, uniqueness
FROM user_indexes
ORDER BY table_name, index_name;

-- Örnek: idx_kisi_tc
SELECT index_name, column_name
FROM user_ind_columns
WHERE table_name = 'KISI'
ORDER BY column_position;
```

### Sequence Kontrolü
```sql
-- Tüm sequence'ler
SELECT sequence_name, last_number, increment_by
FROM user_sequences
ORDER BY sequence_name;

-- Hibernate sequence
SELECT * FROM user_sequences WHERE sequence_name = 'HIBERNATE_SEQUENCE';
```

### Veri Kontrolü
```sql
-- Master data kontrolü
SELECT 'yakinlik_kodu' AS tablo, COUNT(*) AS kayit_sayisi FROM yakinlik_kodu
UNION ALL
SELECT 'meslek', COUNT(*) FROM meslek
UNION ALL
SELECT 'ozel_statu', COUNT(*) FROM ozel_statu
UNION ALL
SELECT 'hastalik', COUNT(*) FROM hastalik
UNION ALL
SELECT 'engelli_tipi', COUNT(*) FROM engelli_tipi
UNION ALL
SELECT 'gelir_turu', COUNT(*) FROM gelir_turu
UNION ALL
SELECT 'borc_turu', COUNT(*) FROM borc_turu;

-- Beklenen sonuçlar:
-- yakinlik_kodu: 12
-- meslek: 15
-- ozel_statu: 8
-- hastalik: 10
-- engelli_tipi: 5
-- gelir_turu: 8
-- borc_turu: 6
```

---

## 🚨 Acil Durum Prosedürü

### Tüm Sistemi Sıfırla

```bash
# 1. Uygulamayı durdur
# Ctrl+C veya kill process

# 2. Veritabanını temizle
sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb <<EOF
@src/main/resources/database/oracle-cleanup.sql
EXIT;
EOF

# 3. application.yml'yi kontrol et
cat src/main/resources/application.yml | grep -A 20 "jpa:"

# Şunlar olmalı:
# ddl-auto: create-drop
# globally_quoted_identifiers: true
# default_schema: SAIS_USER

# 4. Uygulamayı başlat
mvn clean spring-boot:run

# 5. Logları izle
tail -f logs/spring.log | grep -E "(create table|Executing SQL|Started SaisApplication)"

# 6. Test et
curl http://localhost:8080/sais
```

---

## 📝 Doğrulama Checklist

### Başlamadan Önce
- [ ] Oracle PDB açık mı? `SELECT name, open_mode FROM v$pdbs;`
- [ ] Listener çalışıyor mu? `lsnrctl status`
- [ ] SAIS_USER var mı? `SELECT username FROM dba_users WHERE username='SAIS_USER';`
- [ ] Quota verilmiş mi? `SELECT * FROM user_ts_quotas;`

### Uygulama Başlatma
- [ ] HikariCP bağlandı mı? (Log: "HikariPool-1 - Start completed")
- [ ] Hibernate DDL çalıştı mı? (Log: "create table...")
- [ ] 27 tablo oluştu mu? `SELECT COUNT(*) FROM user_tables;`
- [ ] Master data yüklendi mi? (Log: "Executing SQL script")
- [ ] Uygulama başladı mı? (Log: "Started SaisApplication")

### Runtime Kontrol
- [ ] Sayfalar açılıyor mu? `http://localhost:8080/sais`
- [ ] Hata logu var mı? `grep ERROR logs/spring.log`
- [ ] Database connection aktif mi? `SELECT COUNT(*) FROM v$session WHERE username='SAIS_USER';`

---

## 🔗 Faydalı Komutlar

### Oracle PDB Yönetimi
```bash
# PDB listele
sqlplus / as sysdba
SELECT name, open_mode FROM v$pdbs;

# PDB aç
ALTER PLUGGABLE DATABASE orclpdb OPEN;

# PDB kapat
ALTER PLUGGABLE DATABASE orclpdb CLOSE;

# Otomatik açılsın
ALTER PLUGGABLE DATABASE orclpdb SAVE STATE;
```

### Listener Yönetimi
```bash
# Durum
lsnrctl status

# Başlat
lsnrctl start

# Durdur
lsnrctl stop

# Yeniden başlat
lsnrctl reload
```

### Log Dosyaları
```bash
# Spring Boot log
tail -f logs/spring.log

# Oracle alert log
tail -f $ORACLE_BASE/diag/rdbms/orclcdb/ORCLCDB/trace/alert_ORCLCDB.log

# Listener log
tail -f $ORACLE_BASE/diag/tnslsnr/$(hostname)/listener/trace/listener.log
```

---

## 📞 Yardım Al

### 1. Log Toplama
```bash
# Tüm logları bir dosyaya topla
{
    echo "=== SPRING BOOT LOG ==="
    tail -100 logs/spring.log
    echo ""
    echo "=== DATABASE STATUS ==="
    sqlplus -s SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb <<EOF
    SELECT table_name FROM user_tables ORDER BY table_name;
    SELECT sequence_name FROM user_sequences;
    EXIT;
EOF
    echo ""
    echo "=== APPLICATION.YML ==="
    cat src/main/resources/application.yml | grep -A 30 "jpa:"
} > troubleshooting-report.txt
```

### 2. Hata Raporlama
Şunları paylaşın:
- `troubleshooting-report.txt`
- Tam hata mesajı
- Ne yaptığınız (hangi adımlar)
- Oracle versiyonu: `SELECT * FROM v$version;`
- Java versiyonu: `java -version`

---

## ✅ En Sık Çözümler (TL;DR)

| Hata | Hızlı Çözüm |
|------|-------------|
| **ORA-00942** | `globally_quoted_identifiers: true` + `oracle-cleanup.sql` çalıştır |
| **ORA-01017** | `ALTER USER SAIS_USER IDENTIFIED BY Sais_PDB_123;` |
| **ORA-01950** | `ALTER USER SAIS_USER QUOTA UNLIMITED ON USERS;` |
| **Listener Error** | `lsnrctl start` + `ALTER PLUGGABLE DATABASE orclpdb OPEN;` |
| **Tablolar yok** | `ddl-auto: create-drop` + uygulamayı yeniden başlat |
| **Master data yok** | `defer-datasource-initialization: true` kontrol et |
| **Connection timeout** | `maximum-pool-size: 20` artır |

---

**Son Güncelleme**: 2024
**Oracle Versiyonu**: 19c
**Spring Boot**: 3.2.0
