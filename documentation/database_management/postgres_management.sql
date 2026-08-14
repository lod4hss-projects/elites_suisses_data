


select version();


-- list of actives queries:
SELECT pid, usename, state, query, query_start 
FROM pg_stat_activity 
WHERE state = 'active';

SELECT pg_terminate_backend(32860);





-- 1. Grant permission to connect to the specific database
GRANT CONNECT ON DATABASE [database_name] TO [role]; 
-- (Replace 'elites_suisses' with the actual DATABASE name if it differs from the schema name)

-- 2. Ensure they can use the schema (as discussed before)
GRANT USAGE ON SCHEMA elites_suisses TO [role];



-- Grant SELECT on all existing tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA elites_suisses TO your_role;


ALTER DEFAULT PRIVILEGES IN SCHEMA elites_suisses GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO your_role;




