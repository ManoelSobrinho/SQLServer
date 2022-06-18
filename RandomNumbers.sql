------------------------------------------------------------------
-- Gerar números aleatórios no SQL Server
------------------------------------------------------------------
 
----------------------------------------------
-- Utilizando NEWID
----------------------------------------------

-- 1: Inteiro aleatório
SELECT
    NEWID() AS String,
    CHECKSUM(NEWID()) AS Numero
 
-- 2: Inteiro aleatório positivo
SELECT ABS(CHECKSUM(NEWID())) AS Resultado
 
-- 3: Inteiro aleatório entre -100 e 100
SELECT CHECKSUM(NEWID()) %101 AS Resultado 
 
-- 4: Inteiro aleatório entre 1 e 100
SELECT (ABS(CHECKSUM(NEWID())) % 100) + 1 AS Resultado
 
-- 5: Número inteiro com até X digitos
SELECT LEFT(CHECKSUM(NEWID()), 5) AS Resultado
 
-- 6: BIGINT
SELECT CONVERT(BIGINT, CONVERT(VARBINARY(8), NEWID())) AS Resultado
 
-- 7: DECIMAL
SELECT CONVERT(DECIMAL(38,10), LEFT(CONVERT(VARCHAR, CONVERT(BIGINT, CONVERT(VARBINARY(8), NEWID()))) + '.' + CONVERT(VARCHAR, ABS(CHECKSUM(NEWID()))), 38)) AS Resultado
 
-- 8: FLOAT
SELECT CONVERT(FLOAT, LEFT(CONVERT(VARCHAR, CONVERT(BIGINT, CONVERT(VARBINARY(8), NEWID()))) + '.' + CONVERT(VARCHAR, ABS(CHECKSUM(NEWID()))), 38)) AS Resultado
 
 
----------------------------------------------
-- Gerando listas de números aleatórios
----------------------------------------------
-- 1: Usando CTE recursiva (meu preferido!)
WITH CTE_Seq AS (
    SELECT 1 AS Sequencia, CHECKSUM(NEWID()) AS InteiroPositivo
    UNION ALL
    SELECT Sequencia + 1, checksum(newid()) FROM CTE_Seq WHERE Sequencia < 1000
)
SELECT * FROM CTE_Seq OPTION (MaxRecursion 0) -- option (maxrecursion 0) permite loops + de 100 itens
 
-- 2: Usando loop ou cursor
DECLARE @i SMALLINT = 1
WHILE @i <= 1000 
    BEGIN
        PRINT CHECKSUM(NEWID())
        SET @i+= 1
    END
 
-- 3: Usando select em tabelas
SELECT TOP 1000
    LEFT(CONVERT(INT, CRYPT_GEN_RANDOM(8)), 2) AS Resultado
FROM sysobjects a FULL join sysobjects b ON 1 = 1

-- 4: Utilizando GO

SELECT ABS(CHECKSUM(NEWID())) AS Resultado
GO 50
 
 
----------------------------------------------
-- Outras formas
----------------------------------------------
-- FC matemática rand e rand com seed
-- OBS: Ao executar os dois comandos juntos o valor não é aleatório
SELECT RAND()
SELECT RAND(123)
 
-- FC matemática rand (inteiro em um range)
DECLARE @maior INT;
DECLARE @menor INT
SET @menor = 1 ---- menor número
SET @maior = 60 ---- maior número
SELECT ROUND(((@maior - @menor -1) * RAND() + @menor), 0)
 
-- FC matemática rand (decimal)
-- Entre 0 e 20 (decimal)
SELECT 20 * RAND()
-- Entre 10 e 30
SELECT 10 + 20*RAND()
 
-- FC criptografica
SELECT CONVERT(BIGINT, CRYPT_GEN_RANDOM(8))
 
-- FC sysdatetime (ns = nanosegundos)
SELECT (DATEPART(NS, SYSDATETIME())) 
 
 
 
-- Créditos: https://dba-pro.com/como-gerar-numeros-aleatorios-no-sql/