# Labb 2: Bokhandelsdatabas

Detta repo innehåller min lösning på Labb 2 i kursen Databaser.

Projektet består av en bokhandelsdatabas i SQL Server samt ett Pythonprogram som ansluter till databasen med SQLAlchemy. Pythonprogrammet låter användaren fritextsöka efter boktitlar och visar matchande böcker tillsammans med lagersaldo per butik.

## Innehåll

Databasen innehåller bland annat tabeller för:

- Böcker
- Författare
- BokFörfattare
- Förlag
- Butiker
- LagerSaldo
- Kunder
- Ordrar
- Orderrader
- Betalningar

Databasen innehåller även vyer och en stored procedure.

## Körordning för SQL-filer

Filerna kan köras i denna ordning:

1. `sql/00_reset_database.sql`, valfri fil om databasen behöver tas bort och skapas om
2. `sql/01_create_database.sql`
3. `sql/02_create_tables.sql`
4. `sql/02b_insert_manual_data.sql`
5. `sql/02c_generated_inserts.sql`
6. `sql/03_views.sql`
7. `sql/04_stored_procedure.sql`
8. `sql/05_test_queries.sql`, används för kontrollfrågor
9. `sql/06_python_user.sql`, visar hur en begränsad databasanvändare kan skapas för Pythonprogrammet

## Testdata

Bokdata har hämtats med hjälp av `generate_book_data.py`.

Scriptet hämtar data från Open Library och sparar resultatet lokalt i `books_cache.json`, så att API:et inte behöver anropas varje gång scriptet testas.

De färdiga INSERT-satserna finns i:

```text
sql/02c_generated_inserts.sql
```

Den filen innehåller statiska INSERT-satser och kräver inget API-anrop när databasen byggs upp.

## Pythonprogram

Pythonprogrammet finns i:

```text
search_books.py
```

Kör programmet med:

```bash
uv run python search_books.py
```

Programmet söker på boktitlar och visar:

- Titel
- ISBN13
- Pris
- Butik
- Antal exemplar i aktuell butik

Sökningen använder en parameteriserad query med `:search_pattern`, vilket skyddar mot SQL-injection.

## Begränsade rättigheter

Filen `sql/06_python_user.sql` visar hur en separat databasanvändare kan skapas med endast SELECT-rättigheter på de tabeller som Pythonprogrammet behöver:

- Böcker
- LagerSaldo
- Butiker

I GitHub-versionen används ett placeholder-lösenord. Det behöver bytas om filen ska köras lokalt.

## Vyer

Databasen innehåller vyn `TitlarPerFörfattare`, som visar författarens namn, ålder, antal titlar och totalt lagervärde för författarens böcker.

Databasen innehåller även den extra vyn `ButiksLagervärde`. Den sammanställer lagervärdet per butik.

Syftet med `ButiksLagervärde` är att bokhandeln snabbt ska kunna jämföra värdet av lagret mellan olika butiker. Det kan användas vid inventering, lagerplanering och beslut om böcker behöver flyttas mellan butiker.

## Stored procedure

Filen `sql/04_stored_procedure.sql` innehåller stored proceduren `FlyttaBok`, som kan användas för att flytta exemplar av en bok från en butik till en annan på ett kontrollerat sätt.

## Backup

Databasbackupen lämnas in separat på itslearning och ligger inte i detta GitHub-repo.