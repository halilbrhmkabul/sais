-- =========================================================================
-- SOSYAL YARDIM BİLGİ SİSTEMİ (SAIS)
-- MASTER REFERANS VERİ YÜKLEME SCRIPT'İ
-- =========================================================================
-- Oracle 19c uyumlu versiyon
-- NOT: Bu script sadece ilk kez çalıştırılmalıdır (ddl-auto=create ile)
-- =========================================================================

-- NOT: ID değerleri manuel olarak veriliyor (1, 2, 3, ...)
-- Hibernate otomatik sequence'ler oluşturacak ve yeni kayıtlar için kullanacak
-- =========================================================================

-- 1. YAKINLIK KODLARI (MERNİS Standartları)
-- =========================================================================
INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, '01', 'Kendisi', 'Kendisi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, '02', 'Eşi', 'Eşi', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, '03', 'Annesi', 'Annesi', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, '04', 'Babası', 'Babası', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, '05', 'Oğlu', 'Oğlu', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, '06', 'Kızı', 'Kızı', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, '07', 'Kardeşi', 'Kardeşi', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, '08', 'Büyükanne', 'Büyükanne', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (9, '09', 'Büyükbaba', 'Büyükbaba', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (10, '10', 'Torun', 'Torun', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (11, '11', 'Gelin', 'Gelin', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (12, '12', 'Damat', 'Damat', 12, 1, SYSDATE, 'SYSTEM');


-- 2. MESLEK TANIMLARI
-- =========================================================================
INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'M001', 'İşsiz', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'M002', 'İşçi', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'M003', 'Memur', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'M004', 'Öğretmen', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'M005', 'Doktor', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'M006', 'Hemşire', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'M007', 'Mühendis', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'M008', 'Serbest Meslek', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'M009', 'Esnaf', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (10, 'M010', 'Emekli', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (11, 'M011', 'Ev Hanımı', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (12, 'M012', 'Öğrenci', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (13, 'M013', 'Çiftçi', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (14, 'M014', 'Şoför', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (id, kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES (15, 'M015', 'Güvenlik Görevlisi', 1, SYSDATE, 'SYSTEM');


-- 3. ÖZEL STATÜ TANIMLARI
-- =========================================================================
INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'OS001', 'Şehit Yakını', 'Şehit ailesi', 100, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'OS002', 'Gazi Yakını', 'Gazi ailesi', 90, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'OS003', 'Yetim', 'Anne veya baba kaybı', 80, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'OS004', 'Öksüz', 'Anne ve baba kaybı', 85, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'OS005', 'Dul', 'Eş kaybı', 70, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'OS006', 'Koruma Altında', 'ASPB koruma altında', 60, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (id, kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'OS007', 'Mülteci', 'Geçici koruma statüsü', 50, 1, SYSDATE, 'SYSTEM');


-- 4. ENGELLİ TİPİ TANIMLARI (Ana Tipler + Alt Tipler)
-- =========================================================================
-- Ana tipler
INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'ET001', 'Bedensel Engelli', NULL, 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'ET002', 'Görme Engelli', NULL, 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'ET003', 'İşitme Engelli', NULL, 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'ET004', 'Zihinsel Engelli', NULL, 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'ET005', 'Ruhsal/Psikolojik Engelli', NULL, 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'ET006', 'Süreğen Hastalık', NULL, 6, 1, SYSDATE, 'SYSTEM');

-- Alt Tipler (ust_tip_id sonra güncellenecek)
INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'ET001-01', 'Ortopedik Engelli', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'ET001-02', 'Omurilik Felci', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'ET002-01', 'Az Gören', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (10, 'ET002-02', 'Tamamen Görme Engelli', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (11, 'ET003-01', 'Az İşiten', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (12, 'ET003-02', 'Tamamen İşitme Engelli', 12, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (13, 'ET004-01', 'Hafif Zihinsel Engelli', 13, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (14, 'ET004-02', 'Orta Zihinsel Engelli', 14, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (15, 'ET004-03', 'Ağır Zihinsel Engelli', 15, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (16, 'ET005-01', 'Otizm', 16, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (17, 'ET005-02', 'Down Sendromu', 17, 1, SYSDATE, 'SYSTEM');


-- Alt tiplerin üst tiplerini bağlama
UPDATE engelli_tipi
SET ust_tip_id = (SELECT id FROM engelli_tipi WHERE kod = 'ET001' AND ROWNUM = 1)
WHERE kod LIKE 'ET001-%';

UPDATE engelli_tipi
SET ust_tip_id = (SELECT id FROM engelli_tipi WHERE kod = 'ET002' AND ROWNUM = 1)
WHERE kod LIKE 'ET002-%';

UPDATE engelli_tipi
SET ust_tip_id = (SELECT id FROM engelli_tipi WHERE kod = 'ET003' AND ROWNUM = 1)
WHERE kod LIKE 'ET003-%';

UPDATE engelli_tipi
SET ust_tip_id = (SELECT id FROM engelli_tipi WHERE kod = 'ET004' AND ROWNUM = 1)
WHERE kod LIKE 'ET004-%';

UPDATE engelli_tipi
SET ust_tip_id = (SELECT id FROM engelli_tipi WHERE kod = 'ET005' AND ROWNUM = 1)
WHERE kod LIKE 'ET005-%';


-- 5. HASTALIK TANIMLARI
-- =========================================================================
INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'H001', 'Şeker Hastalığı (Diyabet)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'H002', 'Tansiyon (Hipertansiyon)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'H003', 'Kalp Hastalığı', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'H004', 'Astım', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'H005', 'KOAH', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'H006', 'Böbrek Yetmezliği', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'H007', 'Kanser', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'H008', 'Epilepsi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'H009', 'Multiple Skleroz (MS)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (10, 'H010', 'Parkinson', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (11, 'H011', 'Alzheimer', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (12, 'H012', 'Talasemi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (13, 'H013', 'Hemofili', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (14, 'H014', 'Sedef Hastalığı', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (id, kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES (15, 'H015', 'Romatizma', 1, 1, SYSDATE, 'SYSTEM');


-- 6. GELİR TÜRÜ TANIMLARI
-- =========================================================================
INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'GT001', 'Maaş', 'Aylık maaş geliri', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'GT002', 'Emekli Maaşı', 'Emeklilik maaşı', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'GT003', 'Kira Geliri', 'Gayrimenkulden kira geliri', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'GT004', 'Ticari Kazanç', 'Ticari faaliyetten gelir', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'GT005', 'Sosyal Yardım', 'Devlet/kuruluşlardan sosyal yardım', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'GT006', 'Nafaka', 'Nafaka geliri', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'GT007', 'Engelli Maaşı', 'Engelliler için aylık', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'GT008', 'Yaşlılık Aylığı', '65 yaş üstü aylık', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'GT009', 'Diğer', 'Diğer gelir kaynakları', 9, 1, SYSDATE, 'SYSTEM');


-- 7. BORÇ TÜRÜ TANIMLARI
-- =========================================================================
INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'BT001', 'Elektrik', 'Elektrik faturası', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'BT002', 'Su', 'Su faturası', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'BT003', 'Doğalgaz', 'Doğalgaz faturası', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'BT004', 'Kira', 'Aylık kira borcu', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'BT005', 'Kredi Kartı', 'Kredi kartı borcu', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'BT006', 'Banka Kredisi', 'Tüketici kredisi', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'BT007', 'İnternet', 'İnternet faturası', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'BT008', 'Telefon', 'Telefon faturası', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'BT009', 'Eğitim Masrafı', 'Okul, kurs vb.', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (10, 'BT010', 'Sağlık Masrafı', 'İlaç, tedavi vb.', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (11, 'BT011', 'Diğer', 'Diğer borç/giderler', 11, 1, SYSDATE, 'SYSTEM');


-- 8. YARDIM DİLİMİ TANIMLARI
-- =========================================================================
INSERT INTO yardim_dilimi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'D01', 'Birinci Dilim', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'D02', 'İkinci Dilim', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'D03', 'Üçüncü Dilim', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (id, kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'D04', 'Dördüncü Dilim', 4, 1, SYSDATE, 'SYSTEM');


-- 9. YARDIM DÖNEMİ TANIMLARI (1-12 ay)
-- =========================================================================
INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (1, '1 Aylık', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (2, '2 Aylık', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (3, '3 Aylık', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (4, '4 Aylık', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (5, '5 Aylık', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (6, '6 Aylık', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (7, '7 Aylık', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (8, '8 Aylık', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (9, '9 Aylık', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (10, '10 Aylık', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (11, '11 Aylık', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (id, adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (12, '12 Aylık', 12, 1, SYSDATE, 'SYSTEM');


-- 10. YARDIM RED SEBEBİ TANIMLARI
-- =========================================================================
INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'RS001', 'Gelir Düzeyi Yüksek', 'Gelir seviyesi yardım almak için uygun değil', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'RS002', 'Evrak Eksikliği', 'Gerekli belgeler eksik', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'RS003', 'Gebze Dışı İkamet', 'Başvuru sahibi Gebze dışında ikamet ediyor', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'RS004', 'Sahte Beyan', 'Yanlış veya eksik bilgi verme', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'RS005', 'Başka Kuruluştan Alıyor', 'Başka bir yerden benzer yardım alıyor', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'RS006', 'Kriterlere Uymuyor', 'Yardım kriterlere uygun değil', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'RS007', 'Bütçe Yetersizliği', 'Yardım bütçesi tükendi', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (id, kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'RS008', 'Diğer', 'Diğer sebepler', 8, 1, SYSDATE, 'SYSTEM');


-- 11. YARDIM ALT TİPİ TANIMLARI
-- =========================================================================
-- Komisyonlu Nakdi Yardımlar
INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (1, 'NAKDI-001', 'Genel Ekonomik Destek', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Genel ihtiyaçlar', 'TL', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (2, 'NAKDI-002', 'Kira Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Kira ödemesi', 'TL', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (3, 'NAKDI-003', 'Eğitim Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Eğitim masrafları', 'TL', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (4, 'NAKDI-004', 'Sağlık Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Tedavi masrafları', 'TL', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (5, 'NAKDI-005', 'Engelli Bakım Desteği', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Engelli bakım', 'TL', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (6, 'NAKDI-006', 'Yaşlı Bakım Desteği', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Yaşlı bakım', 'TL', 6, 1, SYSDATE, 'SYSTEM');

-- Komisyonlu Ayni Yardımlar
INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (7, 'AYNI-001', 'Gıda Kolisi', 1, 'AYNI', 'Komisyonlu ayni yardım - Gıda ürünleri', 'Adet', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (8, 'AYNI-002', 'Kömür Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Kış yakıtı', 'Adet', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (9, 'AYNI-003', 'Beyaz Eşya', 1, 'AYNI', 'Komisyonlu ayni yardım - Buzdolabı, çamaşır makinesi', 'Adet', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (10, 'AYNI-004', 'Mobilya', 1, 'AYNI', 'Komisyonlu ayni yardım - Yatak, dolap, masa', 'Adet', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (11, 'AYNI-005', 'Kırtasiye Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Okul malzemeleri', 'Adet', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (12, 'AYNI-006', 'Giyim Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Giyecek', 'Adet', 12, 1, SYSDATE, 'SYSTEM');

-- Komisyonsuz Ayni Yardımlar
INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (13, 'AYNI-K001', 'Acil Gıda Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Acil durum paketi', 'Adet', 13, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (14, 'AYNI-K002', 'Hijyen Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Temizlik malzemeleri', 'Adet', 14, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (15, 'AYNI-K003', 'Bebek Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Bebek bezi, mama', 'Adet', 15, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (16, 'AYNI-K004', 'İlaç Kuponu', 0, 'AYNI', 'Komisyonsuz ayni yardım - Eczane kuponu', 'Adet', 16, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (id, kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES (17, 'AYNI-K005', 'Ekmek Kuponu', 0, 'AYNI', 'Komisyonsuz ayni yardım - Günlük ekmek', 'Adet', 17, 1, SYSDATE, 'SYSTEM');


-- 12. PERSONEL KAYITLARI
-- =========================================================================
INSERT INTO personel (id, tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES (1, '11111111110', 'Ahmet', 'YILMAZ', '5551234567', 'ahmet.yilmaz@gebze.bel.tr', 'Sosyal Yardım Uzmanı', 'Sosyal Hizmetler', 1, 0, 1, SYSDATE, 'SYSTEM');

INSERT INTO personel (id, tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES (2, '22222222220', 'Ayşe', 'KAYA', '5559876543', 'ayse.kaya@gebze.bel.tr', 'Sosyal Çalışmacı', 'Sosyal Hizmetler', 1, 0, 1, SYSDATE, 'SYSTEM');

INSERT INTO personel (id, tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES (3, '33333333330', 'Mehmet', 'DEMİR', '5551112233', 'mehmet.demir@gebze.bel.tr', 'Müdür', 'Sosyal Hizmetler', 0, 1, 1, SYSDATE, 'SYSTEM');


-- 13. KİŞİ KAYITLARI
-- =========================================================================
-- GEBZE İÇİ KİŞİLER
INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (1, '24151827460', 'Fatma', 'YILMAZ', 'Mehmet', 'Ayşe', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 'İstanbul', 'K', 'Güzeller Mahallesi No:45 Gebze', 'Kocaeli', 'Gebze', '5551112233', 1, 'SSK', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (2, '35678912340', 'Ali', 'KAYA', 'Hasan', 'Zeynep', TO_DATE('1978-07-22', 'YYYY-MM-DD'), 'Ankara', 'E', 'Aydıntepe Mahallesi No:12 Gebze', 'Kocaeli', 'Gebze', '5552223344', 1, 'EMEKLI_SANDIGI', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (3, '18956234520', 'Zeynep', 'ÇELİK', 'Ahmet', 'Hatice', TO_DATE('1990-11-08', 'YYYY-MM-DD'), 'İzmir', 'K', 'Cumhuriyet Mahallesi No:78 Gebze', 'Kocaeli', 'Gebze', '5553334455', 1, 'BAG_KUR', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (4, '42789654310', 'Mustafa', 'ŞAHİN', 'İbrahim', 'Emine', TO_DATE('1965-05-30', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Eskihisar Mahallesi No:23 Gebze', 'Kocaeli', 'Gebze', '5554445566', 1, 'EMEKLI_SANDIGI', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (5, '56234789120', 'Emine', 'YILDIZ', 'Ömer', 'Fatma', TO_DATE('1995-09-12', 'YYYY-MM-DD'), 'Bursa', 'K', 'Kirazpınar Mahallesi No:56 Gebze', 'Kocaeli', 'Gebze', '5555556677', 1, 'YOK', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (6, '67123456780', 'Hasan', 'ÖZTÜRK', 'Ali', 'Zeynep', TO_DATE('1982-01-25', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Adnan Menderes Mahallesi Gebze', 'Kocaeli', 'Gebze', '5556667788', 1, 'SSK', 'ON_LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (7, '78945612300', 'Hatice', 'AYDIN', 'Mustafa', 'Ayşe', TO_DATE('1988-12-03', 'YYYY-MM-DD'), 'Sakarya', 'K', 'Karadeniz Mahallesi No:34 Gebze', 'Kocaeli', 'Gebze', '5557778899', 1, 'YESIL_KART', 'OKUR_YAZAR', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (8, '89456723410', 'İbrahim', 'ARSLAN', 'Mehmet', 'Emine', TO_DATE('1970-04-18', 'YYYY-MM-DD'), 'Ankara', 'E', 'Çınar Mahallesi No:89 Gebze', 'Kocaeli', 'Gebze', '5558889900', 1, 'BAG_KUR', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (9, '12345678920', 'Elif', 'DOĞAN', 'Hüseyin', 'Fatma', TO_DATE('1998-06-27', 'YYYY-MM-DD'), 'İstanbul', 'K', 'Pelitli Mahallesi No:67 Gebze', 'Kocaeli', 'Gebze', '5559990011', 1, 'YOK', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (10, '23456789030', 'Hüseyin', 'KURT', 'Ali', 'Zeynep', TO_DATE('1975-08-14', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Hürriyet Mahallesi No:45 Gebze', 'Kocaeli', 'Gebze', '5550011122', 1, 'SSK', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

-- GEBZE DIŞI KİŞİLER
INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (11, '98765432106', 'Emre', 'YILDIRIM', 'Mustafa', 'Ayşe', TO_DATE('1992-02-10', 'YYYY-MM-DD'), 'İstanbul', 'E', 'Kadıköy Mahallesi No:123', 'İstanbul', 'Kadıköy', '5551234321', 0, 'SSK', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (12, '87654321097', 'Derya', 'ÖZKAN', 'Ahmet', 'Fatma', TO_DATE('1987-05-20', 'YYYY-MM-DD'), 'Ankara', 'K', 'Çankaya Mahallesi No:45', 'Ankara', 'Çankaya', '5552345432', 0, 'BAG_KUR', 'YUKSEK_LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (13, '76543210988', 'Burak', 'AKTAŞ', 'Hasan', 'Zeynep', TO_DATE('1980-09-08', 'YYYY-MM-DD'), 'İzmir', 'E', 'Karşıyaka Mahallesi No:67', 'İzmir', 'Karşıyaka', '5553456543', 0, 'EMEKLI_SANDIGI', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (14, '65432109879', 'Selin', 'POLAT', 'Mehmet', 'Emine', TO_DATE('1993-11-15', 'YYYY-MM-DD'), 'Bursa', 'K', 'Nilüfer Mahallesi No:89', 'Bursa', 'Nilüfer', '5554567654', 0, 'YOK', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (id, tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES (15, '54321098766', 'Serkan', 'KAPLAN', 'İbrahim', 'Hatice', TO_DATE('1968-03-28', 'YYYY-MM-DD'), 'Antalya', 'E', 'Muratpaşa Mahallesi No:12', 'Antalya', 'Muratpaşa', '5555678765', 0, 'EMEKLI_SANDIGI', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');


-- 14. HESAP BİLGİSİ (IBAN) KAYITLARI
-- =========================================================================
INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 1, k.id, 'Ziraat Bankası', 'TR330006100519786457841326', 'Fatma YILMAZ', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '24151827460';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 2, k.id, 'Halkbank', 'TR120001200934800019850016', 'Ali KAYA', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '35678912340';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 3, k.id, 'Vakıfbank', 'TR150001500158007301234567', 'Zeynep ÇELİK', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '18956234520';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 4, k.id, 'İş Bankası', 'TR640006400000112340056789', 'Mustafa ŞAHİN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '42789654310';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 5, k.id, 'Akbank', 'TR460004600232888001298765', 'Emine YILDIZ', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '56234789120';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 6, k.id, 'Garanti BBVA', 'TR370006200019200006789123', 'Hasan ÖZTÜRK', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '67123456780';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 7, k.id, 'Yapı Kredi', 'TR670006700100000022334455', 'Hatice AYDIN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '78945612300';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 8, k.id, 'QNB Finansbank', 'TR110001100000000111122233', 'İbrahim ARSLAN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '89456723410';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 9, k.id, 'Denizbank', 'TR340001340002550099887766', 'Elif DOĞAN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '12345678920';

INSERT INTO hesap_bilgisi (id, kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT 10, k.id, 'TEB', 'TR320003200015510000554433', 'Hüseyin KURT', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '23456789030';

-- =========================================================================
-- VERİ YÜKLEME TAMAMLANDI
-- =========================================================================
COMMIT;
