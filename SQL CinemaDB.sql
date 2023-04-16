CREATE DATABASE Cinema

Use Cinema

--Languages
CREATE TABLE Languages(
	Id INT PRIMARY KEY IDENTITY,
	LanguageName NVARCHAR(255)
)


INSERT INTO Languages
VALUES('EN'),
	('AZ'),
	('RU'),
	('TR')

--Movies
CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	MovieName NVARCHAR(255),
	Duration INT
)

INSERT INTO Movies
VALUES('Black', 120),
	('White', 200),
	('Blue', 140),
	('Green', 90)

--LanguageMovies
CREATE TABLE LanguageMovies(
	Id INT PRIMARY KEY IDENTITY,
	LanguageId INT FOREIGN KEY REFERENCES Languages(Id),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id)
)

INSERT INTO LanguageMovies
VALUES(1, 4),
	(2, 3),
	(3, 2),
	(4, 1)

--Halls
CREATE TABLE Halls(
	Id INT PRIMARY KEY IDENTITY,
	HallName VARCHAR(255),
	Row INT,
	Colum INT
)

INSERT INTO Halls
VALUES('Hall 1', 15, 15),
	('Hall 2', 12, 15),
	('Hall 3', 10, 12),
	('Hall 4', 14, 15)

--Sessions
CREATE TABLE Sessions(
	Id INT PRIMARY KEY IDENTITY,
	StartTime DATETIME2,
	EndTime DATETIME2,
)

INSERT INTO Sessions
VALUES('2023.02.15 15:40:45', '2023.02.15 17:40:45'),
	('2023.02.15 15:40:45', '2023.02.15 17:40:45'),
	('2023.02.15 15:40:45', '2023.02.15 17:40:45'),
	('2023.02.15 15:40:45', '2023.02.15 17:40:45')

--LagMovSes
CREATE TABLE LagMovSes(
	Id INT PRIMARY KEY IDENTITY,
	LanguageMovieId INT FOREIGN KEY REFERENCES LanguageMovies(Id),
	HallId INT FOREIGN KEY REFERENCES Halls(Id),
	SessionsId INT FOREIGN KEY REFERENCES Sessions(Id),
	Price DECIMAL(7,2)
)

INSERT INTO LagMovSes
VALUES(3, 1, 2, 5.5),
	(2, 4, 1, 6.5),
	(1, 2, 4, 7.5),
	(4, 1, 3, 8.5)

--BuyTicket
CREATE TABLE BuyTicket(
	Id INT PRIMARY KEY IDENTITY,
	Row INT,
	Colum INT,
	IsEmpty BIT,
	LagMovSesId INT FOREIGN KEY REFERENCES LagMovSes(Id),
)

INSERT INTO BuyTicket
VALUES(9, 5, 1, 1),
	(8, 3, 0, 2),
	(4, 8, 0, 3),
	(6, 5, 1, 4)

CREATE VIEW ticket_info
AS
SELECT Movies.MovieName, Languages.LanguageName, Halls.HallName, Sessions.StartTime, Sessions.EndTime, LagMovSes.Price, BuyTicket.Row, BuyTicket.Colum FROM BuyTicket
JOIN LagMovSes 
ON BuyTicket.LagMovSesId = LagMovSes.Id
JOIN LanguageMovies
ON LagMovSes.LanguageMovieId = LanguageMovies.Id
JOIN Halls
ON LagMovSes.HallId = Halls.Id
JOIN Sessions
ON LagMovSes.SessionsId = Sessions.Id
JOIN Movies 
ON LanguageMovies.MovieId = Movies.Id
JOIN Languages
ON LanguageMovies.LanguageId = Languages.Id

SELECT * FROM ticket_info



