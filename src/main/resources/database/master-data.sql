-- =========================================================================
-- SOSYAL YARDIM BİLGİ SİSTEMİ (SAIS)
-- MASTER REFERANS VERİ YÜKLEME SCRIPT'İ
-- =========================================================================
-- Oracle 19c uyumlu versiyon - GenerationType.SEQUENCE ile uyumlu
-- NOT: Bu script sadece ilk kez çalıştırılmalıdır (ddl-auto=create ile)
-- =========================================================================
-- IMPORTANT: ID değerleri Hibernate tarafından OTOMATIK oluşturulacak!
-- Entity'lerde @GeneratedValue(strategy = GenerationType.SEQUENCE) kullanılıyor
-- Hibernate otomatik olarak sequence'ler oluşturacak ve ID'leri generate edecek
-- Bu nedenle INSERT statement'larında ID kolonu BULUNMAMALIDIR!
-- =========================================================================

-- 1. YAKINLIK KODLARI (MERNİS Standartları) - 12 kayıt
-- =========================================================================
INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('01', 'Kendisi', 'Kendisi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('02', 'Eşi', 'Eşi', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('03', 'Annesi', 'Annesi', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('04', 'Babası', 'Babası', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('05', 'Oğlu', 'Oğlu', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('06', 'Kızı', 'Kızı', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('07', 'Kardeşi', 'Kardeşi', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('08', 'Büyükanne', 'Büyükanne', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('09', 'Büyükbaba', 'Büyükbaba', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('10', 'Torun', 'Torun', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('11', 'Gelin', 'Gelin', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yakinlik_kodu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('12', 'Damat', 'Damat', 12, 1, SYSDATE, 'SYSTEM');


-- 2. MESLEK TANIMLARI - 15 kayıt
-- =========================================================================
INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M001', 'İşsiz', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M002', 'İşçi', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M003', 'Memur', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M004', 'Öğretmen', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M005', 'Doktor', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M006', 'Hemşire', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M007', 'Mühendis', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M008', 'Serbest Meslek', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M009', 'Esnaf', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M010', 'Emekli', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M011', 'Ev Hanımı', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M012', 'Öğrenci', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M013', 'Çiftçi', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M014', 'Şoför', 1, SYSDATE, 'SYSTEM');

INSERT INTO meslek (kod, adi, aktif, olusturma_tarihi, olusturan)
VALUES ('M015', 'Güvenlik Görevlisi', 1, SYSDATE, 'SYSTEM');


-- 3. ÖZEL STATÜ TANIMLARI - 7 kayıt
-- =========================================================================
INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS001', 'Şehit Yakını', 'Şehit ailesi', 100, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS002', 'Gazi Yakını', 'Gazi ailesi', 90, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS003', 'Yetim', 'Anne veya baba kaybı', 80, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS004', 'Öksüz', 'Anne ve baba kaybı', 85, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS005', 'Dul', 'Eş kaybı', 70, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS006', 'Koruma Altında', 'ASPB koruma altında', 60, 1, SYSDATE, 'SYSTEM');

INSERT INTO ozel_statu (kod, adi, aciklama, oncelik_puani, aktif, olusturma_tarihi, olusturan)
VALUES ('OS007', 'Mülteci', 'Geçici koruma statüsü', 50, 1, SYSDATE, 'SYSTEM');


-- 4. ENGELLİ TİPİ TANIMLARI (Ana Tipler + Alt Tipler) - 17 kayıt
-- =========================================================================
-- Ana tipler (ust_tip_id NULL)
INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET001', 'Bedensel Engelli', NULL, 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET002', 'Görme Engelli', NULL, 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET003', 'İşitme Engelli', NULL, 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET004', 'Zihinsel Engelli', NULL, 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET005', 'Ruhsal/Psikolojik Engelli', NULL, 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, ust_tip_id, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET006', 'Süreğen Hastalık', NULL, 6, 1, SYSDATE, 'SYSTEM');

-- Alt Tipler (ust_tip_id sonra UPDATE ile bağlanacak)
INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET001-01', 'Ortopedik Engelli', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET001-02', 'Omurilik Felci', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET002-01', 'Az Gören', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET002-02', 'Tamamen Görme Engelli', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET003-01', 'Az İşiten', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET003-02', 'Tamamen İşitme Engelli', 12, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET004-01', 'Hafif Zihinsel Engelli', 13, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET004-02', 'Orta Zihinsel Engelli', 14, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET004-03', 'Ağır Zihinsel Engelli', 15, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET005-01', 'Otizm', 16, 1, SYSDATE, 'SYSTEM');

INSERT INTO engelli_tipi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('ET005-02', 'Down Sendromu', 17, 1, SYSDATE, 'SYSTEM');

-- Alt tiplerin üst tiplerini bağlama (Oracle uyumlu)
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


-- 5. HASTALIK TANIMLARI - 15 kayıt
-- =========================================================================
INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H001', 'Şeker Hastalığı (Diyabet)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H002', 'Tansiyon (Hipertansiyon)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H003', 'Kalp Hastalığı', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H004', 'Astım', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H005', 'KOAH', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H006', 'Böbrek Yetmezliği', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H007', 'Kanser', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H008', 'Epilepsi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H009', 'Multiple Skleroz (MS)', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H010', 'Parkinson', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H011', 'Alzheimer', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H012', 'Talasemi', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H013', 'Hemofili', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H014', 'Sedef Hastalığı', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO hastalik (kod, adi, kronik, aktif, olusturma_tarihi, olusturan)
VALUES ('H015', 'Romatizma', 1, 1, SYSDATE, 'SYSTEM');


-- 6. GELİR TÜRÜ TANIMLARI - 9 kayıt
-- =========================================================================
INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT001', 'Maaş', 'Aylık maaş geliri', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT002', 'Emekli Maaşı', 'Emeklilik maaşı', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT003', 'Kira Geliri', 'Gayrimenkulden kira geliri', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT004', 'Ticari Kazanç', 'Ticari faaliyetten gelir', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT005', 'Sosyal Yardım', 'Devlet/kuruluşlardan sosyal yardım', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT006', 'Nafaka', 'Nafaka geliri', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT007', 'Engelli Maaşı', 'Engelliler için aylık', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT008', 'Yaşlılık Aylığı', '65 yaş üstü aylık', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO gelir_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('GT009', 'Diğer', 'Diğer gelir kaynakları', 9, 1, SYSDATE, 'SYSTEM');


-- 7. BORÇ TÜRÜ TANIMLARI - 11 kayıt
-- =========================================================================
INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT001', 'Elektrik', 'Elektrik faturası', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT002', 'Su', 'Su faturası', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT003', 'Doğalgaz', 'Doğalgaz faturası', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT004', 'Kira', 'Aylık kira borcu', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT005', 'Kredi Kartı', 'Kredi kartı borcu', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT006', 'Banka Kredisi', 'Tüketici kredisi', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT007', 'İnternet', 'İnternet faturası', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT008', 'Telefon', 'Telefon faturası', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT009', 'Eğitim Masrafı', 'Okul, kurs vb.', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT010', 'Sağlık Masrafı', 'İlaç, tedavi vb.', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO borc_turu (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('BT011', 'Diğer', 'Diğer borç/giderler', 11, 1, SYSDATE, 'SYSTEM');


-- 8. YARDIM DİLİMİ TANIMLARI - 4 kayıt
-- =========================================================================
INSERT INTO yardim_dilimi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('D01', 'Birinci Dilim', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('D02', 'İkinci Dilim', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('D03', 'Üçüncü Dilim', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_dilimi (kod, adi, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('D04', 'Dördüncü Dilim', 4, 1, SYSDATE, 'SYSTEM');


-- 9. YARDIM DÖNEMİ TANIMLARI (1-12 ay) - 12 kayıt
-- =========================================================================
INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('1 Aylık', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('2 Aylık', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('3 Aylık', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('4 Aylık', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('5 Aylık', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('6 Aylık', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('7 Aylık', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('8 Aylık', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('9 Aylık', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('10 Aylık', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('11 Aylık', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_donemi (adi, ay_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('12 Aylık', 12, 1, SYSDATE, 'SYSTEM');


-- 10. YARDIM RED SEBEBİ TANIMLARI - 8 kayıt
-- =========================================================================
INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS001', 'Gelir Düzeyi Yüksek', 'Gelir seviyesi yardım almak için uygun değil', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS002', 'Evrak Eksikliği', 'Gerekli belgeler eksik', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS003', 'Gebze Dışı İkamet', 'Başvuru sahibi Gebze dışında ikamet ediyor', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS004', 'Sahte Beyan', 'Yanlış veya eksik bilgi verme', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS005', 'Başka Kuruluştan Alıyor', 'Başka bir yerden benzer yardım alıyor', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS006', 'Kriterlere Uymuyor', 'Yardım kriterlere uygun değil', 6, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS007', 'Bütçe Yetersizliği', 'Yardım bütçesi tükendi', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_red_sebebi (kod, adi, aciklama, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('RS008', 'Diğer', 'Diğer sebepler', 8, 1, SYSDATE, 'SYSTEM');


-- 11. YARDIM ALT TİPİ TANIMLARI - 17 kayıt
-- =========================================================================
-- Komisyonlu Nakdi Yardımlar
INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-001', 'Genel Ekonomik Destek', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Genel ihtiyaçlar', 'TL', 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-002', 'Kira Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Kira ödemesi', 'TL', 2, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-003', 'Eğitim Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Eğitim masrafları', 'TL', 3, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-004', 'Sağlık Yardımı', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Tedavi masrafları', 'TL', 4, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-005', 'Engelli Bakım Desteği', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Engelli bakım', 'TL', 5, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('NAKDI-006', 'Yaşlı Bakım Desteği', 1, 'NAKDI', 'Komisyonlu nakdi yardım - Yaşlı bakım', 'TL', 6, 1, SYSDATE, 'SYSTEM');

-- Komisyonlu Ayni Yardımlar
INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-001', 'Gıda Kolisi', 1, 'AYNI', 'Komisyonlu ayni yardım - Gıda ürünleri', 'Adet', 7, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-002', 'Kömür Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Kış yakıtı', 'Adet', 8, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-003', 'Beyaz Eşya', 1, 'AYNI', 'Komisyonlu ayni yardım - Buzdolabı, çamaşır makinesi', 'Adet', 9, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-004', 'Mobilya', 1, 'AYNI', 'Komisyonlu ayni yardım - Yatak, dolap, masa', 'Adet', 10, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-005', 'Kırtasiye Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Okul malzemeleri', 'Adet', 11, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-006', 'Giyim Yardımı', 1, 'AYNI', 'Komisyonlu ayni yardım - Giyecek', 'Adet', 12, 1, SYSDATE, 'SYSTEM');

-- Komisyonsuz Ayni Yardımlar
INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-K001', 'Acil Gıda Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Acil durum paketi', 'Adet', 13, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-K002', 'Hijyen Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Temizlik malzemeleri', 'Adet', 14, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-K003', 'Bebek Paketi', 0, 'AYNI', 'Komisyonsuz ayni yardım - Bebek bezi, mama', 'Adet', 15, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-K004', 'İlaç Kuponu', 0, 'AYNI', 'Komisyonsuz ayni yardım - Eczane kuponu', 'Adet', 16, 1, SYSDATE, 'SYSTEM');

INSERT INTO yardim_alt_tipi (kod, adi, komisyon_kararli, yardim_tipi, aciklama, birim, sira_no, aktif, olusturma_tarihi, olusturan)
VALUES ('AYNI-K005', 'Ekmek Kuponu', 0, 'AYNI', 'Komisyonsuz ayni yardım - Günlük ekmek', 'Adet', 17, 1, SYSDATE, 'SYSTEM');


-- 12. PERSONEL KAYITLARI - 3 kayıt
-- =========================================================================
INSERT INTO personel (tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES ('11111111110', 'Ahmet', 'YILMAZ', '5551234567', 'ahmet.yilmaz@gebze.bel.tr', 'Sosyal Yardım Uzmanı', 'Sosyal Hizmetler', 1, 0, 1, SYSDATE, 'SYSTEM');

INSERT INTO personel (tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES ('22222222220', 'Ayşe', 'KAYA', '5559876543', 'ayse.kaya@gebze.bel.tr', 'Sosyal Çalışmacı', 'Sosyal Hizmetler', 1, 0, 1, SYSDATE, 'SYSTEM');

INSERT INTO personel (tc_kimlik_no, ad, soyad, telefon, email, unvan, departman, tahkikat_yetkili, komisyon_uyesi, aktif, olusturma_tarihi, olusturan)
VALUES ('33333333330', 'Mehmet', 'DEMİR', '5551112233', 'mehmet.demir@gebze.bel.tr', 'Müdür', 'Sosyal Hizmetler', 0, 1, 1, SYSDATE, 'SYSTEM');


-- 13. KİŞİ KAYITLARI - 15 kayıt
-- =========================================================================
-- GEBZE İÇİ KİŞİLER (10 kayıt)
INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('24151827460', 'Fatma', 'YILMAZ', 'Mehmet', 'Ayşe', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 'İstanbul', 'K', 'Güzeller Mahallesi No:45 Gebze', 'Kocaeli', 'Gebze', '5551112233', 1, 'SSK', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('35678912340', 'Ali', 'KAYA', 'Hasan', 'Zeynep', TO_DATE('1978-07-22', 'YYYY-MM-DD'), 'Ankara', 'E', 'Aydıntepe Mahallesi No:12 Gebze', 'Kocaeli', 'Gebze', '5552223344', 1, 'EMEKLI_SANDIGI', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('18956234520', 'Zeynep', 'ÇELİK', 'Ahmet', 'Hatice', TO_DATE('1990-11-08', 'YYYY-MM-DD'), 'İzmir', 'K', 'Cumhuriyet Mahallesi No:78 Gebze', 'Kocaeli', 'Gebze', '5553334455', 1, 'BAG_KUR', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('42789654310', 'Mustafa', 'ŞAHİN', 'İbrahim', 'Emine', TO_DATE('1965-05-30', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Eskihisar Mahallesi No:23 Gebze', 'Kocaeli', 'Gebze', '5554445566', 1, 'EMEKLI_SANDIGI', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('56234789120', 'Emine', 'YILDIZ', 'Ömer', 'Fatma', TO_DATE('1995-09-12', 'YYYY-MM-DD'), 'Bursa', 'K', 'Kirazpınar Mahallesi No:56 Gebze', 'Kocaeli', 'Gebze', '5555556677', 1, 'YOK', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('67123456780', 'Hasan', 'ÖZTÜRK', 'Ali', 'Zeynep', TO_DATE('1982-01-25', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Adnan Menderes Mahallesi Gebze', 'Kocaeli', 'Gebze', '5556667788', 1, 'SSK', 'ON_LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('78945612300', 'Hatice', 'AYDIN', 'Mustafa', 'Ayşe', TO_DATE('1988-12-03', 'YYYY-MM-DD'), 'Sakarya', 'K', 'Karadeniz Mahallesi No:34 Gebze', 'Kocaeli', 'Gebze', '5557778899', 1, 'YESIL_KART', 'OKUR_YAZAR', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('89456723410', 'İbrahim', 'ARSLAN', 'Mehmet', 'Emine', TO_DATE('1970-04-18', 'YYYY-MM-DD'), 'Ankara', 'E', 'Çınar Mahallesi No:89 Gebze', 'Kocaeli', 'Gebze', '5558889900', 1, 'BAG_KUR', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('12345678920', 'Elif', 'DOĞAN', 'Hüseyin', 'Fatma', TO_DATE('1998-06-27', 'YYYY-MM-DD'), 'İstanbul', 'K', 'Pelitli Mahallesi No:67 Gebze', 'Kocaeli', 'Gebze', '5559990011', 1, 'YOK', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('23456789030', 'Hüseyin', 'KURT', 'Ali', 'Zeynep', TO_DATE('1975-08-14', 'YYYY-MM-DD'), 'Kocaeli', 'E', 'Hürriyet Mahallesi No:45 Gebze', 'Kocaeli', 'Gebze', '5550011122', 1, 'SSK', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

-- GEBZE DIŞI KİŞİLER (5 kayıt)
INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('98765432106', 'Emre', 'YILDIRIM', 'Mustafa', 'Ayşe', TO_DATE('1992-02-10', 'YYYY-MM-DD'), 'İstanbul', 'E', 'Kadıköy Mahallesi No:123', 'İstanbul', 'Kadıköy', '5551234321', 0, 'SSK', 'LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('87654321097', 'Derya', 'ÖZKAN', 'Ahmet', 'Fatma', TO_DATE('1987-05-20', 'YYYY-MM-DD'), 'Ankara', 'K', 'Çankaya Mahallesi No:45', 'Ankara', 'Çankaya', '5552345432', 0, 'BAG_KUR', 'YUKSEK_LISANS', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('76543210988', 'Burak', 'AKTAŞ', 'Hasan', 'Zeynep', TO_DATE('1980-09-08', 'YYYY-MM-DD'), 'İzmir', 'E', 'Karşıyaka Mahallesi No:67', 'İzmir', 'Karşıyaka', '5553456543', 0, 'EMEKLI_SANDIGI', 'LISE', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('65432109879', 'Selin', 'POLAT', 'Mehmet', 'Emine', TO_DATE('1993-11-15', 'YYYY-MM-DD'), 'Bursa', 'K', 'Nilüfer Mahallesi No:89', 'Bursa', 'Nilüfer', '5554567654', 0, 'YOK', 'ORTAOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');

INSERT INTO kisi (tc_kimlik_no, ad, soyad, baba_adi, anne_adi, dogum_tarihi, dogum_yeri, cinsiyet, adres, il, ilce, telefon, gebze_ikameti, sgk_durum, ogrenim_durum, son_mernis_sorgu_tarihi, mernis_guncelleme_sayisi, aktif, olusturma_tarihi, olusturan)
VALUES ('54321098766', 'Serkan', 'KAPLAN', 'İbrahim', 'Hatice', TO_DATE('1968-03-28', 'YYYY-MM-DD'), 'Antalya', 'E', 'Muratpaşa Mahallesi No:12', 'Antalya', 'Muratpaşa', '5555678765', 0, 'EMEKLI_SANDIGI', 'ILKOKUL', TRUNC(SYSDATE), 1, 1, SYSDATE, 'SYSTEM');


-- 14. HESAP BİLGİSİ (IBAN) KAYITLARI - 10 kayıt
-- =========================================================================
-- NOT: kisi_id Hibernate tarafından otomatik atandığı için, TC ile JOIN yapılıyor
INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Ziraat Bankası', 'TR330006100519786457841326', 'Fatma YILMAZ', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '24151827460';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Halkbank', 'TR120001200934800019850016', 'Ali KAYA', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '35678912340';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Vakıfbank', 'TR150001500158007301234567', 'Zeynep ÇELİK', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '18956234520';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'İş Bankası', 'TR640006400000112340056789', 'Mustafa ŞAHİN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '42789654310';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Akbank', 'TR460004600232888001298765', 'Emine YILDIZ', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '56234789120';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Garanti BBVA', 'TR370006200019200006789123', 'Hasan ÖZTÜRK', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '67123456780';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Yapı Kredi', 'TR670006700100000022334455', 'Hatice AYDIN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '78945612300';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'QNB Finansbank', 'TR110001100000000111122233', 'İbrahim ARSLAN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '89456723410';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'Denizbank', 'TR340001340002550099887766', 'Elif DOĞAN', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '12345678920';

INSERT INTO hesap_bilgisi (kisi_id, banka_adi, iban, hesap_sahibi_adi, varsayilan, aktif, olusturma_tarihi, olusturan)
SELECT k.id, 'TEB', 'TR320003200015510000554433', 'Hüseyin KURT', 1, 1, SYSDATE, 'SYSTEM'
FROM kisi k WHERE k.tc_kimlik_no = '23456789030';

-- =========================================================================
-- VERİ YÜKLEME TAMAMLANDI - ORACLE 19c VERSİYONU
-- =========================================================================
-- Özet:
-- ✅ 12 Yakınlık Kodu
-- ✅ 15 Meslek
-- ✅ 7 Özel Statü
-- ✅ 17 Engelli Tipi (6 ana + 11 alt)
-- ✅ 15 Hastalık
-- ✅ 9 Gelir Türü
-- ✅ 11 Borç Türü
-- ✅ 4 Yardım Dilimi
-- ✅ 12 Yardım Dönemi
-- ✅ 8 Yardım Red Sebebi
-- ✅ 17 Yardım Alt Tipi (6 Nakdi + 6 Ayni Komisyonlu, 5 Ayni Komisyonsuz)
-- ✅ 3 Personel
-- ✅ 15 Kişi (10 Gebze içi, 5 Gebze dışı)
-- ✅ 10 Hesap Bilgisi (IBAN - Gebze içi kişiler için)
--
-- TOPLAM: 155 kayıt
-- =========================================================================
-- NOT: ID değerleri Hibernate tarafından otomatik oluşturulacak!
-- SEQUENCE kullanımı YOK - Hibernate yönetecek!
-- =========================================================================
COMMIT;
