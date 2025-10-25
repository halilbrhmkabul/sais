-- =========================================================================
-- SOSYAL YARDIM BİLGİ SİSTEMİ (SAIS)
-- ORACLE 19c KURULUM SCRIPT'İ
-- =========================================================================
-- Bu script Oracle 19c PDB ortamında SAIS veritabanını hazırlar
-- Çalıştırma: SYSDBA yetkisi gereklidir
-- =========================================================================

-- =========================================================================
-- 1. PLUGGABLE DATABASE (PDB) OLUŞTURMA
-- =========================================================================

-- PDB oluştur (eğer yoksa)
CREATE PLUGGABLE DATABASE orclpdb
  ADMIN USER SAIS_ADMIN IDENTIFIED BY Sais_Admin_123
  FILE_NAME_CONVERT = ('/opt/oracle/oradata/ORCLCDB/', '/opt/oracle/oradata/ORCLPDB/');

-- PDB'yi aç
ALTER PLUGGABLE DATABASE orclpdb OPEN;

-- PDB'yi otomatik açılır yap
ALTER PLUGGABLE DATABASE orclpdb SAVE STATE;

-- =========================================================================
-- 2. PDB'YE BAĞLAN
-- =========================================================================

ALTER SESSION SET CONTAINER = orclpdb;

-- =========================================================================
-- 3. KULLANICI OLUŞTURMA
-- =========================================================================

-- Uygulama kullanıcısı oluştur
CREATE USER SAIS_USER IDENTIFIED BY Sais_PDB_123
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON USERS;

-- Yetkileri ver
GRANT CONNECT TO SAIS_USER;
GRANT RESOURCE TO SAIS_USER;
GRANT CREATE SESSION TO SAIS_USER;
GRANT CREATE TABLE TO SAIS_USER;
GRANT CREATE VIEW TO SAIS_USER;
GRANT CREATE SEQUENCE TO SAIS_USER;
GRANT CREATE PROCEDURE TO SAIS_USER;
GRANT CREATE TRIGGER TO SAIS_USER;

-- DBA yetkisi (geliştirme ortamı için - production'da kaldırılabilir)
GRANT DBA TO SAIS_USER;

-- =========================================================================
-- 4. SEQUENCE'LER (Hibernate Auto-generated)
-- =========================================================================
-- NOT: Hibernate GenerationType.SEQUENCE kullandığında otomatik oluşturulur
-- Ancak manuel oluşturmak isterseniz:

-- CREATE SEQUENCE hibernate_sequence START WITH 1 INCREMENT BY 50;

-- =========================================================================
-- 5. TABLO OLUŞTURMA (Hibernate DDL Auto)
-- =========================================================================
-- NOT: application.yml'de ddl-auto: create ayarlandığı için
-- Hibernate otomatik tablo oluşturacak
-- Ancak production ortamında manual DDL tercih edilirse aşağıdaki kullanılabilir:

/*
-- BaseEntity alanlarını içeren örnek tablo
CREATE TABLE kisi (
    id NUMBER(19) PRIMARY KEY,
    tc_kimlik_no VARCHAR2(11) NOT NULL UNIQUE,
    ad VARCHAR2(100) NOT NULL,
    soyad VARCHAR2(100) NOT NULL,
    baba_adi VARCHAR2(100),
    anne_adi VARCHAR2(100),
    dogum_tarihi DATE,
    dogum_yeri VARCHAR2(100),
    cinsiyet CHAR(1),
    medeni_durum VARCHAR2(20),
    adres CLOB,
    il VARCHAR2(50),
    ilce VARCHAR2(50),
    mahalle VARCHAR2(100),
    telefon VARCHAR2(20),
    email VARCHAR2(150),
    gebze_ikameti NUMBER(1) DEFAULT 1,
    sgk_durum VARCHAR2(50),
    ogrenim_durum VARCHAR2(50),
    son_mernis_sorgu_tarihi DATE,
    mernis_guncelleme_sayisi NUMBER(10) DEFAULT 0,
    olusturma_tarihi TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    guncelleme_tarihi TIMESTAMP,
    olusturan VARCHAR2(100),
    guncelleyen VARCHAR2(100),
    aktif NUMBER(1) DEFAULT 1
);

-- Index'ler
CREATE INDEX idx_kisi_tc ON kisi(tc_kimlik_no);
CREATE INDEX idx_kisi_son_mernis ON kisi(son_mernis_sorgu_tarihi);
*/

-- =========================================================================
-- 6. ORACLE-SPECIFIC OPTIMIZATIONS
-- =========================================================================

-- Tablespace boyutunu artır (gerekirse)
-- ALTER TABLESPACE USERS ADD DATAFILE '/opt/oracle/oradata/ORCLPDB/users02.dbf' SIZE 1G AUTOEXTEND ON;

-- Redo log boyutunu artır (gerekirse)
-- ALTER DATABASE ADD LOGFILE GROUP 4 ('/opt/oracle/oradata/ORCLPDB/redo04.log') SIZE 512M;

-- Archive log mode aktif et (backup için)
-- SHUTDOWN IMMEDIATE;
-- STARTUP MOUNT;
-- ALTER DATABASE ARCHIVELOG;
-- ALTER DATABASE OPEN;

-- =========================================================================
-- 7. PERFORMANS AYARLARI
-- =========================================================================

-- SGA (System Global Area) boyutunu artır
-- ALTER SYSTEM SET sga_target=2G SCOPE=SPFILE;

-- PGA (Program Global Area) boyutunu artır
-- ALTER SYSTEM SET pga_aggregate_target=1G SCOPE=SPFILE;

-- Paralel query aktif et
-- ALTER SYSTEM SET parallel_max_servers=8;

-- Statistics toplama job'ı aktif et
BEGIN
    DBMS_SCHEDULER.ENABLE('GATHER_STATS_JOB');
END;
/

-- =========================================================================
-- 8. GÜVENLİK AYARLARI
-- =========================================================================

-- Transparent Data Encryption (TDE) aktif et (gerekirse)
-- ALTER SYSTEM SET encryption_wallet_location='/opt/oracle/admin/ORCLPDB/wallet' SCOPE=SPFILE;

-- Audit logging aktif et
-- AUDIT ALL BY SAIS_USER BY ACCESS;

-- Password complexity policy (gerekirse)
-- ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- =========================================================================
-- 9. YEDEKLEME AYARLARI
-- =========================================================================

-- RMAN backup configuration
/*
RMAN> CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 30 DAYS;
RMAN> CONFIGURE CONTROLFILE AUTOBACKUP ON;
RMAN> CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
*/

-- Günlük otomatik backup job'ı oluştur
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'SAIS_DAILY_BACKUP',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN NULL; END;', -- RMAN script buraya eklenecek
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=2',
        enabled         => FALSE
    );
END;
/

-- =========================================================================
-- 10. MONİTORİNG VE LOGGING
-- =========================================================================

-- Alert log boyutunu sınırla
ALTER SYSTEM SET max_dump_file_size='1G';

-- SQL trace aktif et (geliştirme için)
-- ALTER SESSION SET sql_trace = TRUE;

-- AWR (Automatic Workload Repository) snapshot interval
-- EXEC DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(interval => 30);

-- =========================================================================
-- 11. BAĞLANTI KONTROLÜ
-- =========================================================================

-- Kullanıcı ile bağlan
-- sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb

-- Yetkileri kontrol et
-- SELECT * FROM session_privs ORDER BY privilege;

-- Tablespace kullanımını kontrol et
-- SELECT tablespace_name, bytes/1024/1024 AS mb FROM user_ts_quotas;

-- =========================================================================
-- 12. ÖRNEK VERİ YÜKLEME
-- =========================================================================

-- Master data script'i çalıştır (Hibernate otomatik yapacak)
-- @/path/to/master-data.sql

-- =========================================================================
-- KURULUM TAMAMLANDI
-- =========================================================================

SELECT 'SAIS Oracle 19c PDB kurulumu başarıyla tamamlandı!' AS status FROM DUAL;

-- Connection string kontrol
SELECT 'jdbc:oracle:thin:@localhost:1521/orclpdb' AS connection_string FROM DUAL;

-- User kontrol
SELECT 'SAIS_USER' AS username, 'Sais_PDB_123' AS password FROM DUAL;

-- =========================================================================
-- SORUN GİDERME
-- =========================================================================

/*
1. PDB durumunu kontrol et:
   SELECT name, open_mode FROM v$pdbs;

2. Listener durumunu kontrol et:
   lsnrctl status

3. Bağlantı test et:
   sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb

4. Tablolar oluştu mu kontrol et:
   SELECT table_name FROM user_tables ORDER BY table_name;

5. Sequence'ler kontrol et:
   SELECT sequence_name FROM user_sequences;

6. Hata logları:
   SELECT * FROM v$diag_alert_ext WHERE originating_timestamp > SYSDATE - 1;
*/
