SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT s.name, s.type_desc
FROM sys.procedures s
LEFT OUTER JOIN sys.dm_exec_procedure_stats d
			ON s.object_id = d.object_id
WHERE d.object_id IS NULL
ORDER BY s.name