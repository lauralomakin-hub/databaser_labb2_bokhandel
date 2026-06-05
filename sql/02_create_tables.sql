--Vilken dataabs jag vill arneta i

USE bokhandel;

GO

DROP TABLE IF EXISTS Betalningar;
DROP TABLE IF EXISTS Orderrader;
DROP TABLE IF EXISTS LagerSaldo;
DROP TABLE IF EXISTS BokFörfattare;
DROP TABLE IF EXISTS Ordrar;
DROP TABLE IF EXISTS Böcker;
DROP TABLE IF EXISTS Kunder;
DROP TABLE IF EXISTS Butiker;
DROP TABLE IF EXISTS Författare;
DROP TABLE IF EXISTS Förlag;
DROP TABLE IF EXISTS Genre;
GO


--  entitet: skapa första tabellen, FÖRfattare:

CREATE TABLE Författare (
    FörfattarID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn NVARCHAR(50) NOT NULL,
    Efternamn NVARCHAR(50) NOT NULL,
    Födelsedatum DATE NOT NULL
);

-- IDENTITY(1, 1) betyder att FörfattaraID kommer att auto-inkrementeras med start från 1.
-- PRIMARY KEY betyder att FörfattaraID är en unik identifierare för varje rad i tabellen.
-- Nvarchar används för att lagra text, och 50 är max antal tecken. NOT NULL betyder att fältet måste ha ett värde.
-- Födelsedatum lagras som DATE, vilket är ett datumformat.

-- kontrollwera att tabellen skapats:
SELECT name
FROM sys.tables;

-- skapa andra tabell - förlag:

CREATE TABLE Förlag (
    FörlagID INT IDENTITY(1,1) PRIMARY KEY,
    Förlagsnamn Nvarchar(100) NOT NULL UNIQUE,
    Land Nvarchar(50) NOT NULL

);

GO

-- skapa fjärde tabellen Genre (utgår ifrån openlibraries ämnesord):

CREATE TABLE Genre (
    GenreID INT IDENTITY(1,1) PRIMARY KEY,
    Genrenamn Nvarchar(100) NOT NULL UNIQUE
);

GO

-- entitet: skapa fjärde tabellen, Böcker:


CREATE TABLE Böcker (
    ISBN13 CHAR(13) PRIMARY KEY,
    Titel Nvarchar(200) NOT NULL,
    Språk Nvarchar(50) NOT NULL,
    Pris DECIMAL(10, 2) NOT NULL,
    Utgivningsdatum DATE NOT NULL,
    FörlagID INT NOT NULL,
    GenreID INT NOT NULL,

    CONSTRAINT CK_Böcker_ISBN13 CHECK (
        ISBN13 LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),
    CONSTRAINT CK_Böcker_Pris CHECK (Pris >= 0),

    CONSTRAINT FK_Böcker_Förlag FOREIGN KEY (FörlagID)
        REFERENCES Förlag(FörlagID),
    
    CONSTRAINT FK_Böcker_Genre FOREIGN KEY (GenreID)
        REFERENCES Genre(GenreID)
    
);

GO

-- ISBN13 är en unik identifierare för varje bok, och det är en CHAR(13) eftersom det alltid är 13 tecken.
-- Char(13) betyder att det är en fast längd på 13 tecken. Nvarchar(200) används för att lagra titeln, och 200 är max antal tecken.
-- Pris DECIMAL(10,2) betyder totalt upp till 10 siffror, varav 2 efter decimalen.
-- Här sparas vilken författare boken hör till.
-- CONSTRAINT används för att lägga till regler på data. 
-- CK_Böcker_ISBN13 säkerställer att ISBN13 består av exakt 13 siffror.
-- CK_Böcker_Pris säkerställer att priset inte är negativt.
-- CK_Böcker_Författare Refereces Författare(FörfattarID) säkerställer att FörfattarID i Böcker-tabellen måste finnas i Författare-tabellen. skapar en relation mellan de två tabellerna.


-- kontrollwera att tabellen skapats:
SELECT name
FROM sys.tables;

-- skapa femte tabellen - BokFörfattare (en kopplingstabell mellan böcker och författare):
CREATE TABLE BokFörfattare (
    ISBN13 CHAR(13) NOT NULL,
    FörfattarID INT NOT NULL,

    CONSTRAINT PK_BokFörfattare PRIMARY KEY (ISBN13, FörfattarID),

    CONSTRAINT FK_BokFörfattare_Böcker FOREIGN KEY (ISBN13)
        REFERENCES Böcker(ISBN13),
    
    CONSTRAINT FK_BokFörfattare_Författare FOREIGN KEY (FörfattarID)
        REFERENCES Författare(FörfattarID)

);
GO

-- entitet: skapa sjätte tabellen, Butiker:

CREATE TABLE Butiker (
    ButikID INT IDENTITY(1,1) PRIMARY KEY,
    Butiknamn Nvarchar(100) NOT NULL,
    Gatuadress Nvarchar(150) NOT NULL,
    Postnummer Nvarchar(5) NOT NULL,
    Ort Nvarchar(100) NOT NULL,

    CONSTRAINT CK_Butiker_Postnummer CHECK (Postnummer LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

-- constraint CK_Butiker_Postnummer säkerställer att postnumret består av exakt 5 siffror.

-- testar att tabellen skapats:
SELECT name
FROM sys.tables;

-- Kopplingstabell: Skapa sjunde tabellen, LagerSaldo:

CREATE TABLE LagerSaldo (
    ButikID INT NOT NULL,
    ISBN13 CHAR(13) NOT NULL,
    Antal INT NOT NULL,
    
    CONSTRAINT PK_LagerSaldo PRIMARY KEY (ButikID, ISBN13),

    CONSTRAINT FK_LagerSaldo_Butiker FOREIGN KEY (ButikID)
        REFERENCES Butiker(ButikID),
    
    CONSTRAINT FK_LagerSaldo_Böcker FOREIGN KEY (ISBN13)
        REFERENCES Böcker(ISBN13),
    
    CONSTRAINT CK_LagerSaldo_Antal CHECK (Antal >= 0)

);

GO

-- BUtikID och ISBN13 tillsammans utgör en sammansatt primärnyckel, 
-- vilket innebär att varje kombination av ButikID och ISBN13 måste vara unik i LagerSaldo-tabellen
-- FK_LagerSaldo_Butiker säkerställer att ButikID i LagerSaldo-tabellen måste finnas i Butiker-tabellen.
-- FK_LagerSaldo_Böcker säkerställer att ISBN13 i LagerSaldo-tabellen måste finnas i Böcker-tabellen.
-- CK_LagerSaldo_Antal säkerställer att antalet inte är negativt.

-- kontrollwera att tabellen skapats:
SELECT name
FROM sys.tables;

-- entitet: Skapa en åttonde tabell - Kunder:

CREATE TABLE Kunder (
    KundID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn Nvarchar(50) NOT NULL,
    Efternamn Nvarchar(50) NOT NULL,
    Epost Nvarchar(100) NOT NULL UNIQUE
);

GO

-- testar att tabellen skapats:
SELECT name
FROM sys.tables;

--  entitet: Skapa en nionde tabell - Ordrar ( info om butik, kund, orderid och datum):

CREATE TABLE Ordrar(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    KundID INT NOT NULL,
    ButikID INT NOT NULL,
    Orderdatum DATE NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Ordrar_Kunder FOREIGN KEY (KundID)
        REFERENCES Kunder(KundID),
    
    CONSTRAINT FK_Ordrar_Butiker FOREIGN KEY (ButikID)
        REFERENCES Butiker(ButikID)
);

GO
--Identity(1,1) betyder att OrderID kommer att auto-inkrementeras med start från 1 och öka med 1.
-- FK_Ordrar_Kunder säkerställer att KundID i Ordrar-tabellen måste finnas i Kunder-tabellen.
-- FK_Ordrar_Butiker säkerställer att ButikID i Ordrar-tabellen måste finnas i Butiker-tabellen.


--testar att tabellen skapats:
SELECT name
FROM sys.tables;

-- Kopplingstabell: Lägg till tionde tabell - orderrader(info om vilka böcker som beställts, antal och pris vid beställning):
CREATE TABLE Orderrader (
    OrderID INT NOT NULL,
    ISBN13 CHAR(13) NOT NULL,
    Antal INT NOT NULL,
    PrisVidBeställning DECIMAL(10, 2) NOT NULL,

    CONSTRAINT PK_Orderrader PRIMARY KEY (OrderID, ISBN13),

    CONSTRAINT FK_Orderrader_Ordrar FOREIGN KEY (OrderID)
        REFERENCES Ordrar(OrderID),
    
    CONSTRAINT FK_Orderrader_Böcker FOREIGN KEY (ISBN13)
        REFERENCES Böcker(ISBN13),
    
    CONSTRAINT CK_Orderrader_Antal CHECK (Antal > 0),
    CONSTRAINT CK_Orderrader_PrisVidBeställning CHECK (PrisVidBeställning >= 0)

);

GO

--testar att tabellen skapats:
SELECT name
FROM sys.tables;

-- kopplingstabell:Skapa elfte tabell - Betalningar (info om betalning, belopp och datum):

CREATE TABLE Betalningar (
    BetalningID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    Belopp DECIMAL(10, 2) NOT NULL,
    Betalningsdatum DATE NOT NULL DEFAULT GETDATE(),
    Betalsätt Nvarchar(50) NOT NULL,

    CONSTRAINT FK_Betalningar_Ordrar FOREIGN KEY (OrderID)
        REFERENCES Ordrar(OrderID),
    
    CONSTRAINT CK_Betalningar_Belopp CHECK (Belopp >= 0),
    CONSTRAINT CK_Betalningar_Betalsätt CHECK (Betalsätt IN ('Kort', 'Swish', 'Faktura','Kontant'))
);
GO

-- betalning kan vara = 0 ifall retur sker, kompensation, reklamation eller liknande.

-- Kontrollera att relationer finns:

SELECT
    fk.name AS ForeignKey,
    OBJECT_NAME(fk.parent_object_id) AS Tabell,
    OBJECT_NAME(fk.referenced_object_id) AS RefererarTill
FROM sys.foreign_keys fk;

-- OBJECT_NAME används för att hämta namnet på tabellen baserat på dess ID. 
-- parent_object_id är ID för tabellen som innehåller den främmande nyckeln,
-- referenced_object_id är ID för tabellen som den främmande nyckeln refererar till. 
-- Detta ger en översikt över alla främmande nycklar och deras relationer i databasen.







