SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT TOP 20
	CAST(qs.total_elapsed_time / 1000000.0 AS DECIMAL(28, 2)) AS [elapsed_time]
	, qs.execution_count AS [execution_count]
	, SUBSTRING(qt.text, (qs.statement_start_offset / 2) + 1
	, ((CASE WHEN qs.statement_end_offset = -1
		 THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
			ELSE
				qs.statement_end_offset
			END - qs.statement_start_offset) / 2) + 1) AS [individual_query]
	, qt.text AS [parent_query]
	, DB_NAME(qt.dbid) AS [database_name]
	, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_elapsed_time DESC