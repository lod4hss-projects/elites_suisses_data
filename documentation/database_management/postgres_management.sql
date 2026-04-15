


select version();


-- list of actives queries:
SELECT pid, usename, state, query, query_start 
FROM pg_stat_activity 
WHERE state = 'active';

SELECT pg_terminate_backend(32860);





