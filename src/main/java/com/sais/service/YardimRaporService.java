package com.sais.service;

import com.sais.entity.YardimKarar;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class YardimRaporService {

    @PersistenceContext
    private EntityManager entityManager;

    public Double calculateTotalYardimTutari(List<YardimKarar> yardimlar) {
        return yardimlar.stream()
            .filter(y -> y.getVerilenTutar() != null)
            .mapToDouble(YardimKarar::getVerilenTutar)
            .sum();
    }

    /**
     * Yeni rapor formatı için yardım kararlarını getirir
     * TİPİ, Yardım adı, DURUMU, AÇIKLAMA, YARDIM TUTARI, YARDIM SAYISI, YARDIM DİLİMİ kolonları
     */
    public List<YardimKarar> findYardimKararlariForNewReport() {
        List<YardimKarar> yardimlar = entityManager.createQuery(
            "SELECT yk FROM YardimKarar yk " +
            "LEFT JOIN FETCH yk.muracaat m " +
            "LEFT JOIN FETCH m.basvuruSahibi bs " +
            "LEFT JOIN FETCH yk.yardimAltTipi " +
            "LEFT JOIN FETCH yk.yardimDilimi " +
            "WHERE yk.aktif = true " +
            "ORDER BY yk.kararTarihi DESC, yk.olusturmaTarihi DESC",
            YardimKarar.class)
            .getResultList();
        
        // Karar numaralarını otomatik oluştur
        generateKararNumaralari(yardimlar);
        
        return yardimlar;
    }
    
    /**
     * Yardım kararları için karar numaralarını otomatik oluşturur
     */
    private void generateKararNumaralari(List<YardimKarar> yardimlar) {
        int kararSayisi = 1;
        
        for (YardimKarar yardim : yardimlar) {
            if (yardim.getKararTarihi() == null) {
                yardim.setKararTarihi(java.time.LocalDate.now());
            }
            
            if (yardim.getKararSayisi() == null) {
                yardim.setKararSayisi(kararSayisi++);
            }
        }
    }
    
    /**
     * Müracaat teslim bilgilerini getirir
     */
    public java.util.Map<String, Object> getMuracaatTeslimBilgileri(Long muracaatId) {
        String query = """
            SELECT m.muracaatNo as muracaatNo,
                   m.muracaatTarihi as muracaatTarihi,
                   bs.tcKimlikNo as mernisNo,
                   CONCAT(bs.ad, ' ', bs.soyad) as adSoyad,
                   bs.adres as adres,
                   yk.kararSayisi as kararSayisi,
                   yk.kararTarihi as kararTarihi,
                   yk.toplantiTarihi as toplantıTarihi,
                   null as gizlilikNumarasi
            FROM Muracaat m
            LEFT JOIN m.basvuruSahibi bs
            LEFT JOIN m.yardimKararlari yk
            WHERE m.id = :muracaatId
            AND yk.aktif = true
            ORDER BY yk.kararTarihi DESC, yk.olusturmaTarihi DESC
            """;
            
        List<Object[]> result = entityManager.createQuery(query, Object[].class)
            .setParameter("muracaatId", muracaatId)
            .setMaxResults(1)
            .getResultList();
            
        if (result.isEmpty()) {
            throw new RuntimeException("Müracaat bulunamadı: " + muracaatId);
        }
        
        Object[] row = result.get(0);
        java.util.Map<String, Object> data = new java.util.HashMap<>();
        
        // Tüm değerleri String'e çevir - JasperReports String bekliyor
        data.put("muracaatNo", row[0] != null ? row[0].toString() : "");
        data.put("muracaatTarihi", row[1] != null ? row[1].toString() : "");
        data.put("mernisNo", row[2] != null ? row[2].toString() : "");
        data.put("adSoyad", row[3] != null ? row[3].toString() : "");
        data.put("adres", row[4] != null ? row[4].toString() : "");
        data.put("kararSayisi", row[5] != null ? row[5].toString() : "");
        data.put("kararTarihi", row[6] != null ? row[6].toString() : "");
        data.put("toplantıTarihi", row[7] != null ? row[7].toString() : "");
        data.put("gizlilikNumarasi", row[8] != null ? row[8].toString() : "");
        
        return data;
    }
    
    /**
     * Yardım teslim listesini getirir
     */
    public List<java.util.Map<String, Object>> getYardimTeslimListesi(Long muracaatId) {
        String query = """
            SELECT yt.yardimTipi as tip,
                   yt.adi as yardimAdi,
                   yk.yardimDurum as durumu,
                   COALESCE(yk.aciklama, '') as aciklama,
                   yk.verilenTutar as tutari,
                   yk.adetSayi as yardimSayisi,
                   COALESCE(yd.adi, '') as yardimDonemi,
                   COALESCE(ydi.adi, '') as yardimDilimi
            FROM YardimKarar yk
            LEFT JOIN yk.yardimAltTipi yt
            LEFT JOIN yk.yardimDonemi yd
            LEFT JOIN yk.yardimDilimi ydi
            WHERE yk.muracaat.id = :muracaatId
            AND yk.aktif = true
            AND yk.yardimDurum = com.sais.enums.YardimDurum.KABUL_EDILDI
            ORDER BY yk.kararTarihi DESC
            """;
            
        List<Object[]> result = entityManager.createQuery(query, Object[].class)
            .setParameter("muracaatId", muracaatId)
            .getResultList();
            
        List<java.util.Map<String, Object>> yardimList = new java.util.ArrayList<>();
        for (Object[] row : result) {
            java.util.Map<String, Object> yardim = new java.util.HashMap<>();
            
            // Enum değerlerini string'e çevir
            yardim.put("tip", row[0] != null ? row[0].toString() : "");
            yardim.put("yardimAdi", row[1] != null ? row[1].toString() : "");
            yardim.put("durumu", row[2] != null ? row[2].toString() : "");
            yardim.put("aciklama", row[3] != null ? row[3].toString() : "");
            
            // Tutarı BigDecimal'e çevir
            java.math.BigDecimal tutari = null;
            if (row[4] != null) {
                if (row[4] instanceof Double) {
                    tutari = java.math.BigDecimal.valueOf((Double) row[4]);
                } else if (row[4] instanceof java.math.BigDecimal) {
                    tutari = (java.math.BigDecimal) row[4];
                }
            }
            // Eğer tutar null ise 0.00 yap
            yardim.put("tutari", tutari != null ? tutari : java.math.BigDecimal.ZERO);
            
            // Yardım sayısını Integer'a çevir
            Integer yardimSayisi = null;
            if (row[5] != null) {
                if (row[5] instanceof Integer) {
                    yardimSayisi = (Integer) row[5];
                } else {
                    yardimSayisi = Integer.valueOf(row[5].toString());
                }
            }
            yardim.put("yardimSayisi", yardimSayisi != null ? yardimSayisi : 0);
            
            // Yardım dönemi ve dilimi
            yardim.put("yardimDonemi", row[6] != null ? row[6].toString() : "");
            yardim.put("yardimDilimi", row[7] != null ? row[7].toString() : "");
            
            yardimList.add(yardim);
        }
        
        return yardimList;
    }
}
