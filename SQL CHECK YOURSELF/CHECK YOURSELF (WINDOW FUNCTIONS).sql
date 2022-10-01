


---------- CHECK YOURSELF (WINDOW FUNCTIONS)
--- Write a query using the window function that returns staffs' first name, last name, and their total net amount of orders in descending order.
--- (Use SampleRetail Database and paste your result in the box below.)
SELECT * FROM sale.staff
SELECT * FROM sale.orders
SELECT * FROM sale.order_item

--- GROUP BY ile
SELECT A.first_name, A.last_name, SUM(C.quantity * C.list_price * (1 - C.discount)) AS total_net_amount
FROM sale.staff A, sale.orders B, sale.order_item C
WHERE A.staff_id = B.staff_id 
AND B.order_id = C.order_id
GROUP BY A.first_name, A.last_name
ORDER BY SUM(C.quantity * C.list_price * (1 - C.discount)) DESC;

--- WF ile
SELECT DISTINCT A.first_name, A.last_name, SUM(C.quantity*C.list_price*(1-C.discount)) OVER (PARTITION BY A.staff_id) AS total_net_amount
FROM sale.staff A, sale.orders B, sale.order_item C
WHERE A.staff_id = B.staff_id 
AND B.order_id = C.order_id
ORDER BY 3 DESC;



--- List the employee's first order dates by month in 2020. Expected columns are: first name, last name, month and the first order date. 
--- (last name and month in ascending order)
--- (Use SampleRetail Database and paste your result in the box below.)

--- GROUP BY ile
SELECT A.first_name, A.last_name, MONTH(B.order_date)
FROM sale.staff A, sale.orders B, sale.order_item C
WHERE A.staff_id = B.staff_id 
AND B.order_id = C.order_id
AND YEAR(B.order_date) = 2020
GROUP BY A.first_name, A.last_name, MONTH(B.order_date)
ORDER BY 2,3 ASC;

--- WF ile
SELECT DISTINCT A.first_name, A.last_name,  MONTH(B.order_date) AS month,
FIRST_VALUE(B.order_date) OVER (PARTITION BY A.staff_id, MONTH(B.order_date) ORDER BY B.order_id) AS first_order_date
FROM sale.staff A, sale.orders B, sale.order_item C
WHERE A.staff_id = B.staff_id 
AND B.order_id = C.order_id
AND YEAR(B.order_date) = 2020
ORDER BY 2,3 ASC;

--- Write a query using the window function that returns the cumulative total turnovers of the Burkes Outlet by order date 
--- between "2019-04-01" and "2019-04-30".
--- Columns that should be listed are: 'order_date' in ascending order and 'Cumulative_Total_Price'.

SELECT DISTINCT A.order_date, SUM(B.quantity*B.list_price) OVER (ORDER BY A.order_date) AS Cumulative_Total_Price
FROM sale.orders A, sale.order_item B, sale.store C
WHERE A.order_id = B.order_id 
AND	A.store_id = C.store_id
AND C.store_name= 'Burkes Outlet'
AND A.order_date BETWEEN '2019-04-01' AND '2019-04-30'
ORDER BY 1

--- GROUP BY ile
SELECT DISTINCT A.order_date, SUM(B.quantity*B.list_price) AS total_price
FROM sale.orders A, sale.order_item B, sale.store C
WHERE A.order_id = B.order_id 
AND	A.store_id = C.store_id
AND C.store_name= 'Burkes Outlet'
AND A.order_date BETWEEN '2019-04-01' AND '2019-04-30'
GROUP BY A.order_date
ORDER BY 1

