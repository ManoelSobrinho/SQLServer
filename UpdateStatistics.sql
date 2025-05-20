SELECT DISTINCT mst.[object_id] AS objectID,t.name AS schemaName,'UPDATE STATISTICS ' + OBJECT_NAME(mst.[object_id]) + ' '+ss.name+' WITH fullscan, MAXDOP=16;',
OBJECT_NAME(mst.[object_id]) AS tableName,
sp.last_updated,sp.[rows],sp.modification_counter,ss.[stats_id],ss.name AS [stat_name],sp.rows_sampled,
ss.auto_created,ss.user_created,ss.has_filter,ss.filter_definition,sp.unfiltered_rows,sp.steps,
(CAST(CAST(modification_counter AS decimal(28,8)) / CAST(rows AS decimal(28,8)) AS DECIMAL(28,8)) * 100) AS pct_chng_stat_table
FROM sys.objects AS o
INNER JOIN sys.tables AS mst ON mst.[object_id] = o.[object_id]
INNER JOIN sys.schemas AS t ON t.[schema_id] = mst.[schema_id]
INNER JOIN sys.stats AS ss ON ss.[object_id] = mst.[object_id]
CROSS APPLY sys.dm_db_stats_properties(ss.[object_id],ss.[stats_id]) AS sp
WHERE sp.[rows] > 500
AND t.name <> 'cdc'
AND mst.name in ('ObjectName')
AND ((CAST((sp.rows_sampled / (sp.[rows] * 1.00)) * 100.0 AS DECIMAL(5, 2)) between 0.1 and 90)
OR (CAST(CAST(modification_counter AS DECIMAL(28, 8)) / CAST(ROWS AS DECIMAL(28, 8)) AS DECIMAL(28, 8)) * 100) > 1)
ORDER BY ROWS, modification_counter