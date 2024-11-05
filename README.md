# BMÜ329 Veri Tabanı Sistemleri Dersi Dönem Projesi Gereksinimleri ve E-R Diyagramı Formatı




## Proje Adı: Eczane İlaç Yönetim Sistemi
Bu proje, eczanelerde ilaç stoklarını, müşteri kayıtlarını ve rezervasyon işlemlerini verimli bir şekilde yönetmek için tasarlanmış bir veritabanı projesidir. Hem eczacıların hem de müşterilerin ihtiyaçlarına yönelik olarak geliştirilmiştir.
**Proje Ekibindeki Kişiler:**
- Emirhan BAL(225260028)
- Mustafa TATLI(225260046)
- Ahmet Eren ARĞUN(225260072)


---

## 1. Dönem Projesi Gereksinimleri

### Müşteri Gereksinimleri
| **Gereksinim**                | **Açıklama**                                                      |
|-------------------------------|-------------------------------------------------------------------|
| İlaç Bilgilerini Görüntüleme  | Müşteri, geçmişte aldığı ilaçların bilgilerini görüntüleyebilir.  |
| Stok Kontrolü                 | Müşteri, almak istediği ilacın stok durumunu kontrol edebilir.   |
| Rezervasyon Yapma             | Müşteri, istediği ilacı rezerve ederek stoktan ayırtabilir.      |
| Fiyat Bilgisi Görüntüleme     | Müşteri, ilaçların fiyatlarını görüntüleyebilir.                 |

### Eczacı Gereksinimleri
| **Gereksinim**                | **Açıklama**                                                      |
|-------------------------------|-------------------------------------------------------------------|
| Stok Yönetimi                 | Eczacı, ilaçların stok miktarlarını ve son kullanma tarihlerini yönetebilir. |
| Fiyat Yönetimi                | Eczacı, ilaçların fiyat bilgilerini güncelleyebilir.             |
| Satış ve Alım Geçmişi         | Eczacı, tüm satış ve satın alma işlemlerini görebilir ve rapor alabilir. |
| Tedarikçi Bilgilerini Yönetme | Eczacı, tedarikçi bilgilerini ekleyebilir ve güncelleyebilir.    |

---

## 2. Varlıklar ve İlişkiler

### Varlıklar
| **Varlık**         | **Özellikler**                                                                 | **İlişkiler**                                                   |
|--------------------|-------------------------------------------------------------------------------|-----------------------------------------------------------------|
| **Müşteri**        | Müşteri_ID, İsim, Telefon, Adres, Kayıt_Tarihi, Bakiye                        | - Sahip Olur (Rezervasyon): 1:N <br> - Satın Alır (Satış): 1:N |
| **İlaç**           | İlaç_ID, İsim, Stok Miktarı, Son Kullanma Tarihi, Fiyat, Alış Fiyatı          | - Satılır (Satış): 1:N <br> - Rezerve Edilir (Rezervasyon): 1:N <br> - Temin Edilir (Tedarikçi): N:M <br> - Bulunur (Şube): N:M |
| **Tedarikçi**      | Tedarikçi_ID, İsim, İletişim_Bilgileri, Adres, Tedarik_Tarihi                 | - Sağlar (İlaç): N:M                                           |
| **Satış**          | Satış_ID, Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat, Ödeme_Tipi | - Yapılır (Müşteri): N:1 <br> - İçerir (İlaç): N:1             |
| **Rezervasyon**    | Rezervasyon_ID, Müşteri_ID, İlaç_ID, Rezervasyon_Tarihi, Miktar, Onay_Durumu  | - Yapar (Müşteri): N:1 <br> - İçerir (İlaç): N:1               |
| **Eczacı**         | Eczacı_ID, İsim, Çalışma_Saatleri, Telefon, Uzmanlık, Şube_ID                 | - Yönetir (Stok): 1:N <br> - Hazırlar (Rapor): 1:N             |
| **Stok Geçmişi**   | Geçmiş_ID, İlaç_ID, Değişim_Tarihi, Eski_Miktar, Yeni_Miktar, Eczacı_ID       | - Kayıtlı (İlaç): N:1 <br> - Takip Edilir (Eczacı): N:1        |
| **Şube**           | Şube_ID, Şube_Adı, Adres, Telefon, Çalışma_Saatleri                           | - Barındırır (Eczacı): 1:N <br> - Hizmet Verir (Müşteri): 1:N <br> - Barındırır (İlaç): N:M        |

---

### N:M İlişki Tabloları

| **İlişki Tablosu**  | **Özellikler**                                  | **Açıklama**                                                  |
|---------------------|-------------------------------------------------|--------------------------------------------------------------|
| **İlaç_Tedarikçi**  | İlaç_ID, Tedarikçi_ID                           | Bir ilaç birden fazla tedarikçi tarafından sağlanabilir ve bir tedarikçi birçok ilacı temin edebilir. |
| **İlaç_Şube**       | İlaç_ID, Şube_ID                                | Bir ilaç birden fazla şubede bulunabilir ve bir şube birçok ilacı barındırabilir.                  |

---

### İlişki Özeti
| **İlişki**         | **Varlık 1**      | **Varlık 2**       | **Kardinalite**                          |
|--------------------|--------------------|--------------------|------------------------------------------|
| Sahip Olur         | Müşteri            | Rezervasyon        | 1:N                                      |
| Satın Alır         | Müşteri            | Satış              | 1:N                                      |
| Satılır            | İlaç               | Satış              | 1:N                                      |
| Rezerve Edilir     | İlaç               | Rezervasyon        | 1:N                                      |
| Sağlar             | Tedarikçi          | İlaç               | N:M (İlaç_Tedarikçi)                     |
| Yapılır            | Müşteri            | Satış              | N:1                                      |
| Kayıtlı            | Stok Geçmişi       | İlaç               | N:1                                      |
| Takip Edilir       | Stok Geçmişi       | Eczacı             | N:1                                      |
| Barındırır         | Şube               | Eczacı             | 1:N                                      |
| Hizmet Verir       | Şube               | Müşteri            | 1:N                                      |
| Barındırır         | Şube               | İlaç               | N:M (İlaç_Şube)                          |

---

## E-R Diyagramı
![Untitled](https://github.com/user-attachments/assets/a9dfc82d-2566-49b8-89b4-d05860632041)
