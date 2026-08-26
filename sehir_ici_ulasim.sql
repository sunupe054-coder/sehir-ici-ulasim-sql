-- =============================================================================
-- PROJE: Şehir İçi Ulaşım ve Akıllı Kart Yönetim Altyapısı
-- TESLİMAT: Tek Dosya .sql (DDL + DML + DQL)
-- =============================================================================

-- =============================================================================
-- 1. BÖLÜM: DDL (Data Definition Language) - TABLO VE KISITLAMALAR
-- =============================================================================

DROP TABLE IF EXISTS Gecisler;
DROP TABLE IF EXISTS Yuklemeler;
DROP TABLE IF EXISTS Kartlar;
DROP TABLE IF EXISTS Hatlar;
DROP TABLE IF EXISTS Duraklar;

-- Kartlar Tablosu
CREATE TABLE Kartlar (
    KartID INT PRIMARY KEY,
    KartNumarasi VARCHAR(20) UNIQUE NOT NULL,
    KartTipi VARCHAR(20) NOT NULL,
    Bakiye DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    OlusturmaTarihi DATE NOT NULL,
    CONSTRAINT CHK_KartTipi CHECK (KartTipi IN ('Öğrenci', 'Tam', 'Anonim', 'Yaşlı')),
    CONSTRAINT CHK_Bakiye CHECK (Bakiye >= 0)
);

-- Hatlar Tablosu
CREATE TABLE Hatlar (
    HatID INT PRIMARY KEY,
    HatKodu VARCHAR(10) UNIQUE NOT NULL,
    HatAdi VARCHAR(100) NOT NULL,
    UlasimTipi VARCHAR(20) NOT NULL,
    CONSTRAINT CHK_UlasimTipi CHECK (UlasimTipi IN ('Otobüs', 'Metro', 'Tramvay'))
);

-- Duraklar Tablosu
CREATE TABLE Duraklar (
    DurakID INT PRIMARY KEY,
    DurakAdi VARCHAR(100) NOT NULL,
    Ilce VARCHAR(50) NOT NULL
);

-- Geçişler Tablosu
CREATE TABLE Gecisler (
    GecisID INT PRIMARY KEY,
    KartID INT NOT NULL,
    HatID INT NOT NULL,
    DurakID INT NOT NULL,
    GecisTarihi TIMESTAMP NOT NULL,
    CekilenUcret DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Gecis_Kart FOREIGN KEY (KartID) REFERENCES Kartlar(KartID),
    CONSTRAINT FK_Gecis_Hat FOREIGN KEY (HatID) REFERENCES Hatlar(HatID),
    CONSTRAINT FK_Gecis_Durak FOREIGN KEY (DurakID) REFERENCES Duraklar(DurakID),
    CONSTRAINT CHK_CekilenUcret CHECK (CekilenUcret >= 0)
);

-- Yüklemeler Tablosu
CREATE TABLE Yuklemeler (
    YuklemeID INT PRIMARY KEY,
    KartID INT NOT NULL,
    YuklemeTarihi TIMESTAMP NOT NULL,
    Miktar DECIMAL(10, 2) NOT NULL,
    OdemeYontemi VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Yukleme_Kart FOREIGN KEY (KartID) REFERENCES Kartlar(KartID),
    CONSTRAINT CHK_Miktar CHECK (Miktar > 0)
);

-- =============================================================================
-- 2. BÖLÜM: DML (Data Manipulation Language) - ÖRNEK VERİ SETİ
-- =============================================================================

-- Kart Ekleme
INSERT INTO Kartlar (KartID, KartNumarasi, KartTipi, Bakiye, OlusturmaTarihi) VALUES
(1, 'KART-1001', 'Öğrenci', 45.00, '2026-01-10'),
(2, 'KART-1002', 'Öğrenci', 120.00, '2026-01-15'),
(3, 'KART-1003', 'Öğrenci', 15.00, '2026-02-01'),
(4, 'KART-2001', 'Tam', 250.00, '2026-01-05'),
(5, 'KART-2002', 'Tam', 80.00, '2026-02-20'),
(6, 'KART-2003', 'Tam', 10.00, '2026-03-01'),
(7, 'KART-3001', 'Anonim', 30.00, '2026-04-10'),
(8, 'KART-3002', 'Anonim', 5.00, '2026-05-12'),
(9, 'KART-4001', 'Yaşlı', 0.00, '2026-01-01'),
(10, 'KART-4002', 'Yaşlı', 0.00, '2026-01-02');

-- Hat Ekleme
INSERT INTO Hatlar (HatID, HatKodu, HatAdi, UlasimTipi) VALUES
(1, 'M1', 'Kızılay - Batıkent Metrosu', 'Metro'),
(2, 'M2', 'Çayyolu Metrosu', 'Metro'),
(3, 'M3', 'Törekent Metrosu', 'Metro'),
(4, 'T1', 'Gar - Üniversite Tramvayı', 'Tramvay'),
(5, '501', 'Gar Meydanı - Kampüs Hattı', 'Otobüs'),
(6, '502', 'Kızılay - Çankaya Ekspres', 'Otobüs'),
(7, '503', 'Batıkent - Sanayi Ring', 'Otobüs'),
(8, '504', 'Kızılay - Batı Çevre Yolu', 'Otobüs');

-- Durak Ekleme
INSERT INTO Duraklar (DurakID, DurakAdi, Ilce) VALUES
(101, 'Kızılay İstasyonu', 'Çankaya'),
(102, 'Ulus Meydanı', 'Altındağ'),
(103, 'Batıkent Merkez', 'Yenimahalle'),
(104, 'Üniversite Ana Giriş', 'Çankaya'),
(105, 'Gar İstasyonu', 'Altındağ'),
(106, 'Milli Kütüphane', 'Çankaya'),
(107, 'Sanayi Sitesi', 'Ostim');

-- Yükleme Ekleme (Son 1 ay: 2026-07-26 ile 2026-08-26 arası)
INSERT INTO Yuklemeler (YuklemeID, KartID, YuklemeTarihi, Miktar, OdemeYontemi) VALUES
(1, 1, '2026-06-10 10:30:00', 100.00, 'Kredi Kartı'),
(2, 2, '2026-08-15 14:20:00', 200.00, 'Kredi Kartı'),
(3, 3, '2026-05-01 09:00:00', 50.00, 'Nakit'),
(4, 4, '2026-08-20 18:00:00', 300.00, 'Kredi Kartı'),
(5, 5, '2026-06-01 12:00:00', 150.00, 'Mobil Bankacılık'),
(6, 6, '2026-05-15 11:15:00', 200.00, 'Kredi Kartı'),
(7, 7, '2026-08-01 16:45:00', 100.00, 'Nakit'),
(8, 8, '2026-04-20 08:30:00', 50.00, 'Nakit');

-- Geçiş Ekleme
INSERT INTO Gecisler (GecisID, KartID, HatID, DurakID, GecisTarihi, CekilenUcret) VALUES
-- Öğrenci Kart 1 Geçişleri (Aşırı harcama senaryosu)
(1, 1, 1, 101, '2026-08-05 08:15:00', 15.00),
(2, 1, 1, 102, '2026-08-06 08:20:00', 15.00),
(3, 1, 5, 104, '2026-08-10 18:10:00', 15.00),
(4, 1, 1, 101, '2026-08-15 08:30:00', 15.00),
(5, 1, 5, 101, '2026-08-22 17:45:00', 15.00),

-- Öğrenci Kart 2 ve 3 Normal Geçişler
(6, 2, 1, 101, '2026-08-02 08:10:00', 15.00),
(7, 3, 4, 105, '2026-08-03 14:00:00', 15.00),

-- Tam Kart 4 ve 5 Geçişleri
(8, 4, 1, 101, '2026-08-01 07:45:00', 30.00),
(9, 4, 2, 106, '2026-08-04 17:30:00', 30.00),
(10, 5, 3, 103, '2026-08-05 08:00:00', 30.00),

-- Tam Kart 6 Geçişleri (Aşırı harcama)
(11, 6, 1, 101, '2026-08-02 09:00:00', 30.00),
(12, 6, 2, 106, '2026-08-07 18:30:00', 30.00),
(13, 6, 1, 102, '2026-08-12 17:15:00', 30.00),
(14, 6, 3, 103, '2026-08-18 19:00:00', 30.00),
(15, 6, 8, 101, '2026-08-25 18:40:00', 30.00),

-- Anonim ve Yaşlı Kart Geçişleri
(16, 7, 1, 101, '2026-08-01 12:00:00', 35.00),
(17, 8, 4, 105, '2026-08-02 13:00:00', 35.00),
(18, 9, 1, 101, '2026-08-03 10:00:00', 0.00),
(19, 10, 5, 104, '2026-08-03 11:30:00', 0.00),

-- Hat Analizleri İçin İlave Geçiş Kayıtları
(20, 2, 1, 101, '2026-08-10 08:15:00', 15.00),
(21, 4, 1, 101, '2026-08-11 08:30:00', 30.00),
(22, 5, 1, 101, '2026-08-12 08:45:00', 30.00),
(23, 7, 1, 101, '2026-08-13 17:30:00', 35.00),
(24, 1, 7, 107, '2026-08-14 09:00:00', 15.00);

-- =============================================================================
-- 3. BÖLÜM: DQL (Data Query Language) - KARMAŞIK VE ANALİTİK SORGULAR
-- =============================================================================

-- -----------------------------------------------------------------------------
-- SORGU 1: Anormal Harcama Yapan Kartlar
-- Kendi kart tipinin aylık ortalama harcamasından %50 fazla harcayan,
-- ancak son 1 ayda hiç bakiye yüklememiş kartları ve son duraklarını getirir.
-- -----------------------------------------------------------------------------
WITH KartAylikHarcama AS (
    SELECT 
        k.KartID,
        k.KartNumarasi,
        k.KartTipi,
        SUM(g.CekilenUcret) AS ToplamAylikHarcama
    FROM Kartlar k
    JOIN Gecisler g ON k.KartID = g.KartID
    WHERE g.GecisTarihi >= '2026-07-26'
    GROUP BY k.KartID, k.KartNumarasi, k.KartTipi
),
TipOrtalamaHarcama AS (
    SELECT 
        KartTipi,
        AVG(ToplamAylikHarcama) AS TipOrtalamasi
    FROM KartAylikHarcama
    GROUP BY KartTipi
),
SonGecisDurak AS (
    SELECT 
        g.KartID,
        d.DurakAdi AS SonKullanilanDurak,
        ROW_NUMBER() OVER (PARTITION BY g.KartID ORDER BY g.GecisTarihi DESC) AS Sira
    FROM Gecisler g
    JOIN Duraklar d ON g.DurakID = d.DurakID
)
SELECT 
    kah.KartID,
    kah.KartNumarasi,
    kah.KartTipi,
    kah.ToplamAylikHarcama,
    ROUND(toh.TipOrtalamasi, 2) AS TipOrtalamasi,
    sgd.SonKullanilanDurak
FROM KartAylikHarcama kah
JOIN TipOrtalamaHarcama toh ON kah.KartTipi = toh.KartTipi
JOIN SonGecisDurak sgd ON kah.KartID = sgd.KartID AND sgd.Sira = 1
WHERE kah.ToplamAylikHarcama > (toh.TipOrtalamasi * 1.50)
  AND NOT EXISTS (
      SELECT 1 
      FROM Yuklemeler y 
      WHERE y.KartID = kah.KartID 
        AND y.YuklemeTarihi >= '2026-07-26'
  );

-- -----------------------------------------------------------------------------
-- SORGU 2: Atıl Kalmış Hat ve Durak Analizi
-- Metro tipinde en çok kullanılan ilk 3 hattın geçtiği duraklardan geçen,
-- ancak son 3 aydaki toplam geçiş sayısı otobüslerin genel ortalamasının
-- altında kalan otobüs hatlarını listeler.
-- -----------------------------------------------------------------------------
WITH PopulerMetroHatlari AS (
    SELECT 
        h.HatID
    FROM Hatlar h
    JOIN Gecisler g ON h.HatID = g.HatID
    WHERE h.UlasimTipi = 'Metro'
    GROUP BY h.HatID
    ORDER BY COUNT(g.GecisID) DESC
    LIMIT 3
),
MetroDuraklari AS (
    SELECT DISTINCT 
        g.DurakID
    FROM Gecisler g
    JOIN PopulerMetroHatlari pmh ON g.HatID = pmh.HatID
),
OtobusHatGecisleri AS (
    SELECT 
        h.HatID,
        h.HatKodu,
        h.HatAdi,
        COUNT(g.GecisID) AS Son3AyGecisSayisi
    FROM Hatlar h
    LEFT JOIN Gecisler g ON h.HatID = g.HatID AND g.GecisTarihi >= '2026-05-26'
    WHERE h.UlasimTipi = 'Otobüs'
    GROUP BY h.HatID, h.HatKodu, h.HatAdi
),
OtobusOrtalamaGecis AS (
    SELECT 
        AVG(Son3AyGecisSayisi) AS OrtalamaOtobusGecisi
    FROM OtobusHatGecisleri
)
SELECT 
    ohg.HatID,
    ohg.HatKodu,
    ohg.HatAdi,
    ohg.Son3AyGecisSayisi,
    ROUND(oog.OrtalamaOtobusGecisi, 2) AS GenelOtobusOrtalamasi
FROM OtobusHatGecisleri ohg
CROSS JOIN OtobusOrtalamaGecis oog
WHERE ohg.Son3AyGecisSayisi < oog.OrtalamaOtobusGecisi
  AND ohg.HatID IN (
      SELECT DISTINCT g2.HatID 
      FROM Gecisler g2
      WHERE g2.DurakID IN (SELECT DurakID FROM MetroDuraklari)
  );

-- -----------------------------------------------------------------------------
-- SORGU 3: Yoğun Saat ve Yolcu Modu Analizi
-- Her hat için en yoğun 2 saatlik zaman dilimini belirler ve bu saat aralığında
-- hatta binen öğrenci yolcu oranını hesaplar.
-- -----------------------------------------------------------------------------
WITH SaatlikGecisler AS (
    SELECT 
        g.HatID,
        CASE 
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 7 AND 8 THEN '07:00-09:00'
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 17 AND 18 THEN '17:00-19:00'
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 12 AND 13 THEN '12:00-14:00'
            ELSE 'Diğer Saatler'
        END AS ZamanDilimi,
        COUNT(g.GecisID) AS ToplamGecis,
        COUNT(CASE WHEN k.KartTipi = 'Öğrenci' THEN 1 END) AS OgrenciGecisSayisi
    FROM Gecisler g
    JOIN Kartlar k ON g.KartID = k.KartID
    GROUP BY 
        g.HatID,
        CASE 
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 7 AND 8 THEN '07:00-09:00'
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 17 AND 18 THEN '17:00-19:00'
            WHEN EXTRACT(HOUR FROM g.GecisTarihi) BETWEEN 12 AND 13 THEN '12:00-14:00'
            ELSE 'Diğer Saatler'
        END
),
SiraliZamanDilimleri AS (
    SELECT 
        sg.HatID,
        h.HatKodu,
        h.HatAdi,
        sg.ZamanDilimi,
        sg.ToplamGecis,
        sg.OgrenciGecisSayisi,
        ROW_NUMBER() OVER (PARTITION BY sg.HatID ORDER BY sg.ToplamGecis DESC) AS YogunlukSirasi
    FROM SaatlikGecisler sg
    JOIN Hatlar h ON sg.HatID = h.HatID
)
SELECT 
    HatKodu,
    HatAdi,
    ZamanDilimi AS EnYogunZamanAraligi,
    ToplamGecis AS YogunSaatToplamGecis,
    OgrenciGecisSayisi,
    CONCAT(ROUND((OgrenciGecisSayisi * 100.0 / NULLIF(ToplamGecis, 0)), 2), '%') AS OgrenciOrani
FROM SiraliZamanDilimleri
WHERE YogunlukSirasi = 1;