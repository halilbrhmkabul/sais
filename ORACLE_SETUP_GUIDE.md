# SAIS - Oracle 19c Kurulum Rehberi

## 📋 İçindekiler

1. [Sistem Gereksinimleri](#sistem-gereksinimleri)
2. [Oracle 19c Kurulumu](#oracle-19c-kurulumu)
3. [Pluggable Database (PDB) Oluşturma](#pluggable-database-pdb-oluşturma)
4. [Kullanıcı ve Yetki Ayarları](#kullanıcı-ve-yetki-ayarları)
5. [SAIS Uygulaması Kurulumu](#sais-uygulaması-kurulumu)
6. [Doğrulama ve Test](#doğrulama-ve-test)
7. [Sorun Giderme](#sorun-giderme)

---

## 1. Sistem Gereksinimleri

### Donanım
- **RAM**: Minimum 8GB (Önerilen: 16GB+)
- **Disk**: 50GB boş alan (Oracle + Data)
- **CPU**: 2+ core

### Yazılım
- **İşletim Sistemi**:
  - Oracle Linux 7/8
  - Red Hat Enterprise Linux (RHEL) 7/8
  - CentOS 7/8
  - Windows Server 2016/2019 (Desteklenir ama Linux önerilir)
- **Oracle Database**: 19c Enterprise Edition
- **Java**: JDK 17 (LTS)
- **Maven**: 3.8+

---

## 2. Oracle 19c Kurulumu

### Linux Üzerinde Kurulum

#### Adım 1: Oracle Binaries İndirme
```bash
# Oracle resmi sitesinden indirin:
# https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html

# ZIP dosyasını /opt/oracle dizinine kopyalayın
sudo mkdir -p /opt/oracle
sudo unzip LINUX.X64_193000_db_home.zip -d /opt/oracle/product/19c/dbhome_1
```

#### Adım 2: Kernel Parametrelerini Ayarlama
```bash
# /etc/sysctl.conf dosyasına ekleyin:
sudo tee -a /etc/sysctl.conf > /dev/null <<EOF
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
EOF

# Parametreleri uygula
sudo sysctl -p
```

#### Adım 3: Oracle Kullanıcısı Oluşturma
```bash
sudo groupadd oinstall
sudo groupadd dba
sudo useradd -g oinstall -G dba -d /home/oracle oracle
sudo passwd oracle
```

#### Adım 4: Oracle Home ve Base Dizinleri
```bash
sudo mkdir -p /opt/oracle/product/19c/dbhome_1
sudo mkdir -p /opt/oracle/oradata
sudo chown -R oracle:oinstall /opt/oracle
sudo chmod -R 775 /opt/oracle
```

#### Adım 5: Environment Variables
```bash
# /home/oracle/.bash_profile dosyasına ekleyin
su - oracle
cat >> ~/.bash_profile <<'EOF'
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19c/dbhome_1
export ORACLE_SID=ORCLCDB
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
EOF

source ~/.bash_profile
```

#### Adım 6: Database Installation (Silent Mode)
```bash
cd $ORACLE_HOME
./runInstaller -silent -responseFile $ORACLE_HOME/install/response/db_install.rsp \
    oracle.install.option=INSTALL_DB_SWONLY \
    UNIX_GROUP_NAME=oinstall \
    INVENTORY_LOCATION=/opt/oracle/oraInventory \
    ORACLE_HOME=$ORACLE_HOME \
    ORACLE_BASE=$ORACLE_BASE \
    oracle.install.db.InstallEdition=EE \
    oracle.install.db.OSDBA_GROUP=dba \
    oracle.install.db.OSOPER_GROUP=dba \
    oracle.install.db.OSBACKUPDBA_GROUP=dba \
    oracle.install.db.OSDGDBA_GROUP=dba \
    oracle.install.db.OSKMDBA_GROUP=dba \
    oracle.install.db.OSRACDBA_GROUP=dba \
    DECLINE_SECURITY_UPDATES=true
```

---

## 3. Pluggable Database (PDB) Oluşturma

### Yöntem 1: SQL Script İle (Önerilen)

#### Adım 1: SYSDBA Olarak Bağlanma
```bash
sqlplus / as sysdba
```

#### Adım 2: Container Database Oluşturma (İlk Kez)
```sql
-- Eğer Container Database yoksa oluşturun
-- NOT: Genellikle Oracle kurulumunda ORCLCDB otomatik oluşturulur
```

#### Adım 3: Pluggable Database Oluşturma
```sql
-- PDB oluştur
CREATE PLUGGABLE DATABASE orclpdb
  ADMIN USER SAIS_ADMIN IDENTIFIED BY Sais_Admin_123
  FILE_NAME_CONVERT = ('/opt/oracle/oradata/ORCLCDB/', '/opt/oracle/oradata/ORCLPDB/');

-- PDB'yi aç
ALTER PLUGGABLE DATABASE orclpdb OPEN;

-- Otomatik açılmasını sağla
ALTER PLUGGABLE DATABASE orclpdb SAVE STATE;

-- Doğrulama
SELECT name, open_mode FROM v$pdbs;
```

#### Adım 4: PDB'ye Bağlanma
```sql
ALTER SESSION SET CONTAINER = orclpdb;
```

### Yöntem 2: DBCA (Database Configuration Assistant) İle

```bash
dbca -silent -createDatabase \
    -templateName General_Purpose.dbc \
    -gdbname ORCLCDB \
    -sid ORCLCDB \
    -responseFile NO_VALUE \
    -characterSet AL32UTF8 \
    -sysPassword Oracle_123 \
    -systemPassword Oracle_123 \
    -createAsContainerDatabase true \
    -numberOfPDBs 1 \
    -pdbName orclpdb \
    -pdbAdminPassword Sais_Admin_123 \
    -databaseType MULTIPURPOSE \
    -memoryMgmtType auto_sga \
    -totalMemory 2048 \
    -storageType FS \
    -datafileDestination /opt/oracle/oradata \
    -emConfiguration NONE
```

---

## 4. Kullanıcı ve Yetki Ayarları

### Adım 1: SAIS_USER Oluşturma

```sql
-- PDB'ye bağlan
ALTER SESSION SET CONTAINER = orclpdb;

-- Kullanıcı oluştur
CREATE USER SAIS_USER IDENTIFIED BY Sais_PDB_123
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON USERS;

-- Temel yetkiler
GRANT CONNECT TO SAIS_USER;
GRANT RESOURCE TO SAIS_USER;
GRANT CREATE SESSION TO SAIS_USER;
GRANT CREATE TABLE TO SAIS_USER;
GRANT CREATE VIEW TO SAIS_USER;
GRANT CREATE SEQUENCE TO SAIS_USER;
GRANT CREATE PROCEDURE TO SAIS_USER;
GRANT CREATE TRIGGER TO SAIS_USER;

-- Geliştirme ortamı için DBA (PRODUCTION'da kaldırın!)
GRANT DBA TO SAIS_USER;

-- Doğrulama
SELECT username, default_tablespace, account_status
FROM dba_users
WHERE username = 'SAIS_USER';
```

### Adım 2: Bağlantı Testi
```bash
sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb
```

---

## 5. SAIS Uygulaması Kurulumu

### Adım 1: Projeyi Klonlama
```bash
git clone https://github.com/halilbrhmkabul/sais.git
cd sais
git checkout claude/review-project-011CUKqCTx9uZxFs9aGGNGUu
```

### Adım 2: application.yml Kontrolü
```bash
# Dosya zaten Oracle için yapılandırılmış olmalı
cat src/main/resources/application.yml
```

**Kontrol Edilecekler:**
```yaml
datasource:
  url: jdbc:oracle:thin:@localhost:1521/orclpdb
  username: SAIS_USER
  password: Sais_PDB_123
  driver-class-name: oracle.jdbc.OracleDriver

jpa:
  hibernate:
    ddl-auto: create  # İlk çalıştırma için
  properties:
    hibernate:
      dialect: org.hibernate.dialect.Oracle12cDialect
      default_schema: SAIS_USER
```

### Adım 3: Maven Build
```bash
# Clean install
mvn clean install -DskipTests

# Test dahil build
mvn clean install
```

### Adım 4: İlk Çalıştırma (Tablo Oluşturma)
```bash
# Spring Boot çalıştır
mvn spring-boot:run

# Logları izleyin:
# ✓ "HikariPool-1 - Start completed" - Bağlantı OK
# ✓ "Hibernate: create table..." - Tablolar oluşturuluyor (27 tablo)
# ✓ "Executing SQL script..." - Master data yükleniyor
# ✓ "Started SaisApplication" - Uygulama hazır
```

### Adım 5: Tarayıcıda Test
```
http://localhost:8080/sais
```

---

## 6. Doğrulama ve Test

### SQL Kontrolü

```sql
-- PDB'ye bağlan
sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb

-- Tabloları listele (27 tablo olmalı)
SELECT table_name FROM user_tables ORDER BY table_name;

-- Beklenen tablolar:
-- AILE_FERT
-- AILE_FERT_ENGEL_BILGISI
-- AILE_FERT_HASTALIK_BILGISI
-- AILE_MADDI_DURUM
-- BORC_BILGISI
-- BORC_TURU
-- ENGELLI_TIPI
-- GAYRIMENKUL_BILGISI
-- GELIR_BILGISI
-- GELIR_TURU
-- HASTALIK
-- HESAP_BILGISI
-- KISI
-- MESLEK
-- MURACAAT
-- MURACAAT_DOKUMAN
-- MURACAAT_YARDIM_TALEP
-- OZEL_STATU
-- PERSONEL
-- TUTANAK_BILGISI
-- TUTANAK_GORSEL
-- YARDIM_ALT_TIPI
-- YARDIM_DILIMI
-- YARDIM_DONEMI
-- YARDIM_KARAR
-- YARDIM_RED_SEBEBI
-- YAKINLIK_KODU

-- Sequence'leri kontrol et (Hibernate otomatik oluşturur)
SELECT sequence_name, last_number FROM user_sequences ORDER BY sequence_name;

-- Master data kontrolü
SELECT COUNT(*) FROM yakinlik_kodu;  -- 12 kayıt
SELECT COUNT(*) FROM meslek;          -- 15 kayıt
SELECT COUNT(*) FROM ozel_statu;      -- 8 kayıt
SELECT COUNT(*) FROM hastalik;        -- 10 kayıt
SELECT COUNT(*) FROM engelli_tipi;    -- 5 kayıt

-- Index'leri kontrol et
SELECT index_name, table_name FROM user_indexes ORDER BY table_name, index_name;
```

### Application Log Kontrolü

```bash
# Hibernate DDL logları
grep "Hibernate: create table" logs/spring.log

# Bağlantı kontrolü
grep "HikariPool" logs/spring.log

# Master data yükleme
grep "Executing SQL script" logs/spring.log

# Hata kontrolü
grep "ERROR" logs/spring.log
```

---

## 7. Sorun Giderme

### Problem 1: Bağlantı Hatası
```
Error: IO Error: The Network Adapter could not establish the connection
```

**Çözüm:**
```bash
# Listener durumunu kontrol et
lsnrctl status

# Listener başlat (gerekirse)
lsnrctl start

# PDB'nin açık olduğunu kontrol et
sqlplus / as sysdba
SELECT name, open_mode FROM v$pdbs;

# PDB kapalıysa aç
ALTER PLUGGABLE DATABASE orclpdb OPEN;
```

### Problem 2: ORA-01017: invalid username/password
```
Error: ORA-01017: invalid username/password; logon denied
```

**Çözüm:**
```sql
-- Kullanıcı var mı kontrol et
SELECT username, account_status FROM dba_users WHERE username = 'SAIS_USER';

-- Şifre sıfırlama
ALTER USER SAIS_USER IDENTIFIED BY Sais_PDB_123;

-- Hesabı unlock et (gerekirse)
ALTER USER SAIS_USER ACCOUNT UNLOCK;
```

### Problem 3: ORA-01950: no privileges on tablespace
```
Error: ORA-01950: no privileges on tablespace 'USERS'
```

**Çözüm:**
```sql
-- Quota ver
ALTER USER SAIS_USER QUOTA UNLIMITED ON USERS;
```

### Problem 4: Tablolar Oluşmuyor
```
Hibernate not creating tables
```

**Çözüm:**
```yaml
# application.yml kontrol
spring:
  jpa:
    hibernate:
      ddl-auto: create  # "none" değil, "create" olmalı
    properties:
      hibernate:
        default_schema: SAIS_USER  # Doğru schema
```

```sql
-- Current schema kontrol
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') FROM DUAL;
```

### Problem 5: ORA-00955: name is already used
```
Error: ORA-00955: name is already used by an existing object
```

**Çözüm:**
```sql
-- Tüm tabloları sil (dikkatli kullanın!)
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN ('TABLE','VIEW','PACKAGE','SEQUENCE','PROCEDURE','FUNCTION','INDEX'))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE' THEN
            EXECUTE IMMEDIATE 'DROP '||cur_rec.object_type||' "'||cur_rec.object_name||'" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '||cur_rec.object_type||' "'||cur_rec.object_name||'"';
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('FAILED: DROP '||cur_rec.object_type||' "'||cur_rec.object_name||'"');
      END;
   END LOOP;
END;
/

-- Uygulamayı yeniden çalıştır
mvn spring-boot:run
```

### Problem 6: Sequence Hatası
```
Error: could not extract ResultSet
```

**Çözüm:**
```sql
-- Sequence'leri manuel oluştur
CREATE SEQUENCE hibernate_sequence START WITH 1 INCREMENT BY 50;

-- Veya Hibernate'e bırak (önerilen)
-- Entity'lerde @GeneratedValue(strategy = GenerationType.SEQUENCE) olduğundan emin olun
```

---

## 8. Production Ayarları

### application.yml Güvenlik

```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: validate  # Production'da "create" değil "validate"

  datasource:
    # Şifreleri environment variable'dan al
    url: ${DB_URL}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
```

### Environment Variables

```bash
export DB_URL=jdbc:oracle:thin:@production-server:1521/orclpdb
export DB_USERNAME=SAIS_USER
export DB_PASSWORD=<strong-password>
```

### Backup Script

```bash
#!/bin/bash
# backup-sais.sh

export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCLCDB
export PATH=$ORACLE_HOME/bin:$PATH

# Backup dizini
BACKUP_DIR=/opt/oracle/backup
DATE=$(date +%Y%m%d_%H%M%S)

# PDB export
expdp SAIS_USER/Sais_PDB_123@orclpdb \
    DIRECTORY=BACKUP_DIR \
    DUMPFILE=sais_backup_$DATE.dmp \
    LOGFILE=sais_backup_$DATE.log \
    SCHEMAS=SAIS_USER \
    COMPRESSION=ALL

# 30 günden eski backupları sil
find $BACKUP_DIR -name "sais_backup_*.dmp" -mtime +30 -delete
```

---

## 9. Performans İzleme

### AWR Report

```sql
-- Son 1 saatlik AWR raporu
@$ORACLE_HOME/rdbms/admin/awrrpt.sql
```

### Session İzleme

```sql
-- Aktif sessionlar
SELECT s.username, s.machine, s.program, s.status, s.sql_id
FROM v$session s
WHERE s.username = 'SAIS_USER';

-- Long running queries
SELECT sql_id, elapsed_time/1000000 AS elapsed_secs, sql_text
FROM v$sql
WHERE parsing_schema_name = 'SAIS_USER'
  AND elapsed_time > 10000000  -- 10 saniyeden uzun
ORDER BY elapsed_time DESC;
```

### Tablespace Kullanımı

```sql
SELECT
    tablespace_name,
    ROUND(SUM(bytes)/1024/1024, 2) AS used_mb,
    ROUND(MAX(bytes)/1024/1024, 2) AS max_mb
FROM user_ts_quotas
GROUP BY tablespace_name;
```

---

## 10. Kaynaklar

- **Oracle Docs**: https://docs.oracle.com/en/database/oracle/oracle-database/19/
- **Spring Boot + Oracle**: https://spring.io/guides/gs/accessing-data-jpa/
- **Hibernate Oracle**: https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html

---

## İletişim ve Destek

**Proje**: SAIS (Sosyal Yardım Bilgi Sistemi)
**Repository**: halilbrhmkabul/sais
**Branch**: claude/review-project-011CUKqCTx9uZxFs9aGGNGUu

---

**Son Güncelleme**: 2024
**Oracle Versiyonu**: 19c Enterprise Edition
**Java Versiyonu**: 17 LTS
**Spring Boot Versiyonu**: 3.2.0
