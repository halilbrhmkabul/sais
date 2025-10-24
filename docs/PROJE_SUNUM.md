# SAIS - SOSYAL YARDIM BİLGİ SİSTEMİ
## Proje Mimari ve Tasarım Sunumu

---

## 📋 İÇİNDEKİLER

1. [Proje Genel Bakış](#1-proje-genel-bakış)
2. [Teknoloji Yığını](#2-teknoloji-yığını)
3. [Mimari Yapı](#3-mimari-yapı)
4. [Veritabanı Tasarımı](#4-veritabanı-tasarımı)
5. [Katmanlı Mimari Detayları](#5-katmanlı-mimari-detayları)
6. [Tasarım Desenleri](#6-tasarım-desenleri)
7. [İş Akışları](#7-iş-akışları)
8. [Güvenlik ve Validation](#8-güvenlik-ve-validation)
9. [Performans Optimizasyonları](#9-performans-optimizasyonları)
10. [Raporlama Sistemi](#10-raporlama-sistemi)

---

## 1. PROJE GENEL BAKIŞ

### 1.1 Proje Tanımı

**SAIS (Sosyal Yardım Bilgi Sistemi)**, Türk belediyelerinin sosyal yardım süreçlerini dijitalleştiren, uçtan uca yönetim sağlayan kapsamlı bir enterprise uygulamasıdır.

### 1.2 Temel Özellikler

- ✅ Müracaat yönetimi ve takibi
- ✅ MERNİS entegrasyonu ile vatandaş doğrulama
- ✅ Aile fert bilgileri yönetimi
- ✅ Mali durum değerlendirmesi
- ✅ Tahkikat süreci yönetimi
- ✅ Komisyon karar sistemi
- ✅ Doküman yönetimi
- ✅ Gelişmiş raporlama (PDF/Excel)
- ✅ Audit trail (izlenebilirlik)

### 1.3 Proje İstatistikleri

```
📊 Kod Yapısı:
├── 124+ Java kaynak dosyası
├── 28 Entity sınıfı
├── 24 Repository sınıfı
├── 13 Service sınıfı
├── 6 Controller sınıfı
├── 6 Mapper sınıfı
└── 9 Enum sınıfı

📦 Proje Boyutu:
├── Backend: ~15,000+ LOC
├── Frontend: ~6 XHTML sayfası
└── Database: 28+ tablo
```

---

## 2. TEKNOLOJİ YIĞINI

### 2.1 Backend Framework

```yaml
Framework: Spring Boot 3.2.0
Java Version: 17 (LTS)
Build Tool: Maven 3.x
Architecture: Monolithic (Layered)
```

### 2.2 Teknoloji Matrisi

| Katman | Teknoloji | Versiyon | Kullanım Amacı |
|--------|-----------|----------|----------------|
| **Framework** | Spring Boot | 3.2.0 | Core application framework |
| **ORM** | Hibernate / JPA | 6.x | Object-Relational Mapping |
| **UI Framework** | JSF (Jakarta Faces) | 4.0 | Server-side UI |
| **UI Library** | PrimeFaces | 13.0.0 | Rich UI components |
| **Database** | MySQL | 8.x | Relational database |
| **Mapping** | MapStruct | 1.6.3 | DTO/Entity mapping |
| **Boilerplate** | Lombok | 1.18.30 | Code generation |
| **Reporting** | JasperReports | 6.21.0 | Report generation |
| **Validation** | Bean Validation | 3.0 | Data validation |
| **Integration** | JoinFaces | 5.3.3 | Spring Boot + JSF |

### 2.3 Dependency Management

```xml
<!-- Core Dependencies -->
spring-boot-starter-data-jpa      → Database operations
spring-boot-starter-web           → Web layer
spring-boot-starter-validation    → Validation

<!-- UI Layer -->
mojarra-spring-boot-starter       → JSF implementation
primefaces-jakarta                → Rich UI components
omnifaces                         → JSF utilities

<!-- Data Mapping -->
mapstruct                         → DTO mapping
lombok                            → Boilerplate reduction

<!-- Reporting -->
jasperreports                     → PDF/Excel generation
jasperreports-fonts               → Turkish characters

<!-- File Handling -->
commons-fileupload                → Multipart upload
commons-io                        → I/O operations
```

---

## 3. MİMARİ YAPI

### 3.1 Genel Mimari Görünüm

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ XHTML Views  │  │  Templates   │  │   Resources  │      │
│  │ (JSF Pages)  │  │  (Layout)    │  │   (CSS/JS)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                     CONTROLLER LAYER                         │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  JSF Backing Beans (@ViewScoped / @RequestScoped)    │   │
│  │  - MuracaatController                                │   │
│  │  - AileFertController                                │   │
│  │  - MaddiDurumController                              │   │
│  │  - TutanakController                                 │   │
│  │  - YardimKararController                             │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                      SERVICE LAYER                           │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐  │
│  │ Business Logic │  │   Validation   │  │  Workflow    │  │
│  │   Services     │  │    Services    │  │  Management  │  │
│  └────────────────┘  └────────────────┘  └──────────────┘  │
│                                                              │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐  │
│  │  MuracaatSvc   │  │    KisiSvc     │  │  YardimSvc   │  │
│  │  AileFertSvc   │  │  TutanakSvc    │  │  ReportSvc   │  │
│  │  MernisSvc     │  │  FileStoSvc    │  │  LookupSvc   │  │
│  └────────────────┘  └────────────────┘  └──────────────┘  │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                    REPOSITORY LAYER                          │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Spring Data JPA Repositories (24 repositories)      │   │
│  │  - Automatic CRUD operations                         │   │
│  │  - Custom query methods                              │   │
│  │  - Named queries                                     │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                      ENTITY LAYER                            │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐  │
│  │  JPA Entities  │  │      DTOs      │  │   Mappers    │  │
│  │  (28 classes)  │  │  (11 classes)  │  │ (MapStruct)  │  │
│  └────────────────┘  └────────────────┘  └──────────────┘  │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                     DATABASE LAYER                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │           MySQL Database (28+ tables)                │   │
│  │  - Referential integrity                             │   │
│  │  - Indexes for performance                           │   │
│  │  - Audit columns                                     │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 Katmanlı Mimari Prensipleri

#### ✅ Separation of Concerns (SoC)
- Her katman kendi sorumluluğuna odaklanır
- Controller sadece HTTP isteklerini yönetir
- Service iş mantığını içerir
- Repository veri erişimini sağlar

#### ✅ Dependency Injection
- Spring IoC Container ile bağımlılık yönetimi
- Constructor injection kullanımı (@RequiredArgsConstructor)
- Loosely coupled components

#### ✅ Single Responsibility Principle
- Her sınıf tek bir işi yapar
- MuracaatService → Sadece müracaat işlemleri
- KisiService → Sadece kişi işlemleri

---

## 4. VERİTABANI TASARIMI

### 4.1 Entity Relationship Diagram (ERD)

```
┌──────────────────────────────────────────────────────────────────┐
│                    CORE ENTITIES                                  │
└──────────────────────────────────────────────────────────────────┘

                    ┌─────────────┐
                    │  PERSONEL   │
                    ├─────────────┤
                    │ id (PK)     │
                    │ tc_kimlik_no│
                    │ ad          │
                    │ soyad       │
                    │ tahkikat_   │
                    │   yetkili   │
                    └──────┬──────┘
                           │ (kaydeden)
                           │
         ┌─────────────────▼─────────────────┐
         │         MURACAAT (CORE)           │
         ├───────────────────────────────────┤
         │ id (PK)                           │
         │ muracaat_no (UNIQUE)              │
         │ basvuru_sahibi_id (FK) ──────┐    │
         │ komisyon_kararli              │    │
         │ muracaat_tarihi               │    │
         │ durum (ENUM)                  │    │
         │ karar_no                      │    │
         │ karar_tarihi                  │    │
         └────┬──────────┬──────────┬────┘    │
              │          │          │         │
              │          │          │         │
    ┌─────────▼──┐  ┌───▼─────┐ ┌─▼──────┐  │
    │ AILE_FERT  │  │ AILE_   │ │TUTANAK │  │
    │            │  │ MADDI_  │ │BILGISI │  │
    │            │  │ DURUM   │ │        │  │
    └─────┬──────┘  └────┬────┘ └────────┘  │
          │              │                   │
          │              │                   │
    ┌─────▼──────┐  ┌────▼────────┐         │
    │   KISI     │◄─┘ GELIR/BORC/ │         │
    │            │   GAYRIMENKUL  │         │
    └────────────┘   └─────────────┘         │
                                              │
    ┌─────────────────────────────────────────┘
    │
    │    ┌──────────────┐
    └───►│    KISI      │
         ├──────────────┤
         │ id (PK)      │
         │ tc_kimlik_no │
         │ ad           │
         │ soyad        │
         │ dogum_tarihi │
         │ adres        │
         │ gebze_ikameti│
         └──────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                    LOOKUP TABLES (13 adet)                        │
└──────────────────────────────────────────────────────────────────┘

┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│YAKINLIK_KODU │  │   MESLEK     │  │ OZEL_STATU   │
├──────────────┤  ├──────────────┤  ├──────────────┤
│ id (PK)      │  │ id (PK)      │  │ id (PK)      │
│ kod          │  │ kod          │  │ kod          │
│ adi          │  │ adi          │  │ adi          │
└──────────────┘  └──────────────┘  └──────────────┘

┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  HASTALIK    │  │ ENGELLI_TIPI │  │  GELIR_TURU  │
├──────────────┤  ├──────────────┤  ├──────────────┤
│ id (PK)      │  │ id (PK)      │  │ id (PK)      │
│ kod          │  │ kod          │  │ kod          │
│ adi          │  │ adi          │  │ adi          │
└──────────────┘  └──────────────┘  └──────────────┘

┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  BORC_TURU   │  │YARDIM_ALT_   │  │YARDIM_RED_   │
│              │  │    TIPI      │  │   SEBEBI     │
├──────────────┤  ├──────────────┤  ├──────────────┤
│ id (PK)      │  │ id (PK)      │  │ id (PK)      │
│ kod          │  │ kod          │  │ kod          │
│ adi          │  │ yardim_tipi  │  │ adi          │
└──────────────┘  └──────────────┘  └──────────────┘
```

### 4.2 İlişkisel Bütünlük (Referential Integrity)

#### Core Entity: MURACAAT

```sql
-- Müracaat merkezi entity'dir, tüm ilişkileri cascade delete ile yönetir

MURACAAT (1) ──────────────── (N) AILE_FERT
         (1) ──────────────── (1) AILE_MADDI_DURUM
         (1) ──────────────── (1) TUTANAK_BILGISI
         (1) ──────────────── (N) YARDIM_KARAR
         (1) ──────────────── (N) MURACAAT_DOKUMAN
         (1) ──────────────── (N) MURACAAT_YARDIM_TALEP

-- İlişki Tipleri:
• One-to-One   : AileMaddiDurum, TutanakBilgisi
• One-to-Many  : AileFert, YardimKarar, Dokuman
• Many-to-One  : Kisi (BasvuruSahibi)
```

#### JPA Mapping Stratejisi

```java
// Muracaat Entity - Cascade ve Orphan Removal
@Entity
public class Muracaat extends BaseEntity {

    // One-to-Many: Cascade ALL + Orphan Removal
    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,
               orphanRemoval = true)
    private List<AileFert> aileFertleri = new ArrayList<>();

    // One-to-One: Cascade ALL + Orphan Removal
    @OneToOne(mappedBy = "muracaat",
              cascade = CascadeType.ALL,
              orphanRemoval = true)
    private AileMaddiDurum aileMaddiDurum;

    // Many-to-One: EAGER fetch (performans için)
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "basvuru_sahibi_id")
    private Kisi basvuruSahibi;
}
```

### 4.3 Veritabanı İndeksleme Stratejisi

```sql
-- Performance optimization için indexler

-- 1. UNIQUE Indexes (Business key constraints)
CREATE UNIQUE INDEX idx_muracaat_no ON muracaat(muracaat_no);
CREATE UNIQUE INDEX idx_kisi_tc ON kisi(tc_kimlik_no);

-- 2. Foreign Key Indexes
CREATE INDEX idx_aile_fert_muracaat ON aile_fert(muracaat_id);
CREATE INDEX idx_aile_fert_kisi ON aile_fert(kisi_id);
CREATE INDEX idx_yardim_karar_muracaat ON yardim_karar(muracaat_id);

-- 3. Search/Filter Indexes
CREATE INDEX idx_muracaat_durum ON muracaat(durum);
CREATE INDEX idx_muracaat_tarih ON muracaat(muracaat_tarihi);
CREATE INDEX idx_yardim_karar_durum ON yardim_karar(yardim_durum);

-- 4. Composite Indexes (çok kullanılan sorgular için)
CREATE INDEX idx_muracaat_durum_tarih ON muracaat(durum, muracaat_tarihi);
```

### 4.4 Audit Trail Yapısı

```java
// BaseEntity - Tüm entity'lerin parent'ı
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseEntity implements Serializable {

    @CreatedDate
    @Column(name = "olusturma_tarihi", nullable = false, updatable = false)
    private LocalDateTime olusturmaTarihi;

    @LastModifiedDate
    @Column(name = "guncelleme_tarihi")
    private LocalDateTime guncellemeTarihi;

    @CreatedBy
    @Column(name = "olusturan", length = 100, updatable = false)
    private String olusturan;

    @LastModifiedBy
    @Column(name = "guncelleyen", length = 100)
    private String guncelleyen;

    @Column(name = "aktif")
    private Boolean aktif = true;  // Soft delete flag
}

// Spring JPA Auditing Configuration
@Configuration
@EnableJpaAuditing
public class JpaConfig {
    @Bean
    public AuditorAware<String> auditorAware() {
        return new AuditorAwareImpl();
    }
}
```

**Audit Trail Faydaları:**
- ✅ Kim, ne zaman, hangi kaydı oluşturdu? → Tam izlenebilirlik
- ✅ Kim, ne zaman, hangi kaydı güncelledi? → Değişiklik geçmişi
- ✅ Soft delete ile veri kaybı yok → Aktif/Pasif flag
- ✅ Compliance ve yasal zorunluluklar → Audit log

### 4.5 Enumeration Yönetimi

```java
// Database'de VARCHAR olarak saklanır (STRING strategy)

@Enumerated(EnumType.STRING)
@Column(name = "durum", nullable = false)
private MuracaatDurum durum = MuracaatDurum.BEKLEMEDE;

// Enum tanımları
public enum MuracaatDurum {
    TALEP_IPTAL_EDILDI,
    BASVURU_SAHIBINE_ULASILMADI,
    BEKLEMEDE,
    TAHKIKATA_SEVK,
    DEGERLENDIRME_KOMISYONU,
    SONUCLANDI,
    BASVURU_SAHIBI_VEFAT_ETTI
}

public enum YardimTipi {
    NAKDI,      // Nakit yardım
    AYNI,       // Ayni yardım (kömür, gıda vb)
    SAGLIK,     // Sağlık yardımı
    EGITIM,     // Eğitim yardımı
    BARIS,      // Barınma yardımı
    DIGER       // Diğer
}

public enum YardimDurum {
    KABUL_EDILDI,
    RED_EDILDI
}
```

**Enum Kullanım Avantajları:**
- ✅ Type-safe (Tip güvenli)
- ✅ Database'de okunabilir (STRING olarak)
- ✅ Kod değişikliğinde migration gerektirmez
- ✅ IDE autocomplete desteği

---

## 5. KATMANLI MİMARİ DETAYLARI

### 5.1 Controller Layer (Presentation)

#### JSF Backing Bean Pattern

```java
@Component("muracaatController")
@ViewScoped  // JSF view scope - sayfa boyunca yaşar
@Getter
@Setter
@Slf4j
public class MuracaatController implements Serializable {

    // Dependency Injection (Constructor-based)
    private final MuracaatService muracaatService;
    private final KisiService kisiService;
    private final YardimService yardimService;

    // View state management
    private Muracaat selectedMuracaat;
    private int activeTabIndex = 0;
    private boolean muracaatTamamlandi = false;

    @PostConstruct
    public void init() {
        // Controller başlatma
        loadYardimTipleri();
        newMuracaat();
    }

    // Action methods (JSF'den çağrılır)
    public void saveMuracaat() {
        try {
            // Business logic delegation
            Muracaat saved = muracaatService.create(selectedMuracaat);
            MessageUtil.showInfoMessage("Başarılı", "Müracaat kaydedildi");
        } catch (BusinessException e) {
            MessageUtil.showErrorMessage("Hata", e.getMessage());
        }
    }
}
```

**Controller Sorumlulukları:**
- 🎯 HTTP request/response yönetimi
- 🎯 View state management
- 🎯 Service layer'a delegation
- 🎯 User feedback (messages)
- 🎯 Navigation control

### 5.2 Service Layer (Business Logic)

#### Service Pattern Implementation

```java
@Service
@RequiredArgsConstructor  // Lombok - Constructor injection
@Slf4j
@Transactional  // Tüm metodlar transactional
public class MuracaatService {

    // Repository dependencies
    private final MuracaatRepository muracaatRepository;
    private final AileFertRepository aileFertRepository;
    private final MuracaatMapper muracaatMapper;

    // Business method
    public Muracaat create(Muracaat muracaat) {
        // 1. Validation
        validateMuracaat(muracaat);

        // 2. Business rule check
        if (muracaatRepository.existsSonuclanmamisMuracaat(
                muracaat.getBasvuruSahibi().getId())) {
            throw new BusinessException(
                "Başvuru sahibinin sonuçlanmamış müracaatı var");
        }

        // 3. Auto-increment logic
        if (muracaat.getMuracaatNo() == null) {
            Long sonNo = getSonMuracaatNo();
            muracaat.setMuracaatNo(sonNo + 1);
        }

        // 4. Default values
        if (muracaat.getMuracaatTarihi() == null) {
            muracaat.setMuracaatTarihi(LocalDate.now());
        }

        // 5. Persist
        return muracaatRepository.save(muracaat);
    }

    // State transition validation
    private void validateDurumGecisi(MuracaatDurum eskiDurum,
                                      MuracaatDurum yeniDurum,
                                      Muracaat muracaat) {
        if (eskiDurum == MuracaatDurum.SONUCLANDI) {
            throw new BusinessException("Sonuçlanmış müracaat açılamaz");
        }

        if (yeniDurum == MuracaatDurum.TAHKIKATA_SEVK) {
            long aileFertSayisi = aileFertRepository
                .countByMuracaatId(muracaat.getId());
            if (aileFertSayisi == 0) {
                throw new BusinessException(
                    "Tahkikata sevk için aile fert bilgileri gerekli");
            }
        }
    }
}
```

**Service Layer Sorumlulukları:**
- 💼 Business logic implementation
- 💼 Transaction management (@Transactional)
- 💼 Validation & business rules
- 💼 Exception handling
- 💼 Repository coordination

#### Transaction Management

```java
// Class-level transaction
@Transactional  // Tüm metodlar için default

// Method-level read-only optimization
@Transactional(readOnly = true)
public List<Muracaat> findAll() {
    return muracaatRepository.findAllWithBasvuruSahibi();
}

// Programmatic transaction (gerekirse)
@Transactional(
    propagation = Propagation.REQUIRES_NEW,
    isolation = Isolation.READ_COMMITTED,
    timeout = 30
)
public void complexOperation() {
    // Complex logic
}
```

### 5.3 Repository Layer (Data Access)

#### Spring Data JPA Repository Pattern

```java
@Repository
public interface MuracaatRepository extends JpaRepository<Muracaat, Long> {

    // Query method naming convention
    Optional<Muracaat> findByMuracaatNo(Long muracaatNo);
    List<Muracaat> findByDurum(MuracaatDurum durum);
    List<Muracaat> findByBasvuruSahibiId(Long kisiId);

    // @Query annotation ile custom JPQL
    @Query("SELECT m FROM Muracaat m " +
           "JOIN FETCH m.basvuruSahibi " +
           "WHERE m.aktif = true " +
           "ORDER BY m.muracaatTarihi DESC")
    List<Muracaat> findAllWithBasvuruSahibi();

    // Named parameter ile custom query
    @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END " +
           "FROM Muracaat m " +
           "WHERE m.basvuruSahibi.id = :kisiId " +
           "AND m.durum != 'SONUCLANDI' " +
           "AND m.aktif = true")
    boolean existsSonuclanmamisMuracaat(@Param("kisiId") Long kisiId);

    // Aggregate functions
    @Query("SELECT MAX(m.muracaatNo) FROM Muracaat m WHERE m.aktif = true")
    Optional<Long> findMaxMuracaatNo();

    // Delete operations
    @Modifying
    @Query("DELETE FROM Muracaat m WHERE m.id = :muracaatId")
    void deleteByMuracaatId(@Param("muracaatId") Long muracaatId);
}
```

**Repository Avantajları:**
- ✅ Zero boilerplate code
- ✅ Automatic CRUD operations
- ✅ Type-safe queries
- ✅ Pagination & sorting built-in
- ✅ Custom queries with @Query

### 5.4 Entity Layer (Domain Model)

#### JPA Entity Best Practices

```java
@Entity
@Table(name = "muracaat", indexes = {
    @Index(name = "idx_muracaat_no", columnList = "muracaat_no"),
    @Index(name = "idx_muracaat_durum", columnList = "durum")
})
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Muracaat extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "muracaat_no", nullable = false, unique = true)
    private Long muracaatNo;

    // Relationships
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "basvuru_sahibi_id", nullable = false)
    private Kisi basvuruSahibi;

    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,
               orphanRemoval = true)
    @Builder.Default
    private List<AileFert> aileFertleri = new ArrayList<>();

    // Helper methods for bidirectional relationships
    public void addAileFert(AileFert fert) {
        aileFertleri.add(fert);
        fert.setMuracaat(this);  // Sync bidirectional
    }

    public void removeAileFert(AileFert fert) {
        aileFertleri.remove(fert);
        fert.setMuracaat(null);  // Break relationship
    }
}
```

**Entity Design Principles:**
- 📦 Rich domain model (helper methods)
- 📦 Bidirectional sync management
- 📦 Cascade operations
- 📦 Lombok annotations
- 📦 Builder pattern support

### 5.5 DTO & Mapping Layer

#### DTO Pattern

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MuracaatDTO {
    private Long id;
    private Long muracaatNo;
    private String basvuruSahibiAdSoyad;  // Computed field
    private String basvuruSahibiTcNo;
    private Boolean komisyonKararli;
    private LocalDate muracaatTarihi;
    private MuracaatDurum durum;
    private Long kararNo;
}
```

#### MapStruct Mapper

```java
@Mapper(componentModel = "spring")
public interface MuracaatMapper {

    // Entity -> DTO with nested mapping
    @Mapping(source = "basvuruSahibi.adSoyad",
             target = "basvuruSahibiAdSoyad")
    @Mapping(source = "basvuruSahibi.tcKimlikNo",
             target = "basvuruSahibiTcNo")
    MuracaatDTO toDto(Muracaat muracaat);

    // DTO -> Entity
    Muracaat toEntity(MuracaatDTO dto);

    // List mapping
    List<MuracaatDTO> toDtoList(List<Muracaat> muracaatlar);
}
```

**MapStruct Avantajları:**
- 🚀 Compile-time generation (runtime overhead yok)
- 🚀 Type-safe mapping
- 🚀 Nested property mapping
- 🚀 Custom mapping strategies
- 🚀 Zero reflection

---

## 6. TASARIM DESENLERİ

### 6.1 Kullanılan Design Patterns

#### 1. Repository Pattern
```
Purpose: Data access abstraction
Implementation: Spring Data JPA
Benefit: Database agnostic, testable
```

#### 2. Service Layer Pattern
```
Purpose: Business logic encapsulation
Implementation: @Service stereotype
Benefit: Reusable, transactional
```

#### 3. DTO Pattern
```
Purpose: Data transfer optimization
Implementation: Dedicated DTO classes
Benefit: Decoupling, security
```

#### 4. Builder Pattern
```
Purpose: Object construction
Implementation: Lombok @Builder
Benefit: Readable, immutable
```

#### 5. Template Method Pattern
```
Purpose: Common workflow
Implementation: BaseEntity (audit)
Benefit: Code reuse, consistency
```

#### 6. Strategy Pattern
```
Purpose: Algorithm selection
Implementation: Report exporters
Benefit: Extensible, maintainable
```

### 6.2 SOLID Principles Application

#### Single Responsibility Principle (SRP)
```java
// ✅ Good: Her service tek sorumluluk
MuracaatService  → Sadece müracaat yönetimi
KisiService      → Sadece kişi yönetimi
FileStorageService → Sadece dosya işlemleri

// ❌ Bad: God class anti-pattern
ApplicationService → Her şeyi yapan servis (YANLIŞ!)
```

#### Open/Closed Principle (OCP)
```java
// Extension point: Report export strategy
public interface ReportExporter {
    void export(JasperPrint print, OutputStream out);
}

// Open for extension
public class PdfReportExporter implements ReportExporter {
    @Override
    public void export(JasperPrint print, OutputStream out) {
        // PDF specific logic
    }
}

// Closed for modification
public class ExcelReportExporter implements ReportExporter {
    @Override
    public void export(JasperPrint print, OutputStream out) {
        // Excel specific logic
    }
}
```

#### Liskov Substitution Principle (LSP)
```java
// BaseEntity can be substituted by any entity
public abstract class BaseEntity {
    // Common audit fields
}

// All entities extend BaseEntity
public class Muracaat extends BaseEntity { }
public class Kisi extends BaseEntity { }
public class YardimKarar extends BaseEntity { }
```

#### Interface Segregation Principle (ISP)
```java
// ✅ Good: Specific interfaces
public interface FileStorageService {
    String storeFile(MultipartFile file, String path);
    Resource loadFileAsResource(String fileName, String path);
}

// ❌ Bad: Fat interface
public interface ApplicationService {
    // Çok fazla metod (YANLIŞ!)
}
```

#### Dependency Inversion Principle (DIP)
```java
// High-level module depends on abstraction
public class MuracaatService {
    private final MuracaatRepository repository;  // Interface
    // Not concrete implementation
}

// Low-level module implements abstraction
@Repository
public interface MuracaatRepository extends JpaRepository<...> {
    // Spring provides implementation
}
```

---

## 7. İŞ AKIŞLARI (WORKFLOWS)

### 7.1 Komisyonlu Müracaat İş Akışı

```
┌─────────────────────────────────────────────────────────────────┐
│           KOMISYONLU MÜRACAAT İŞ AKIŞI (7 ADIM)                  │
└─────────────────────────────────────────────────────────────────┘

ADIM 1: MÜRACAAT KAYDI
├─ TC No ile MERNİS sorgusu
├─ Kişi bilgileri otomatik doldurulur
├─ Gebze ikameti kontrolü
├─ Başvuru metni girişi
├─ Yardım talepleri seçimi
└─ Durum: BEKLEMEDE

         │
         ▼

ADIM 2: AİLE FERTLERİ KAYDI
├─ Her aile ferdi için MERNİS sorgusu
├─ Yakınlık ilişkisi tanımlama
├─ SGK ve öğrenim durumu
├─ Hastalık/engellilik bilgileri
└─ En az 1 aile ferdi zorunlu

         │
         ▼

ADIM 3: MADDİ DURUM DEĞERLENDİRMESİ
├─ Gelir bilgileri (türüne göre)
│  └─ Maaş, emekli maaşı, kira, ticari
├─ Borç bilgileri (türüne göre)
│  └─ Kredi kartı, banka, vs.
├─ Gayrimenkul bilgileri
│  └─ Ev, araba, diğer mülkler
└─ Toplam gelir/borç hesaplama

         │
         ▼

ADIM 4: TAHKİKATA SEVK
├─ Durum geçiş kontrolü
│  └─ Aile fert kaydı var mı?
├─ Tahkikat personeli atama
├─ Durum: TAHKIKATA_SEVK
└─ Tutanak sekmesi aktif olur

         │
         ▼

ADIM 5: TUTANAK OLUŞTURMA
├─ Yerinde inceleme tarihi
├─ Tahkikat metni yazma
├─ Ev görselleri ekleme
├─ İnceleme notları
└─ Tutanak tamamlandı

         │
         ▼

ADIM 6: DEĞERLENDİRME KOMİSYONU
├─ Durum: DEGERLENDIRME_KOMISYONU
├─ Sadece yardım kararı girilebilir
├─ Diğer sekmeler kilitli
└─ Komisyon toplantı tarihi

         │
         ▼

ADIM 7: YARDIM KARARI & KESİNLEŞTİRME
├─ Yardım tipleri belirleme
│  ├─ KABUL ise → Tutar/Dönem
│  └─ RED ise → Red sebebi
├─ Komisyon kararı kesinleştir
├─ Otomatik karar no oluşturulur
├─ Durum: SONUCLANDI
└─ Müracaat tamamlandı ✓

```

### 7.2 Komisyonsuz Müracaat İş Akışı

```
┌─────────────────────────────────────────────────────────────────┐
│         KOMİSYONSUZ MÜRACAAT İŞ AKIŞI (2 ADIM)                   │
└─────────────────────────────────────────────────────────────────┘

ADIM 1: MÜRACAAT KAYDI
├─ TC No ile MERNİS sorgusu
├─ komisyon_kararli = FALSE
├─ Basit yardımlar için (acil durum)
├─ Başvuru metni girişi
├─ Komisyonsuz yardım tipleri seçimi
└─ Durum: BEKLEMEDE

         │
         ▼

ADIM 2: YARDIM KARARI & TAMAMLAMA
├─ Doğrudan karar verme
├─ Tahkikat/komisyon gerektirmez
├─ Yardım tipi ve tutar belirleme
├─ Tamamla butonuna tıkla
├─ Durum: SONUCLANDI
└─ Müracaat tamamlandı ✓

Not: Karar no oluşturulmaz (komisyon kararlı değil)
```

### 7.3 State Machine (Durum Geçişleri)

```
┌──────────────────────────────────────────────────────────────┐
│               MÜRACAAT DURUM MAKİNESİ                         │
└──────────────────────────────────────────────────────────────┘

         ┌─────────────┐
    ┌───►│ BEKLEMEDE   │◄─── İlk durum (default)
    │    └──────┬──────┘
    │           │
    │           ├──► tahkikataSevkEt()
    │           │
    │    ┌──────▼─────────────┐
    │    │ TAHKIKATA_SEVK     │
    │    └──────┬─────────────┘
    │           │
    │           ├──► komisyonaGonder()
    │           │
    │    ┌──────▼──────────────────┐
    │    │ DEGERLENDIRME_KOMISYONU │
    │    └──────┬──────────────────┘
    │           │
    │           ├──► kesinlestir()
    │           │
    │    ┌──────▼──────────┐
    │    │  SONUCLANDI     │ (Final state)
    │    └─────────────────┘
    │
    │    Diğer durumlar:
    │    ┌───────────────────────────┐
    └────┤ TALEP_IPTAL_EDILDI        │ (İptal)
         ├───────────────────────────┤
         │ BASVURU_SAHIBINE_         │ (Ulaşılamadı)
         │   ULASILMADI              │
         ├───────────────────────────┤
         │ BASVURU_SAHIBI_VEFAT_ETTI │ (Vefat)
         └───────────────────────────┘

Validasyon Kuralları:
═══════════════════════════════════════════════════════════════
• TAHKIKATA_SEVK    → En az 1 aile ferdi gerekli
• DEG. KOMISYONU    → Tutanak + Maddi durum gerekli
• SONUCLANDI        → En az 1 yardım kararı gerekli
• SONUCLANDI'dan    → GERİ DÖNÜŞ YOK!
```

### 7.4 Business Rules Engine

```java
// İş kuralları merkezi yönetim

public class MuracaatBusinessRules {

    // Rule 1: Gebze İkamet Kontrolü
    public void checkGebzeResidence(Kisi kisi) {
        if (!kisi.getGebzeIkameti()) {
            throw new BusinessException(
                "Gebze dışından müracaat kabul edilmez");
        }
    }

    // Rule 2: Duplicate Müracaat Kontrolü
    public void checkDuplicateApplication(Long kisiId) {
        if (existsActiveMuracaat(kisiId)) {
            throw new BusinessException(
                "Kişinin sonuçlanmamış müracaatı var");
        }
    }

    // Rule 3: Minimum Başvuru Metni Uzunluğu
    public void checkMinimumTextLength(String text) {
        if (text.length() < MIN_TEXT_LENGTH) {
            throw new BusinessException(
                "Başvuru metni en az " + MIN_TEXT_LENGTH +
                " karakter olmalı");
        }
    }

    // Rule 4: State Transition Validation
    public void validateStateTransition(
            MuracaatDurum from,
            MuracaatDurum to,
            Muracaat muracaat) {

        if (from == SONUCLANDI) {
            throw new BusinessException(
                "Sonuçlanmış müracaat düzenlenemez");
        }

        if (to == TAHKIKATA_SEVK) {
            if (!hasAileFert(muracaat)) {
                throw new BusinessException(
                    "Tahkikat için aile fert gerekli");
            }
        }

        if (to == DEGERLENDIRME_KOMISYONU) {
            if (!hasTutanak(muracaat) ||
                !hasMaddiDurum(muracaat)) {
                throw new BusinessException(
                    "Komisyon için tutanak ve maddi durum gerekli");
            }
        }
    }
}
```

---

## 8. GÜVENLİK VE VALIDATION

### 8.1 Data Validation Strategy

#### Bean Validation (JSR-380)

```java
@Entity
public class Kisi extends BaseEntity {

    @Column(name = "tc_kimlik_no", nullable = false, unique = true)
    @NotBlank(message = "TC Kimlik No boş olamaz")
    @Pattern(regexp = "^[1-9][0-9]{10}$",
             message = "TC Kimlik No 11 haneli olmalı")
    private String tcKimlikNo;

    @NotBlank(message = "Ad boş olamaz")
    @Size(min = 2, max = 50, message = "Ad 2-50 karakter arası olmalı")
    private String ad;

    @Email(message = "Geçerli bir email adresi giriniz")
    private String email;

    @Past(message = "Doğum tarihi geçmişte olmalı")
    private LocalDate dogumTarihi;
}
```

#### Custom Validation

```java
// Custom validator annotation
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = IbanValidator.class)
public @interface ValidIban {
    String message() default "Geçersiz IBAN formatı";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}

// Validator implementation
public class IbanValidator
        implements ConstraintValidator<ValidIban, String> {

    @Override
    public boolean isValid(String iban,
                          ConstraintValidatorContext context) {
        if (iban == null || iban.isEmpty()) {
            return true;  // @NotBlank ayrı kontrol eder
        }

        // IBAN format: TR00 0000 0000 0000 0000 0000 00
        return iban.matches("^TR\\d{24}$");
    }
}

// Usage
@ValidIban
@Column(name = "iban", length = 26)
private String iban;
```

### 8.2 File Upload Security

```java
@Service
public class FileStorageServiceImpl implements FileStorageService {

    private static final Set<String> ALLOWED_EXTENSIONS = Set.of(
        "pdf", "doc", "docx", "jpg", "jpeg", "png",
        "gif", "xls", "xlsx", "txt"
    );

    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

    public String storeFile(MultipartFile file, String subPath) {
        // 1. Null check
        if (file.isEmpty()) {
            throw new FileStorageException("Dosya boş olamaz");
        }

        // 2. Size validation
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new FileStorageException(
                "Dosya boyutu 10MB'dan küçük olmalı");
        }

        // 3. Extension validation
        String fileName = file.getOriginalFilename();
        String extension = getFileExtension(fileName);
        if (!ALLOWED_EXTENSIONS.contains(extension.toLowerCase())) {
            throw new FileStorageException(
                "İzin verilmeyen dosya tipi: " + extension);
        }

        // 4. Path traversal prevention
        String sanitizedFileName = sanitizeFileName(fileName);

        // 5. Unique filename generation
        String uniqueFileName = generateUniqueFileName(sanitizedFileName);

        // 6. Safe path construction
        Path targetLocation = constructSafePath(subPath, uniqueFileName);

        // 7. Store file
        Files.copy(file.getInputStream(), targetLocation,
                   StandardCopyOption.REPLACE_EXISTING);

        return uniqueFileName;
    }

    private String sanitizeFileName(String fileName) {
        // Remove path traversal characters
        return fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}
```

**Security Measures:**
- ✅ File type whitelist (sadece izin verilen tipler)
- ✅ File size limit (10MB maksimum)
- ✅ Path traversal prevention (../../../etc/passwd engelleme)
- ✅ Filename sanitization (zararlı karakterler temizleme)
- ✅ Unique filename generation (collision prevention)

### 8.3 SQL Injection Prevention

```java
// ✅ SAFE: Parameterized queries (JPA)
@Query("SELECT m FROM Muracaat m WHERE m.muracaatNo = :no")
Optional<Muracaat> findByMuracaatNo(@Param("no") Long muracaatNo);

// ✅ SAFE: Query method naming
List<Muracaat> findByBasvuruSahibiTcKimlikNo(String tcNo);

// ❌ UNSAFE: String concatenation (ASLA YAPMAYIN!)
// String query = "SELECT * FROM muracaat WHERE no = " + input;
```

### 8.4 Exception Handling Strategy

```java
// Global exception handler (Optional - REST için)
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ErrorResponse> handleBusinessException(
            BusinessException ex) {
        ErrorResponse error = new ErrorResponse(
            LocalDateTime.now(),
            HttpStatus.BAD_REQUEST.value(),
            ex.getMessage()
        );
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFoundException(
            ResourceNotFoundException ex) {
        ErrorResponse error = new ErrorResponse(
            LocalDateTime.now(),
            HttpStatus.NOT_FOUND.value(),
            ex.getMessage()
        );
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }
}

// Custom exceptions
public class BusinessException extends RuntimeException {
    public BusinessException(String message) {
        super(message);
    }
}

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String resource,
                                     String field,
                                     Object value) {
        super(String.format("%s not found with %s: '%s'",
                           resource, field, value));
    }
}
```

---

## 9. PERFORMANS OPTİMİZASYONLARI

### 9.1 JPA Fetch Strategy

```java
// Problem: N+1 Query Problem
// ❌ BAD: Lazy loading ile N+1 sorgu
@ManyToOne(fetch = FetchType.LAZY)
private Kisi basvuruSahibi;

List<Muracaat> list = muracaatRepository.findAll();
for (Muracaat m : list) {
    System.out.println(m.getBasvuruSahibi().getAd());  // Her seferinde query!
}

// ✅ GOOD: EAGER fetch veya JOIN FETCH
@Query("SELECT m FROM Muracaat m " +
       "JOIN FETCH m.basvuruSahibi " +
       "WHERE m.aktif = true")
List<Muracaat> findAllWithBasvuruSahibi();
```

#### Fetch Strategy Matrix

| Relationship | Default | Recommended | Reason |
|--------------|---------|-------------|--------|
| @ManyToOne | EAGER | EAGER | Genelde gerekli |
| @OneToMany | LAZY | LAZY | Büyük koleksiyonlar |
| @OneToOne | EAGER | EAGER | Tek nesne |
| @ManyToMany | LAZY | LAZY | Çok fazla data |

### 9.2 Database Indexing

```java
// Entity-level index definition
@Table(name = "muracaat", indexes = {
    @Index(name = "idx_muracaat_no", columnList = "muracaat_no"),
    @Index(name = "idx_muracaat_durum", columnList = "durum"),
    @Index(name = "idx_muracaat_tarih", columnList = "muracaat_tarihi")
})
public class Muracaat extends BaseEntity {
    // ...
}

// Query performance improvement
// Without index: Full table scan O(n)
// With index: B-tree search O(log n)
```

### 9.3 Transaction Optimization

```java
// ✅ GOOD: Read-only transactions (no dirty checking)
@Transactional(readOnly = true)
public List<Muracaat> findAll() {
    return muracaatRepository.findAll();
}

// ✅ GOOD: Batch operations
@Transactional
public void saveBatch(List<AileFert> fertler) {
    int batchSize = 20;
    for (int i = 0; i < fertler.size(); i++) {
        aileFertRepository.save(fertler.get(i));
        if (i % batchSize == 0 && i > 0) {
            entityManager.flush();
            entityManager.clear();
        }
    }
}
```

### 9.4 Caching Strategy (Gelecek İyileştirme)

```java
// Optional: Spring Cache abstraction
@Cacheable(value = "yardimTipleri")
public List<YardimAltTipi> findAllYardimAltTipleri() {
    return yardimAltTipiRepository.findAll();
}

@CacheEvict(value = "yardimTipleri", allEntries = true)
public YardimAltTipi saveYardimTipi(YardimAltTipi tipi) {
    return yardimAltTipiRepository.save(tipi);
}
```

---

## 10. RAPORLAMA SİSTEMİ

### 10.1 JasperReports Architecture

```
┌────────────────────────────────────────────────────────────┐
│              JASPERREPORTS WORKFLOW                         │
└────────────────────────────────────────────────────────────┘

STEP 1: DESIGN (.jrxml)
├─ iReport Designer / Jaspersoft Studio
├─ XML-based template
└─ Fields, variables, styles

         │ Compile
         ▼

STEP 2: COMPILE (.jasper)
├─ JasperCompileManager
├─ Binary format
└─ Runtime ready

         │ Fill Data
         ▼

STEP 3: FILL DATA (JasperPrint)
├─ JasperFillManager
├─ Data source (JDBC, Java Beans, XML)
├─ Parameters
└─ In-memory print object

         │ Export
         ▼

STEP 4: EXPORT (PDF / Excel)
├─ JasperExportManager (PDF)
├─ JRXlsExporter (Excel)
└─ Output stream
```

### 10.2 Report Service Implementation

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class ReportService {

    private final JasperReportsConfig jasperConfig;
    private final ReportCompiler reportCompiler;

    public byte[] generateMuracaatListesi(
            LocalDate baslangic,
            LocalDate bitis,
            String format) {

        try {
            // 1. Compile report template
            JasperReport jasperReport = reportCompiler.compile(
                "classpath:reports/muracaat-liste.jrxml");

            // 2. Prepare parameters
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("BASLANGIC_TARIHI", baslangic);
            parameters.put("BITIS_TARIHI", bitis);
            parameters.put("RAPOR_TARIHI", LocalDate.now());

            // 3. Prepare data source (JPA query)
            List<Muracaat> data = muracaatRepository
                .findByMuracaatTarihiBetween(baslangic, bitis);

            JRBeanCollectionDataSource dataSource =
                new JRBeanCollectionDataSource(data);

            // 4. Fill report
            JasperPrint jasperPrint = JasperFillManager.fillReport(
                jasperReport, parameters, dataSource);

            // 5. Export to format
            if ("pdf".equalsIgnoreCase(format)) {
                return JasperExportManager.exportReportToPdf(jasperPrint);
            } else if ("xlsx".equalsIgnoreCase(format)) {
                return exportToExcel(jasperPrint);
            }

        } catch (Exception e) {
            log.error("Rapor oluşturma hatası", e);
            throw new ReportGenerationException(
                "Rapor oluşturulamadı: " + e.getMessage());
        }
    }

    private byte[] exportToExcel(JasperPrint print) throws Exception {
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        JRXlsxExporter exporter = new JRXlsxExporter();
        exporter.setExporterInput(new SimpleExporterInput(print));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(out));

        SimpleXlsxReportConfiguration config =
            new SimpleXlsxReportConfiguration();
        config.setDetectCellType(true);
        config.setCollapseRowSpan(false);
        exporter.setConfiguration(config);

        exporter.exportReport();
        return out.toByteArray();
    }
}
```

### 10.3 Report Templates

```xml
<!-- muracaat-liste.jrxml örnek yapı -->
<?xml version="1.0" encoding="UTF-8"?>
<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports"
              name="muracaat_liste">

    <!-- Parameters -->
    <parameter name="BASLANGIC_TARIHI" class="java.time.LocalDate"/>
    <parameter name="BITIS_TARIHI" class="java.time.LocalDate"/>

    <!-- Fields from data source -->
    <field name="muracaatNo" class="java.lang.Long"/>
    <field name="basvuruSahibi.adSoyad" class="java.lang.String"/>
    <field name="muracaatTarihi" class="java.time.LocalDate"/>
    <field name="durum" class="com.sais.enums.MuracaatDurum"/>

    <!-- Title Band -->
    <title>
        <band height="60">
            <staticText>
                <text>Müracaat Listesi</text>
            </staticText>
        </band>
    </title>

    <!-- Column Header -->
    <columnHeader>
        <band height="30">
            <staticText><text>Müracaat No</text></staticText>
            <staticText><text>Başvuru Sahibi</text></staticText>
            <staticText><text>Tarih</text></staticText>
            <staticText><text>Durum</text></staticText>
        </band>
    </columnHeader>

    <!-- Detail Band -->
    <detail>
        <band height="20">
            <textField><textFieldExpression>$F{muracaatNo}</textFieldExpression></textField>
            <textField><textFieldExpression>$F{basvuruSahibi.adSoyad}</textFieldExpression></textField>
            <textField><textFieldExpression>$F{muracaatTarihi}</textFieldExpression></textField>
            <textField><textFieldExpression>$F{durum}</textFieldExpression></textField>
        </band>
    </detail>

</jasperReport>
```

### 10.4 Turkish Character Support

```yaml
# application-jasper.yml
jasper:
  reports:
    encoding: UTF-8
    font-name: DejaVu Sans
    pdf:
      force-linebreak-policy: true
      encoding: UTF-8
```

```xml
<!-- Font extension in .jrxml -->
<style name="DefaultStyle" isDefault="true">
    <font fontName="DejaVu Sans" size="10" pdfEncoding="UTF-8"/>
</style>
```

---

## 11. DEPLOYMENT & CONFIGURATION

### 11.1 Application Configuration

```yaml
# application.yml
server:
  port: 8080
  servlet:
    context-path: /sais
    encoding:
      charset: UTF-8
      enabled: true
      force: true

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/sais_db?useUnicode=true&characterEncoding=UTF-8
    username: root
    password: ${DB_PASSWORD:12345}  # Environment variable

  jpa:
    hibernate:
      ddl-auto: create  # Production'da "validate" olmalı
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQLDialect
        format_sql: true
    open-in-view: false  # Anti-pattern prevention

  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 20MB

logging:
  level:
    com.sais: INFO
    org.hibernate.SQL: WARN
```

### 11.2 Build & Packaging

```xml
<!-- pom.xml build configuration -->
<build>
    <plugins>
        <!-- Spring Boot Maven Plugin -->
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>

        <!-- Compiler Plugin -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.11.0</version>
            <configuration>
                <source>17</source>
                <target>17</target>
                <annotationProcessorPaths>
                    <!-- Lombok -->
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                    </path>
                    <!-- MapStruct -->
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
```

**Build Commands:**
```bash
# Clean & Package
mvn clean package

# Skip tests
mvn clean package -DskipTests

# Run application
java -jar target/sosyal-yardim-sistemi-1.0.0.jar

# Run with profile
java -jar target/sosyal-yardim-sistemi-1.0.0.jar --spring.profiles.active=prod
```

---

## 12. PROJE GÜÇLÜKLERİ VE ZAYIFLIKLAR

### 12.1 Güçlü Yönler

✅ **Katmanlı Mimari**
- Temiz kod organizasyonu
- Her katman kendi sorumluluğuna odaklanır
- Test edilebilir yapı

✅ **Modern Teknoloji Stack**
- Spring Boot 3.2.0 (Latest)
- Java 17 LTS
- JPA/Hibernate
- MapStruct (compile-time mapping)

✅ **Veritabanı Tasarımı**
- Normalize edilmiş şema
- Foreign key constraints
- Index optimizasyonları
- Audit trail

✅ **İş Kuralları Yönetimi**
- Merkezi validation
- State machine pattern
- Transaction management

✅ **Güvenlik**
- File upload validation
- SQL injection prevention
- Business rule enforcement

✅ **Raporlama**
- JasperReports entegrasyonu
- PDF/Excel export
- Turkish character support

### 12.2 İyileştirme Alanları

🔧 **Security & Authentication**
```
Eksik:
- Spring Security entegrasyonu
- Role-based access control (RBAC)
- JWT authentication
- Session management

Öneri:
- Spring Security ile login/logout
- USER, ADMIN, SUPERVISOR rolleri
- Method-level security (@PreAuthorize)
```

🔧 **API Layer**
```
Eksik:
- REST API endpoints
- OpenAPI/Swagger documentation
- Mobile app desteği

Öneri:
- @RestController ile REST API
- Springdoc OpenAPI
- Versioning strategy
```

🔧 **Testing**
```
Eksik:
- Unit tests
- Integration tests
- Test coverage

Öneri:
- JUnit 5 + Mockito
- @DataJpaTest for repositories
- @WebMvcTest for controllers
- Minimum %80 coverage
```

🔧 **Caching**
```
Eksik:
- Lookup table caching
- Query result caching

Öneri:
- Spring Cache + Caffeine
- Redis for distributed cache
```

🔧 **Monitoring & Logging**
```
Eksik:
- Application monitoring
- Performance metrics
- Centralized logging

Öneri:
- Spring Boot Actuator
- Prometheus + Grafana
- ELK Stack (Elasticsearch, Logstash, Kibana)
```

---

## 13. SONUÇ VE ÖNERİLER

### 13.1 Proje Özeti

SAIS projesi, **katmanlı mimari** ve **modern Java teknolojileri** kullanılarak geliştirilmiş, sosyal yardım süreçlerini dijitalleştiren kapsamlı bir enterprise uygulamadır.

**Teknik Başarılar:**
- ✅ Clean Architecture principles
- ✅ SOLID principles
- ✅ Design patterns (Repository, Service, DTO, Builder)
- ✅ Transaction management
- ✅ Audit trail
- ✅ File management
- ✅ Report generation

### 13.2 Gelecek Geliştirmeler

#### Faz 1: Security & Authentication (Öncelik: Yüksek)
```
- Spring Security entegrasyonu
- Role-based access control
- Session management
- Password encryption
```

#### Faz 2: Testing & Quality (Öncelik: Yüksek)
```
- Unit tests (%80+ coverage)
- Integration tests
- E2E tests
- SonarQube code quality
```

#### Faz 3: API & Integration (Öncelik: Orta)
```
- REST API development
- OpenAPI documentation
- External system integrations
```

#### Faz 4: Performance & Scalability (Öncelik: Orta)
```
- Redis caching
- Database query optimization
- Load balancing
- Horizontal scaling
```

#### Faz 5: Monitoring & DevOps (Öncelik: Düşük)
```
- Spring Boot Actuator
- Prometheus metrics
- Grafana dashboards
- CI/CD pipeline
- Docker containerization
```

### 13.3 Best Practices Checklist

- [x] Katmanlı mimari uygulandı
- [x] SOLID principles takip edildi
- [x] Transaction management yapıldı
- [x] Exception handling merkezi
- [x] Audit trail mevcut
- [x] File upload güvenli
- [ ] Security/Authentication yok
- [ ] Unit test coverage düşük
- [ ] REST API yok
- [ ] Caching yok
- [ ] Monitoring yok

---

## 14. EKLER

### 14.1 Kullanılan Annotation'lar

| Annotation | Kullanım | Amaç |
|------------|----------|------|
| @Entity | Entity class | JPA entity tanımı |
| @Service | Service class | Business logic layer |
| @Repository | Repository interface | Data access layer |
| @Controller | JSF bean | Presentation layer |
| @Transactional | Service method | Transaction boundary |
| @Builder | Entity/DTO | Builder pattern |
| @Getter/@Setter | Entity/DTO | Lombok boilerplate |
| @RequiredArgsConstructor | Service | Constructor injection |
| @Mapper | MapStruct interface | DTO mapping |
| @Query | Repository method | Custom JPQL |
| @Index | Entity table | Database index |
| @Enumerated | Enum field | Enum mapping |

### 14.2 Proje Klasör Yapısı

```
src/main/java/com/sais/
├── SaisApplication.java           # Main class
├── bean/                          # JSF beans
├── config/                        # Spring configurations
│   ├── JpaConfig.java
│   ├── JasperReportsConfig.java
│   └── FileStorageProperties.java
├── constants/                     # Constants
├── controller/                    # JSF controllers
│   ├── MuracaatController.java
│   ├── AileFertController.java
│   └── ...
├── dto/                          # Data Transfer Objects
├── entity/                       # JPA entities
│   ├── BaseEntity.java
│   ├── Muracaat.java
│   └── ...
├── enums/                        # Enumerations
├── exception/                    # Custom exceptions
├── mapper/                       # MapStruct mappers
├── repository/                   # Spring Data repositories
├── service/                      # Business services
│   ├── impl/                     # Service implementations
│   └── report/                   # Report services
└── util/                         # Utility classes

src/main/resources/
├── application.yml               # Main configuration
├── application-jasper.yml        # JasperReports config
├── database/
│   └── master-data.sql          # Initial data
├── reports/                     # JasperReports templates
└── static/                      # Static resources

src/main/webapp/
├── WEB-INF/
│   ├── web.xml
│   └── faces-config.xml
├── pages/                       # JSF pages
├── templates/                   # JSF templates
└── resources/                   # CSS/JS/Images
```

### 14.3 Veritabanı Tablo Listesi

| Tablo Adı | Kayıt Tipi | İlişkiler |
|-----------|------------|-----------|
| personel | Lookup | - |
| kisi | Core | - |
| muracaat | Core | Kisi, Personel |
| aile_fert | Transactional | Muracaat, Kisi |
| aile_maddi_durum | Transactional | Muracaat |
| gelir_bilgisi | Transactional | AileMaddiDurum |
| borc_bilgisi | Transactional | AileMaddiDurum |
| gayrimenkul_bilgisi | Transactional | AileMaddiDurum |
| tutanak_bilgisi | Transactional | Muracaat |
| yardim_karar | Transactional | Muracaat |
| muracaat_dokuman | Transactional | Muracaat |
| yakinlik_kodu | Lookup | - |
| meslek | Lookup | - |
| ozel_statu | Lookup | - |
| hastalik | Lookup | - |
| engelli_tipi | Lookup | - |
| gelir_turu | Lookup | - |
| borc_turu | Lookup | - |
| yardim_tipi | Lookup | - |
| yardim_alt_tipi | Lookup | - |
| yardim_dilimi | Lookup | - |
| yardim_donemi | Lookup | - |
| yardim_red_sebebi | Lookup | - |
| hesap_bilgisi | Lookup | - |

---

## SUNUM BİTİŞ

**Sorular için hazırım!**

---

**Proje Bilgileri:**
- **Proje Adı:** SAIS - Sosyal Yardım Bilgi Sistemi
- **Versiyon:** 1.0.0
- **Teknoloji:** Spring Boot 3.2.0 + JSF + JPA
- **Veritabanı:** MySQL 8.x
- **Java Version:** 17 (LTS)
- **Build Tool:** Maven 3.x

**İletişim:**
- GitHub: [Proje Repository]
- Dokümantasyon: /docs klasörü
- Database Schema: database-schema.md
