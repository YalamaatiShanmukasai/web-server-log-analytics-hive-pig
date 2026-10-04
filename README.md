# Web Server Log Analytics using Hive & Pig

## Project Overview

This project performs web server log analytics using the Hadoop ecosystem, mainly **Apache Hive** and **Apache Pig**. The analysis identifies request patterns, HTTP methods, response statuses, frequently accessed pages, server errors, response times, and IP/client activity.

## Technologies Used

- Hadoop / HDFS
- Apache Hive
- Apache Pig
- HiveQL
- Pig Latin
- CSV

## Project Files

| File | Purpose |
|---|---|
| `web_logs.csv` | Web server log dataset |
| `web_logs.pig` | Pig Latin analytics program |
| `web_logs.hql` | HiveQL analytics program |
| `README.md` | Project documentation |

## Dataset Summary

The project dataset contains **1,422 records**.

Recorded observations from the project:

- Total records: **1,422**
- GET requests: **730**
- POST requests: **690**
- HTTP statuses: **200, 302, 404, 500**
- 404 errors: **29**
- 500 errors: **19**
- Pages: `/checkout`, `/cart`, `/home`, `/login`, `/products`

## CSV Format

```text
ip,timestamp,method,page,status,response_time_ms,user_agent
```

### Columns

| Column | Description |
|---|---|
| `ip` | Client IP address |
| `timestamp` | Date and time of the request |
| `method` | HTTP request method |
| `page` | Requested page |
| `status` | HTTP response status |
| `response_time_ms` | Response time in milliseconds |
| `user_agent` | Browser/client |

## Pig Analytics

`web_logs.pig` performs:

1. Total request count
2. HTTP method analysis
3. HTTP status analysis
4. Most requested pages
5. 404/500 error analysis
6. Average response time by method
7. Top IP addresses

Run:

```bash
pig web_logs.pig
```

For HDFS:

```bash
hdfs dfs -mkdir -p /input/web_logs
hdfs dfs -put web_logs.csv /input/web_logs/
```

If using HDFS input, change the Pig `LOAD` path from `web_logs.csv` to the HDFS dataset path.

## Hive Analytics

`web_logs.hql`:

- Creates the `web_log_analytics` database
- Creates the log table
- Loads `web_logs.csv`
- Counts total requests
- Groups GET/POST/HEAD requests
- Groups response statuses
- Finds popular pages
- Counts 404 and 500 errors
- Calculates average response time
- Finds top IP addresses
- Analyzes user agents

Run:

```bash
hive -f web_logs.hql
```

Or:

```sql
SOURCE web_logs.hql;
```

## Example Queries

### Total Records

```sql
SELECT COUNT(*) FROM web_logs_raw;
```

Expected:

```text
1422
```

### HTTP Methods

```sql
SELECT method, COUNT(*)
FROM web_logs_raw
GROUP BY method;
```

Project observations include:

```text
GET   730
POST  690
```

### Error Analysis

```sql
SELECT status, COUNT(*)
FROM web_logs_raw
WHERE status IN (404, 500)
GROUP BY status;
```

Project observations:

```text
404   29
500   19
```

## Outcome

The project demonstrates how Hive and Pig can process web server logs and extract useful information about user requests, HTTP methods, frequently visited pages, server errors, response performance, and client/IP activity.

## GitHub Repository

**YalamaatiShanmukasai/web-server-log-analytics-hive-pig**

## Author

**Shanmuka Sai Yalamaati**
