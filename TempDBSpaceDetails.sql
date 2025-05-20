USE tempdb
GO

SELECT DB_NAME() AS DbName, 
    name AS FileName, 
    type_desc,
    size/128.0 AS CurrentSizeMB,  
    size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB,
	CAST(((size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0)/(size/128.0)) * 100 AS DECIMAL(4,2)) AS PercentageOfFreeSpace
FROM sys.database_files
WHERE type IN (0,1);