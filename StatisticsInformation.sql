SELECT sp.stats_id, 
       stat.name, 
       filter_definition, 
	   stat.auto_created,
	   stat.is_temporary,
	   so.create_date,
       last_updated, 
       rows, 
       rows_sampled, 
       steps, 
       unfiltered_rows, 
       modification_counter
FROM sys.stats AS stat
     CROSS APPLY sys.dm_db_stats_properties(stat.object_id, stat.stats_id) AS sp
	 INNER JOIN sys.objects so ON sp.object_id = so.object_id
WHERE stat.object_id = OBJECT_ID('Table_Name')
