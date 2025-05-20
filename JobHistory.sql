USE DatabaseName

SELECT 
	j.name
	,run_date
	,message
FROM msdb.dbo.sysjobs j
INNER JOIN msdb.dbo.sysjobhistory h
ON j.job_id = h.job_id
WHERE j.name = 'CS - BulkInserts'
ORDER BY run_date DESC