-- Stored procedure för att flytta böcker mellan butiker.
-- Den använder kontroller och transaktion för att skydda dataintegriteten.

USE bokhandel;
GO

DROP PROCEDURE IF EXISTS FlyttaBok;
GO

CREATE PROCEDURE FlyttaBok
    @FranButikID INT,
    @TillButikID INT,
    @ISBN13 CHAR(13),
    @Antal INT = 1
AS
BEGIN
    SET NOCOUNT ON;

    IF @Antal <= 0
    BEGIN
        THROW 50001, 'Antal måste vara större än 0.', 1;
    END;

    IF @FranButikID = @TillButikID
    BEGIN
        THROW 50002, 'Från-butik och till-butik kan inte vara samma butik.', 1;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM LagerSaldo
        WHERE ButikID = @FranButikID
          AND ISBN13 = @ISBN13
    )
    BEGIN
        THROW 50003, 'Boken finns inte i från-butiken.', 1;
    END;

    IF (
        SELECT Antal
        FROM LagerSaldo
        WHERE ButikID = @FranButikID
          AND ISBN13 = @ISBN13
    ) < @Antal
    BEGIN
        THROW 50004, 'Det finns inte tillräckligt många exemplar att flytta.', 1;
    END;

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE LagerSaldo
        SET Antal = Antal - @Antal
        WHERE ButikID = @FranButikID
          AND ISBN13 = @ISBN13;

        IF EXISTS (
            SELECT 1
            FROM LagerSaldo
            WHERE ButikID = @TillButikID
              AND ISBN13 = @ISBN13
        )
        BEGIN
            UPDATE LagerSaldo
            SET Antal = Antal + @Antal
            WHERE ButikID = @TillButikID
              AND ISBN13 = @ISBN13;
        END
        ELSE
        BEGIN
            INSERT INTO LagerSaldo (ButikID, ISBN13, Antal)
            VALUES (@TillButikID, @ISBN13, @Antal);
        END;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- testa proceduren

EXEC FlyttaBok
    @FranButikID = 1,
    @TillButikID = 2,
    @ISBN13 = '9780425052167',
    @Antal = 1;
    GO

SELECT *
FROM LagerSaldo
WHERE ISBN13 = '9780425052167'
ORDER BY ButikID;

GO