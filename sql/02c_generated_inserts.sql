-- Författare
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Thomas', 'De Quincey', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Agatha', 'Christie', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Howard', 'Pyle', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Rita', 'Williams-Garcia', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Jay', 'Anson', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('H.P.', 'Lovecraft', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Robert', 'A. Heinlein', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Robert', 'Silverberg', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Catherine', 'Coulter', '1900-01-01');
INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) VALUES ('Neal', 'Stephenson', '1900-01-01');

-- Förlag
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Liese. Outside The Box, Andreas', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('The Classic Collection', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Arc Manor', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Recorded Books', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('G. K. Hall', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Edaf', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Berkley', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Avon', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Brilliance Audio Unabridged Lib Ed', 'Okänt');
INSERT INTO Förlag (Förlagsnamn, Land) VALUES ('Audible Studios on Brilliance', 'Okänt');

-- Genre
INSERT INTO Genre (Genrenamn) VALUES ('Crime');
INSERT INTO Genre (Genrenamn) VALUES ('Historical Fiction');
INSERT INTO Genre (Genrenamn) VALUES ('Horror');
INSERT INTO Genre (Genrenamn) VALUES ('Science Fiction');
INSERT INTO Genre (Genrenamn) VALUES ('Thriller');

-- Böcker
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781018871486', 'The lock and key library', 'Engelska', 249, '1909-01-01', 1, 1);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781981138197', 'The Mysterious Affair at Styles', 'Engelska', 229, '1920-01-01', 2, 1);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781722325152', 'Men of Iron', 'Engelska', 229, '1891-01-01', 3, 2);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781432860332', 'One crazy summer', 'Engelska', 179, '2010-01-01', 4, 2);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781416507697', 'The Amityville Horror', 'Engelska', 229, '1977-01-01', 5, 3);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9788420636375', 'The Dunwich Horror', 'Engelska', 229, '1963-01-01', 6, 3);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9780425052167', 'Great Sf Heinlein Bxs', 'Engelska', 129, '1980-01-01', 7, 4);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9780999174067', 'The Science Fiction Hall of Fame -- Volume One', 'Engelska', 129, '1970-01-01', 8, 4);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9781593557256', 'Double Take', 'Engelska', 179, '2007-01-01', 9, 5);
INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörlagID, GenreID) VALUES ('9780802198570', 'Zodiac', 'Engelska', 179, '1988-01-01', 10, 5);

-- BokFörfattare
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781018871486', 1);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781981138197', 2);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781722325152', 3);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781432860332', 4);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781416507697', 5);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9788420636375', 6);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9780425052167', 7);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9780999174067', 8);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9781593557256', 9);
INSERT INTO BokFörfattare (ISBN13, FörfattarID) VALUES ('9780802198570', 10);

-- LagerSaldo
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781018871486', 1, 14);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781018871486', 2, 20);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781018871486', 3, 19);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781981138197', 1, 17);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781981138197', 2, 16);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781981138197', 3, 18);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781722325152', 1, 7);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781722325152', 2, 18);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781722325152', 3, 17);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781432860332', 1, 6);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781432860332', 2, 4);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781432860332', 3, 7);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781416507697', 1, 0);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781416507697', 2, 2);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781416507697', 3, 8);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9788420636375', 1, 15);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9788420636375', 2, 1);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9788420636375', 3, 15);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780425052167', 1, 11);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780425052167', 2, 2);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780425052167', 3, 4);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780999174067', 1, 12);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780999174067', 2, 18);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780999174067', 3, 18);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781593557256', 1, 19);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781593557256', 2, 7);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9781593557256', 3, 7);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780802198570', 1, 3);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780802198570', 2, 4);
INSERT INTO LagerSaldo (ISBN13, ButikID, Antal) VALUES ('9780802198570', 3, 7);
