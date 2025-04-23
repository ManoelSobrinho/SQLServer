SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT TOP 10
	st.text AS [SQL]
	, DB_NAME(st.dbid) AS DatabaseName
	, cp.usecounts AS [Plan usage]
	, qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE st.text LIKE '%CREATE PROCEDURE%'
ORDER BY cp.usecounts DESC