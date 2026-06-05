# Programmet är tänkt att köras med en databasanvändare
# som endast har SELECT-rättigheter på Böcker, LagerSaldo och Butiker.
# I denna lokala version används Windows Authentication.

from sqlalchemy import create_engine, text
# Skapa en anslutning till SQL Server med hjälp av SQLAlchemy

connection_string = (
    "mssql+pyodbc://localhost/bokhandel"
    "?driver=ODBC+Driver+17+for+SQL+Server"
    "&trusted_connection=yes"
)

# Skapa en SQLAlchemy-engine och anslutning
engine = create_engine(connection_string)

# Fråga användaren efter en sökterm
search_text = input("Sök efter boktitel: ")


query_text = text("""
SELECT 
    B.Titel,
    B.ISBN13,
    B.Pris,
    Bu.Butiknamn,
    LS.Antal
FROM Böcker AS B
JOIN LagerSaldo AS LS ON B.ISBN13 = LS.ISBN13
JOIN Butiker AS Bu ON LS.ButikID = Bu.ButikID
WHERE B.Titel LIKE :search_pattern
ORDER BY B.Titel, Bu.Butiknamn;
""")

with engine.connect() as connection:
    result= connection.execute(
        query_text,
        {"search_pattern": f"%{search_text}%"}
    )

    rows = result.fetchall()

    if not rows:
        print("Inga böcker hittades.")
    else:
        for row in rows:
            print()
            print("Titel: ", row.Titel)
            print("ISBN13: ", row.ISBN13)
            print("Pris: ", row.Pris)
            print("Butik: ", row.Butiknamn)
            print("Antal:", row.Antal)




