# 🚌 Şehir İçi Ulaşım ve Akıllı Kart Yönetim Sistemi (SQL)

Bir şehrin toplu taşıma ağındaki akıllı kart basım hareketlerini, kart tiplerini, hatları ve bakiye yüklemelerini yöneten ilişkisel veritabanı altyapısı ve analitik sorguları.

> 🎓 **Akademik Not:** Bu çalışma, Yönetim Bilişim Sistemleri lisans eğitimi kapsamında İleri SQL, İlişkisel Veritabanı Tasarımı (DDL), Veri Manipülasyonu (DML) ve Karmaşık Analitik Sorgulama (DQL/CTE/Window Functions) pratiklerini pekiştirmek amacıyla ders projesi olarak hazırlanmıştır.

---

## 🗄️ Veritabanı Mimarisi (DDL)

- **Kartlar:** KartID, KartNumarasi, KartTipi (`Öğrenci`, `Tam`, `Anonim`, `Yaşlı`), Bakiye, OlusturmaTarihi
- **Hatlar:** HatID, HatKodu, HatAdi, UlasimTipi (`Otobüs`, `Metro`, `Tramvay`)
- **Duraklar:** DurakID, DurakAdi, Ilce
- **Gecisler:** GecisID, KartID, HatID, DurakID, GecisTarihi, CekilenUcret
- **Yuklemeler:** YuklemeID, KartID, YuklemeTarihi, Miktar, OdemeYontemi

---

## 📊 Geliştirilen Karmaşık Analitik Sorgular (DQL)

1. **Anormal Harcama Yapan Kartlar Analizi:**
   - Kendi kart tipinin aylık harcama ortalamasının %50 üzerinde harcama yapan fakat son 1 ayda hiç bakiye yüklememiş kartları ve son kullandıkları durağı tespit eder (`CTE`, `AVG`, `ROW_NUMBER`, `NOT EXISTS`).
2. **Atıl Kalmış Hat ve Durak Analizi:**
   - Metro hatlarının en yoğun geçtiği duraklardan geçen fakat son 3 aydaki toplam yolcu sayısı genel ortalamanın altında kalan otobüs hatlarını listeler (`Subquery`, `Aggregate Functions`).
3. **Yoğun Saat ve Öğrenci Yolcu Modu Analizi:**
   - Her hat için günün en yoğun 2 saatlik zaman dilimini belirler ve bu zaman aralığındaki öğrenci yolcu oranını hesaplar (`CASE WHEN`, `EXTRACT`, `ROW_NUMBER() OVER(PARTITION BY)`).

---

## 👩‍💻 Geliştirici

- **Geliştirici:** [Sudenur Peker](https://github.com/sunupe054-coder)
