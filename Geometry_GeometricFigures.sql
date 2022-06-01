-- Geometry

/* 
Pontos
	Cada par de pontos representa uma coordenada no plano (x,y)
*/

SELECT GEOMETRY::Parse('POINT(10 20)') AS Ponto
SELECT GEOMETRY::Parse('MULTIPOINT((10 20), (10 40))') AS DoisPontos

/*
Retas
*/

SELECT GEOMETRY::Parse('LINESTRING(0 0, 2 2)') AS Reta
SELECT GEOMETRY::Parse('LINESTRING(0 0, 2 2, 4 0, 0 0)') AS Triangulo
SELECT GEOMETRY::Parse('MULTILINESTRING((0 0, 2 2), (0 2, 2 0), (1 2, 1 0), (0 1, 2 1))') AS Asterisco

/*
Curvas
*/

SELECT GEOMETRY::Parse('CIRCULARSTRING(0 1, 1 0, 2 1)') AS Semicirculo
SELECT GEOMETRY::Parse('CIRCULARSTRING(0 1, 1 0, 2 1, 1 2, 0 1)') AS Circulo

/*
Poligonos
*/

SELECT GEOMETRY::Parse('POLYGON((1 1, 5 1, 4 3, 2 3, 1 1))') AS Trapezio
SELECT GEOMETRY::Parse('MULTIPOLYGON(((1 1, 5 1, 4 3, 2 3, 1 1), (6 1, 8 1, 8 3, 6 3, 6 1)))') AS TrapezioEQuadrado

/*
Círculos - Polígonos curvos
*/

SELECT GEOMETRY::Parse('CURVEPOLYGON(CIRCULARSTRING(0 1, 1 0, 2 1, 1 2, 0 1))') AS Circulo
SELECT GEOMETRY::Parse('CURVEPOLYGON(CIRCULARSTRING(0 1, 1 0, 2 1, 1 2, 0 1), CIRCULARSTRING(2 4, 4 2, 6 4, 4 6, 2 4))') AS DoisCirculos

/*
Agrupar vários objetos em um único SELECT
*/

SELECT GEOMETRY::Parse('
	GEOMETRYCOLLECTION(
		CIRCULARSTRING(0 1, 1 0, 2 1, 1 2, 0 1),
		LINESTRING(1 0, 1 -4),
		LINESTRING(3 -1, -1 -1)
	)')
