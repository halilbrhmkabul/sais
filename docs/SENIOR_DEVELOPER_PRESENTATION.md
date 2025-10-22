# SAIS - SOSYAL YARDIM BİLGİ SİSTEMİ
## Senior Developer Technical Presentation
### Enterprise-Grade Social Assistance Management System

---

# 📑 İÇİNDEKİLER

1. [Executive Summary](#1-executive-summary)
2. [Sistem Mimarisi ve Teknoloji Stack](#2-sistem-mimarisi-ve-teknoloji-stack)
3. [Veritabanı Tasarımı ve İlişkisel Model](#3-veritabanı-tasarımı-ve-ilişkisel-model)
4. [Katmanlı Mimari (Layered Architecture)](#4-katmanlı-mimari-layered-architecture)
5. [Domain-Driven Design (DDD) Prensipleri](#5-domain-driven-design-ddd-prensipleri)
6. [Tasarım Desenleri (Design Patterns)](#6-tasarım-desenleri-design-patterns)
7. [SOLID Principles Uygulaması](#7-solid-principles-uygulaması)
8. [Transaction Management & Data Consistency](#8-transaction-management--data-consistency)
9. [Security Architecture](#9-security-architecture)
10. [Performance Optimization](#10-performance-optimization)
11. [Code Quality & Best Practices](#11-code-quality--best-practices)
12. [Testing Strategy](#12-testing-strategy)
13. [Scalability & Future Roadmap](#13-scalability--future-roadmap)
14. [Technical Debt & Improvements](#14-technical-debt--improvements)

---

# 1. EXECUTIVE SUMMARY

## 1.1 Proje Özeti

**SAIS (Sosyal Yardım Bilgi Sistemi)**, Türk belediyelerinin sosyal yardım süreçlerini dijitalleştiren, enterprise-grade bir Java/Spring Boot uygulamasıdır.

### Temel Metrikler

```
📊 Kod Metrikleri:
├── Total LOC (Lines of Code)      : ~18,000+
├── Java Classes                    : 124+
├── Entity Classes                  : 28
├── Service Layer Classes           : 13
├── Repository Interfaces           : 24
├── Controller/Bean Classes         : 6
├── DTO Classes                     : 11
├── Mapper Interfaces (MapStruct)   : 6
├── Custom Exception Classes        : 6
├── Enum Classes                    : 9
├── Utility Classes                 : 4
└── Configuration Classes           : 5

📦 Database Metrikleri:
├── Total Tables                    : 28
├── Core Business Tables            : 11
├── Lookup/Reference Tables         : 14
├── Junction/Association Tables     : 3
├── Foreign Key Constraints         : 35+
├── Indexes                         : 20+
└── Total Master Data Records       : 150+

🎯 Business Capabilities:
├── Müracaat (Application) Management
├── Kişi (Person) Registry with MERNİS Integration
├── Aile Fert (Family Member) Management
├── Mali Durum (Financial) Assessment
├── Tahkikat (Investigation) Workflow
├── Komisyon (Committee) Decision Process
├── Yardım Kararı (Aid Decision) Management
├── Doküman (Document) Management
├── Raporlama (Reporting) System
└── Audit Trail & Compliance
```

### Teknoloji Stack Özeti

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| **Backend Framework** | Spring Boot | 3.2.0 | Application Core |
| **Language** | Java | 17 (LTS) | Programming Language |
| **ORM** | Hibernate/JPA | 6.x | Data Persistence |
| **UI Framework** | JSF (Jakarta Faces) | 4.0 | Server-side UI |
| **UI Components** | PrimeFaces | 13.0.0 | Rich UI Library |
| **Database** | MySQL | 8.x | RDBMS |
| **Build Tool** | Maven | 3.x | Dependency Management |
| **DTO Mapping** | MapStruct | 1.6.3 | Object Mapping |
| **Code Generation** | Lombok | 1.18.30 | Boilerplate Reduction |
| **Reporting** | JasperReports | 6.21.0 | PDF/Excel Generation |

---

# 2. SISTEM MİMARİSİ VE TEKNOLOJİ STACK

## 2.1 High-Level System Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION TIER                                │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │               JSF/PrimeFaces Web Interface                       │    │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │    │
│  │  │ XHTML    │  │ JSF      │  │ Managed  │  │ Ajax/    │       │    │
│  │  │ Templates│  │ Components│  │ Beans    │  │ Push     │       │    │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘       │    │
│  └────────────────────────────────────────────────────────────────┘    │
└──────────────────────────────┬──────────────────────────────────────────┘
                               │ HTTP/HTTPS
                               │
┌──────────────────────────────▼──────────────────────────────────────────┐
│                      APPLICATION TIER (Spring Boot)                      │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │                    CONTROLLER LAYER                             │    │
│  │  ┌──────────────────────────────────────────────────────────┐  │    │
│  │  │ JSF Backing Beans (@ViewScoped / @SessionScoped)         │  │    │
│  │  │ - Request/Response Handling                              │  │    │
│  │  │ - View State Management                                  │  │    │
│  │  │ - Navigation Control                                     │  │    │
│  │  │ - User Interaction Management                            │  │    │
│  │  └──────────────────────────────────────────────────────────┘  │    │
│  └────────────────────────────────────────────────────────────────┘    │
│                               │                                          │
│  ┌────────────────────────────▼────────────────────────────────────┐   │
│  │                      SERVICE LAYER                               │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │ Business Logic Layer (@Service + @Transactional)         │  │   │
│  │  │                                                            │  │   │
│  │  │ ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │  │   │
│  │  │ │ Muracaat    │  │ Kisi        │  │ Yardim      │       │  │   │
│  │  │ │ Service     │  │ Service     │  │ Service     │       │  │   │
│  │  │ └─────────────┘  └─────────────┘  └─────────────┘       │  │   │
│  │  │                                                            │  │   │
│  │  │ ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │  │   │
│  │  │ │ AileFert    │  │ Tutanak     │  │ Report      │       │  │   │
│  │  │ │ Service     │  │ Service     │  │ Service     │       │  │   │
│  │  │ └─────────────┘  └─────────────┘  └─────────────┘       │  │   │
│  │  │                                                            │  │   │
│  │  │ ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │  │   │
│  │  │ │ Mernis      │  │ FileStorage │  │ Lookup      │       │  │   │
│  │  │ │ Service     │  │ Service     │  │ Service     │       │  │   │
│  │  │ └─────────────┘  └─────────────┘  └─────────────┘       │  │   │
│  │  │                                                            │  │   │
│  │  │ Responsibilities:                                         │  │   │
│  │  │ • Business Rule Enforcement                               │  │   │
│  │  │ • Transaction Management                                  │  │   │
│  │  │ • Validation Logic                                        │  │   │
│  │  │ • State Machine Management                                │  │   │
│  │  │ • Cross-Cutting Concerns                                  │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  └────────────────────────────────────────────────────────────────┘   │
│                               │                                          │
│  ┌────────────────────────────▼────────────────────────────────────┐   │
│  │                   REPOSITORY LAYER                               │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │ Data Access Layer (Spring Data JPA Repositories)         │  │   │
│  │  │                                                            │  │   │
│  │  │ • JpaRepository<Entity, ID>                               │  │   │
│  │  │ • Query Method Naming Convention                          │  │   │
│  │  │ • @Query JPQL/Native SQL                                  │  │   │
│  │  │ • Pagination & Sorting                                    │  │   │
│  │  │ • Specifications for Dynamic Queries                      │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  └────────────────────────────────────────────────────────────────┘   │
│                               │                                          │
│  ┌────────────────────────────▼────────────────────────────────────┐   │
│  │                      DOMAIN LAYER                                │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │ Entity Classes (JPA Entities)                            │  │   │
│  │  │ • Rich Domain Model                                       │  │   │
│  │  │ • Bidirectional Relationship Management                   │  │   │
│  │  │ • Cascade Operations                                      │  │   │
│  │  │ • Lifecycle Callbacks                                     │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  │                                                                   │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │ DTO Classes (Data Transfer Objects)                      │  │   │
│  │  │ • API Response/Request Models                             │  │   │
│  │  │ • MapStruct Auto-Mapping                                  │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  │                                                                   │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │ Enums & Value Objects                                     │  │   │
│  │  │ • MuracaatDurum, YardimTipi, YardimDurum                 │  │   │
│  │  │ • SGKDurum, OgrenimDurum, etc.                           │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  └────────────────────────────────────────────────────────────────┘   │
└──────────────────────────────┬──────────────────────────────────────────┘
                               │ JDBC/Hibernate
                               │
┌──────────────────────────────▼──────────────────────────────────────────┐
│                         DATA TIER                                        │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │                    MySQL Database Server                        │    │
│  │  ┌──────────────────────────────────────────────────────────┐  │    │
│  │  │ Database: sais_db                                        │  │    │
│  │  │                                                           │  │    │
│  │  │ ┌─────────────────┐  ┌─────────────────┐               │  │    │
│  │  │ │ Core Tables     │  │ Lookup Tables   │               │  │    │
│  │  │ │ (11 tables)     │  │ (14 tables)     │               │  │    │
│  │  │ └─────────────────┘  └─────────────────┘               │  │    │
│  │  │                                                           │  │    │
│  │  │ ┌─────────────────┐                                     │  │    │
│  │  │ │ Junction Tables │                                     │  │    │
│  │  │ │ (3 tables)      │                                     │  │    │
│  │  │ └─────────────────┘                                     │  │    │
│  │  │                                                           │  │    │
│  │  │ Features:                                                │  │    │
│  │  │ • Referential Integrity (Foreign Keys)                  │  │    │
│  │  │ • B-Tree Indexes for Performance                        │  │    │
│  │  │ • Audit Columns (created_at, updated_at, created_by)   │  │    │
│  │  │ • Soft Delete Pattern (aktif flag)                     │  │    │
│  │  │ • UTF-8 Character Set (Turkish Support)                │  │    │
│  │  └──────────────────────────────────────────────────────────┘  │    │
│  └────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                      CROSS-CUTTING CONCERNS                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ Logging      │  │ Exception    │  │ Validation   │  │ Audit      │ │
│  │ (SLF4J)      │  │ Handling     │  │ (JSR-380)    │  │ Trail      │ │
│  └──────────────┘  └──────────────┘  └──────────────┘  └────────────┘ │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ File Upload  │  │ Reporting    │  │ Caching      │  │ i18n       │ │
│  │ Security     │  │ (Jasper)     │  │ (Future)     │  │ (Turkish)  │ │
│  └──────────────┘  └──────────────┘  └──────────────┘  └────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

## 2.2 Technology Stack Deep Dive

### 2.2.1 Backend Technology Stack

#### **Spring Boot 3.2.0 Ecosystem**

```yaml
Core Framework:
  spring-boot-starter-parent: 3.2.0

Data Layer:
  spring-boot-starter-data-jpa:
    - Hibernate 6.x (JPA implementation)
    - Spring Data JPA repositories
    - Query method derivation
    - @Transactional support

Web Layer:
  spring-boot-starter-web:
    - Embedded Tomcat server
    - Spring MVC
    - REST capabilities (future use)

Validation:
  spring-boot-starter-validation:
    - Bean Validation 3.0 (Jakarta)
    - Hibernate Validator
    - Custom constraint validators
```

#### **JSF Integration (JoinFaces)**

```yaml
JoinFaces: 5.3.3
  Purpose: Spring Boot + JSF seamless integration

  Components:
    - mojarra-spring-boot-starter: JSF 4.0 implementation
    - Auto-configuration for JSF
    - Spring bean injection in JSF
    - Session management

PrimeFaces: 13.0.0 (Jakarta edition)
  Purpose: Rich UI component library

  Features:
    - 100+ UI components
    - Ajax support
    - Responsive design
    - Theme support (saga)
    - DataTable with lazy loading
    - File upload
    - Dialog framework

OmniFaces: 4.4.1
  Purpose: JSF utility library

  Features:
    - Extended converters
    - Custom validators
    - Ajax utilities
    - Cache management
```

#### **Database & ORM**

```yaml
Database Driver:
  mysql-connector-j: 8.x (runtime)

JPA Configuration:
  hibernate:
    ddl-auto: create (dev), validate (prod)
    dialect: MySQLDialect
    show_sql: false (prod)
    format_sql: true (dev)

  Connection Pool (HikariCP - default):
    maximum-pool-size: 10
    minimum-idle: 5
    connection-timeout: 30000
    idle-timeout: 600000
```

#### **Object Mapping (MapStruct)**

```yaml
MapStruct: 1.6.3
  Strategy: Compile-time code generation

  Advantages:
    - Zero runtime overhead (no reflection)
    - Type-safe mapping
    - Compile-time error detection
    - IDE autocomplete support
    - Nested object mapping
    - Collection mapping
    - Custom mapping methods

  vs Alternatives:
    vs ModelMapper:    10-15x faster (no reflection)
    vs Manual Mapping: Less boilerplate, maintainable
    vs Dozer:         Compile-time safety
```

#### **Code Generation (Lombok)**

```yaml
Lombok: 1.18.30

  Usage:
    - @Getter / @Setter: Automatic getters/setters
    - @NoArgsConstructor / @AllArgsConstructor: Constructors
    - @Builder: Builder pattern
    - @RequiredArgsConstructor: Constructor injection
    - @Slf4j: Logger injection
    - @Data: All-in-one (use sparingly on entities)

  Configuration:
    lombok.equalsAndHashCode.callSuper: warn
    lombok.toString.callSuper: warn
```

#### **Reporting (JasperReports)**

```yaml
JasperReports: 6.21.0
  Purpose: Enterprise reporting engine

  Capabilities:
    - PDF generation
    - Excel export (XLSX)
    - Dynamic report compilation
    - Subreports
    - Charts and graphs
    - Localization support

jasperreports-fonts: 6.21.0
  Purpose: DejaVu Sans font for Turkish characters

  Configuration:
    encoding: UTF-8
    font-name: DejaVu Sans
    pdf-encoding: UTF-8
```

### 2.2.2 Build & Dependency Management

```xml
<build>
    <plugins>
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
                        <version>${lombok.version}</version>
                    </path>
                    <!-- MapStruct -->
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                        <version>${mapstruct.version}</version>
                    </path>
                    <!-- Lombok + MapStruct Binding -->
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok-mapstruct-binding</artifactId>
                        <version>0.2.0</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>

        <!-- Spring Boot Maven Plugin -->
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <excludes>
                    <exclude>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                    </exclude>
                </excludes>
            </configuration>
        </plugin>
    </plugins>
</build>
```

**Build Process:**
```
1. Lombok Annotation Processing
   └─> Generates getters, setters, constructors, builders

2. MapStruct Annotation Processing
   └─> Generates mapper implementations

3. Java Compilation
   └─> Compiles to bytecode

4. Resource Copying
   └─> application.yml, XHTML files, reports

5. Packaging
   └─> Executable JAR with embedded Tomcat
```

---

# 3. VERİTABANI TASARIMI VE İLİŞKİSEL MODEL

## 3.1 Database Schema Overview

### 3.1.1 Tablo Kategorileri

Sistemimizde **28 tablo** bulunmaktadır ve 3 kategoriye ayrılır:

```
📊 TABLO KATEGORİLERİ:

1️⃣ CORE BUSINESS TABLES (11 tablo)
   └─ İş mantığının temel verilerini tutan tablolar

2️⃣ LOOKUP/REFERENCE TABLES (14 tablo)
   └─ Dropdown menüler, kodlu değerler için referans tabloları

3️⃣ JUNCTION/ASSOCIATION TABLES (3 tablo)
   └─ Many-to-many ilişkileri yöneten ara tablolar
```

## 3.2 Lookup Tables (Referans Tabloları) Nedir?

### 3.2.1 Lookup Table Kavramı

**Lookup Table**, sistemdeki **tekrar eden, standartlaştırılmış kodlu değerleri** saklamak için kullanılan referans tablolardır.

#### **Örnek: Meslek Tablosu**

```sql
-- ❌ KÖTÜ TASARIM: Her kayıtta string tekrarı
CREATE TABLE kisi (
    id BIGINT PRIMARY KEY,
    ad VARCHAR(50),
    meslek VARCHAR(100)  -- "İşçi", "Memur", "Öğretmen" her kayıtta tekrar
);

-- Problems:
-- • Data redundancy (veri tekrarı)
-- • Typo risk: "Öğretmen" vs "ögretmen" vs "Ogretmen"
-- • Storage waste
-- • Query performance (string comparison)
-- • Maintenance nightmare (değişiklik yapmak zor)


-- ✅ İYİ TASARIM: Lookup table ile normalize
CREATE TABLE meslek (
    id BIGINT PRIMARY KEY,
    kod VARCHAR(10) UNIQUE,  -- Business key
    adi VARCHAR(100),
    aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE kisi (
    id BIGINT PRIMARY KEY,
    ad VARCHAR(50),
    meslek_id BIGINT,
    FOREIGN KEY (meslek_id) REFERENCES meslek(id)
);

-- Benefits:
-- ✅ Data normalization (3NF)
-- ✅ Data integrity (Foreign Key constraint)
-- ✅ No typos (dropdown listelerden seçim)
-- ✅ Better performance (integer comparison)
-- ✅ Easy maintenance (tek yerden güncelleme)
-- ✅ Audit trail (kim ne zaman ekledi?)
```

### 3.2.2 Sistemdeki Lookup Tables (14 adet)

```
┌────────────────────────────────────────────────────────────────┐
│              LOOKUP/REFERENCE TABLES (14 ADET)                  │
└────────────────────────────────────────────────────────────────┘

1. yakinlik_kodu         - Aile yakınlık ilişkileri (MERNİS standardı)
   ├─ Örnek: Eşi, Annesi, Babası, Oğlu, Kızı, Kardeşi
   └─ Kullanım: AileFert tablosunda yakınlık tanımlama

2. meslek                - Meslek tanımları
   ├─ Örnek: İşsiz, İşçi, Memur, Öğretmen, Doktor
   └─ Kullanım: AileFert ve Kisi tablolarında

3. ozel_statu            - Özel durum tanımları
   ├─ Örnek: Şehit Yakını, Gazi Yakını, Yetim, Dul
   ├─ oncelik_puani: Önceliklendirme için
   └─ Kullanım: AileFert tablosunda

4. engelli_tipi          - Engellilik türleri (Hiyerarşik)
   ├─ Ana Tipler: Bedensel, Görme, İşitme, Zihinsel, Ruhsal
   ├─ Alt Tipler: Ortopedik, Az Gören, Otizm, Down Sendromu
   ├─ ust_tip_id: Self-referencing FK (hiyerarşi)
   └─ Kullanım: AileFertEngelBilgisi tablosunda

5. hastalik              - Hastalık tanımları
   ├─ Örnek: Şeker Hastalığı, Tansiyon, Kalp Hastalığı
   ├─ kronik: Boolean flag (kronik mi?)
   └─ Kullanım: AileFertHastalikBilgisi tablosunda

6. gelir_turu            - Gelir türleri
   ├─ Örnek: Maaş, Emekli Maaşı, Kira Geliri, Ticari Kazanç
   └─ Kullanım: GelirBilgisi tablosunda

7. borc_turu             - Borç türleri
   ├─ Örnek: Elektrik, Su, Doğalgaz, Kira, Kredi Kartı
   └─ Kullanım: BorcBilgisi tablosunda

8. yardim_dilimi         - Yardım dilimleri
   ├─ Örnek: Birinci Dilim, İkinci Dilim, Üçüncü Dilim
   └─ Kullanım: YardimKarar tablosunda (nakdi yardımlar için)

9. yardim_donemi         - Yardım dönemleri
   ├─ ay_sayisi: 1-12 ay arası
   ├─ Örnek: 1 Aylık, 3 Aylık, 6 Aylık, 12 Aylık
   └─ Kullanım: YardimKarar tablosunda (sürekli yardımlar için)

10. yardim_red_sebebi    - Yardım red sebepleri
    ├─ Örnek: Gelir Düzeyi Yüksek, Evrak Eksikliği, Gebze Dışı İkamet
    └─ Kullanım: YardimKarar tablosunda (red durumunda)

11. yardim_alt_tipi      - Yardım alt tipleri (17 adet kayıt)
    ├─ Komisyonlu Nakdi: 6 adet (Genel Ekonomik, Kira, Eğitim, Sağlık, ...)
    ├─ Komisyonlu Ayni: 6 adet (Gıda, Kömür, Beyaz Eşya, Mobilya, ...)
    ├─ Komisyonsuz Ayni: 5 adet (Acil Gıda, Hijyen, Bebek Paketi, ...)
    ├─ komisyon_kararli: Boolean flag
    ├─ yardim_tipi: ENUM (NAKDI, AYNI, SAGLIK, EGITIM, BARIS, DIGER)
    └─ Kullanım: YardimKarar ve MuracaatYardimTalep tablolarında

12. personel             - Personel kayıtları (3 adet örnek)
    ├─ tahkikat_yetkili: Boolean (tahkikata çıkabilir mi?)
    ├─ komisyon_uyesi: Boolean (komisyon üyesi mi?)
    └─ Kullanım: Muracaat ve TutanakBilgisi tablolarında

13. hesap_bilgisi        - Banka hesap/IBAN bilgileri
    ├─ kisi_id: FK to Kisi
    ├─ iban: TR ile başlayan 26 haneli
    ├─ varsayilan: Boolean (default hesap mı?)
    └─ Kullanım: YardimKarar tablosunda (nakdi yardımlarda para transferi)

14. kisi                 - Kişi kayıtları (15 adet örnek)
    ├─ Core data ama lookup gibi kullanılıyor
    ├─ MERNİS entegrasyonu
    └─ Kullanım: Muracaat (basvuru_sahibi), AileFert ilişkilerinde
```

### 3.2.3 Lookup Table Design Pattern

```java
// Tüm lookup tablolar için base abstract class
@MappedSuperclass
@Getter
@Setter
public abstract class BaseLookupEntity extends BaseEntity {

    @Column(name = "kod", unique = true, length = 20)
    private String kod;  // Business key (user-friendly code)

    @Column(name = "adi", nullable = false, length = 200)
    private String adi;  // Display name (UI'da gösterilecek)

    @Column(name = "aciklama", columnDefinition = "TEXT")
    private String aciklama;  // Optional description

    @Column(name = "sira_no")
    private Integer siraNo;  // Display order

    // aktif field inherited from BaseEntity (soft delete)
}

// Örnek: Meslek entity
@Entity
@Table(name = "meslek")
public class Meslek extends BaseLookupEntity {
    // Kod: M001, M002, M003, ...
    // Adi: İşsiz, İşçi, Memur, ...
    // No additional fields needed
}

// Örnek: OzelStatu entity (extra field)
@Entity
@Table(name = "ozel_statu")
public class OzelStatu extends BaseLookupEntity {

    @Column(name = "oncelik_puani")
    private Integer oncelikPuani;  // Priority score for sorting

    // Kod: OS001, OS002, ...
    // Adi: Şehit Yakını, Gazi Yakını, ...
    // oncelikPuani: 100, 90, 80, ... (higher = more priority)
}
```

### 3.2.4 Lookup Table Benefits

```
✅장점:

1. Data Integrity (Veri Bütünlüğü)
   - Foreign key constraints ile referential integrity
   - Sadece tablodaki değerler kullanılabilir
   - Orphan records önlenir

2. Data Consistency (Veri Tutarlılığı)
   - Standardizasyon: Tek kaynak, tek doğru
   - Typo/yazım hatası önlenir
   - Case-sensitivity problemleri ortadan kalkar

3. Performance (Performans)
   - Integer karşılaştırma (string'den hızlı)
   - Index'leme daha verimli
   - Query optimization kolaylaşır

4. Maintenance (Bakım Kolaylığı)
   - Tek yerden güncelleme
   - Yeni değer ekleme kolay
   - Audit trail (kim ekledi, ne zaman?)
   - Soft delete ile veri kaybı yok

5. User Experience (Kullanıcı Deneyimi)
   - Dropdown/Select box ile kolay seçim
   - Autocomplete support
   - Input validation otomatik

6. Internationalization (i18n)
   - Multiple language support için hazır altyapı
   - Kod sabit kalır, sadece "adi" translate edilir

7. Business Logic
   - Kod bazlı iş kuralları (örn: kod='OS001' ise öncelik ver)
   - Önceliklendirme (oncelik_puani field'ı)
   - Hiyerarşik ilişkiler (engelli_tipi parent-child)
```

## 3.3 Complete Entity Relationship Diagram (ERD)

### 3.3.1 Visual Database Schema

```
┌═══════════════════════════════════════════════════════════════════════════════════════┐
║                            SAIS DATABASE SCHEMA (28 TABLES)                            ║
║                         MySQL 8.x | UTF-8 | InnoDB Engine                              ║
└═══════════════════════════════════════════════════════════════════════════════════════┘

┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                              CORE BUSINESS ENTITIES                                      │
└─────────────────────────────────────────────────────────────────────────────────────────┘

                             ┌─────────────────────────┐
                             │      PERSONEL (3)       │
                             ├─────────────────────────┤
                             │ id (PK)                 │
                             │ tc_kimlik_no (UQ)       │
                             │ ad                      │
                             │ soyad                   │
                             │ email                   │
                             │ telefon                 │
                             │ unvan                   │
                             │ departman               │
                             │ tahkikat_yetkili (bool) │
                             │ komisyon_uyesi (bool)   │
                             │ + audit fields          │
                             └──────────┬──────────────┘
                                        │
                                        │ kaydeden_personel_id
                                        │
         ┌──────────────────────────────▼─────────────────────────────────────┐
         │                        MURACAAT (CORE)                              │
         │                      Central Aggregate Root                         │
         ├─────────────────────────────────────────────────────────────────────┤
         │ id (PK)                                                             │
         │ muracaat_no (UQ) [idx]           ← Business Key (Auto-increment)   │
         │ basvuru_sahibi_id (FK) [idx]     → KISI                            │
         │ adina_basvurulan_kisi_id (FK)    → KISI (optional)                 │
         │ kaydeden_personel_id (FK)        → PERSONEL                        │
         │ komisyon_kararli (bool)          ← Workflow flag                   │
         │ kendisi_basvurdu (bool)          ← Self/proxy application          │
         │ muracaat_tarihi [idx]            ← Application date                │
         │ inceleme_tarihi                  ← Review date                     │
         │ basvuru_metnu (TEXT)             ← Application text                │
         │ personel_gorus_notu (TEXT)       ← Staff notes                     │
         │ dokuman_listesi (TEXT)           ← Document list summary           │
         │ durum (ENUM) [idx]               ← State machine                   │
         │   • BEKLEMEDE                                                       │
         │   • TAHKIKATA_SEVK                                                  │
         │   • DEGERLENDIRME_KOMISYONU                                         │
         │   • SONUCLANDI                                                      │
         │   • TALEP_IPTAL_EDILDI                                              │
         │   • BASVURU_SAHIBINE_ULASILMADI                                     │
         │   • BASVURU_SAHIBI_VEFAT_ETTI                                       │
         │ karar_no                         ← Decision number (komisyonlu)    │
         │ karar_tarihi                     ← Decision date                   │
         │ sonuclanma_tarihi                ← Completion date                 │
         │ + audit fields                                                      │
         └────┬────────┬────────┬──────┬──────────┬───────────────────────────┘
              │        │        │      │          │
              │        │        │      │          │
    ┌─────────▼──┐ ┌──▼────┐ ┌─▼──────▼───┐ ┌────▼────────┐ ┌──────────────┐
    │ MURACAAT_  │ │ AILE_ │ │ AILE_MADDI │ │ TUTANAK_    │ │ YARDIM_KARAR │
    │ YARDIM_    │ │ FERT  │ │ _DURUM     │ │ BILGISI     │ │              │
    │ TALEP      │ │       │ │            │ │             │ │              │
    ├────────────┤ ├───────┤ ├────────────┤ ├─────────────┤ ├──────────────┤
    │ id (PK)    │ │ id    │ │ id (PK)    │ │ id (PK)     │ │ id (PK)      │
    │ muracaat_id│ │ (PK)  │ │ muracaat_id│ │ muracaat_id │ │ muracaat_id  │
    │ (FK) [idx] │ │       │ │ (FK) [idx] │ │ (FK) [idx]  │ │ (FK) [idx]   │
    │ yardim_alt │ │       │ │ toplam_gelir│ │ tahkikat_   │ │ yardim_alt_  │
    │ _tipi_id   │ │       │ │ toplam_borc│ │ personel_id │ │ tipi_id (FK) │
    │ (FK)       │ │       │ │ aciklama   │ │ (FK)        │ │ talepEdilmis │
    └────────────┘ │       │ │ + audit    │ │ tahkikat_   │ │ Mi (bool)    │
         │         │       │ └────┬───────┘ │ tarihi      │ │ yardim_durum │
         │         │       │      │         │ tahkikat_   │ │ (ENUM) [idx] │
         │         │       │      │         │ metni (TEXT)│ │ komisyon_    │
         │         │       │      │         │ ev_gorseller│ │ kararli      │
         │         │       │      │         │ (JSON)      │ │ toplanti_    │
         │         │       │      │         │ + audit     │ │ tarihi       │
         │         │       │      │         └─────────────┘ │ verilen_tutar│
         │         │       │      │                         │ adet_sayi    │
         │         │       │      │         ┌──────────────┐│ yardim_      │
         │         │       │      │         │ TUTANAK_     │││ dilimi_id   │
         │         │       │      │         │ GORSEL       │││ yardim_      │
         │         │       │      │         ├──────────────┤│ donemi_id    │
         │         │       │      │         │ id (PK)      │││ hesap_       │
         │         │       │      │         │ tutanak_id   │││ bilgisi_id   │
         │         │       │      │         │ (FK)         │││ red_sebebi_id│
         │         │       │      │         │ dosya_yolu   │││ aciklama     │
         │         │       │      │         │ dosya_adi    │││ kesinlesti   │
         │         │       │      │         │ sira_no      │││ kesinlesme_  │
         │         │       │      │         │ + audit      │││ tarihi       │
         │         │       │      │         └──────────────┘││ karar_sayisi │
         │         │       │      │                         ││ karar_tarihi │
         │         │       │      │                         ││ + audit      │
         │         │       │      │                         │└──────────────┘
         │         │       │      │                         │
         │         │       │      │                         │
         │         │       │      └─────────┬───────────────┘
         │         │       │                │
         │         │       │    ┌───────────▼───────────┐
         │         │       │    │ GELIR_BILGISI         │
         │         │       │    ├───────────────────────┤
         │         │       │    │ id (PK)               │
         │         │       │    │ aile_maddi_durum_id   │
         │         │       │    │ (FK) [idx]            │
         │         │       │    │ kisi_id (FK)          │
         │         │       │    │ gelir_turu_id (FK)    │
         │         │       │    │ gelir_tutari          │
         │         │       │    │ aciklama              │
         │         │       │    │ + audit               │
         │         │       │    └───────────────────────┘
         │         │       │
         │         │       │    ┌───────────────────────┐
         │         │       │    │ BORC_BILGISI          │
         │         │       │    ├───────────────────────┤
         │         │       │    │ id (PK)               │
         │         │       │    │ aile_maddi_durum_id   │
         │         │       │    │ (FK) [idx]            │
         │         │       │    │ borc_turu_id (FK)     │
         │         │       │    │ borc_tutari           │
         │         │       │    │ aciklama              │
         │         │       │    │ + audit               │
         │         │       │    └───────────────────────┘
         │         │       │
         │         │       │    ┌───────────────────────┐
         │         │       │    │ GAYRIMENKUL_BILGISI   │
         │         │       │    ├───────────────────────┤
         │         │       │    │ id (PK)               │
         │         │       │    │ aile_maddi_durum_id   │
         │         │       │    │ (FK) [idx]            │
         │         │       │    │ evi_var (bool)        │
         │         │       │    │ ev_tipi (ENUM)        │
         │         │       │    │ ev_mulkiyet (ENUM)    │
         │         │       │    │ ev_yakacak_tipi (ENUM)│
         │         │       │    │ araba_var (bool)      │
         │         │       │    │ gayrimenkul_var (bool)│
         │         │       │    │ gayrimenkul_turu (ENUM│
         │         │       │    │ gayrimenkul_deger     │
         │         │       │    │ aciklama              │
         │         │       │    │ + audit               │
         │         │       │    └───────────────────────┘
         │         │       │
         │         │       └──────────────────────────────────────┐
         │         │                                              │
         │         │                                              │
         │    ┌────▼─────────────────┐                     ┌──────▼──────┐
         │    │    AILE_FERT         │                     │    KISI     │
         │    ├──────────────────────┤                     ├─────────────┤
         │    │ id (PK)              │                     │ id (PK)     │
         │    │ muracaat_id (FK)[idx]│◄────────────────────┤ tc_kimlik_no│
         │    │ kisi_id (FK) [idx]   │────────────────────►│ (UQ) [idx]  │
         │    │ yakinlik_kodu_id (FK)│                     │ ad          │
         │    │ ozel_statu_id (FK)   │                     │ soyad       │
         │    │ meslek_id (FK)       │                     │ baba_adi    │
         │    │ yaptigi_is           │                     │ anne_adi    │
         │    │ sgk_durum (ENUM)     │                     │ dogum_tarihi│
         │    │ ogrenim_durumu (ENUM)│                     │ dogum_yeri  │
         │    │ aciklama             │                     │ cinsiyet    │
         │    │ + audit              │                     │ adres       │
         │    └────┬───────┬─────────┘                     │ il          │
         │         │       │                               │ ilce        │
         │         │       │                               │ telefon     │
         │         │       │                               │ gebze_      │
         │         │       │                               │ ikameti(bool│
         │         │       │                               │ sgk_durum   │
         │         │       │                               │ (ENUM)      │
         │         │       │                               │ ogrenim_    │
         │         │       │                               │ durum (ENUM)│
         │         │       │                               │ son_mernis_ │
         │         │       │                               │ sorgu_tarihi│
         │         │       │                               │ mernis_     │
         │         │       │                               │ guncelleme_ │
         │         │       │                               │ sayisi      │
         │         │       │                               │ + audit     │
         │         │       │                               └─────────────┘
         │         │       │                                      │
         │         │       │                               ┌──────▼──────────┐
         │         │       │                               │ HESAP_BILGISI   │
         │         │       │                               ├─────────────────┤
         │         │       │                               │ id (PK)         │
         │         │       │                               │ kisi_id (FK)    │
         │         │       │                               │ [idx]           │
         │         │       │                               │ banka_adi       │
         │         │       │                               │ iban            │
         │         │       │                               │ hesap_sahibi_adi│
         │         │       │                               │ varsayilan(bool)│
         │         │       │                               │ + audit         │
         │         │       │                               └─────────────────┘
         │         │       │
         │    ┌────▼────────────────────┐
         │    │ AILE_FERT_ENGEL_BILGISI │
         │    ├─────────────────────────┤
         │    │ id (PK)                 │
         │    │ aile_fert_id (FK) [idx] │
         │    │ engelli_tipi_id (FK)    │
         │    │ engel_orani (1-99)      │
         │    │ rapor_no                │
         │    │ rapor_tarihi            │
         │    │ aciklama                │
         │    │ + audit                 │
         │    └─────────────────────────┘
         │
         │    ┌──────────────────────────┐
         │    │ AILE_FERT_HASTALIK_      │
         │    │ BILGISI                  │
         │    ├──────────────────────────┤
         │    │ id (PK)                  │
         │    │ aile_fert_id (FK) [idx]  │
         │    │ hastalik_id (FK)         │
         │    │ tani_tarihi              │
         │    │ tedavi_durumu            │
         │    │ aciklama                 │
         │    │ + audit                  │
         │    └──────────────────────────┘
         │
         │    ┌──────────────────┐
         └───►│ MURACAAT_DOKUMAN │
              ├──────────────────┤
              │ id (PK)          │
              │ muracaat_id (FK) │
              │ [idx]            │
              │ dosya_adi        │
              │ orijinal_dosya_  │
              │ adi              │
              │ dosya_yolu       │
              │ dosya_boyutu     │
              │ dosya_tipi       │
              │ aciklama         │
              │ + audit          │
              └──────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                          LOOKUP/REFERENCE TABLES (14 ADET)                               │
└─────────────────────────────────────────────────────────────────────────────────────────┘

┌────────────────┐  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐
│ YAKINLIK_KODU  │  │    MESLEK      │  │  OZEL_STATU    │  │ ENGELLI_TIPI   │
├────────────────┤  ├────────────────┤  ├────────────────┤  ├────────────────┤
│ id (PK)        │  │ id (PK)        │  │ id (PK)        │  │ id (PK)        │
│ kod (UQ)       │  │ kod (UQ)       │  │ kod (UQ)       │  │ kod (UQ)       │
│ adi            │  │ adi            │  │ adi            │  │ adi            │
│ aciklama       │  │ aciklama       │  │ aciklama       │  │ ust_tip_id (FK)│
│ sira_no        │  │ sira_no        │  │ oncelik_puani  │  │ sira_no        │
│ + audit        │  │ + audit        │  │ sira_no        │  │ + audit        │
└────────────────┘  └────────────────┘  │ + audit        │  └────────────────┘
                                        └────────────────┘
12 kayıt            15 kayıt            7 kayıt            17 kayıt (6+11)

┌────────────────┐  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐
│   HASTALIK     │  │  GELIR_TURU    │  │   BORC_TURU    │  │ YARDIM_DILIMI  │
├────────────────┤  ├────────────────┤  ├────────────────┤  ├────────────────┤
│ id (PK)        │  │ id (PK)        │  │ id (PK)        │  │ id (PK)        │
│ kod (UQ)       │  │ kod (UQ)       │  │ kod (UQ)       │  │ kod (UQ)       │
│ adi            │  │ adi            │  │ adi            │  │ adi            │
│ kronik (bool)  │  │ aciklama       │  │ aciklama       │  │ sira_no        │
│ + audit        │  │ sira_no        │  │ sira_no        │  │ + audit        │
└────────────────┘  │ + audit        │  │ + audit        │  └────────────────┘
15 kayıt            └────────────────┘  └────────────────┘  4 kayıt
                    9 kayıt             11 kayıt

┌────────────────┐  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐
│ YARDIM_DONEMI  │  │ YARDIM_RED_    │  │ YARDIM_ALT_    │  │   PERSONEL     │
│                │  │   SEBEBI       │  │     TIPI       │  │                │
├────────────────┤  ├────────────────┤  ├────────────────┤  ├────────────────┤
│ id (PK)        │  │ id (PK)        │  │ id (PK)        │  │ id (PK)        │
│ adi            │  │ kod (UQ)       │  │ kod (UQ)       │  │ tc_kimlik_no   │
│ ay_sayisi(1-12)│  │ adi            │  │ adi            │  │ (UQ)           │
│ + audit        │  │ aciklama       │  │ komisyon_      │  │ ad             │
└────────────────┘  │ sira_no        │  │ kararli (bool) │  │ soyad          │
12 kayıt            │ + audit        │  │ yardim_tipi    │  │ telefon        │
                    └────────────────┘  │ (ENUM)         │  │ email          │
                    8 kayıt             │ aciklama       │  │ unvan          │
                                        │ birim          │  │ departman      │
                                        │ varsayilan_    │  │ tahkikat_      │
                                        │ tutar          │  │ yetkili (bool) │
                                        │ sira_no        │  │ komisyon_      │
                                        │ + audit        │  │ uyesi (bool)   │
                                        └────────────────┘  │ + audit        │
                                        17 kayıt            └────────────────┘
                                        (6 nakdi +          3 kayıt
                                         6 ayni kom. +
                                         5 ayni kom.suz)

┌───────────────────────────────────────────────────────────────────────────┐
│                    COMMON AUDIT FIELDS (BaseEntity)                        │
├───────────────────────────────────────────────────────────────────────────┤
│ olusturma_tarihi   DATETIME    NOT NULL  (@CreatedDate)                   │
│ guncelleme_tarihi  DATETIME              (@LastModifiedDate)              │
│ olusturan          VARCHAR(100)          (@CreatedBy)                     │
│ guncelleyen        VARCHAR(100)          (@LastModifiedBy)                │
│ aktif              BOOLEAN     DEFAULT TRUE  (Soft Delete Flag)           │
└───────────────────────────────────────────────────────────────────────────┘
```

### 3.3.2 İlişki Tipleri (Relationship Types)

```
┌────────────────────────────────────────────────────────────────┐
│                  JPA RELATIONSHIP MAPPING                       │
└────────────────────────────────────────────────────────────────┘

1️⃣ ONE-TO-ONE (1:1)
   ────────────────────────────────────────────────────────────
   MURACAAT (1) ──────────── (1) AILE_MADDI_DURUM
   MURACAAT (1) ──────────── (1) TUTANAK_BILGISI
   AILE_FERT (1) ─────────── (1) AILE_FERT_ENGEL_BILGISI
   AILE_FERT (1) ─────────── (1) AILE_FERT_HASTALIK_BILGISI
   AILE_MADDI_DURUM (1) ──── (1) GAYRIMENKUL_BILGISI

   JPA Mapping:
   @OneToOne(mappedBy = "muracaat",
             cascade = CascadeType.ALL,
             orphanRemoval = true)
   private AileMaddiDurum aileMaddiDurum;

2️⃣ ONE-TO-MANY (1:N)
   ────────────────────────────────────────────────────────────
   MURACAAT (1) ──────────── (N) AILE_FERT
   MURACAAT (1) ──────────── (N) YARDIM_KARAR
   MURACAAT (1) ──────────── (N) MURACAAT_DOKUMAN
   MURACAAT (1) ──────────── (N) MURACAAT_YARDIM_TALEP
   AILE_MADDI_DURUM (1) ──── (N) GELIR_BILGISI
   AILE_MADDI_DURUM (1) ──── (N) BORC_BILGISI
   TUTANAK_BILGISI (1) ───── (N) TUTANAK_GORSEL
   KISI (1) ──────────────── (N) HESAP_BILGISI

   JPA Mapping:
   @OneToMany(mappedBy = "muracaat",
              cascade = CascadeType.ALL,
              orphanRemoval = true)
   @Builder.Default
   private List<AileFert> aileFertleri = new ArrayList<>();

3️⃣ MANY-TO-ONE (N:1)
   ────────────────────────────────────────────────────────────
   MURACAAT (N) ──────────── (1) KISI (basvuru_sahibi)
   MURACAAT (N) ──────────── (1) PERSONEL (kaydeden)
   AILE_FERT (N) ─────────── (1) KISI
   AILE_FERT (N) ─────────── (1) MURACAAT
   AILE_FERT (N) ─────────── (1) YAKINLIK_KODU
   AILE_FERT (N) ─────────── (1) MESLEK
   AILE_FERT (N) ─────────── (1) OZEL_STATU
   GELIR_BILGISI (N) ─────── (1) GELIR_TURU
   BORC_BILGISI (N) ──────── (1) BORC_TURU
   YARDIM_KARAR (N) ──────── (1) YARDIM_ALT_TIPI
   YARDIM_KARAR (N) ──────── (1) YARDIM_DILIMI
   YARDIM_KARAR (N) ──────── (1) YARDIM_DONEMI
   YARDIM_KARAR (N) ──────── (1) YARDIM_RED_SEBEBI
   YARDIM_KARAR (N) ──────── (1) HESAP_BILGISI

   JPA Mapping:
   @ManyToOne(fetch = FetchType.EAGER, optional = false)
   @JoinColumn(name = "basvuru_sahibi_id", nullable = false)
   private Kisi basvuruSahibi;

4️⃣ SELF-REFERENCING (Hierarchical)
   ────────────────────────────────────────────────────────────
   ENGELLI_TIPI (N) ──────── (1) ENGELLI_TIPI (parent-child)

   Example:
   ET001: Bedensel Engelli (parent)
     ├─ ET001-01: Ortopedik Engelli (child)
     └─ ET001-02: Omurilik Felci (child)

   JPA Mapping:
   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "ust_tip_id")
   private EngelliTipi ustTip;

   @OneToMany(mappedBy = "ustTip")
   private List<EngelliTipi> altTipler = new ArrayList<>();

5️⃣ MANY-TO-MANY (M:N) via Junction Table
   ────────────────────────────────────────────────────────────
   MURACAAT (M) ─── MURACAAT_YARDIM_TALEP ─── (N) YARDIM_ALT_TIPI

   Why Junction Table:
   • Bir müracaatta birden fazla yardım türü talep edilebilir
   • Bir yardım türü birden fazla müracaatta bulunabilir
   • Extra attributes: talep_tarihi, talep_eden_personel, etc.

   JPA Mapping:
   // In Muracaat entity:
   @OneToMany(mappedBy = "muracaat",
              cascade = CascadeType.ALL,
              orphanRemoval = true)
   private List<MuracaatYardimTalep> yardimTalepleri = new ArrayList<>();

   // In MuracaatYardimTalep entity (junction):
   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "muracaat_id")
   private Muracaat muracaat;

   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "yardim_alt_tipi_id")
   private YardimAltTipi yardimAltTipi;
```

### 3.3.3 Cascade Operations & Orphan Removal

```java
// Muracaat is the AGGREGATE ROOT
// All child entities cascade from Muracaat

@Entity
public class Muracaat extends BaseEntity {

    // CASCADE ALL: Create, Update, Delete propagates to children
    // ORPHAN REMOVAL: If removed from collection, entity is deleted

    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,      // ← CASCADE ALL
               orphanRemoval = true)            // ← ORPHAN REMOVAL
    private List<AileFert> aileFertleri = new ArrayList<>();

    @OneToOne(mappedBy = "muracaat",
              cascade = CascadeType.ALL,        // ← CASCADE ALL
              orphanRemoval = true)              // ← ORPHAN REMOVAL
    private AileMaddiDurum aileMaddiDurum;

    @OneToMany(mappedBy = "muracaat",
               cascade = CascadeType.ALL,       // ← CASCADE ALL
               orphanRemoval = true)             // ← ORPHAN REMOVAL
    private List<YardimKarar> yardimKararlari = new ArrayList<>();

    // Helper methods for bidirectional sync
    public void addAileFert(AileFert fert) {
        aileFertleri.add(fert);
        fert.setMuracaat(this);  // Sync bidirectional relationship
    }

    public void removeAileFert(AileFert fert) {
        aileFertleri.remove(fert);
        fert.setMuracaat(null);  // Break relationship → triggers orphan removal
    }
}

// Usage example:
Muracaat muracaat = muracaatRepository.findById(id);
muracaat.getAileFertleri().clear();  // Orphan removal kicks in
muracaatRepository.save(muracaat);   // All AileFert records deleted
```

**Cascade Operations Explained:**

```
SCENARIO: Müracaat silindiğinde ne olur?

DELETE FROM muracaat WHERE id = 123

Cascade etkisi ile otomatik olarak:
├─ DELETE FROM aile_fert WHERE muracaat_id = 123
├─ DELETE FROM aile_maddi_durum WHERE muracaat_id = 123
│  ├─ DELETE FROM gelir_bilgisi WHERE aile_maddi_durum_id = 456
│  ├─ DELETE FROM borc_bilgisi WHERE aile_maddi_durum_id = 456
│  └─ DELETE FROM gayrimenkul_bilgisi WHERE aile_maddi_durum_id = 456
├─ DELETE FROM tutanak_bilgisi WHERE muracaat_id = 123
│  └─ DELETE FROM tutanak_gorsel WHERE tutanak_id = 789
├─ DELETE FROM yardim_karar WHERE muracaat_id = 123
├─ DELETE FROM muracaat_dokuman WHERE muracaat_id = 123
└─ DELETE FROM muracaat_yardim_talep WHERE muracaat_id = 123

✅ Tek SQL sorgusu ile tüm ilişkili kayıtlar temizlenir
✅ Orphan records (sahipsiz kayıtlar) kalmaz
✅ Referential integrity korunur
```

### 3.3.4 Database Indexes & Performance

```sql
-- UNIQUE INDEXES (Business Keys)
CREATE UNIQUE INDEX idx_muracaat_no ON muracaat(muracaat_no);
CREATE UNIQUE INDEX idx_kisi_tc ON kisi(tc_kimlik_no);
CREATE UNIQUE INDEX idx_personel_tc ON personel(tc_kimlik_no);

-- FOREIGN KEY INDEXES (Join Performance)
CREATE INDEX idx_muracaat_basvuru_sahibi ON muracaat(basvuru_sahibi_id);
CREATE INDEX idx_muracaat_kaydeden ON muracaat(kaydeden_personel_id);
CREATE INDEX idx_aile_fert_muracaat ON aile_fert(muracaat_id);
CREATE INDEX idx_aile_fert_kisi ON aile_fert(kisi_id);
CREATE INDEX idx_yardim_karar_muracaat ON yardim_karar(muracaat_id);
CREATE INDEX idx_gelir_bilgisi_maddi_durum ON gelir_bilgisi(aile_maddi_durum_id);
CREATE INDEX idx_borc_bilgisi_maddi_durum ON borc_bilgisi(aile_maddi_durum_id);

-- SEARCH/FILTER INDEXES (WHERE clause optimization)
CREATE INDEX idx_muracaat_durum ON muracaat(durum);
CREATE INDEX idx_muracaat_tarih ON muracaat(muracaat_tarihi);
CREATE INDEX idx_yardim_karar_durum ON yardim_karar(yardim_durum);

-- COMPOSITE INDEXES (Multi-column queries)
CREATE INDEX idx_muracaat_durum_tarih ON muracaat(durum, muracaat_tarihi);
CREATE INDEX idx_kisi_gebze_aktif ON kisi(gebze_ikameti, aktif);

-- Performance Impact:
-- Without index: O(n) - Full table scan
-- With index:    O(log n) - B-tree search
-- For 10,000 records: 10,000 rows → 13 rows (logarithmic)
```

---

## 3.4 Database Normalization & Data Integrity

### 3.4.1 Normal Forms (NF)

```
✅ 1NF (First Normal Form):
   • Atomic values (no repeating groups)
   • Each column contains single value
   • Example: address field is atomic (no CSV like "address1,address2")

✅ 2NF (Second Normal Form):
   • 1NF + No partial dependencies
   • All non-key attributes depend on entire primary key
   • Example: In GELIR_BILGISI, kisi_id is normalized (not repeated in each row)

✅ 3NF (Third Normal Form):
   • 2NF + No transitive dependencies
   • Non-key attributes don't depend on other non-key attributes
   • Example: YAKINLIK_KODU is separate table (not embedded in AILE_FERT)

Current Status: ✅ 3NF achieved across all tables
```

### 3.4.2 Referential Integrity

```sql
-- Foreign Key Constraints ensure data integrity

-- Example 1: AILE_FERT → MURACAAT
ALTER TABLE aile_fert
ADD CONSTRAINT fk_aile_fert_muracaat
FOREIGN KEY (muracaat_id) REFERENCES muracaat(id)
ON DELETE CASCADE           -- ← Müracaat silinirse aile fert de silinir
ON UPDATE CASCADE;          -- ← Müracaat id değişirse aile fert de güncellenir

-- Example 2: AILE_FERT → KISI
ALTER TABLE aile_fert
ADD CONSTRAINT fk_aile_fert_kisi
FOREIGN KEY (kisi_id) REFERENCES kisi(id)
ON DELETE RESTRICT          -- ← Kisi silinmeye çalışılırsa hata verir
ON UPDATE CASCADE;          -- ← Kisi id değişirse aile fert de güncellenir

-- Example 3: GELIR_BILGISI → GELIR_TURU
ALTER TABLE gelir_bilgisi
ADD CONSTRAINT fk_gelir_bilgisi_turu
FOREIGN KEY (gelir_turu_id) REFERENCES gelir_turu(id)
ON DELETE RESTRICT          -- ← Lookup table deletion restricted
ON UPDATE CASCADE;

-- Total Foreign Key Constraints: 35+
-- Each FK ensures:
--   ✅ Orphan records cannot exist
--   ✅ Invalid references cannot be inserted
--   ✅ Data consistency maintained
```

### 3.4.3 Check Constraints (Business Rules)

```sql
-- Engel oranı 1-99 arası olmalı
ALTER TABLE aile_fert_engel_bilgisi
ADD CONSTRAINT chk_engel_orani
CHECK (engel_orani BETWEEN 1 AND 99);

-- Yardım dönemi 1-12 ay arası olmalı
ALTER TABLE yardim_donemi
ADD CONSTRAINT chk_ay_sayisi
CHECK (ay_sayisi BETWEEN 1 AND 12);

-- Gelir tutarı negatif olamaz
ALTER TABLE gelir_bilgisi
ADD CONSTRAINT chk_gelir_tutari_pozitif
CHECK (gelir_tutari >= 0);

-- Borç tutarı negatif olamaz
ALTER TABLE borc_bilgisi
ADD CONSTRAINT chk_borc_tutari_pozitif
CHECK (borc_tutari >= 0);

-- IBAN TR ile başlamalı
ALTER TABLE hesap_bilgisi
ADD CONSTRAINT chk_iban_format
CHECK (iban LIKE 'TR%' AND LENGTH(iban) = 26);

-- Gebze kontrolü (il = Kocaeli AND ilce = Gebze)
-- (Application level'da kontrol ediliyor)
```

---

Dosya çok uzun olduğu için devam ediyorum...

