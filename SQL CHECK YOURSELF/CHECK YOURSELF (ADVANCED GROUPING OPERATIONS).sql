--------- CHECK YOURSELF (ADVANCED GROUPING OPERATIONS)

--- Write a query that returns the count of orders of each day between '2020-01-19' and '2020-01-25'. Report the result using Pivot Table.
--- Note: The column names should be day names (Sun, Mon, etc.).
--- (Use SampleRetail DB on SQL Server and paste the result in the answer box.)

SELECT * FROM sale.orders

SELECT *
FROM (
		SELECT order_id, DATENAME(DW, order_date) AS date
		FROM sale.orders
		WHERE order_date >= '2020-01-19' and order_date <= '2020-01-25') A
PIVOT
(
COUNT(order_id)
FOR	date
IN	(
	[Monday],
    [Tuesday],
    [Wednesday],
    [Thursday],
    [Friday],
    [Saturday],
    [Sunday]
	)
) AS PIVOT_TABLE

--- ROW Olarak (Day)
SELECT 
    DATENAME(DW, order_date) AS date, 
    COUNT(order_id) AS count 
FROM sale.orders
    WHERE order_date >= '2020-01-19' and order_date <= '2020-01-25' 
GROUP BY 
    DATENAME(DW, order_date)

--- ROW Olarak (Tarih)
SELECT 
    DATEPART(DAY, order_date) AS date, 
    COUNT(order_id) AS count 
FROM sale.orders
    WHERE order_date >= '2020-01-19' and order_date <= '2020-01-25' 
GROUP BY 
    DATEPART(DAY, order_date)


--- Please write a query to return only the order ids that have an average amount of more than $2000. Your result set should include order_id. 
--- Sort the order_id in ascending order.
--- (Use SampleRetail DB on SQL Server and paste the result in the answer box.)

SELECT * FROM sale.order_item


SELECT order_id, AVG((list_price*(1-discount))*quantity) AS avg_amount
FROM sale.order_item
GROUP BY order_id
HAVING AVG((list_price*(1-discount))*quantity) > 2000
ORDER BY order_id ASC;


