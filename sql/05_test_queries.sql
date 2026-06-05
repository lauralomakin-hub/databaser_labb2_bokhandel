SELECT COUNT(*) AS AntalButiker
FROM Butiker;

SELECT COUNT(*) AS AntalLagerRader
FROM LagerSaldo;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Böcker';


SELECT COUNT(*) AS AntalButiker FROM Butiker;
SELECT COUNT(*) AS AntalKunder FROM Kunder;
SELECT COUNT(*) AS AntalFörfattare FROM Författare;
SELECT COUNT(*) AS AntalFörlag FROM Förlag;
SELECT COUNT(*) AS AntalBöcker FROM Böcker;
SELECT COUNT(*) AS AntalBokFörfattare FROM BokFörfattare;
SELECT COUNT(*) AS AntalLagerRader FROM LagerSaldo;

USE bokhandel;
SELECT name
FROM sys.tables
ORDER BY name;

USE bokhandel;
SELECT COUNT(*) AS AntalFörfattare
SELECT COUNT(*) AS AntalFörlag FROM Förlag;
SELECT COUNT(*) AS AntalGenre FROM Genre;
SELECT COUNT(*) AS AntalBöcker FROM Böcker;
SELECT COUNT(*) AS AntalBokförfattare FROM BokFörfattare;
SELECT COUNT(*) AS AntalLagerSaldo FROM LagerSaldo;
SELECT COUNT(*) AS AntalButiker FROM Butiker;
SELECT COUNT(*) AS AntalKunder FROM Kunder;

USE bokhandel;
GO

SELECT name
FROM sys.tables
ORDER BY name;

USE bokhandel;
GO

SELECT COUNT(*) AS AntalFörfattare FROM Författare;
SELECT COUNT(*) AS AntalFörlag FROM Förlag;
SELECT COUNT(*) AS AntalGenre FROM Genre;
SELECT COUNT(*) AS AntalBöcker FROM Böcker;
SELECT COUNT(*) AS AntalBokFörfattare FROM BokFörfattare;
SELECT COUNT(*) AS AntalLagerSaldo FROM LagerSaldo;
SELECT COUNT(*) AS AntalButiker FROM Butiker;
SELECT COUNT(*) AS AntalKunder FROM Kunder;
SELECT COUNT(*) AS AntalOrdrar FROM Ordrar;
SELECT COUNT(*) AS AntalOrderrader FROM Orderrader;
SELECT COUNT(*) AS AntalBetalningar FROM Betalningar;
GO

USE bokhandel;
GO

SELECT name
FROM sys.tables
ORDER BY name;

USE bokhandel;
GO

SELECT COUNT(*) AS AntalFörfattare FROM Författare;
SELECT COUNT(*) AS AntalFörlag FROM Förlag;
SELECT COUNT(*) AS AntalGenre FROM Genre;
SELECT COUNT(*) AS AntalBöcker FROM Böcker;
SELECT COUNT(*) AS AntalBokFörfattare FROM BokFörfattare;
SELECT COUNT(*) AS AntalLagerSaldo FROM LagerSaldo;
SELECT COUNT(*) AS AntalButiker FROM Butiker;
SELECT COUNT(*) AS AntalKunder FROM Kunder;
SELECT COUNT(*) AS AntalOrdrar FROM Ordrar;
SELECT COUNT(*) AS AntalOrderrader FROM Orderrader;
SELECT COUNT(*) AS AntalBetalningar FROM Betalningar;
GO

USE bokhandel;
GO

SELECT name
FROM sys.tables
WHERE name = 'Genre';

USE bokhandel;
GO

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Böcker';

USE bokhandel;
GO

SELECT COUNT(*) AS AntalButiker FROM Butiker;
SELECT COUNT(*) AS AntalFörfattare FROM Författare;
SELECT COUNT(*) AS AntalBöcker FROM Böcker;
SELECT COUNT(*) AS AntalLagerRader FROM LagerSaldo;
SELECT COUNT(*) AS AntalKunder FROM Kunder;

SELECT *
FROM TitlarPerFörfattare;

SELECT
    B.Titel,
    Bu.Butiknamn,
    LS.Antal
FROM Böcker B
JOIN LagerSaldo LS ON B.ISBN13 = LS.ISBN13
JOIN Butiker Bu ON LS.ButikID = Bu.ButikID
ORDER BY B.Titel, Bu.Butiknamn;

SELECT *
FROM LagervärdePerButik;
GO