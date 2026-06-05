Pythonprogrammet search_books.py ansluter till databasen med SQLAlchemy och använder en parameteriserad query för att skydda mot SQL-injection.

Programmet söker på boktitlar och visar titel, ISBN13, pris, butik och antal exemplar per butik.

Filen sql/06_python_user.sql visar hur en separat databasanvändare kan skapas med endast SELECT-rättigheter på de tabeller som programmet behöver: Böcker, LagerSaldo och Butiker. Placeholder-lösenordet behöver bytas om filen ska köras lokalt.