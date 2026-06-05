-- Butiker
INSERT INTO Butiker (Butiknamn, Gatuadress, Postnummer, Ort)
VALUES ('Bokhörnan Centrum', 'Storgatan 1', '46130', 'Trollhättan');

INSERT INTO Butiker (Butiknamn, Gatuadress, Postnummer, Ort)
VALUES ('Bokhörnan Torp', 'Köpcentrumsvägen 10', '45176', 'Uddevalla');

INSERT INTO Butiker (Butiknamn, Gatuadress, Postnummer, Ort)
VALUES ('Bokhörnan Nordstan', 'Nordstadstorget 5', '41105', 'Göteborg');

-- Kunder
INSERT INTO Kunder (Förnamn, Efternamn, Epost)
VALUES ('Amira', 'Nilsson', 'amira.nilsson@example.com');

INSERT INTO Kunder (Förnamn, Efternamn, Epost)
VALUES ('Erik', 'Karlsson', 'erik.karlsson@example.com');

INSERT INTO Kunder (Förnamn, Efternamn, Epost)
VALUES ('Sara', 'Andersson', 'sara.andersson@example.com');

INSERT INTO Kunder (Förnamn, Efternamn, Epost)
VALUES ('Jonas', 'Berg', 'jonas.berg@example.com');

INSERT INTO Kunder (Förnamn, Efternamn, Epost)
VALUES ('Maja', 'Lind', 'maja.lind@example.com');


SELECT COUNT(*) AS AntalButiker
FROM Butiker;

SELECT COUNT(*) AS AntalKunder
FROM Kunder;