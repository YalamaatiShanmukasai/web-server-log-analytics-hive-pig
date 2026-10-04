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

The repository includes the project execution screenshots uploaded as JPEG files. They provide visual evidence of the Hadoop, Pig, Hive, analysis, and project execution work.

### Screenshot 1

![Project Screenshot 1](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM%20(1).jpeg)

### Screenshot 2

![Project Screenshot 2](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM%20(2).jpeg)

### Screenshot 3

![Project Screenshot 3](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.54%20PM.jpeg)

### Screenshot 4

![Project Screenshot 4](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.55%20PM%20(1).jpeg)

### Screenshot 5

![Project Screenshot 5](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.55%20PM.jpeg)

### Screenshot 6

![Project Screenshot 6](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.59%20PM%20(1).jpeg)

### Screenshot 7

![Project Screenshot 7](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.09.59%20PM.jpeg)

### Screenshot 8

![Project Screenshot 8](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(1).jpeg)

### Screenshot 9

![Project Screenshot 9](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(2).jpeg)

### Screenshot 10

![Project Screenshot 10](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM%20(3).jpeg)

### Screenshot 11

![Project Screenshot 11](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.00%20PM.jpeg)

### Screenshot 12

![Project Screenshot 12](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(1).jpeg)

### Screenshot 13

![Project Screenshot 13](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(2).jpeg)

### Screenshot 14

![Project Screenshot 14](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM%20(3).jpeg)

### Screenshot 15

![Project Screenshot 15](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.01%20PM.jpeg)

### Screenshot 16

![Project Screenshot 16](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(1).jpeg)

### Screenshot 17

![Project Screenshot 17](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(2).jpeg)

### Screenshot 18

![Project Screenshot 18](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM%20(3).jpeg)

### Screenshot 19

![Project Screenshot 19](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.02%20PM.jpeg)

### Screenshot 20

![Project Screenshot 20](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(1).jpeg)

### Screenshot 21

![Project Screenshot 21](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(2).jpeg)

### Screenshot 22

![Project Screenshot 22](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM%20(3).jpeg)

### Screenshot 23

![Project Screenshot 23](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.03%20PM.jpeg)

### Screenshot 24

![Project Screenshot 24](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM%20(1).jpeg)

### Screenshot 25

![Project Screenshot 25](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM%20(2).jpeg)

### Screenshot 26

![Project Screenshot 26](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.04%20PM.jpeg)

### Screenshot 27

![Project Screenshot 27](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.05%20PM.jpeg)

### Screenshot 28

![Project Screenshot 28](https://raw.githubusercontent.com/YalamaatiShanmukasai/web-server-log-analytics-hive-pig/main/WhatsApp%20Image%202026-10-04%20at%208.10.06%20PM.jpeg)
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
