SELECT DB_NAME = CASE 
	WHEN database_id = 32767 THEN 'RESOURCEDB'
	ELSE 
		DB_NAME(database_id) END
		,Size_MB = count(1)/128
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
ORDER BY 2 DESC