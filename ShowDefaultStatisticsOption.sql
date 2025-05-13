SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT name AS DatabaseName
	, is_auto_create_stats_on AS AutoCreateStatistics
	, is_auto_update_stats_on AS AutoUpdateStatistics
	, is_auto_update_stats_async_on	AS AutoUpdateStatisticsAsync
FROM sys.databases
ORDER BY DatabaseName