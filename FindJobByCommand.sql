SELECT sjt.database_name,sj.enabled,sj.name,sj.description,
sjt.command,sjt.last_run_date,sjt.last_run_time,sjt.output_file_name
FROM msdb..sysjobs sj
JOIN msdb..sysjobsteps sjt ON sj.job_id = sjt.job_id
WHERE sjt.command like '%TextoDesejado%'