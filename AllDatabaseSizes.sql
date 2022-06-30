SELECT
    DB_NAME (database_id) AS DatabaseName,
    [Type] = CASE WHEN Type_Desc = 'ROWS' THEN 'Data File(s)'
            WHEN Type_Desc = 'LOG'  THEN 'Log File(s)'
            ELSE Type_Desc END,
    size * 8 / 1024 AS 'Size (MB)',
    physical_name AS DatabaseFileLocation
FROM sys.master_files
ORDER BY 1,3