package com.sais.bean;

import com.sais.entity.YardimKarar;
import com.sais.service.ReportService;
import com.sais.service.YardimRaporService;
import jakarta.annotation.PostConstruct;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.ExternalContext;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@ViewScoped
@Getter
@Setter
@Slf4j
public class RaporBean implements Serializable {

    private static final long serialVersionUID = 1L;
    
    private static final String REPORT_TITLE_PARAM = "RAPOR_BASLIGI";
    private static final String REPORT_DATE_PARAM = "RAPOR_TARIHI";
    private static final String TOTAL_RECORDS_PARAM = "TOPLAM_KAYIT";
    private static final String TOTAL_AMOUNT_PARAM = "TOPLAM_TUTAR";
    
    private static final String YARDIM_TEMPLATE = "reports/yardim-karar-liste.jrxml";
    private static final String YARDIM_TESLIM_TEMPLATE = "reports/yardim-teslim-raporu.jrxml";
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy");
    
    private static final String PDF_MIME_TYPE = "application/pdf";

    @Autowired
    private ReportService reportService;
    
    @Autowired
    private YardimRaporService yardimRaporService;
    
    // Yardım Teslim Raporu için
    private Long selectedMuracaatId;

    @PostConstruct
    public void init() {
        log.info("RaporBean başlatıldı");
    }

    // Tüm yardım kararları raporu - Yeni Format
    public void tumYardimKararlariPdfIndir() {
        List<YardimKarar> yardimlar = yardimRaporService.findYardimKararlariForNewReport();
        Double toplamTutar = yardimRaporService.calculateTotalYardimTutari(yardimlar);
        generateYardimReport(yardimlar, "TÜM YARDIM KARARLARI", "tum-yardim-kararlari.pdf", toplamTutar);
    }

    //helper methods
    private void generateYardimReport(List<YardimKarar> yardimList,
                                     String reportTitle,
                                     String fileName,
                                     Double toplamTutar) {
        try {
            Map<String, Object> parameters = new HashMap<>();
            parameters.put(REPORT_TITLE_PARAM, reportTitle);
            parameters.put(REPORT_DATE_PARAM, getCurrentDateFormatted());
            parameters.put(TOTAL_RECORDS_PARAM, yardimList.size());
            parameters.put(TOTAL_AMOUNT_PARAM, toplamTutar);
            
            byte[] reportBytes = reportService.generatePdfFromCollection(YARDIM_TEMPLATE, parameters, yardimList);
            
            downloadFile(reportBytes, fileName, PDF_MIME_TYPE);
            showSuccessMessage("Rapor başarıyla oluşturuldu");
            
        } catch (Exception e) {
            log.error("{} raporu oluşturulurken hata", reportTitle, e);
            showErrorMessage("Rapor oluşturulamadı: " + e.getMessage());
        }
    }

    private String getCurrentDateFormatted() {
        return LocalDate.now().format(DATE_FORMATTER);
    }

    private void downloadFile(byte[] fileBytes, String fileName, String mimeType) {
        try {
            FacesContext facesContext = FacesContext.getCurrentInstance();
            ExternalContext externalContext = facesContext.getExternalContext();

            externalContext.responseReset();
            externalContext.setResponseContentType(mimeType);
            externalContext.setResponseContentLength(fileBytes.length);
            externalContext.setResponseHeader("Content-Disposition", 
                String.format("attachment; filename=\"%s\"", fileName));

            externalContext.getResponseOutputStream().write(fileBytes);
            facesContext.responseComplete();

        } catch (IOException e) {
            log.error("Dosya indirme hatası: {}", fileName, e);
            throw new RuntimeException("Dosya indirilemedi", e);
        }
    }

    private void showSuccessMessage(String detail) {
        showMessage("Başarılı", detail, FacesMessage.SEVERITY_INFO);
    }

    private void showErrorMessage(String detail) {
        showMessage("Hata", detail, FacesMessage.SEVERITY_ERROR);
    }

    private void showMessage(String summary, String detail, FacesMessage.Severity severity) {
        FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(severity, summary, detail));
    }
    
    /**
     * Yardım Teslim Raporu oluşturur
     */
    public void generateYardimTeslimRaporu(Long muracaatId) {
        String reportTitle = "Yardım Teslim Raporu";
        String fileName = String.format("yardim_teslim_raporu_%s_%s.pdf", 
            muracaatId, LocalDate.now().format(DateTimeFormatter.ofPattern("ddMMyyyy")));
        
        try {
            // Müracaat bilgilerini al
            Map<String, Object> muracaatData = yardimRaporService.getMuracaatTeslimBilgileri(muracaatId);
            List<Map<String, Object>> yardimList = yardimRaporService.getYardimTeslimListesi(muracaatId);
            
            // Rapor parametrelerini hazırla
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("muracaatNo", muracaatData.get("muracaatNo"));
            parameters.put("muracaatTarihi", muracaatData.get("muracaatTarihi"));
            parameters.put("mernisNo", muracaatData.get("mernisNo"));
            parameters.put("adSoyad", muracaatData.get("adSoyad"));
            parameters.put("adres", muracaatData.get("adres"));
            parameters.put("kararSayisi", muracaatData.get("kararSayisi"));
            parameters.put("kararTarihi", muracaatData.get("kararTarihi"));
            parameters.put("toplantiTarihi", muracaatData.get("toplantıTarihi"));
            parameters.put("gizlilikNumarasi", muracaatData.get("gizlilikNumarasi"));
            
            byte[] reportBytes = reportService.generatePdfFromCollection(YARDIM_TESLIM_TEMPLATE, parameters, yardimList);
            
            downloadFile(reportBytes, fileName, PDF_MIME_TYPE);
            showSuccessMessage("Yardım teslim raporu başarıyla oluşturuldu");
            
        } catch (Exception e) {
            log.error("{} raporu oluşturulurken hata", reportTitle, e);
            showErrorMessage("Rapor oluşturulamadı: " + e.getMessage());
        }
    }
}
