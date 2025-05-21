
CREATE DATABASE Bokhandel;
GO

CREATE TABLE [Författare] (
    [FörfattarID] INT PRIMARY KEY,
    [Förnamn] NVARCHAR(50),
    [Efternamn] NVARCHAR(50),
    [Födelsedatum] DATE
);
GO

CREATE TABLE [Böcker] (
    [ISBN13] CHAR(13) PRIMARY KEY CHECK (ISBN13 LIKE '[0-9]%'),
    [Titel] NVARCHAR(200) NOT NULL,
    [Språk] NVARCHAR(50),
    [Pris] DECIMAL(10,2) NOT NULL CHECK ([Pris] >= 0),
    [Utgivningsdatum] DATE,
    [FörfattarID] INT NOT NULL,
    [Sidantal] INT,               
    [Förlag] NVARCHAR(100),        
    [Genre] NVARCHAR(100),         
    FOREIGN KEY ([FörfattarID]) REFERENCES [Författare]([FörfattarID])
);
GO

CREATE TABLE [Butiker] (
    [ButikID] INT IDENTITY(1,1) PRIMARY KEY,
    [Butiksnamn] NVARCHAR(100) NOT NULL,
    [Gatuadress] NVARCHAR(100),
    [Postnummer] NVARCHAR(10),
    [Ort] NVARCHAR(50),
    [Land] NVARCHAR(50)
);
GO

CREATE TABLE [LagerSaldo] (
    [ButikID] INT NOT NULL,
    [ISBN13] CHAR(13) NOT NULL,
    [Antal] INT NOT NULL CHECK ([Antal] >= 0),
    PRIMARY KEY ([ButikID], [ISBN13]),
    FOREIGN KEY ([ButikID]) REFERENCES [Butiker]([ButikID]),
    FOREIGN KEY ([ISBN13]) REFERENCES [Böcker]([ISBN13])
);
GO

CREATE TABLE [Kunder] (
    [KundID] INT IDENTITY(1,1) PRIMARY KEY,
    [Förnamn] NVARCHAR(50) NOT NULL,
    [Efternamn] NVARCHAR(50) NOT NULL,
    [Epost] NVARCHAR(100),
    [Telefon] NVARCHAR(20),
    [Adress] NVARCHAR(100),
    [Postnummer] NVARCHAR(10),
    [Ort] NVARCHAR(50)
);
GO
CREATE TABLE [Ordrar] (
    [OrderID] INT IDENTITY(1,1) PRIMARY KEY,
    [KundID] INT NOT NULL,
    [Orderdatum] DATE NOT NULL,
    [ButikID] INT,
    FOREIGN KEY ([KundID]) REFERENCES [Kunder]([KundID]),
    FOREIGN KEY ([ButikID]) REFERENCES [Butiker]([ButikID])
);
GO

CREATE TABLE [Orderrader] (
    [OrderID] INT NOT NULL,
    [ISBN13] CHAR(13) NOT NULL,
    [Antal] INT NOT NULL CHECK ([Antal] > 0),
    [Pris] DECIMAL(10,2) NOT NULL,
    PRIMARY KEY ([OrderID], [ISBN13]),
    FOREIGN KEY ([OrderID]) REFERENCES [Ordrar]([OrderID]),
    FOREIGN KEY ([ISBN13]) REFERENCES [Böcker]([ISBN13])
);
GO
CREATE TABLE [Kategorier] (
    [KategoriID] INT IDENTITY(1,1) PRIMARY KEY,
    [Namn] NVARCHAR(50) NOT NULL
);
GO
CREATE TABLE [Bokkategorier] (
    [ISBN13] CHAR(13) NOT NULL,
    [KategoriID] INT NOT NULL,
    PRIMARY KEY ([ISBN13], [KategoriID]),
    FOREIGN KEY ([ISBN13]) REFERENCES [Böcker]([ISBN13]),
    FOREIGN KEY ([KategoriID]) REFERENCES [Kategorier]([KategoriID])
);
GO

INSERT INTO [Butiker] ([Butiksnamn], [Gatuadress], [Postnummer], [Ort], [Land]) VALUES
('Bokhörnan', 'Storgatan 1', '12345', 'Stockholm', 'Sverige'),
('Läslyckan', 'Kungsgatan 22', '41111', 'Göteborg', 'Sverige'),
('Bokpalatset', 'Centralvägen 5', '22333', 'Lund', 'Sverige');
GO

INSERT INTO [Författare] ([FörfattarID], [Förnamn], [Efternamn], [Födelsedatum]) VALUES
(1, 'Astrid', 'Lindgren', '1907-11-14'),
(2, 'Selma', 'Lagerlöf', '1858-11-20'),
(3, 'Stieg', 'Larsson', '1954-08-15'),
(4, 'Fredrik', 'Backman', '1981-04-02');
GO

INSERT INTO [Böcker] ([ISBN13], [Titel], [Språk], [Pris], [Utgivningsdatum], [FörfattarID], [Sidantal], [Förlag], [Genre]) VALUES
('9789129707488', 'Pippi Långstrump', 'Svenska', 129.00, '1945-11-01', 1, 120, 'Rabén & Sjögren', 'Barnbok'),
('9789129676050', 'Mio, min Mio', 'Svenska', 99.00, '1954-09-01', 1, 200, 'Rabén & Sjögren', 'Barnbok'),
('9789174295192', 'Gösta Berlings saga', 'Svenska', 89.00, '1891-01-01', 2, 350, 'Bonnier', 'Roman'),
('9789174290999', 'Jerusalem', 'Svenska', 109.00, '1901-01-01', 2, 500, 'Bonnier', 'Roman'),
('9789113014081', 'Män som hatar kvinnor', 'Svenska', 149.00, '2005-08-01', 3, 600, 'Norstedts', 'Deckare'),
('9789113014098', 'Flickan som lekte med elden', 'Svenska', 149.00, '2006-06-01', 3, 650, 'Norstedts', 'Deckare'),
('9789113014104', 'Luftslottet som sprängdes', 'Svenska', 149.00, '2007-05-01', 3, 700, 'Norstedts', 'Deckare'),
('9789174296168', 'En man som heter Ove', 'Svenska', 129.00, '2012-08-01', 4, 350, 'Forum', 'Roman'),
('9789174296519', 'Britt-Marie var här', 'Svenska', 129.00, '2014-09-01', 4, 400, 'Forum', 'Roman'),
('9789174296410', 'Folk med ångest', 'Svenska', 129.00, '2019-04-01', 4, 420, 'Forum', 'Roman'),
('9781234567890', 'Svenska mysterier', 'Svenska', 199.00, '2020-01-01', 3, 450, 'Norstedts', 'Deckare'),
('9782345678901', 'Sagor för barn', 'Svenska', 149.00, '2018-05-15', 1, 250, 'Rabén & Sjögren', 'Barnbok');
GO

INSERT INTO [LagerSaldo] ([ButikID], [ISBN13], [Antal]) VALUES
(1, '9789129707488', 5),
(1, '9789129676050', 3),
(1, '9789174295192', 4),
(1, '9789113014081', 2),
(2, '9789113014098', 6),
(2, '9789113014104', 2),
(2, '9789174296168', 7),
(3, '9789174296519', 4),
(3, '9789174296410', 5),
(3, '9789174290999', 2),
(1, '9781234567890', 3),
(2, '9782345678901', 4);
GO



INSERT INTO [Kunder] ([Förnamn], [Efternamn], [Epost], [Telefon], [Adress], [Postnummer], [Ort]) VALUES
('Anna', 'Svensson', 'anna@email.se', '0701234567', 'Blomstergatan 3', '12345', 'Stockholm'),
('Erik', 'Andersson', 'erik@email.se', '0707654321', 'Solvägen 7', '41111', 'Göteborg');
GO

INSERT INTO [Ordrar] ([KundID], [Orderdatum], [ButikID]) VALUES
(1, '2024-05-01', 1),
(2, '2024-05-02', 2);
GO

INSERT INTO [Orderrader] ([OrderID], [ISBN13], [Antal], [Pris]) VALUES
(1, '9789129707488', 1, 129.00),
(1, '9789174296168', 1, 129.00),
(2, '9789113014098', 2, 149.00);
GO


CREATE VIEW TitlarPerFörfattare AS
SELECT
    CONCAT(F.[Förnamn], ' ', F.[Efternamn]) AS Namn,
    CONCAT(DATEDIFF(YEAR, F.[Födelsedatum], GETDATE()), ' år') AS Ålder,
    COUNT(DISTINCT B.[ISBN13]) AS Titlar,
    CAST(SUM(ISNULL(B.[Pris] * L.[Antal], 0)) AS INT) AS Lagervärde
FROM
    [Författare] F
LEFT JOIN [Böcker] B ON F.[FörfattarID] = B.[FörfattarID]
LEFT JOIN [LagerSaldo] L ON B.[ISBN13] = L.[ISBN13]
GROUP BY
    F.[Förnamn], F.[Efternamn], F.[Födelsedatum];
GO


GO

CREATE PROCEDURE FlyttaBok
    @ButikID_Fran INT,
    @ButikID_Till INT,
    @ISBN13 CHAR(13),
    @Antal INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kontrollera att det finns tillräckligt många böcker i från-butik
        DECLARE @AntalIFran INT;
        SELECT @AntalIFran = Antal FROM LagerSaldo
        WHERE ButikID = @ButikID_Fran AND ISBN13 = @ISBN13;

        IF @AntalIFran IS NULL OR @AntalIFran < @Antal
        BEGIN
            RAISERROR('Inte tillräckligt många exemplar i butik.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Minska antal i från-butik
        UPDATE LagerSaldo
        SET Antal = Antal - @Antal
        WHERE ButikID = @ButikID_Fran AND ISBN13 = @ISBN13;

        -- Lägg till eller uppdatera antal i till-butik
        IF EXISTS (SELECT 1 FROM LagerSaldo WHERE ButikID = @ButikID_Till AND ISBN13 = @ISBN13)
        BEGIN
            UPDATE LagerSaldo
            SET Antal = Antal + @Antal
            WHERE ButikID = @ButikID_Till AND ISBN13 = @ISBN13;
        END
        ELSE
        BEGIN
            INSERT INTO LagerSaldo (ButikID, ISBN13, Antal)
            VALUES (@ButikID_Till, @ISBN13, @Antal);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE TABLE [RelationFörfattare] (
    [ISBN13] CHAR(13) NOT NULL,
    [FörfattarID] INT NOT NULL,
    [Titel] NVARCHAR(200) NOT NULL,
    [Författare] NVARCHAR(100) NOT NULL,
    PRIMARY KEY ([ISBN13], [FörfattarID]),
    FOREIGN KEY ([ISBN13]) REFERENCES [Böcker]([ISBN13]),
    FOREIGN KEY ([FörfattarID]) REFERENCES [Författare]([FörfattarID])
);
GO


SELECT
    B.[Titel],
    COUNT(BF.[FörfattarID]) AS AntalFörfattare
FROM
    [Böcker] B
JOIN [RelationFörfattare] BF ON B.[ISBN13] = BF.[ISBN13]
GROUP BY
    B.[Titel]
HAVING COUNT(BF.[FörfattarID]) > 1;
GO

-- Lägg till detta direkt efter att du har skapat RelationFörfattare-tabellen
INSERT INTO [RelationFörfattare] ([ISBN13], [FörfattarID], [Titel], [Författare]) VALUES
('9789129676050', 1, 'Mio, min Mio', 'Astrid Lindgren'),  -- Mio, min Mio av Astrid Lindgren
('9789129676050', 2, 'Mio, min Mio', 'Selma Lagerlöf'),  -- Mio, min Mio av Selma Lagerlöf (samarbete)
('9781234567890', 3, 'Svenska mysterier', 'Stieg Larsson'),  -- Svenska mysterier av Stieg Larsson
('9781234567890', 4, 'Svenska mysterier', 'Fredrik Backman'),  -- Svenska mysterier av Fredrik Backman (samarbete)
('9782345678901', 1, 'Sagor för barn', 'Astrid Lindgren'),  -- Sagor för barn av Astrid Lindgren
('9782345678901', 4, 'Sagor för barn', 'Fredrik Backman');  -- Sagor för barn av Fredrik Backman (samarbete)
GO


CREATE VIEW KundSammanstallning AS
SELECT
    K.[KundID],
    CONCAT(K.[Förnamn], ' ', K.[Efternamn]) AS [Namn],
    COUNT(DISTINCT O.[OrderID]) AS [Antal ordrar],
    SUM(ORR.[Antal]) AS [Antal böcker],
    SUM(ORR.[Pris] * ORR.[Antal]) AS [Totalt köpbelopp]
FROM
    [Kunder] K
LEFT JOIN [Ordrar] O ON K.[KundID] = O.[KundID]
LEFT JOIN [Orderrader] ORR ON O.[OrderID] = ORR.[OrderID]
GROUP BY
    K.[KundID], K.[Förnamn], K.[Efternamn];
GO


-- Vy som visar försäljningsstatistik per butik för bokhandelns analys
-- Användbar för att:
-- 1. Identifiera vilka butiker som har högst försäljning
-- 2. Analysera vilka böcker som säljs bäst i olika butiker
-- 3. Planera lagerförsörjning baserat på butiksprestanda
-- 4. Identifiera möjliga problem i butiker med låg försäljning
GO
CREATE VIEW ButikFörsäljning AS
SELECT
    B.Butiksnamn,
    B.Ort,
    COUNT(DISTINCT O.OrderID) AS [Antal Orderrader],
    COUNT(DISTINCT O.KundID) AS [Unika Kunder],
    SUM(ORR.Antal) AS [Totalt Antal Böcker],
    SUM(ORR.Antal * ORR.Pris) AS [Totalt Omsättning],
    AVG(ORR.Antal * ORR.Pris) AS [Genomsnittlig Ordervärde],
    MAX(ORR.Antal * ORR.Pris) AS [Högsta Enskilda Ordervärde]
FROM
    Butiker B
INNER JOIN Ordrar O ON B.ButikID = O.ButikID
INNER JOIN Orderrader ORR ON O.OrderID = ORR.OrderID
GROUP BY
    B.Butiksnamn,
    B.Ort;
GO

/*
-- Skapa en fullständig backup av Bokhandel-databasen
BACKUP DATABASE Bokhandel
TO DISK = N'C:\Programering\It högskolan\Databaser\Everyloop\Lab 2 Bak\MartinGustafsson.bak'
WITH FORMAT,
    NAME = 'Bokhandel-Fullständig Databas Backup',
    DESCRIPTION = 'Fullständig backup av Bokhandel-databasen';
*/