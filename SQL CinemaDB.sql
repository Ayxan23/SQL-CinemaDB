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

--Genres
CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(255),
)

INSERT INTO Genres
VALUES('Sci Fi'),
	('Horror'),
	('Comedy'),
	('Drama')

--Actors
CREATE TABLE Actors(
	Id INT PRIMARY KEY IDENTITY,
	ActorsName NVARCHAR(255),
)

INSERT INTO Actors
VALUES('Johnny Depp'),
	('Brad Pitt'),
	('Charlize Theron'),
	('Scarlett Johansson')

--InfoMovies
CREATE TABLE InfoMovies(
	Id INT PRIMARY KEY IDENTITY,
	LanguageId INT FOREIGN KEY REFERENCES Languages(Id),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)

INSERT INTO InfoMovies
VALUES(1, 4, 1, 4),
	(2, 3, 2, 3),
	(3, 2, 3, 2),
	(4, 1, 4, 1)

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
CREATE TABLE InfoCinema(
	Id INT PRIMARY KEY IDENTITY,
	InfoMovieId INT FOREIGN KEY REFERENCES InfoMovies(Id),
	HallId INT FOREIGN KEY REFERENCES Halls(Id),
	SessionsId INT FOREIGN KEY REFERENCES Sessions(Id),
	Price DECIMAL(7,2)
)

INSERT INTO InfoCinema
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
	InfoCinemaId INT FOREIGN KEY REFERENCES InfoCinema(Id),
)

INSERT INTO BuyTicket
VALUES(9, 5, 1, 1),
	(8, 3, 0, 2),
	(4, 8, 0, 3),
	(6, 5, 1, 4)

--Customers
CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	CustomerName NVARCHAR(255),
	TicketId INT FOREIGN KEY REFERENCES BuyTicket(Id),
)

INSERT INTO Customers
VALUES('Ayxan', 1),
	('Fikret', 2),
	('Nuray', 3),
	('Aysel', 4)

CREATE VIEW ticket_info
AS
SELECT Customers.CustomerName, Movies.MovieName, Genres.GenreName, Actors.ActorsName, Languages.LanguageName, Sessions.StartTime, Sessions.EndTime, Halls.HallName, BuyTicket.Row, BuyTicket.Colum, InfoCinema.Price FROM Customers
JOIN BuyTicket
ON Customers.TicketId = BuyTicket.Id
JOIN InfoCinema 
ON BuyTicket.InfoCinemaId = InfoCinema.Id
JOIN InfoMovies
ON InfoCinema.InfoMovieId = InfoMovies.Id
JOIN Halls
ON InfoCinema.HallId = Halls.Id
JOIN Sessions
ON InfoCinema.SessionsId = Sessions.Id
JOIN Movies 
ON InfoMovies.MovieId = Movies.Id
JOIN Languages
ON InfoMovies.LanguageId = Languages.Id
JOIN Genres
ON InfoMovies.GenreId = Genres.Id
JOIN Actors
ON InfoMovies.ActorId = Actors.Id

SELECT * FROM ticket_info



