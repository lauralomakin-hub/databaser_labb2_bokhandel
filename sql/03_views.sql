-- Titlar per författare
-- Namn, Ålder, Titlar, Lagervärde

-- Many-to-many-relationen mellan Böcker och Författare går via kopplingstabellen BokFörfattare.
-- Därför joinar vi Författare -> BokFörfattare -> Böcker för att räkna titlar per författare.
USE bokhandel;
GO

DROP VIEW IF EXISTS [TitlarPerFörfattare];
GO

CREATE VIEW [TitlarPerFörfattare] AS
SELECT
    CONCAT(F.[Förnamn], ' ', F.[Efternamn]) AS [Namn],
    DATEDIFF(year, F.[Födelsedatum], GETDATE()) AS [Ålder],
    COUNT(DISTINCT BF.[ISBN13]) AS [Titlar],
    SUM(B.[Pris] * LS.[Antal]) AS [Lagervärde]
FROM [Författare] F
JOIN [BokFörfattare] BF ON F.[FörfattarID] = BF.[FörfattarID]
JOIN [Böcker] B ON BF.[ISBN13] = B.[ISBN13]
JOIN [LagerSaldo] LS ON B.[ISBN13] = LS.[ISBN13]
GROUP BY F.[FörfattarID], F.[Förnamn], F.[Efternamn], F.[Födelsedatum];
GO

SELECT *
FROM [TitlarPerFörfattare]
ORDER BY [Namn];

-- 03_views.sql
-- TitlarPerFörfattare skapad och testad.
-- Vyn returnerar Namn, Ålder, Titlar och Lagervärde.
-- Röd markering i editorn verkar vara IntelliSense, inte körfel?



-- EXTRA-vy VG:

-- Butiker och deras lagervärde
-- Vyn visar det totala värdet av böckerna i lager per butik.
-- Bokhandeln kan använda vyn för att jämföra hur mycket varulager som är bundet i varje butik.
-- Kan användas vid inventering och planering av inköp för jämförelse av butikernas värde bundet i lager.
CREATE VIEW [LagervärdePerButik] AS
SELECT
    Bu.[Butiknamn],
    SUM(B.[Pris] * LS.[Antal]) AS [Lagervärde]
FROM [Butiker] Bu
JOIN [LagerSaldo] LS ON Bu.[ButikID] = LS.[ButikID]
JOIN [Böcker] B ON LS.[ISBN13] = B.[ISBN13]
GROUP BY Bu.[ButikID], Bu.[Butiknamn];
GO

SELECT *
FROM [LagervärdePerButik]
ORDER BY [Butiknamn];
GO
