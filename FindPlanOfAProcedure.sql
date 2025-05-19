SELECT qp.query_plan, OBJECT_NAME(ps.object_id) AS Proc_Name
	FROM sys.dm_exec_procedure_stats AS ps
	CROSS APPLY sys.dm_exec_query_plan(ps.plan_handle) AS qp
	WHERE ps.database_id = DB_ID(N'DatabaseName')
    AND (
		ps.object_id = OBJECT_ID(N'DatabaseName.dbo.Procedure')
	OR ps.object_id = OBJECT_ID(N'DatabaseName.dbo.Procedure')
	)