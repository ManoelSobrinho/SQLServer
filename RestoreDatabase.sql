USE MASTER 

-- Exclui a database caso ela já exista
IF DATABASEPROPERTYEX (N'DatabaseName', N'Version') > 0
BEGIN
	ALTER DATABASE DatabaseName SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DatabaseName;
END

-- Apenas para validar o nome lógico dos arquivos de dados e logs
RESTORE FILELISTONLY
FROM DISK = 'C:\TEMP\DatabaseName_Dados.bak'

-- Restore criando uma nova database
RESTORE DATABASE DatabaseName
FROM DISK = 'C:\TEMP\DatabaseName_Dados.bak'
WITH RECOVERY,STATS = 5,
MOVE 'DatabaseName' TO 'C:\TEMP\DatabaseName.mdf',
MOVE 'DatabaseName_log' TO 'C:\TEMP\DatabaseName_Log.ldf'