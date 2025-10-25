# SOSYAL YARDIM BİLGİ SİSTEMİ (SAIS)
# Teknik Mimari ve Tasarım Dökümanı

**Proje**: Sosyal Yardım Bilgi Sistemi
**Versiyon**: 1.0.0
**Teknoloji**: Spring Boot 3.2.0, Java 17, Oracle 19c
**Mimari**: Layered Architecture + Domain-Driven Design
**Tarih**: 2024

---

## İÇİNDEKİLER

1. [Proje Genel Bakış](#1-proje-genel-bakış)
2. [Teknoloji Stack ve Bağımlılıklar](#2-teknoloji-stack-ve-bağımlılıklar)
3. [Mimari Tasarım](#3-mimari-tasarım)
4. [Veritabanı Tasarımı ve İlişkiler](#4-veritabanı-tasarımı-ve-i̇lişkiler)
5. [Domain Model (Entity'ler)](#5-domain-model-entityler)
6. [Service Layer](#6-service-layer)
7. [Repository Layer](#7-repository-layer)
8. [Controller Layer](#8-controller-layer)
9. [DTO ve Mapper Pattern](#9-dto-ve-mapper-pattern)
10. [Configuration ve Infrastructure](#10-configuration-ve-infrastructure)
11. [Design Patterns](#11-design-patterns)
12. [API Referansı](#12-api-referansı)
13. [Güvenlik ve KVKK](#13-güvenlik-ve-kvkk)
14. [Performans Optimizasyonları](#14-performans-optimizasyonları)
15. [Test Stratejisi](#15-test-stratejisi)

---

## 1. PROJE GENEL BAKIŞ

### 1.1 Amaç

SAIS, belediye sosyal yardım süreçlerini dijitalleştiren enterprise bir uygulamadır:
- Müracaat kaydı ve takibi
- Kişi ve aile bilgileri yönetimi
- Maddi durum analizi
- Sosyal inceleme (tutanak) yönetimi
- Komisyon karar süreçleri
- Rapor ve istatistik

### 1.2 Proje İstatistikleri

```
Toplam Java Dosyası:     124
Entity Sayısı:           27
Repository Sayısı:       27
Service Sayısı:          15
Controller Sayısı:       6
Bean (JSF) Sayısı:       ~15
DTO Sayısı:              ~20
Mapper Sayısı:           ~10
Enum Sayısı:             5

Toplam Satır (LOC):      ~12,000
Test Coverage:           ~40% (hedef: %80)
```

### 1.3 Özellikler

#### Core Features
- ✅ TC Kimlik No doğrulama (MERNİS entegrasyonu)
- ✅ Müracaat workflow yönetimi
- ✅ Aile ekonomik durum analizi
- ✅ Sosyal inceleme raporlama
- ✅ Komisyon karar yönetimi
- ✅ Doküman yönetimi (PDF, resim)
- ✅ JasperReports ile raporlama

#### Teknik Özellikler
- ✅ Oracle 19c PDB desteği
- ✅ HikariCP connection pooling
- ✅ Hibernate auto-DDL
- ✅ Spring Data JPA
- ✅ JSF + PrimeFaces UI
- ✅ RESTful service layer
- ✅ Audit logging (BaseEntity)

---

## 2. TEKNOLOJİ STACK VE BAĞIMLILIKLAR

### 2.1 Core Framework

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.0</version>
</parent>

<properties>
    <java.version>17</java.version>
    <mapstruct.version>1.6.3</mapstruct.version>
    <lombok.version>1.18.30</lombok.version>
    <primefaces.version>13.0.0</primefaces.version>
    <joinfaces.version>5.3.3</joinfaces.version>
</properties>
```

### 2.2 Spring Boot Starters

| Dependency | Versiyon | Kullanım Amacı |
|------------|----------|----------------|
| **spring-boot-starter-data-jpa** | 3.2.0 | JPA/Hibernate ORM |
| **spring-boot-starter-validation** | 3.2.0 | Jakarta Bean Validation |
| **spring-boot-starter-web** | 3.2.0 | REST API (embedded Tomcat) |
| **spring-boot-starter-test** | 3.2.0 | Testing (JUnit 5, Mockito) |

### 2.3 Frontend Stack

| Dependency | Versiyon | Kullanım Amacı |
|------------|----------|----------------|
| **joinfaces (mojarra)** | 5.3.3 | Spring Boot + JSF integration |
| **PrimeFaces** | 13.0.0 (Jakarta) | UI Component Library |
| **OmniFaces** | 4.4.1 | JSF Utilities |

### 2.4 Database

| Dependency | Versiyon | Kullanım Amacı |
|------------|----------|----------------|
| **ojdbc11** | Latest (from parent) | Oracle 19c JDBC Driver |
| **HikariCP** | 5.1.0 (from Spring Boot) | Connection Pool |

### 2.5 Utility Libraries

| Dependency | Versiyon | Kullanım Amacı |
|------------|----------|----------------|
| **Lombok** | 1.18.30 | Boilerplate reduction (@Getter, @Builder) |
| **MapStruct** | 1.6.3 | DTO mapping (compile-time) |
| **Apache Commons Lang3** | 3.14.0 | Utility methods |
| **Commons FileUpload** | 1.5 | Multipart file handling |
| **Commons IO** | 2.15.1 | I/O operations |
| **JasperReports** | 6.21.0 | PDF report generation |
| **jasperreports-fonts** | 6.21.0 | Turkish character support |

### 2.6 Build Plugins

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.11.0</version>
    <configuration>
        <source>17</source>
        <target>17</target>
        <annotationProcessorPaths>
            <path><!-- Lombok --></path>
            <path><!-- MapStruct --></path>
            <path><!-- lombok-mapstruct-binding --></path>
        </annotationProcessorPaths>
    </configuration>
</plugin>
```

**Annotation Processors**:
1. **Lombok**: Getter/Setter/Builder otomatik üretimi
2. **MapStruct**: Entity-DTO mapping kodları compile-time üretimi
3. **lombok-mapstruct-binding**: Lombok + MapStruct uyumlu çalışması

---

## 3. MİMARİ TASARIM

### 3.1 Layered Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                         │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  JSF Managed Beans (@ViewScoped, @SessionScoped)        │ │
│  │  - MuracaatBean, KisiBean, AileFertBean                 │ │
│  │  - PrimeFaces UI Components                             │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  REST Controllers (@RestController)                     │ │
│  │  - MuracaatController, AileFertController               │ │
│  │  - JSON API endpoints                                   │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                    APPLICATION LAYER                          │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Business Services (@Service, @Transactional)           │ │
│  │  - MuracaatService, KisiService                         │ │
│  │  - MuracaatWorkflowService                              │ │
│  │  - Business logic & validation                          │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Integration Services                                   │ │
│  │  - MernisService (external API)                         │ │
│  │  - ReportService (JasperReports)                        │ │
│  │  - FileStorageService                                   │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                    PERSISTENCE LAYER                          │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Spring Data JPA Repositories                           │ │
│  │  - extends JpaRepository<Entity, Long>                  │ │
│  │  - Custom JPQL queries (@Query)                         │ │
│  │  - Query methods (findBy...)                            │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  JPA Entities (@Entity)                                 │ │
│  │  - BaseEntity (audit fields)                            │ │
│  │  - 27 domain entities                                   │ │
│  │  - Relationships (@OneToMany, @ManyToOne)               │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  DTOs (Data Transfer Objects)                           │ │
│  │  - Request/Response DTOs                                │ │
│  │  - MapStruct mappers                                    │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Enums                                                  │ │
│  │  - MuracaatDurum, YardimDurum, YardimTipi              │ │
│  │  - SGKDurum, OgrenimDurum                               │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                  INFRASTRUCTURE LAYER                         │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Configuration (@Configuration)                         │ │
│  │  - JpaConfig, SecurityConfig, WebConfig                 │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Exception Handling                                     │ │
│  │  - Global exception handlers                            │ │
│  │  - Custom exceptions                                    │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Utilities                                              │ │
│  │  - Constants, Helpers                                   │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                    DATABASE LAYER                             │
│  Oracle 19c PDB (orclpdb)                                    │
│  - 27 tables                                                 │
│  - Sequences (Hibernate managed)                             │
│  - Indexes, Constraints                                      │
│  - HikariCP Connection Pool                                  │
└──────────────────────────────────────────────────────────────┘
```

### 3.2 Package Structure

```
com.sais/
│
├── bean/                           # JSF Managed Beans (View Layer)
│   ├── MuracaatBean.java
│   ├── KisiBean.java
│   ├── AileFertBean.java
│   └── ...
│
├── controller/                     # REST Controllers
│   ├── MuracaatController.java
│   ├── AileFertController.java
│   ├── MaddiDurumController.java
│   ├── TutanakController.java
│   ├── YardimKararController.java
│   └── MuracaatDokumanController.java
│
├── service/                        # Business Logic Layer
│   ├── KisiService.java            # Kişi CRUD + MERNİS
│   ├── MuracaatService.java        # Müracaat CRUD
│   ├── MuracaatWorkflowService.java # Workflow state management
│   ├── AileFertService.java
│   ├── AileMaddiDurumService.java
│   ├── YardimService.java
│   ├── YardimRaporService.java
│   ├── TutanakService.java
│   ├── PersonelService.java
│   ├── MernisService.java          # External API
│   ├── LookupService.java          # Reference data cache
│   ├── FileStorageService.java
│   ├── FileStorageServiceImpl.java
│   ├── ReportService.java
│   └── report/                     # Report generators
│
├── repository/                     # Data Access Layer
│   ├── KisiRepository.java
│   ├── MuracaatRepository.java
│   ├── AileFertRepository.java
│   ├── AileMaddiDurumRepository.java
│   ├── ... (24 more repositories)
│   └── PersonelRepository.java
│
├── entity/                         # JPA Entities (Domain Model)
│   ├── BaseEntity.java             # Abstract audit entity
│   ├── Kisi.java
│   ├── Muracaat.java
│   ├── AileFert.java
│   ├── AileMaddiDurum.java
│   ├── ... (23 more entities)
│   └── YardimKarar.java
│
├── dto/                            # Data Transfer Objects
│   ├── KisiDTO.java
│   ├── MuracaatDTO.java
│   ├── request/
│   └── response/
│
├── mapper/                         # MapStruct Mappers
│   ├── KisiMapper.java
│   ├── MuracaatMapper.java
│   └── ...
│
├── enums/                          # Business Enumerations
│   ├── MuracaatDurum.java
│   ├── YardimDurum.java
│   ├── YardimTipi.java
│   ├── SGKDurum.java
│   └── OgrenimDurum.java
│
├── exception/                      # Custom Exceptions
│   ├── EntityNotFoundException.java
│   ├── BusinessException.java
│   └── GlobalExceptionHandler.java
│
├── config/                         # Spring Configurations
│   ├── JpaConfig.java
│   ├── WebConfig.java
│   ├── SecurityConfig.java (future)
│   └── AuditConfig.java
│
├── util/                           # Utility Classes
│   ├── DateUtils.java
│   ├── StringUtils.java
│   └── ValidationUtils.java
│
└── constants/                      # Application Constants
    └── AppConstants.java
```

### 3.3 Dependency Flow

```
┌──────────────┐
│    Bean      │ ───────┐
│ (JSF View)   │        │
└──────────────┘        │
                        ↓
┌──────────────┐   ┌─────────────┐
│ Controller   │──→│   Service   │
│  (REST)      │   │ (Business)  │
└──────────────┘   └─────────────┘
                        │
                        ↓
                   ┌─────────────┐      ┌──────────┐
                   │ Repository  │─────→│  Entity  │
                   │  (Data)     │      └──────────┘
                   └─────────────┘
                        │
                        ↓
                   ┌─────────────┐
                   │  Database   │
                   │ (Oracle 19c)│
                   └─────────────┘
```

**Dependency Rules**:
- ✅ Controller/Bean → Service (allowed)
- ✅ Service → Repository (allowed)
- ✅ Service → Service (allowed, with caution)
- ❌ Repository → Service (not allowed - circular dependency)
- ❌ Entity → Service (not allowed - domain contamination)

---

## 4. VERİTABANI TASARIMI VE İLİŞKİLER

### 4.1 Entity Relationship Diagram (ERD) - Overview

```
┌───────────────────────────────────────────────────────────────┐
│                      CORE ENTITIES                            │
└───────────────────────────────────────────────────────────────┘

                    ┌─────────────┐
                    │    KISI     │ (Person)
                    ├─────────────┤
                    │ PK: id      │
                    │ UK: tc_no   │
                    │    ad       │
                    │    soyad    │
                    │    adres    │
                    └─────────────┘
                         ↑  ↑
                         │  │
          ┌──────────────┘  └──────────────┐
          │                                 │
          │ basvuru_sahibi         adina_basvurulan
          │ (ManyToOne)            (ManyToOne)
          │                                 │
    ┌─────────────────────────────────────────────┐
    │           MURACAAT (Application)            │
    ├─────────────────────────────────────────────┤
    │ PK: id                                      │
    │ UK: muracaat_no                             │
    │ FK: basvuru_sahibi_id → KISI.id            │
    │ FK: adina_basvurulan_kisi_id → KISI.id    │
    │ FK: kaydeden_personel_id → PERSONEL.id     │
    │     muracaat_tarihi                         │
    │     durum (ENUM)                            │
    └─────────────────────────────────────────────┘
              ↑
              │ (OneToMany / OneToOne)
              │
    ┌─────────┴────────┬──────────┬─────────────┬──────────┐
    │                  │          │             │          │
┌───────────┐  ┌───────────┐  ┌──────────┐  ┌────────┐  ┌──────────┐
│AILE_FERT  │  │ YARDIM    │  │  AILE    │  │TUTANAK │  │ MURACAAT │
│           │  │  _KARAR   │  │  _MADDI  │  │_BILGISI│  │_DOKUMAN  │
│           │  │           │  │  _DURUM  │  │        │  │          │
└───────────┘  └───────────┘  └──────────┘  └────────┘  └──────────┘
```

### 4.2 Detailed Entity Relationships

#### 4.2.1 KISI (Person) - Core Entity

```sql
CREATE TABLE "kisi" (
    "id" NUMBER(19) PRIMARY KEY,
    "tc_kimlik_no" VARCHAR2(11) UNIQUE NOT NULL,
    "ad" VARCHAR2(100) NOT NULL,
    "soyad" VARCHAR2(100) NOT NULL,
    "baba_adi" VARCHAR2(100),
    "anne_adi" VARCHAR2(100),
    "dogum_tarihi" DATE,
    "dogum_yeri" VARCHAR2(100),
    "cinsiyet" CHAR(1),
    "medeni_durum" VARCHAR2(20),
    "adres" CLOB,
    "il" VARCHAR2(50),
    "ilce" VARCHAR2(50),
    "mahalle" VARCHAR2(100),
    "telefon" VARCHAR2(20),
    "email" VARCHAR2(150),
    "gebze_ikameti" NUMBER(1) DEFAULT 1,
    "sgk_durum" VARCHAR2(50),
    "ogrenim_durum" VARCHAR2(50),
    "son_mernis_sorgu_tarihi" DATE,
    "mernis_guncelleme_sayisi" NUMBER(10) DEFAULT 0,
    -- BaseEntity fields
    "olusturma_tarihi" TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    "guncelleme_tarihi" TIMESTAMP,
    "olusturan" VARCHAR2(100),
    "guncelleyen" VARCHAR2(100),
    "aktif" NUMBER(1) DEFAULT 1
);

CREATE INDEX "idx_kisi_tc" ON "kisi"("tc_kimlik_no");
CREATE INDEX "idx_kisi_son_mernis" ON "kisi"("son_mernis_sorgu_tarihi");
```

**Relationships**:
- `1 → N` : MURACAAT (as basvuru_sahibi)
- `1 → N` : MURACAAT (as adina_basvurulan_kisi)
- `1 → N` : AILE_FERT (aile bireylerinde referans)
- `1 → N` : GELIR_BILGISI (gelir sahibi)

#### 4.2.2 MURACAAT (Application) - Aggregate Root

```sql
CREATE TABLE "muracaat" (
    "id" NUMBER(19) PRIMARY KEY,
    "muracaat_no" NUMBER(19) UNIQUE NOT NULL,
    "basvuru_sahibi_id" NUMBER(19) NOT NULL,
    "komisyon_kararli" NUMBER(1) DEFAULT 1 NOT NULL,
    "kendisi_basvurdu" NUMBER(1) DEFAULT 1 NOT NULL,
    "adina_basvurulan_kisi_id" NUMBER(19),
    "muracaat_tarihi" DATE NOT NULL,
    "inceleme_tarihi" DATE,
    "basvuru_metnu" CLOB,
    "personel_gorus_notu" CLOB,
    "dokuman_listesi" CLOB,
    "durum" VARCHAR2(50) NOT NULL,
    "kaydeden_personel_id" NUMBER(19),
    "karar_no" NUMBER(19),
    "karar_tarihi" DATE,
    "sonuclanma_tarihi" DATE,
    -- BaseEntity fields
    "olusturma_tarihi" TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    "guncelleme_tarihi" TIMESTAMP,
    "olusturan" VARCHAR2(100),
    "guncelleyen" VARCHAR2(100),
    "aktif" NUMBER(1) DEFAULT 1,
    -- Foreign Keys
    CONSTRAINT "fk_muracaat_basvuru_sahibi"
        FOREIGN KEY ("basvuru_sahibi_id") REFERENCES "kisi"("id"),
    CONSTRAINT "fk_muracaat_adina_basvurulan"
        FOREIGN KEY ("adina_basvurulan_kisi_id") REFERENCES "kisi"("id"),
    CONSTRAINT "fk_muracaat_personel"
        FOREIGN KEY ("kaydeden_personel_id") REFERENCES "personel"("id")
);

CREATE INDEX "idx_muracaat_no" ON "muracaat"("muracaat_no");
CREATE INDEX "idx_muracaat_durum" ON "muracaat"("durum");
CREATE INDEX "idx_muracaat_tarih" ON "muracaat"("muracaat_tarihi");
```

**Relationships (Aggregate)**:
- `N → 1` : KISI (basvuru_sahibi)
- `N → 1` : KISI (adina_basvurulan_kisi) [optional]
- `N → 1` : PERSONEL (kaydeden_personel) [optional]
- `1 → N` : AILE_FERT (aileFertleri)
- `1 → N` : YARDIM_KARAR (yardimKararlari)
- `1 → N` : MURACAAT_YARDIM_TALEP (yardimTalepleri)
- `1 → N` : MURACAAT_DOKUMAN (dokumanlar)
- `1 → 1` : AILE_MADDI_DURUM (aileMaddiDurum)
- `1 → 1` : TUTANAK_BILGISI (tutanakBilgisi)

#### 4.2.3 AILE_FERT (Family Member)

```sql
CREATE TABLE "aile_fert" (
    "id" NUMBER(19) PRIMARY KEY,
    "muracaat_id" NUMBER(19) NOT NULL,
    "kisi_id" NUMBER(19) NOT NULL,
    "yakinlik_kodu_id" NUMBER(19),
    "ozel_statu_id" NUMBER(19),
    "meslek_id" NUMBER(19),
    "yaptigi_is" VARCHAR2(150),
    "sgk_durum" VARCHAR2(50),
    "ogrenim_durumu" VARCHAR2(50),
    "aciklama" CLOB,
    -- BaseEntity fields
    "olusturma_tarihi" TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    "guncelleme_tarihi" TIMESTAMP,
    "olusturan" VARCHAR2(100),
    "guncelleyen" VARCHAR2(100),
    "aktif" NUMBER(1) DEFAULT 1,
    -- Foreign Keys
    CONSTRAINT "fk_aile_fert_muracaat"
        FOREIGN KEY ("muracaat_id") REFERENCES "muracaat"("id"),
    CONSTRAINT "fk_aile_fert_kisi"
        FOREIGN KEY ("kisi_id") REFERENCES "kisi"("id"),
    CONSTRAINT "fk_aile_fert_yakinlik"
        FOREIGN KEY ("yakinlik_kodu_id") REFERENCES "yakinlik_kodu"("id"),
    CONSTRAINT "fk_aile_fert_statu"
        FOREIGN KEY ("ozel_statu_id") REFERENCES "ozel_statu"("id"),
    CONSTRAINT "fk_aile_fert_meslek"
        FOREIGN KEY ("meslek_id") REFERENCES "meslek"("id")
);

CREATE INDEX "idx_aile_fert_muracaat" ON "aile_fert"("muracaat_id");
CREATE INDEX "idx_aile_fert_kisi" ON "aile_fert"("kisi_id");
```

**Relationships**:
- `N → 1` : MURACAAT
- `N → 1` : KISI
- `N → 1` : YAKINLIK_KODU (Kendisi, Eşi, Çocuk, etc.)
- `N → 1` : OZEL_STATU (Şehit, Gazi, etc.) [optional]
- `N → 1` : MESLEK [optional]
- `1 → 1` : AILE_FERT_ENGEL_BILGISI [optional]
- `1 → 1` : AILE_FERT_HASTALIK_BILGISI [optional]

#### 4.2.4 AILE_MADDI_DURUM (Financial Status)

```sql
CREATE TABLE "aile_maddi_durum" (
    "id" NUMBER(19) PRIMARY KEY,
    "muracaat_id" NUMBER(19) NOT NULL,
    "toplam_gelir" NUMBER(10,2),
    "toplam_borc" NUMBER(10,2),
    "aciklama" CLOB,
    -- BaseEntity fields
    "olusturma_tarihi" TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    "guncelleme_tarihi" TIMESTAMP,
    "olusturan" VARCHAR2(100),
    "guncelleyen" VARCHAR2(100),
    "aktif" NUMBER(1) DEFAULT 1,
    -- Foreign Keys
    CONSTRAINT "fk_maddi_durum_muracaat"
        FOREIGN KEY ("muracaat_id") REFERENCES "muracaat"("id")
);
```

**Relationships**:
- `1 → 1` : MURACAAT (bidirectional)
- `1 → N` : GELIR_BILGISI (gelirBilgileri)
- `1 → N` : BORC_BILGISI (borcBilgileri)
- `1 → 1` : GAYRIMENKUL_BILGISI [optional]

#### 4.2.5 YARDIM_KARAR (Aid Decision)

```sql
CREATE TABLE "yardim_karar" (
    "id" NUMBER(19) PRIMARY KEY,
    "muracaat_id" NUMBER(19) NOT NULL,
    "yardim_alt_tipi_id" NUMBER(19) NOT NULL,
    "talep_edilmis_mi" NUMBER(1) DEFAULT 0,
    "yardim_durum" VARCHAR2(50) NOT NULL,
    "komisyon_kararli" NUMBER(1) DEFAULT 1,
    "toplanti_tarihi" DATE,
    -- Nakdi Yardım
    "verilen_tutar" NUMBER(10,2),
    "yardim_dilimi_id" NUMBER(19),
    "yardim_donemi_id" NUMBER(19),
    "hesap_bilgisi_id" NUMBER(19),
    -- Ayni Yardım
    "adet_sayi" NUMBER(10),
    -- Red
    "red_sebebi_id" NUMBER(19),
    "aciklama" CLOB,
    "kesinlesti" NUMBER(1) DEFAULT 0,
    "kesinlesme_tarihi" DATE,
    "karar_sayisi" NUMBER(10) DEFAULT 1,
    "karar_tarihi" DATE DEFAULT SYSDATE,
    -- BaseEntity fields
    "olusturma_tarihi" TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    "guncelleme_tarihi" TIMESTAMP,
    "olusturan" VARCHAR2(100),
    "guncelleyen" VARCHAR2(100),
    "aktif" NUMBER(1) DEFAULT 1,
    -- Foreign Keys
    CONSTRAINT "fk_yardim_karar_muracaat"
        FOREIGN KEY ("muracaat_id") REFERENCES "muracaat"("id"),
    CONSTRAINT "fk_yardim_karar_alt_tipi"
        FOREIGN KEY ("yardim_alt_tipi_id") REFERENCES "yardim_alt_tipi"("id"),
    CONSTRAINT "fk_yardim_karar_dilimi"
        FOREIGN KEY ("yardim_dilimi_id") REFERENCES "yardim_dilimi"("id"),
    CONSTRAINT "fk_yardim_karar_donemi"
        FOREIGN KEY ("yardim_donemi_id") REFERENCES "yardim_donemi"("id"),
    CONSTRAINT "fk_yardim_karar_hesap"
        FOREIGN KEY ("hesap_bilgisi_id") REFERENCES "hesap_bilgisi"("id"),
    CONSTRAINT "fk_yardim_karar_red"
        FOREIGN KEY ("red_sebebi_id") REFERENCES "yardim_red_sebebi"("id")
);

CREATE INDEX "idx_yardim_karar_muracaat" ON "yardim_karar"("muracaat_id");
CREATE INDEX "idx_yardim_karar_durum" ON "yardim_karar"("yardim_durum");
```

**Relationships**:
- `N → 1` : MURACAAT
- `N → 1` : YARDIM_ALT_TIPI (Nakdi, Ayni types)
- `N → 1` : YARDIM_DILIMI (Aylık, 3 Aylık, etc.) [optional]
- `N → 1` : YARDIM_DONEMI (2024 Ocak-Haziran) [optional]
- `N → 1` : HESAP_BILGISI (Bank account) [optional]
- `N → 1` : YARDIM_RED_SEBEBI (Rejection reason) [optional]

### 4.3 Complete Entity List (27 Tables)

#### Core Domain Tables (6)
1. **kisi** - Kişi bilgileri
2. **muracaat** - Müracaat (Application)
3. **personel** - Personel bilgileri
4. **aile_fert** - Aile bireyi
5. **aile_maddi_durum** - Maddi durum
6. **tutanak_bilgisi** - Sosyal inceleme tutanağı

#### Financial Tables (5)
7. **gelir_bilgisi** - Gelir kaydı
8. **borc_bilgisi** - Borç kaydı
9. **gayrimenkul_bilgisi** - Gayrimenkul durumu
10. **hesap_bilgisi** - Banka hesap bilgileri
11. **gelir_turu** - Gelir türleri (lookup)

#### Aid Management Tables (6)
12. **muracaat_yardim_talep** - Talep edilen yardımlar
13. **yardim_karar** - Yardım kararı
14. **yardim_alt_tipi** - Yardım alt tipleri
15. **yardim_dilimi** - Yardım periyodu
16. **yardim_donemi** - Yardım dönemi
17. **yardim_red_sebebi** - Red nedenleri

#### Document Management (2)
18. **muracaat_dokuman** - Müracaat belgeleri
19. **tutanak_gorsel** - Tutanak fotoğrafları

#### Health & Disability (3)
20. **aile_fert_engel_bilgisi** - Engelli bilgileri
21. **aile_fert_hastalik_bilgisi** - Hastalık bilgileri
22. **hastalik** - Hastalık tanımları (lookup)
23. **engelli_tipi** - Engelli tipleri (lookup)

#### Lookup/Reference Tables (5)
24. **yakinlik_kodu** - Yakınlık kodları (MERNİS)
25. **ozel_statu** - Özel statüler (Şehit, Gazi, etc.)
26. **meslek** - Meslek tanımları
27. **borc_turu** - Borç türleri

### 4.4 Cascade ve Orphan Removal

```java
@Entity
public class Muracaat extends BaseEntity {

    // Cascade ALL + orphanRemoval = true
    // Parent silindiğinde child'lar otomatik silinir
    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,
               orphanRemoval = true)
    private List<AileFert> aileFertleri = new ArrayList<>();

    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,
               orphanRemoval = true)
    private List<YardimKarar> yardimKararlari = new ArrayList<>();

    // Helper methods for bidirectional relationship
    public void addAileFert(AileFert fert) {
        aileFertleri.add(fert);
        fert.setMuracaat(this);
    }

    public void removeAileFert(AileFert fert) {
        aileFertleri.remove(fert);
        fert.setMuracaat(null);
    }
}
```

**Cascade Strategy**:
- `CascadeType.ALL`: Tüm operasyonlar (persist, merge, remove, refresh, detach)
- `orphanRemoval = true`: Koleksiyondan çıkarılan entity'ler silinir

---

## 5. DOMAIN MODEL (ENTITY'LER)

### 5.1 BaseEntity - Audit Pattern

```java
@Getter
@Setter
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
    private Boolean aktif = true;
}
```

**Özellikler**:
- `@MappedSuperclass`: Hibernate inheritance mapping
- `@EntityListeners(AuditingEntityListener.class)`: Spring Data JPA auditing
- `@CreatedDate`, `@LastModifiedDate`: Otomatik zaman damgası
- `@CreatedBy`, `@LastModifiedBy`: Otomatik kullanıcı bilgisi
- `aktif`: Soft delete için boolean flag

**Fayda**:
- Tüm entity'ler audit bilgilerini inherit eder
- DRY principle (Don't Repeat Yourself)
- Tutarlı audit logging

### 5.2 Entity Örnekleri

#### 5.2.1 Kisi (Person)

```java
@Entity
@Table(name = "kisi", indexes = {
    @Index(name = "idx_kisi_tc", columnList = "tc_kimlik_no"),
    @Index(name = "idx_kisi_son_mernis", columnList = "son_mernis_sorgu_tarihi")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Kisi extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "tc_kimlik_no", nullable = false, unique = true, length = 11)
    private String tcKimlikNo;

    @Column(name = "ad", nullable = false, length = 100)
    private String ad;

    @Column(name = "soyad", nullable = false, length = 100)
    private String soyad;

    // ... other fields

    @Enumerated(EnumType.STRING)
    @Column(name = "sgk_durum")
    private SGKDurum sgkDurum;

    @Enumerated(EnumType.STRING)
    @Column(name = "ogrenim_durum")
    private OgrenimDurum ogrenimDurum;

    // Transient methods (not persisted)
    @Transient
    public String getAdSoyad() {
        return ad + " " + soyad;
    }

    @Transient
    public Integer getYas() {
        if (dogumTarihi != null) {
            return LocalDate.now().getYear() - dogumTarihi.getYear();
        }
        return null;
    }
}
```

**Key Points**:
- `@GeneratedValue(strategy = GenerationType.SEQUENCE)`: Oracle sequence
- `@Index`: Database index for performance
- `@Enumerated(EnumType.STRING)`: Enum as String in DB
- `@Transient`: Calculated fields, not persisted
- `@Builder`: Lombok builder pattern

#### 5.2.2 Muracaat (Application) - Aggregate Root

```java
@Entity
@Table(name = "muracaat", indexes = {
    @Index(name = "idx_muracaat_no", columnList = "muracaat_no"),
    @Index(name = "idx_muracaat_durum", columnList = "durum"),
    @Index(name = "idx_muracaat_tarih", columnList = "muracaat_tarihi")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Muracaat extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "muracaat_no", nullable = false, unique = true)
    private Long muracaatNo;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "basvuru_sahibi_id", nullable = false)
    private Kisi basvuruSahibi;

    @Enumerated(EnumType.STRING)
    @Column(name = "durum", nullable = false)
    private MuracaatDurum durum = MuracaatDurum.BEKLEMEDE;

    // OneToMany relationships
    @OneToMany(mappedBy = "muracaat", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<MuracaatYardimTalep> yardimTalepleri = new ArrayList<>();

    @OneToMany(mappedBy = "muracaat", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<AileFert> aileFertleri = new ArrayList<>();

    // Helper methods for bidirectional relationships
    public void addYardimTalep(MuracaatYardimTalep talep) {
        yardimTalepleri.add(talep);
        talep.setMuracaat(this);
    }

    public void removeYardimTalep(MuracaatYardimTalep talep) {
        yardimTalepleri.remove(talep);
        talep.setMuracaat(null);
    }
}
```

**Aggregate Root Characteristics**:
- Controls lifecycle of child entities
- Enforces invariants (business rules)
- Provides helper methods for relationship management
- Cascade operations to children

### 5.3 Enums

#### MuracaatDurum

```java
public enum MuracaatDurum {
    BEKLEMEDE("Beklemede"),
    INCELEMEDE("İncelemede"),
    TAMAMLANDI("Tamamlandı"),
    REDDEDILDI("Reddedildi");

    private final String label;

    MuracaatDurum(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
```

#### YardimTipi

```java
public enum YardimTipi {
    NAKDI("Nakdi Yardım"),
    AYNI("Ayni Yardım");

    private final String label;

    // ...
}
```

---

## 6. SERVICE LAYER

### 6.1 Service Architecture

```
KisiService
├── CRUD operations (save, update, delete, findById)
├── Business logic (MERNİS doğrulama)
├── Validation
└── Transaction management (@Transactional)

MuracaatService
├── CRUD operations
├── Müracaat numarası üretimi
├── Durum yönetimi
└── Complex queries

MuracaatWorkflowService
├── State transition logic
├── Durum değiştirme (BEKLEMEDE → INCELEMEDE)
└── Business rule enforcement
```

### 6.2 Service Örnekleri

#### 6.2.1 KisiService

```java
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class KisiService {

    private final KisiRepository repository;
    private final MernisService mernisService;

    @Transactional
    public Kisi save(Kisi kisi) {
        // Validation
        validateTcKimlikNo(kisi.getTcKimlikNo());

        // MERNİS kontrolü
        if (mernisService.isAvailable()) {
            KisiBilgileri mernisBilgi = mernisService.sorgula(kisi.getTcKimlikNo());
            kisi.setAd(mernisBilgi.getAd());
            kisi.setSoyad(mernisBilgi.getSoyad());
            // ... diğer alanlar
        }

        return repository.save(kisi);
    }

    public Optional<Kisi> findByTcKimlikNo(String tcKimlikNo) {
        return repository.findByTcKimlikNo(tcKimlikNo);
    }

    public List<Kisi> findGebzeIkametliler() {
        return repository.findGebzeIkametliler();
    }

    private void validateTcKimlikNo(String tcKimlikNo) {
        if (tcKimlikNo == null || tcKimlikNo.length() != 11) {
            throw new BusinessException("Geçersiz TC Kimlik No");
        }
        // Algoritma kontrolü...
    }
}
```

**Özellikler**:
- `@Transactional(readOnly = true)`: Class level, default read-only
- `@Transactional`: Method level, write transaction
- `@RequiredArgsConstructor`: Lombok constructor injection
- Business validation
- External service integration (MERNİS)

#### 6.2.2 MuracaatService

```java
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MuracaatService {

    private final MuracaatRepository repository;

    @Transactional
    public Muracaat save(Muracaat muracaat) {
        if (muracaat.getId() == null) {
            // Yeni müracaat - numara üret
            Long nextNo = generateMuracaatNo();
            muracaat.setMuracaatNo(nextNo);
            muracaat.setDurum(MuracaatDurum.BEKLEMEDE);
        }

        return repository.save(muracaat);
    }

    public Page<Muracaat> findAll(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Muracaat> findByBasvuruSahibi(Long kisiId) {
        return repository.findByBasvuruSahibiId(kisiId);
    }

    private Long generateMuracaatNo() {
        return repository.findMaxMuracaatNo()
                .map(max -> max + 1)
                .orElse(1L);
    }
}
```

#### 6.2.3 MuracaatWorkflowService

```java
@Service
@Transactional
@RequiredArgsConstructor
public class MuracaatWorkflowService {

    private final MuracaatRepository muracaatRepository;

    public void incelemeBaslat(Long muracaatId) {
        Muracaat muracaat = muracaatRepository.findById(muracaatId)
                .orElseThrow(() -> new EntityNotFoundException("Müracaat bulunamadı"));

        // Durum kontrolü
        if (muracaat.getDurum() != MuracaatDurum.BEKLEMEDE) {
            throw new BusinessException("Sadece beklemedeki müracaatlar incelemeye alınabilir");
        }

        muracaat.setDurum(MuracaatDurum.INCELEMEDE);
        muracaat.setIncelemeTarihi(LocalDate.now());

        muracaatRepository.save(muracaat);
    }

    public void tamamla(Long muracaatId) {
        Muracaat muracaat = muracaatRepository.findById(muracaatId)
                .orElseThrow(() -> new EntityNotFoundException("Müracaat bulunamadı"));

        // Business rule: Tutanak doldurulmuş mu?
        if (muracaat.getTutanakBilgisi() == null) {
            throw new BusinessException("Tutanak bilgisi eksik");
        }

        muracaat.setDurum(MuracaatDurum.TAMAMLANDI);
        muracaat.setSonuclenmaTarihi(LocalDate.now());

        muracaatRepository.save(muracaat);
    }
}
```

**Workflow Pattern**:
- State transition logic
- Business rule enforcement
- Precondition checking
- Postcondition setting

---

## 7. REPOSITORY LAYER

### 7.1 Spring Data JPA Repositories

#### 7.1.1 KisiRepository

```java
@Repository
public interface KisiRepository extends JpaRepository<Kisi, Long> {

    // Query methods (Spring Data auto-generates)
    Optional<Kisi> findByTcKimlikNo(String tcKimlikNo);

    boolean existsByTcKimlikNo(String tcKimlikNo);

    // Custom JPQL query
    @Query("SELECT k FROM Kisi k WHERE k.tcKimlikNo = :tcKimlikNo AND k.sonMernisSorguTarihi = :tarih")
    Optional<Kisi> findByTcKimlikNoAndSonMernisSorguTarihi(
        @Param("tcKimlikNo") String tcKimlikNo,
        @Param("tarih") LocalDate tarih
    );

    @Query("SELECT k FROM Kisi k WHERE k.gebzeIkameti = true")
    List<Kisi> findGebzeIkametliler();
}
```

#### 7.1.2 MuracaatRepository

```java
@Repository
public interface MuracaatRepository extends JpaRepository<Muracaat, Long> {

    @Query("SELECT MAX(m.muracaatNo) FROM Muracaat m")
    Optional<Long> findMaxMuracaatNo();

    @Query("SELECT m FROM Muracaat m WHERE m.basvuruSahibi.id = :kisiId ORDER BY m.muracaatTarihi DESC")
    List<Muracaat> findByBasvuruSahibiId(@Param("kisiId") Long kisiId);

    @Query("SELECT m FROM Muracaat m WHERE m.durum = :durum")
    List<Muracaat> findByDurum(@Param("durum") MuracaatDurum durum);

    // Pagination
    Page<Muracaat> findByDurum(MuracaatDurum durum, Pageable pageable);
}
```

**Repository Features**:
- `JpaRepository<Entity, ID>`: CRUD + pagination + sorting
- Query methods: `findBy...`, `existsBy...`, `countBy...`
- `@Query`: Custom JPQL
- `@Param`: Named parameters
- `Optional<T>`: Null-safe return type
- `Pageable`, `Page<T>`: Pagination support

### 7.2 Query Examples

```java
// Simple query method
Optional<Kisi> kisi = repository.findByTcKimlikNo("12345678901");

// Pagination
Pageable pageable = PageRequest.of(0, 20, Sort.by("muracaatTarihi").descending());
Page<Muracaat> page = repository.findAll(pageable);

// Custom JPQL with JOIN
@Query("SELECT m FROM Muracaat m JOIN FETCH m.basvuruSahibi WHERE m.id = :id")
Optional<Muracaat> findByIdWithBasvuruSahibi(@Param("id") Long id);
```

---

## 8. CONTROLLER LAYER

### 8.1 REST Controllers

#### 8.1.1 MuracaatController

```java
@RestController
@RequestMapping("/api/muracaat")
@RequiredArgsConstructor
public class MuracaatController {

    private final MuracaatService service;

    @GetMapping
    public ResponseEntity<Page<MuracaatDTO>> getAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Muracaat> muracaatlar = service.findAll(pageable);
        Page<MuracaatDTO> dtos = muracaatlar.map(MuracaatMapper.INSTANCE::toDTO);

        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<MuracaatDTO> getById(@PathVariable Long id) {
        return service.findById(id)
                .map(MuracaatMapper.INSTANCE::toDTO)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<MuracaatDTO> create(@Valid @RequestBody MuracaatDTO dto) {
        Muracaat muracaat = MuracaatMapper.INSTANCE.toEntity(dto);
        Muracaat saved = service.save(muracaat);
        MuracaatDTO responseDto = MuracaatMapper.INSTANCE::to DTO(saved);

        return ResponseEntity.created(
            URI.create("/api/muracaat/" + saved.getId())
        ).body(responseDto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MuracaatDTO> update(
            @PathVariable Long id,
            @Valid @RequestBody MuracaatDTO dto) {

        Muracaat muracaat = MuracaatMapper.INSTANCE.toEntity(dto);
        muracaat.setId(id);
        Muracaat updated = service.save(muracaat);

        return ResponseEntity.ok(MuracaatMapper.INSTANCE.toDTO(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
```

**RESTful Conventions**:
- `GET /api/muracaat` - List all
- `GET /api/muracaat/{id}` - Get by ID
- `POST /api/muracaat` - Create
- `PUT /api/muracaat/{id}` - Update
- `DELETE /api/muracaat/{id}` - Delete

### 8.2 JSF Managed Beans

```java
@Named
@ViewScoped
@RequiredArgsConstructor
public class MuracaatBean implements Serializable {

    private final MuracaatService service;
    private final KisiService kisiService;

    private Muracaat muracaat = new Muracaat();
    private List<Muracaat> muracaatlar;
    private Kisi selectedKisi;

    @PostConstruct
    public void init() {
        loadMuracaatlar();
    }

    public void loadMuracaatlar() {
        muracaatlar = service.findAll();
    }

    public void yeniMuracaat() {
        muracaat = new Muracaat();
        muracaat.setBasvuruSahibi(selectedKisi);
    }

    public void kaydet() {
        try {
            service.save(muracaat);
            FacesMessage msg = new FacesMessage("Başarılı", "Müracaat kaydedildi");
            FacesContext.getCurrentInstance().addMessage(null, msg);
            loadMuracaatlar();
        } catch (Exception e) {
            FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Hata", e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, msg);
        }
    }

    // Getters/Setters
}
```

---

## 9. DTO VE MAPPER PATTERN

### 9.1 DTO Example

```java
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MuracaatDTO {
    private Long id;
    private Long muracaatNo;
    private String durum;
    private LocalDate muracaatTarihi;

    // Nested DTO
    private KisiBasicDTO basvuruSahibi;

    // Flat DTO
    private String basvuruSahibiAdSoyad;
    private String basvuruSahibiTcKimlikNo;
}

@Data
@Builder
public class KisiBasicDTO {
    private Long id;
    private String tcKimlikNo;
    private String ad;
    private String soyad;

    // Computed field
    private String adSoyad;
}
```

### 9.2 MapStruct Mapper

```java
@Mapper(componentModel = "spring")
public interface MuracaatMapper {

    MuracaatMapper INSTANCE = Mappers.getMapper(MuracaatMapper.class);

    @Mapping(source = "basvuruSahibi.adSoyad", target = "basvuruSahibiAdSoyad")
    @Mapping(source = "basvuruSahibi.tcKimlikNo", target = "basvuruSahibiTcKimlikNo")
    @Mapping(source = "durum", target = "durum", qualifiedByName = "enumToString")
    MuracaatDTO toDTO(Muracaat entity);

    @Mapping(target = "aileFertleri", ignore = true)
    @Mapping(target = "yardimKararlari", ignore = true)
    Muracaat toEntity(MuracaatDTO dto);

    @Named("enumToString")
    default String enumToString(MuracaatDurum durum) {
        return durum != null ? durum.getLabel() : null;
    }
}
```

**MapStruct Benefits**:
- Compile-time code generation (no reflection)
- Type-safe mapping
- Custom mapping methods
- Performance optimized

---

## 10. CONFIGURATION VE INFRASTRUCTURE

### 10.1 JPA Configuration

```yaml
spring:
  datasource:
    url: jdbc:oracle:thin:@localhost:1521/orclpdb
    username: SAIS_USER
    password: Sais_PDB_123
    driver-class-name: oracle.jdbc.OracleDriver
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000

  jpa:
    hibernate:
      ddl-auto: create-drop
      naming:
        physical-strategy: org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
    properties:
      hibernate:
        dialect: org.hibernate.dialect.Oracle12cDialect
        default_schema: SAIS_USER
        globally_quoted_identifiers: true
        jdbc:
          batch_size: 20
          fetch_size: 50
```

### 10.2 Audit Configuration

```java
@Configuration
@EnableJpaAuditing
public class JpaConfig {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return () -> {
            // Get current user from SecurityContext
            // For now, return "SYSTEM"
            return Optional.of("SYSTEM");
        };
    }
}
```

---

## 11. DESIGN PATTERNS

### 11.1 Repository Pattern
✅ Spring Data JPA repositories
✅ Data access abstraction
✅ JPQL database-independent queries

### 11.2 Service Layer Pattern
✅ Business logic encapsulation
✅ Transaction boundaries (@Transactional)
✅ Separation of concerns

### 11.3 DTO Pattern
✅ Entity-DTO separation
✅ MapStruct compile-time mapping
✅ API versioning support

### 11.4 Builder Pattern
✅ Lombok @Builder
✅ Fluent object creation
✅ Immutability option

### 11.5 Template Method Pattern
✅ BaseEntity abstract class
✅ Common audit fields
✅ Inheritance hierarchy

### 11.6 Strategy Pattern
✅ YardimService (Nakdi/Ayni strategies)
✅ ReportService (different report types)

### 11.7 Facade Pattern
✅ MuracaatWorkflowService
✅ Complex workflow simplification

---

## 12. API REFERANSI

### 12.1 REST Endpoints

```
POST   /api/muracaat              Create new application
GET    /api/muracaat              List all (paginated)
GET    /api/muracaat/{id}         Get by ID
PUT    /api/muracaat/{id}         Update
DELETE /api/muracaat/{id}         Delete

GET    /api/muracaat/durum/{durum}     Filter by status
GET    /api/muracaat/kisi/{kisiId}     Get by person

POST   /api/aile-fert             Add family member
PUT    /api/aile-fert/{id}        Update family member
DELETE /api/aile-fert/{id}        Remove family member

POST   /api/maddi-durum           Save financial status
GET    /api/maddi-durum/muracaat/{id}  Get by application

POST   /api/yardim-karar          Create aid decision
PUT    /api/yardim-karar/{id}     Update aid decision
GET    /api/yardim-karar/muracaat/{id} Get decisions by application
```

### 12.2 JSF Pages

```
/muracaat/liste.xhtml          Müracaat listesi
/muracaat/detay.xhtml          Müracaat detayı
/muracaat/yeni.xhtml           Yeni müracaat
/kisi/liste.xhtml              Kişi listesi
/kisi/detay.xhtml              Kişi detayı
/aile/fert.xhtml               Aile bilgileri
/maddi-durum/form.xhtml        Maddi durum formu
/tutanak/form.xhtml            Tutanak formu
/yardim/karar.xhtml            Yardım kararı
/rapor/liste.xhtml             Rapor listesi
```

---

## 13. GÜVENLİK VE KVKK

### 13.1 Mevcut Güvenlik

- ✅ SQL Injection önleme (JPQL parameterized queries)
- ✅ File upload validation (extension whitelist, size limit)
- ✅ Input validation (Jakarta Bean Validation)
- ✅ Audit logging (BaseEntity)

### 13.2 Planlanan Güvenlik (Future)

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/public/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .formLogin(Customizer.withDefaults())
            .csrf(csrf -> csrf.disable()); // Enable in production

        return http.build();
    }
}
```

### 13.3 KVKK Compliance

- TC Kimlik No masking: `147******23`
- Veri sahibi hakları (silme, düzeltme, görme)
- Audit trail (kim, ne zaman, ne yaptı)
- Aydınlatma metni (consent management)

---

## 14. PERFORMANS OPTİMİZASYONLARI

### 14.1 Database Level

```yaml
# Batch processing
jdbc.batch_size: 20
order_inserts: true
order_updates: true

# Fetch optimization
jdbc.fetch_size: 50

# Query padding
query.in_clause_parameter_padding: true
```

### 14.2 Index Strategy

```java
@Table(indexes = {
    @Index(name = "idx_kisi_tc", columnList = "tc_kimlik_no"),
    @Index(name = "idx_muracaat_no", columnList = "muracaat_no"),
    @Index(name = "idx_muracaat_durum", columnList = "durum")
})
```

### 14.3 Connection Pooling

```yaml
hikari:
  maximum-pool-size: 10
  minimum-idle: 5
  connection-timeout: 30000
  idle-timeout: 600000
  max-lifetime: 1800000
```

### 14.4 Fetch Strategy

```java
// Eager: For lookup/reference data
@ManyToOne(fetch = FetchType.EAGER)
private YakinlikKodu yakinlikKodu;

// Lazy: For large aggregates
@ManyToOne(fetch = FetchType.LAZY)
private Muracaat muracaat;
```

---

## 15. TEST STRATEJİSİ

### 15.1 Test Piramidi

```
        ┌──────────────┐
        │   E2E Tests  │  10%
        │  (Selenium)  │
        ├──────────────┤
        │ Integration  │  30%
        │   Tests      │
        ├──────────────┤
        │    Unit      │  60%
        │   Tests      │
        └──────────────┘
```

### 15.2 Unit Test Example

```java
@ExtendWith(MockitoExtension.class)
class KisiServiceTest {

    @Mock
    private KisiRepository repository;

    @Mock
    private MernisService mernisService;

    @InjectMocks
    private KisiService service;

    @Test
    void shouldSaveKisiWithMernisValidation() {
        // Given
        Kisi kisi = Kisi.builder()
                .tcKimlikNo("12345678901")
                .build();

        when(mernisService.isAvailable()).thenReturn(true);
        when(mernisService.sorgula(anyString())).thenReturn(mockMernisBilgi());
        when(repository.save(any())).thenReturn(kisi);

        // When
        Kisi saved = service.save(kisi);

        // Then
        assertThat(saved).isNotNull();
        verify(mernisService).sorgula("12345678901");
        verify(repository).save(kisi);
    }
}
```

### 15.3 Integration Test Example

```java
@SpringBootTest
@Transactional
class MuracaatServiceIT {

    @Autowired
    private MuracaatService service;

    @Autowired
    private KisiRepository kisiRepository;

    @Test
    void shouldCreateMuracaatWithAutoGeneratedNumber() {
        // Given
        Kisi kisi = kisiRepository.save(createTestKisi());
        Muracaat muracaat = Muracaat.builder()
                .basvuruSahibi(kisi)
                .muracaatTarihi(LocalDate.now())
                .build();

        // When
        Muracaat saved = service.save(muracaat);

        // Then
        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getMuracaatNo()).isEqualTo(1L);
        assertThat(saved.getDurum()).isEqualTo(MuracaatDurum.BEKLEMEDE);
    }
}
```

---

## ÖZET

### Proje İstatistikleri
```
Toplam Dosya:        124
Entity:              27
Repository:          27
Service:             15
Controller:          6
Toplam LOC:          ~12,000
```

### Teknoloji Stack
- **Framework**: Spring Boot 3.2.0, Java 17
- **Database**: Oracle 19c PDB
- **Frontend**: JSF 4.0 + PrimeFaces 13
- **ORM**: Hibernate 6.3.x
- **Build**: Maven 3.8+

### Mimari Özellikler
- ✅ Layered Architecture (5 layers)
- ✅ Domain-Driven Design (Aggregate roots)
- ✅ SOLID Principles
- ✅ Design Patterns (Repository, Service Layer, DTO, Builder, Template Method, Strategy)
- ✅ Database-agnostic (JPQL)

### Veritabanı
- ✅ 27 tables
- ✅ Normalized schema (3NF)
- ✅ Foreign key relationships
- ✅ Cascade operations
- ✅ Audit logging (BaseEntity)

---

**Tarih**: 2024
**Versiyon**: 1.0.0
**Repository**: halilbrhmkabul/sais
**Branch**: claude/review-project-011CUKqCTx9uZxFs9aGGNGUu
