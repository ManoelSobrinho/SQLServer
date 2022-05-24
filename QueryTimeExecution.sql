USE AdventureWorks2019
GO

SELECT * FROM Person.Person

-- Utilizando SET STATISTICS IO, TIME ON

SET STATISTICS IO, TIME ON
SELECT * FROM Person.Person
SET STATISTICS IO, TIME OFF
GO
 
-- Utilizando GETDATE() subtraindo o tempo final menos o inicial - medidas em milisegundos (1s / 1000)

DECLARE @inicio DATETIME = GETDATE()
SELECT * FROM Person.Person
PRINT CONCAT('Concluído: ', RIGHT(CONCAT('0', DATEDIFF(d, @inicio, SYSDATETIME())), 2), ' dias ', + CONVERT(VARCHAR, GETDATE() - @inicio, 114))
GO
 
-- Utilizando SYSDATETIME() - medidas em microsegundos (1s / 1 milhão) (maior precisão)

DECLARE @inicio DATETIME2 = SYSDATETIME()
SELECT * FROM Person.Person
PRINT CONCAT('Concluído: ', RIGHT(CONCAT('0', DATEDIFF(d, @inicio, SYSDATETIME())), 2), ' dias ', CONVERT(VARCHAR, CONVERT(DATETIME, SYSDATETIME()) - CONVERT(DATETIME, @inicio), 108), '.', RIGHT('000000' + CONVERT(VARCHAR, CONVERT(BIGINT, DATEDIFF_BIG(MICROSECOND, @inicio, SYSDATETIME()) % 1000000.0)), 6))
GO