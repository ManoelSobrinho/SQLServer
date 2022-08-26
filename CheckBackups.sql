SELECT database_name, name, backup_start_date, DATEDIFF(mi,backup_start_date,backup_finish_date) [tempo (min)],
	position, server_name, recovery_model, last_lsn,
	ISNULL(logical_device_name,' ') logical_device_name,device_type, type, CAST(backup_size/1024/1024 AS NUMERIC(15,2)) [Tamanho (MB)],first_lsn
FROM msdb.dbo.backupset B
	INNER JOIN msdb.dbo.backupmediafamily BF ON B.media_set_id = BF.media_set_id
WHERE backup_start_date >= DATEADD(hh, -24 ,GETDATE()  )
	AND database_name = 'DatabaseName'
ORDER BY backup_start_date DESC
