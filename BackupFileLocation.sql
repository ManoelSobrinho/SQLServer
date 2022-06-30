SELECT
	database_name AS DatabaseName,
	backup_finish_date as BackupFinishDate,
	CASE msdb..backupset.type
		WHEN 'D' THEN 'Database'
		WHEN 'L' THEN 'Log'
	END AS BackupType,
	physical_device_name Location
FROM msdb.dbo.backupmediafamily
INNER JOIN msdb.dbo.backupset
ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id
ORDER BY database_name,backup_finish_date