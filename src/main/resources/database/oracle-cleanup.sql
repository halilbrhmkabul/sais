-- =========================================================================
-- SAIS - ORACLE TABLO TEMİZLEME SCRIPT'İ
-- =========================================================================
-- Bu script mevcut tüm SAIS tablolarını, sequence'leri ve constraint'leri siler
-- Hata: ORA-00942 (tablo bulunamıyor) durumunda kullanın
-- =========================================================================

-- SAIS_USER olarak bağlanın:
-- sqlplus SAIS_USER/Sais_PDB_123@localhost:1521/orclpdb

SET SERVEROUTPUT ON;

-- =========================================================================
-- 1. TÜM FOREIGN KEY CONSTRAINT'LERİ SİL
-- =========================================================================
BEGIN
   FOR c IN (SELECT constraint_name, table_name
             FROM user_constraints
             WHERE constraint_type = 'R')
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE "' || c.table_name || '" DROP CONSTRAINT "' || c.constraint_name || '"';
         DBMS_OUTPUT.PUT_LINE('Dropped FK: ' || c.constraint_name || ' from ' || c.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to drop FK: ' || c.constraint_name);
      END;
   END LOOP;
END;
/

-- =========================================================================
-- 2. TÜM TABLOLARI SİL
-- =========================================================================
BEGIN
   FOR t IN (SELECT table_name FROM user_tables ORDER BY table_name)
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE "' || t.table_name || '" CASCADE CONSTRAINTS PURGE';
         DBMS_OUTPUT.PUT_LINE('Dropped table: ' || t.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to drop table: ' || t.table_name || ' - ' || SQLERRM);
      END;
   END LOOP;
END;
/

-- =========================================================================
-- 3. TÜM SEQUENCE'LERİ SİL
-- =========================================================================
BEGIN
   FOR s IN (SELECT sequence_name FROM user_sequences ORDER BY sequence_name)
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE "' || s.sequence_name || '"';
         DBMS_OUTPUT.PUT_LINE('Dropped sequence: ' || s.sequence_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to drop sequence: ' || s.sequence_name);
      END;
   END LOOP;
END;
/

-- =========================================================================
-- 4. TÜM VIEW'LARI SİL (varsa)
-- =========================================================================
BEGIN
   FOR v IN (SELECT view_name FROM user_views ORDER BY view_name)
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP VIEW "' || v.view_name || '"';
         DBMS_OUTPUT.PUT_LINE('Dropped view: ' || v.view_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to drop view: ' || v.view_name);
      END;
   END LOOP;
END;
/

-- =========================================================================
-- 5. DOĞRULAMA
-- =========================================================================

PROMPT
PROMPT =========================================================================
PROMPT Temizlik Tamamlandı! Kontrol Ediliyor...
PROMPT =========================================================================
PROMPT

-- Kalan tablolar
PROMPT Kalan Tablolar:
SELECT COUNT(*) AS table_count FROM user_tables;
SELECT table_name FROM user_tables ORDER BY table_name;

PROMPT
-- Kalan sequence'ler
PROMPT Kalan Sequence'ler:
SELECT COUNT(*) AS sequence_count FROM user_sequences;
SELECT sequence_name FROM user_sequences ORDER BY sequence_name;

PROMPT
-- Kalan constraint'ler
PROMPT Kalan Constraint'ler:
SELECT COUNT(*) AS constraint_count FROM user_constraints WHERE constraint_type = 'R';

PROMPT
PROMPT =========================================================================
PROMPT Şimdi Spring Boot uygulamasını yeniden çalıştırabilirsiniz:
PROMPT mvn spring-boot:run
PROMPT =========================================================================

-- =========================================================================
-- ALTERNATIF: TEK TEK SİLME (Manuel)
-- =========================================================================
/*
-- Eğer script çalışmazsa manuel silin:

DROP TABLE "aile_fert_hastalik_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "aile_fert_engel_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "gelir_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "borc_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "gayrimenkul_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "tutanak_gorsel" CASCADE CONSTRAINTS PURGE;
DROP TABLE "muracaat_dokuman" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yardim_karar" CASCADE CONSTRAINTS PURGE;
DROP TABLE "muracaat_yardim_talep" CASCADE CONSTRAINTS PURGE;
DROP TABLE "aile_fert" CASCADE CONSTRAINTS PURGE;
DROP TABLE "tutanak_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "aile_maddi_durum" CASCADE CONSTRAINTS PURGE;
DROP TABLE "muracaat" CASCADE CONSTRAINTS PURGE;
DROP TABLE "kisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "personel" CASCADE CONSTRAINTS PURGE;
DROP TABLE "hesap_bilgisi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yardim_alt_tipi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yardim_dilimi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yardim_donemi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yardim_red_sebebi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "yakinlik_kodu" CASCADE CONSTRAINTS PURGE;
DROP TABLE "ozel_statu" CASCADE CONSTRAINTS PURGE;
DROP TABLE "meslek" CASCADE CONSTRAINTS PURGE;
DROP TABLE "hastalik" CASCADE CONSTRAINTS PURGE;
DROP TABLE "engelli_tipi" CASCADE CONSTRAINTS PURGE;
DROP TABLE "gelir_turu" CASCADE CONSTRAINTS PURGE;
DROP TABLE "borc_turu" CASCADE CONSTRAINTS PURGE;

-- Sequence'leri sil
DROP SEQUENCE hibernate_sequence;
*/
