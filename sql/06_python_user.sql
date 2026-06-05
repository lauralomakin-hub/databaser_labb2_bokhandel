-- Skapa en inloggning och användare för att ge läsbehörighet till vissa tabeller i bokhandel-databasen.
-- Denna fil visar hur Pythonprogrammet kan köras med en separat användare
-- som bara har SELECT-rättigheter.
-- Byt placeholder-lösenordet innan filen körs lokalt.

USE master;
GO

IF NOT EXISTS(
    SELECT 1
    FROM sys.databases 
    WHERE name = 'bokhandel_reader_login'
)
BEGIN
    CREATE LOGIN bokhandel_reader_login 
    WITH PASSWORD = 'BYT_TILL_EGET_LÖSENORD';
END
GO

USE bokhandel;
GO

IF NOT EXISTS(
    SELECT 1
    FROM sys.database_principals 
    WHERE name = 'bokhandel_reader_user'
)
BEGIN
    CREATE USER bokhandel_reader_user 
    FOR LOGIN bokhandel_reader_login;
END
GO

-- Ge SELECT-behörighet på Genre, LagerSaldo och Butiker (det som search_books.py behöver) till användaren.
GRANT SELECT ON Genre TO bokhandel_reader_user;
GRANT SELECT ON LagerSaldo TO bokhandel_reader_user;
GRANT SELECT ON Butiker TO bokhandel_reader_user;
GO




