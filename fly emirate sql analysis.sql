CREATE DATABASE FlightAnalysis;
USE FlightAnalysis

-- 1. creating kpis
--Total Flights
SELECT COUNT(*) AS total_flights
FROM flights_clean;

-- Total Cancelled Flights
SELECT COUNT(*) AS cancelled_flights
FROM flights_clean
WHERE cancelled = 1;

-- Cancellation Rate %
SELECT
ROUND(
    SUM(CAST(cancelled AS INT)) * 100.0 / COUNT(*),
    2
) AS cancellation_rate
FROM flights_clean;




-- Average Arrival Delay

SELECT
ROUND(AVG(arrival_delay),2) AS avg_arrival_delay
FROM flights_clean
WHERE cancelled = 0;

--Average Departure Delay
SELECT
ROUND(AVG(departure_delay),2) AS avg_departure_delay
FROM flights_clean
WHERE cancelled = 0;


--Top 10 Airlines by Total Flights
SELECT top 10
    a.airline,
    COUNT(*) AS total_flights
FROM flights_clean f
JOIN airlines_clean a
    ON f.airline = a.iata_code
GROUP BY a.airline
ORDER BY total_flights DESC;

--Top 10 Airports by Flight Volume
SELECT top 10
    origin_airport,
    COUNT(*) AS total_flights
FROM flights_clean
GROUP BY origin_airport
ORDER BY total_flights DESC;

---- Average Arrival Delay by airlines
SELECT
    a.airline,
    ROUND(AVG(f.arrival_delay),2) AS avg_arrival_delay
FROM flights_clean f
JOIN airlines_clean a
    ON f.airline = a.iata_code
WHERE f.cancelled = 0
GROUP BY a.airline
ORDER BY avg_arrival_delay DESC;


-- Cancellation Rate by airlines 

SELECT
    a.airline,
    ROUND(
        SUM(CAST(f.cancelled AS INT)) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM flights_clean f
JOIN airlines_clean a
    ON f.airline = a.iata_code
GROUP BY a.airline
ORDER BY cancellation_rate DESC;


--Airports with Highest Average Departure Delay

SELECT TOP 10
    origin_airport,
    ROUND(AVG(departure_delay),2) AS avg_departure_delay
FROM flights_clean
WHERE cancelled = 0
GROUP BY origin_airport
ORDER BY avg_departure_delay DESC;

--Delay by Month
SELECT
    month_name,
    ROUND(AVG(arrival_delay),2) AS avg_arrival_delay
FROM flights_clean
WHERE cancelled = 0
GROUP BY month_name
ORDER BY AVG(arrival_delay) DESC;

--Monthly Cancellation Trend
SELECT
    month_name,
    ROUND(
        SUM(CAST(cancelled AS INT))*100.0/
        COUNT(*),
        2
    ) AS cancellation_rate
FROM flights_clean
GROUP BY month_name
ORDER BY cancellation_rate DESC;

--Most Popular Routes

SELECT TOP 10
    origin_airport,
    destination_airport,
    COUNT(*) AS total_flights
FROM flights_clean
GROUP BY
    origin_airport,
    destination_airport
ORDER BY total_flights DESC;



--Busiest Origin Airports
SELECT TOP 10
    origin_airport,
    COUNT(*) AS total_flights
FROM flights_clean
GROUP BY origin_airport
ORDER BY total_flights DESC;

--Airports with Highest Average Departure Delay
SELECT TOP 10
    origin_airport,
    ROUND(AVG(departure_delay),2) AS avg_departure_delay
FROM flights_clean
WHERE cancelled = 0
GROUP BY origin_airport
ORDER BY avg_departure_delay DESC;

--Top 10 Airports with Highest Flights Volume 
SELECT TOP 10
origin_airport,
COUNT(*) AS total_flights
FROM flights_clean
GROUP BY origin_airport
ORDER BY total_flights DESC;
