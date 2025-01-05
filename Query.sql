CREATE TABLE Müşteri (
    Müşteri_ID INT PRIMARY KEY,
    İsim NVARCHAR(50) NOT NULL,
    Telefon NVARCHAR(15) UNIQUE,
    Adres NVARCHAR(100),
    Kayıt_Tarihi DATE DEFAULT GETDATE(),
    Bakiye DECIMAL(10,2) CHECK (Bakiye >= 0),
    Şube_ID INT FOREIGN KEY REFERENCES Şube(Şube_ID)
);

CREATE TABLE İlaç (
    İlaç_ID INT PRIMARY KEY,
    İsim NVARCHAR(50) NOT NULL,
    Stok_Miktarı INT CHECK (Stok_Miktarı >= 0),
    SKT DATE NOT NULL,
    Fiyat DECIMAL(10,2) CHECK (Fiyat > 0),
    Alış_Fiyatı DECIMAL(10,2) CHECK (Alış_Fiyatı > 0),
    Tedarikçi_ID INT FOREIGN KEY REFERENCES Tedarikçi(Tedarikçi_ID)
);

CREATE TABLE Tedarikçi (
    Tedarikçi_ID INT PRIMARY KEY,
    İsim NVARCHAR(50) NOT NULL,
    İletişim_Bilgileri NVARCHAR(100),
    Adres NVARCHAR(100),
    Tedarik_Tarihi DATE DEFAULT GETDATE()
);

CREATE TABLE İlaç_Tedarikçi (
    Tedarikçi_ID INT FOREIGN KEY REFERENCES Tedarikçi(Tedarikçi_ID),
    İlaç_ID INT FOREIGN KEY REFERENCES İlaç(İlaç_ID),
    Tedarik_Tarihi DATE DEFAULT GETDATE(),
    PRIMARY KEY (Tedarikçi_ID, İlaç_ID)
);

CREATE TABLE Satış (
    Satış_ID INT IDENTITY(1,1) PRIMARY KEY,
    Müşteri_ID INT FOREIGN KEY REFERENCES Müşteri(Müşteri_ID),
    İlaç_ID INT FOREIGN KEY REFERENCES İlaç(İlaç_ID),
    Satış_Tarihi DATE DEFAULT GETDATE(),
    Miktar INT CHECK (Miktar > 0),
    Toplam_Fiyat DECIMAL(10,2) CHECK (Toplam_Fiyat > 0)
);

CREATE TABLE Rezervasyon (
    Rezervasyon_ID INT PRIMARY KEY,
    Müşteri_ID INT FOREIGN KEY REFERENCES Müşteri(Müşteri_ID),
    İlaç_ID INT FOREIGN KEY REFERENCES İlaç(İlaç_ID),
    Rezervasyon_Tarihi DATE DEFAULT GETDATE(),
    Miktar INT CHECK (Miktar > 0),
    Onay_Durumu NVARCHAR(20) DEFAULT 'Beklemede'
);

CREATE TABLE Şube (
    Şube_ID INT PRIMARY KEY,
    Şube_Adı NVARCHAR(50) NOT NULL,
    Adres NVARCHAR(100) NOT NULL,
    Telefon NVARCHAR(15),
    Çalışma_Saatleri NVARCHAR(50)
);

CREATE TABLE Eczacı (
    Eczacı_ID INT PRIMARY KEY,
    Şube_ID INT FOREIGN KEY REFERENCES Şube(Şube_ID),
    İsim NVARCHAR(50) NOT NULL,
    Çalışma_Saatleri NVARCHAR(50),
    Telefon NVARCHAR(15),
    Uzmanlık NVARCHAR(50)
);

CREATE TABLE Stok_Geçmişi (
    Geçmiş_ID INT IDENTITY(1,1) PRIMARY KEY,
    İlaç_ID INT FOREIGN KEY REFERENCES İlaç(İlaç_ID),
    Değişim_Tarihi DATE DEFAULT GETDATE(),
    Eski_Miktar INT,
    Yeni_Miktar INT,
    Açıklama NVARCHAR(100),
    Eczacı_ID INT FOREIGN KEY REFERENCES Eczacı(Eczacı_ID)
);

CREATE TABLE İlaç_Şube (
    İlaç_ID INT FOREIGN KEY REFERENCES İlaç(İlaç_ID),
    Şube_ID INT FOREIGN KEY REFERENCES Şube(Şube_ID),
    Stok_Miktarı INT CHECK (Stok_Miktarı >= 0),
    PRIMARY KEY (İlaç_ID, Şube_ID)
);

-- ÖRNEK VERİLER

-- Şube Verileri
INSERT INTO Şube VALUES (1, 'Merkez Şube', 'Atatürk Caddesi No:12, Ankara', '0312-1234567', '08:00 - 18:00');
INSERT INTO Şube VALUES (2, 'Kadıköy Şube', 'Bağdat Caddesi No:45, İstanbul', '0216-9876543', '09:00 - 19:00');
INSERT INTO Şube VALUES (3, 'İzmir Şube', 'Kordon No:5, İzmir', '0232-6543210', '10:00 - 20:00');

-- Eczacı Verileri
INSERT INTO Eczacı VALUES (1, 1, 'Mehmet Demir', '08:00 - 17:00', '0532-1112233', 'Dermatoloji');
INSERT INTO Eczacı VALUES (2, 2, 'Ayşe Yılmaz', '09:00 - 18:00', '0543-4445566', 'Pediatri');
INSERT INTO Eczacı VALUES (3, 3, 'Ali Kara', '10:00 - 19:00', '0555-7778899', 'Genel Eczacılık');

-- Müşteri Verileri
INSERT INTO Müşteri VALUES (1, 'Ahmet Yılmaz', '555-1234', 'İstanbul', '2024-01-01', 1000.00, 1);
INSERT INTO Müşteri VALUES (2, 'Fatma Demir', '555-5678', 'Ankara', '2024-02-01', 800.00, 2);
INSERT INTO Müşteri VALUES (3, 'Hasan Kaya', '555-9012', 'İzmir', '2024-03-01', 500.00, 3);

-- Tedarikçi Verileri
INSERT INTO Tedarikçi VALUES (101, 'İlaç A.Ş.', '123456789', 'Ankara', '2024-01-01');
INSERT INTO Tedarikçi VALUES (102, 'Sağlık Ltd.', '987654321', 'İstanbul', '2024-02-01');
INSERT INTO Tedarikçi VALUES (103, 'Medikal İlaç Sanayi', '456789123', 'İzmir', '2024-03-01');

-- İlaç Verileri
INSERT INTO İlaç VALUES (1, 'Aspirin', 100, '2025-12-31', 20.00, 10.00, 101);
INSERT INTO İlaç VALUES (2, 'Parol', 200, '2024-12-31', 15.00, 8.00, 102);
INSERT INTO İlaç VALUES (3, 'C vitamini', 150, '2026-06-30', 25.00, 12.00, 103);

-- İlaç_Tedarikçi Verileri
INSERT INTO İlaç_Tedarikçi VALUES (101, 1, '2024-01-01');
INSERT INTO İlaç_Tedarikçi VALUES (102, 2, '2024-02-01');
INSERT INTO İlaç_Tedarikçi VALUES (103, 3, '2024-03-01');

-- Rezervasyon Verileri
INSERT INTO Rezervasyon VALUES (1, 1, 1, '2024-01-06', 2, 'Beklemede');
INSERT INTO Rezervasyon VALUES (2, 2, 2, '2024-02-06', 1, 'Onaylandı');
INSERT INTO Rezervasyon VALUES (3, 3, 3, '2024-03-06', 3, 'Beklemede');

-- Satış Verileri
INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
VALUES (1, 1, '2024-01-05', 2, 40.00);
INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
VALUES (2, 2, '2024-02-05', 1, 15.00);
INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
VALUES (3, 3, '2024-03-05', 3, 75.00);

-- Stok Geçmişi Verileri
INSERT INTO Stok_Geçmişi (İlaç_ID, Değişim_Tarihi, Eski_Miktar, Yeni_Miktar, Açıklama, Eczacı_ID)
VALUES 
(1, '2024-01-05', 100, 98, 'Satış', 1),
(2, '2024-02-05', 200, 199, 'Satış', 2),
(3, '2024-03-05', 150, 147, 'Satış', 3);

-- İlaç_Şube Verileri
INSERT INTO İlaç_Şube VALUES (1, 1, 50);
INSERT INTO İlaç_Şube VALUES (2, 2, 75);
INSERT INTO İlaç_Şube VALUES (3, 3, 30);

CREATE OR ALTER PROCEDURE StokGuncelle
    @İlaç_ID INT,
    @Miktar INT
AS
BEGIN
    -- Stok Güncellemesi
    UPDATE İlaç
    SET Stok_Miktarı = Stok_Miktarı - @Miktar
    WHERE İlaç_ID = @İlaç_ID;

    -- Stok Geçmişine Kayıt (Geçmiş_ID otomatik artacak)
    INSERT INTO Stok_Geçmişi (İlaç_ID, Eski_Miktar, Yeni_Miktar, Açıklama, Eczacı_ID)
    VALUES (
        @İlaç_ID,
        (SELECT Stok_Miktarı + @Miktar FROM İlaç WHERE İlaç_ID = @İlaç_ID),
        (SELECT Stok_Miktarı FROM İlaç WHERE İlaç_ID = @İlaç_ID),
        'Satış',
        NULL
    );
END;

CREATE OR ALTER PROCEDURE StokEkle
    @İlaç_ID INT,
    @EklenecekMiktar INT
AS
BEGIN
    -- Mevcut stok miktarını artır
    UPDATE İlaç
    SET Stok_Miktarı = Stok_Miktarı + @EklenecekMiktar
    WHERE İlaç_ID = @İlaç_ID;

    -- Stok Geçmişine bu işlemi kaydet
    INSERT INTO Stok_Geçmişi (İlaç_ID, Eski_Miktar, Yeni_Miktar, Açıklama, Eczacı_ID)
    VALUES (
        @İlaç_ID,
        (SELECT Stok_Miktarı - @EklenecekMiktar FROM İlaç WHERE İlaç_ID = @İlaç_ID),
        (SELECT Stok_Miktarı FROM İlaç WHERE İlaç_ID = @İlaç_ID),
        'Stok Eklendi',
        NULL
    );
END;

CREATE TRIGGER SatışSonrasıStokGuncelle
ON Satış
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        -- Yeni eklenen satış kaydındaki İlaç_ID ve Miktar değerlerini çek
        DECLARE @İlaç_ID INT, @Miktar INT;

        SELECT 
            @İlaç_ID = İlaç_ID, 
            @Miktar = Miktar 
        FROM inserted;

        -- Stok güncelleme prosedürünü çağır
        EXEC StokGuncelle @İlaç_ID, @Miktar;

    END TRY
    BEGIN CATCH
        -- Hata oluşursa işlem iptal edilmez, sadece mesaj yazdırılır
        PRINT 'Stok güncellemesi sırasında bir hata oluştu: ' + ERROR_MESSAGE();
    END CATCH
END;

BEGIN TRANSACTION; -- Satış işlemi sırasında hata tespit edilecek
BEGIN TRY
    -- Satış kaydı eklenir
    INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
    VALUES (1, 1, GETDATE(), 2, 40.00);

    -- Stok güncelleme prosedürü çağrılır
    EXEC StokGuncelle @İlaç_ID = 1, @Miktar = 2;

    -- İşlem başarılı, commit edilir
    COMMIT;
END TRY
BEGIN CATCH
    -- Hata durumunda işlem geri alınır
    ROLLBACK;
    PRINT 'Transaction başarısız: ' + ERROR_MESSAGE();
END CATCH;

BEGIN TRANSACTION; -- Stok yetersizliği kontrol edilir
BEGIN TRY
    -- Satış kaydı eklenir
    INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
    VALUES (1, 1, GETDATE(), 5000, 200000.00); -- Hata: Stok yetersiz

    -- Stok güncelleme prosedürü çağrılır
    EXEC StokGuncelle @İlaç_ID = 1, @Miktar = 5000;

    -- İşlem başarılı, commit edilir
    COMMIT;
END TRY
BEGIN CATCH
    -- Hata durumunda işlem geri alınır
    ROLLBACK;
    PRINT 'Stok yetersiz, işlem iptal edildi: ' + ERROR_MESSAGE();
END CATCH;

SELECT * FROM Müşteri;  -- Tabloların hepsini inceledik
SELECT * FROM İlaç;
SELECT * FROM İlaç_Tedarikçi;
SELECT * FROM İlaç_Şube;
SELECT * FROM Tedarikçi;
SELECT * FROM Satış;
SELECT * FROM Rezervasyon;
SELECT * FROM Stok_Geçmişi;
SELECT * FROM Eczacı;
SELECT * FROM Şube;

EXEC StokGuncelle @İlaç_ID = 1, @Miktar = 10;  -- Stok azaltma test edildi

EXEC StokEkle @İlaç_ID = 1, @EklenecekMiktar = 10;  -- Stok ekleme test edildi

INSERT INTO Satış (Müşteri_ID, İlaç_ID, Satış_Tarihi, Miktar, Toplam_Fiyat)
VALUES (1, 1, GETDATE(), 5, 100.00); -- Trigger kontrolü
