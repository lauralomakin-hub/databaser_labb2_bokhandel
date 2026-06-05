

Hämta data från Open Library en gång
Spara resultatet
Testa vidare mot den sparade datan
Kör inte API-anropet varje gång du testar scriptet

- scriptet kollar först om lokal fil finns:
books_cache.json

Finns filen används den annars hämtar scriptet från API:et och spara reusltatet.

kör filerna i denna ordning:
1. 01_create_database.sql
2. 02_create_tables.sql
3. 02b_insert_manual_data.sql
4. generated_inserts.sql
5. 03_views.sql
6. 04_stored_procedure.sql


01_create_database.sql
= skapar databasen

02_create_tables.sql
= skapar tabellerna

02b_manual_data.sql
= dina manuella inserts, till exempel Butiker och Kunder

generated_inserts.sql
= Python-genererade inserts för Författare, Förlag, Böcker, BokFörfattare och LagerSaldo

03_views.sql
= TitlarPerFörfattare skapad och testad.
Vyn returnerar Namn, Ålder, Titlar och Lagervärde.
Röd markering i editorn verkar vara IntelliSense, inte körfel.

04_stored_procedure.sql
= FlyttaBok om du gör VG


Pythonprogrammet för fritextsökning på boktitlar:
1. Användaren skriver in en söktext
2. Programmet visar matchande böcker och lagersaldo per butik


Skapa ytterligar en tabell som entitet. väljer ämnen då open libarary inte har genre. väljer att bara ta ett första huvudämne från varje bok för att efterlikna genre.



generated_inserts.sql:
-- Demodata för böcker, författare och förlag.
-- Bokinformationen har genererats med hjälp av ett separat Python-script
-- som hämtade grunddata från Open Library.
-- Denna fil innehåller statiska INSERT-satser och kräver inget API-anrop.