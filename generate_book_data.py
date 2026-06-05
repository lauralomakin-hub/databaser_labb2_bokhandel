#fråga chatGPT - Hut göt jag om jag inte vill skriva in alla böcker manuellt och använda tillgänglig API?

# hjälpscript 


import json
import random
from pathlib import Path

import requests

# cache-fil för att spara hämtade data och undvika onödiga API-anrop
#api-url för att hämta bokdata (exempelvis från Open Library API)
CACHE_FILE = Path("books_cache.json")

#Claude: "Hur hitta ISBN i OpenLibrary API?
# Chatgpt: Varför Q måste innehålla en kategori, kan jag använda som ersättning för genres m.m:
API_URL = "https://openlibrary.org/search.json"

# https://openlibrary.org/subjects
GENRE_MAP = [
    ("Crime", "Mystery and detective stories"),
    ("Historical Fiction", "Historical Fiction"),
    ("Horror", "Horror"),
    ("Science Fiction", "Science Fiction"),
    ("Thriller", "Thriller"),
    ("Young Adult", "Young Adult"),
]

FIELDS = "title,author_name,isbn,first_publish_year,publisher,language"

#early return if cache file exists, otherwise fetch data from API and save to cache
def get_book_data():
    if CACHE_FILE.exists():
        print("-- Läser från lokal cache, inget API-anrop görs")
        with open(CACHE_FILE, "r", encoding="utf-8") as file:
            return json.load(file)

    print("-- Hämtar data från Open Library och spara i cache")

    all_books_from_api = []

    for genre_name, search_query in GENRE_MAP:
        PARAMS = {
            "q": search_query,
            "fields": FIELDS,
            "limit": 20
        }
    
        response = requests.get(API_URL, params=PARAMS,timeout=(60, 90))
        response.raise_for_status()

        data= response.json()

        for item in data["docs"]:
            item["genre_name"] = genre_name
            all_books_from_api.append(item)

    data = {
        "docs": all_books_from_api
    }


    with open(CACHE_FILE, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False, indent=2)


    return data

    #####

# Hämta bokdata (antingen från cache eller API)
data = get_book_data()

print(f"Antal träffar i cache: {len(data['docs'])}")

for index, item in enumerate(data["docs"][:10], start=1):
    print(f"\nTräff {index}")
    print("Genre:", item.get("genre_name"))
    print("Titel:", item.get("title"))
    print("Författare:", item.get("author_name"))
    print("ISBN:", item.get("isbn"))
    print("Förlag:", item.get("publisher"))
    print("År:", item.get("first_publish_year"))
    print("Språk:", item.get("language"))

books = []
authors = {}
publishers = {}
genres = {}
used_isbns = set()    #så att inte samma bok kommer med fler ggr pga av ämnesord
books_per_genre = {}

author_id = 1
publisher_id = 1
genre_id = 1

# Processa data och skapa SQL-insert satser
for item in data["docs"]:
    title = item.get("title")
    author_names = item.get("author_name", [])
    isbn_list = item.get("isbn", [])
    first_publish_year = item.get("first_publish_year")
    publisher_names = item.get("publisher", [])
    publisher_name = publisher_names[0] if publisher_names else "Okänt förlag"
    genre_name = item.get("genre_name")

    isbn13 = None 

    for isbn in isbn_list:
        if len(isbn) == 13 and isbn.isdigit() and isbn.startswith(("978", "979")):
            isbn13 = isbn
            break   

    if books_per_genre.get(genre_name, 0) >= 2:
        continue
    
    if not title or not author_names or not isbn13:
        continue

    if isbn13 in used_isbns:
        continue

    used_isbns.add(isbn13)
    
    author_name = author_names[0]

    if author_name not in authors:
        authors[author_name] = author_id
        author_id += 1

    if publisher_name not in publishers:
        publishers[publisher_name] = publisher_id
        publisher_id += 1


    if genre_name not in genres:
        genres[genre_name] = genre_id
        genre_id += 1


    books.append({
        "isbn13": isbn13,
        "title": title.replace("'", "''"),
        "author_name": author_name.replace("'", "''"),
        "author_id": authors[author_name],
        "publisher_id": publishers[publisher_name],
        "genre_id": genres[genre_name],
        "publish_date": f"{first_publish_year}-01-01" if first_publish_year else "2000-01-01",
        "price": random.choice([129, 149, 179, 199, 229, 249])
        
    })

    books_per_genre[genre_name] = books_per_genre.get(genre_name, 0) + 1

    if len(books) == 10:
        break
        

# Skriv SQL-insert satser till en fil

with open("generated_inserts.sql", "w", encoding= "utf-8") as file:
    file.write("-- Författare\n")
    for author_name, id_value in authors.items():
        parts = author_name.split(" ", 1)

        if len(parts) > 1:
            first_name = parts[0].replace("'", "''")
            last_name = parts[1].replace("'", "''")
        else:
            first_name = "Okänt"
            last_name = parts[0].replace("'", "''")

        file.write(
            f"INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) "
            f"VALUES ('{first_name}', '{last_name}', '1900-01-01');\n"
        )

    file.write("\n-- Förlag\n")
    for publisher_name, id_value in publishers.items():
        safe_publisher = publisher_name.replace("'", "''")

        file.write(
            f"INSERT INTO Förlag (Förlagsnamn, Land) "
            f"VALUES ('{safe_publisher}', 'Okänt');\n"
        )

    file.write("\n-- Genre\n")
    for genre_name, id_value in genres.items():
        safe_genre = genre_name.replace("'", "''")

        file.write(
            f"INSERT INTO Genre (Genrenamn) "
            f"VALUES ('{safe_genre}');\n"
        )

    file.write("\n-- Böcker\n")
    for book in books:
        file.write(
            f"INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) "
            f"VALUES ('{book['isbn13']}', '{book['title']}', 'Engelska', "
            f"{book['price']}, '{book['publish_date']}', {book['publisher_id']}, {book['genre_id']});\n"
        )

    file.write("\n-- BokFörfattare\n")
    for book in books:
        file.write(
            f"INSERT INTO BokFörfattare (ISBN13, FörfattarID) "
            f"VALUES ('{book['isbn13']}', {book['author_id']});\n"
        )

    file.write("\n-- LagerSaldo\n")
    for book in books:
        for store_id in [1, 2, 3]:
            stock = random.randint(0, 20)
            file.write(
                f"INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) "
                f"VALUES ('{book['isbn13']}', {store_id}, {stock});\n"
            )

print("SQL-insert satser har genererats i 'generated_inserts.sql'")
