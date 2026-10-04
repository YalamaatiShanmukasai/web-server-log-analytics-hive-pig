# Web Server Log Analytics using Hadoop, Hive and Pig

## Project Overview

This project performs web server log analytics using the Hadoop ecosystem, mainly **HDFS, Apache Hive, and Apache Pig**. The analysis identifies request patterns, HTTP methods, response statuses, frequently accessed pages, server errors, response times, and client activity.

## Technologies Used

- Apache Hadoop / HDFS
- Apache Hive
- Apache Pig
- HiveQL
- Pig Latin
- MapReduce
- CSV
- GitHub

## Dataset Summary

The project dataset contains **10 records**.

Recorded observations from the dataset:

- Total records: **10**
- GET requests: **7**
- POST requests: **3**
- HTTP statuses: **200, 302, 404, 500**
- 404 errors: **1**
- 500 errors: **1**
- Pages: **/checkout, /cart, /home, /login, /products, /payment**

## Dataset Structure

The dataset contains 7 columns:

| Column | Description |
|---|---|
| `ip` | Client IP address |
| `timestamp` | Date and time of the request |
| `method` | HTTP request method |
| `page` | Requested page |
| `status` | HTTP response status |
| `response_time_ms` | Response time in milliseconds |
| `user_agent` | Browser/client |

### Dataset

```text
ip,timestamp,method,page,status,response_time_ms,user_agent
192.168.1.1,2026-10-01 10:00:01,GET,/home,200,512,Mozilla
192.168.1.2,2026-10-01 10:01:15,POST,/login,302,1024,Chrome
192.168.1.3,2026-10-01 10:02:20,GET,/products,200,2048,Edge
192.168.1.4,2026-10-01 10:03:45,GET,/cart,200,512,Firefox
192.168.1.5,2026-10-01 10:05:10,GET,/checkout,500,256,Chrome
192.168.1.6,2026-10-01 10:06:30,POST,/payment,200,1024,Mozilla
192.168.1.7,2026-10-01 10:07:50,GET,/home,200,512,Edge
192.168.1.8,2026-10-01 10:08:12,GET,/products,404,256,Chrome
192.168.1.9,2026-10-01 10:09:25,GET,/home,200,512,Mozilla
192.168.1.10,2026-10-01 10:10:40,POST,/login,200,1024,Firefox
```

## Project Workflow

```text
Web Server Log Dataset
          |
          v
        HDFS
          |
          v
    Apache Pig
          |
          v
Data Cleaning & Processing
          |
          v
     Apache Hive
          |
          v
 Data Analysis & Queries
          |
          v
   Results and Insights
```

## 1. Hadoop / HDFS

The web server log dataset is stored in HDFS before processing.

### Commands

```bash
hadoop fs -mkdir /input
hadoop fs -put web_logs.csv /input
hadoop fs -ls /input
```

### Expected Output

```text
Found 1 items
-rw-r--r--   1 user supergroup   web_logs.csv
```

## 2. Apache Pig

Apache Pig is used to process and analyze the web server logs.

### Load Dataset

```pig
logs = LOAD 'web_logs.csv' USING PigStorage(',')
       AS (ip:chararray,
           timestamp:chararray,
           method:chararray,
           page:chararray,
           status:int,
           response_time_ms:int,
           user_agent:chararray);
```

### Pig Output — Total Requests

```text
(10)
```

### Pig Output — Requests by HTTP Method

```text
(GET,7)
(POST,3)
```

| HTTP Method | Requests |
|---|---:|
| GET | 7 |
| POST | 3 |
| **Total** | **10** |

### Pig Output — HTTP Status

```text
(200,7)
(302,1)
(404,1)
(500,1)
```

| Status | Requests |
|---|---:|
| 200 | 7 |
| 302 | 1 |
| 404 | 1 |
| 500 | 1 |
| **Total** | **10** |

### Pig Output — Most Requested Pages

```text
(/home,3)
(/login,2)
(/products,2)
(/cart,1)
(/checkout,1)
(/payment,1)
```

**Most requested page: `/home`**

### Pig Output — Error Analysis

```text
(404,1)
(500,1)
```

### Pig Output — Average Response Time by Method

```text
(GET,658.2857)
(POST,1024.0)
```

The average response time is calculated from the 10 dataset rows.

## 3. Apache Hive

Hive is used to query the web server logs using HiveQL.

### Create Database

```sql
CREATE DATABASE IF NOT EXISTS web_log_analytics;
USE web_log_analytics;
```

### Create Table

```sql
CREATE TABLE web_logs_raw (
    ip STRING,
    timestamp STRING,
    method STRING,
    page STRING,
    status INT,
    response_time_ms INT,
    user_agent STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
```

### Hive Output — Total Records

```text
10
```

### Hive Output — HTTP Methods

```text
GET     7
POST    3
```

### Hive Output — HTTP Status

```text
200     7
302     1
404     1
500     1
```

### Hive Output — Page Analysis

```text
/home       3
/login      2
/products   2
/cart       1
/checkout   1
/payment    1
```

### Hive Output — Error Analysis

```text
404     1
500     1
```

## Project Results

| Analysis | Result |
|---|---|
| Total requests | **10** |
| GET requests | **7** |
| POST requests | **3** |
| Successful requests (200) | **7** |
| Redirects (302) | **1** |
| 404 errors | **1** |
| 500 errors | **1** |
| Most accessed page | **/home** |
| Average GET response time | **658.29 ms** |
| Average POST response time | **1024 ms** |

## Key Findings

1. The dataset contains **10 web server requests**.
2. **GET requests** are more frequent than POST requests.
3. **/home** is the most accessed page.
4. There is **one 404 error** and **one 500 server error**.
5. HTTP **200** is the most common response status.
6. POST requests have a higher average response time than GET requests in this sample.
7. Hive and Pig can be used to group and analyze web server logs efficiently.


## Project Screenshots

The following screenshots are grouped and captioned according to what each project execution screen demonstrates. They are the visual evidence for the Hadoop, HDFS, Pig, Hive, partitioning, bucketing, and final-analysis stages described in this project.

### 1. Hadoop Environment Setup

Starting Hadoop services with `start-all.sh` and verifying HDFS/YARN daemons with `jps`.

![Hadoop Environment Setup](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM%20(1).jpeg)

### 2. HDFS Input Directory and Dataset Upload

Creating the HDFS input directory and uploading the web server log dataset.

![HDFS Input Directory and Dataset Upload](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM%20(2).jpeg)

### 3. Pig Environment and Dataset Loading

Loading the web server log data into Pig and defining the input schema.

![Pig Environment and Dataset Loading](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM.jpeg)

### 4. Pig Job Execution

Executing the Pig script and showing Hadoop/MapReduce job processing.

![Pig Job Execution](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.55%20PM%20(1).jpeg)

### 5. Pig Total Record Count

Displaying the total number of records processed by Pig.

![Pig Total Record Count](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.55%20PM.jpeg)

### 6. Pig URL Frequency Analysis

Grouping requests by URL and calculating URL access frequency.

![Pig URL Frequency Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.59%20PM%20(1).jpeg)

### 7. Pig Top URL Results

Displaying the most frequently requested URLs.

![Pig Top URL Results](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.59%20PM.jpeg)

### 8. Pig HTTP Method Analysis

Grouping log records by HTTP method and counting requests.

![Pig HTTP Method Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(1).jpeg)

### 9. Pig 400 Client Error Analysis

Filtering and displaying client-side HTTP errors such as 404 responses.

![Pig 400 Client Error Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(2).jpeg)

### 10. Pig 500 Server Error Analysis

Filtering and displaying server-side HTTP errors such as 500 responses.

![Pig 500 Server Error Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(3).jpeg)

### 11. Pig Error Summary

Reviewing the error-analysis output from the processed logs.

![Pig Error Summary](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM.jpeg)

### 12. Hive Environment Setup

Starting Hive and preparing the web log analysis environment.

![Hive Environment Setup](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(1).jpeg)

### 13. Hive External Table Creation

Creating the external Hive table for the web server log dataset.

![Hive External Table Creation](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(2).jpeg)

### 14. Hive Table Data Verification

Querying the Hive table and viewing stored log records.

![Hive Table Data Verification](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(3).jpeg)

### 15. Hive URL Request Count

Grouping records by URL and calculating request counts.

![Hive URL Request Count](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM.jpeg)

### 16. Hive HTTP Status Analysis

Grouping records by HTTP status code to identify successful and error responses.

![Hive HTTP Status Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(1).jpeg)

### 17. Hive HTTP Method Analysis

Analyzing GET, POST and other HTTP methods using HiveQL.

![Hive HTTP Method Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(2).jpeg)

### 18. Hive Error Analysis

Identifying 404 and 500 error records through Hive queries.

![Hive Error Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(3).jpeg)

### 19. Hive Response-Time Analysis

Analyzing response-time information from the web server logs.

![Hive Response-Time Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM.jpeg)

### 20. Hive Final Query Results

Displaying consolidated Hive query results for the log dataset.

![Hive Final Query Results](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(1).jpeg)

### 21. Hive External Table Execution

Showing successful execution of the Hive external-table/query workflow.

![Hive External Table Execution](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(2).jpeg)

### 22. Partitioning Optimization

Creating or demonstrating Hive partitioning by HTTP status.

![Partitioning Optimization](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(3).jpeg)

### 23. Partitioned Data Analysis

Querying the partitioned Hive data for efficient analysis.

![Partitioned Data Analysis](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM.jpeg)

### 24. Bucketing Optimization

Creating or demonstrating Hive bucketing using the client IP field.

![Bucketing Optimization](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM%20(1).jpeg)

### 25. Bucketed Data Query

Querying bucketed data to demonstrate optimized organization of records.

![Bucketed Data Query](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM%20(2).jpeg)

### 26. Final Analytics Output

Showing final web log analytics results and key findings.

![Final Analytics Output](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM.jpeg)

### 27. Project Execution Evidence

Additional terminal evidence from the completed Hadoop, Pig and Hive workflow.

![Project Execution Evidence](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.05%20PM.jpeg)

### 28. Complete Project Workflow

Final execution evidence covering data processing, analysis and results.

![Complete Project Workflow](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.06%20PM.jpeg)
## Project Files

```text
web-server-log-analytics-hive-pig/
|
├── web_logs.csv
├── web_logs.pig
├── web_logs.hql
└── README.md
```

| File | Description |
|---|---|
| `web_logs.csv` | Web server log dataset |
| `web_logs.pig` | Pig Latin processing and analysis script |
| `web_logs.hql` | HiveQL analysis queries |
| `README.md` | Project documentation |

## Conclusion

This project demonstrates the use of **Hadoop, HDFS, Apache Pig, and Apache Hive** for web server log analytics. Using the 10-record dataset, the project analyzes HTTP methods, response statuses, frequently accessed pages, errors, and response times.

## Team Members

1. Karri Sai Kiran
2. Kolli Tejesh Chowdary
3. Yalamaati Shanmuka Sai
4. Ponnamanda Mohana Lakshmi Srikrishna

## GitHub Repository

**YalamaatiShanmukasai/web-server-log-analytics-hive-pig**

Repository:
https://github.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig

## Project Information

**Project:** Web Server Log Analytics using Hadoop, Hive and Pig  
**Domain:** Big Data Analytics  
**Dataset Size:** 10 Records
