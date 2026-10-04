-- Web Server Log Analytics using Pig Latin
-- Dataset: web_logs_5kb.csv

logs = LOAD '/logs/web_logs_5kb.csv' USING PigStorage(',')
       AS (ip:chararray, log_time:chararray, method:chararray,
           url:chararray, status:int, bytes:int, user_agent:chararray);

clean_logs = FILTER logs BY ip IS NOT NULL AND url IS NOT NULL;

grp_url = GROUP clean_logs BY url;

count_url = FOREACH grp_url GENERATE
            group AS url,
            COUNT(clean_logs) AS visits;

DUMP count_url;

grp_status = GROUP clean_logs BY status;

count_status = FOREACH grp_status GENERATE
               group AS status,
               COUNT(clean_logs) AS records;

DUMP count_status;
