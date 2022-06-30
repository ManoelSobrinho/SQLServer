SELECT 
	SERVERPROPERTY('ServerName') AS ServerName,
	SERVERPROPERTY('InstanceName') AS InstanceName,
	CONNECTIONPROPERTY('local_net_address') AS IP,
	SERVERPROPERTY('Edition') AS SQLEdition,
	SERVERPROPERTY('IsClustered') AS IsClustered,
	SERVERPROPERTY('IsHadrEnabled') AS IsHadrEnabled,
	@@VERSION AS SQLVersion,
	cpu_count AS CPUs,
	physical_memory_kb/1000000 AS RAM
FROM sys.dm_os_sys_info
GO
