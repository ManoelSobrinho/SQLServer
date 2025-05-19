SELECT CASE WHEN drs.synchronization_health_desc <> 'healthy' OR drs.synchronization_state_desc NOT IN ('synchronizing', 'synchronized')  
	THEN 'PROBLEM' ELSE 'NOTHING' END AS alert_level
	,ag.name AS availability_group_name  
	,ags.primary_replica AS primary_replica  
	,DB_NAME(drs.database_id) AS database_name  
	,rcs.replica_server_name AS secondary_replica  
	,drs.synchronization_health_desc AS synchronization_health_desc  
	,drs.synchronization_state_desc AS synchronization_state_desc  
	,CAST(drs.log_send_queue_size/1024./1024. AS NUMERIC(7,3)) AS send_queue_gb    
	,CAST(drs.redo_queue_size/1024./1024. AS NUMERIC(7,3)) AS redo_queue_gb 
	,redo_queue_size  
	,drs.last_received_time AS last_received_datetime  
	,drs.last_redone_time AS last_redone_datetime
	, last_commit_time 
	FROM sys.availability_groups ag 
		INNER JOIN sys.dm_hadr_availability_group_states ags 
			ON ags.group_id = ag.group_id 
		INNER JOIN sys.dm_hadr_database_replica_states drs 
			ON drs.group_id = ag.group_id  
		INNER JOIN sys.dm_hadr_availability_replica_cluster_states rcs 
			ON rcs.replica_id = drs.replica_id  
	WHERE rcs.replica_server_name <> @@SERVERNAME