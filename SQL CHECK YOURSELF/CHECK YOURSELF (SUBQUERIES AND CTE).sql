---------- CHECK YOURSELF (SUBQUERIES AND CTE)

--- List the store names in ascending order that did not have an order between "2018-07-22" and "2018-07-28".
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM sale.store
SELECT * FROM sale.orders

SELECT store_name
FROM sale.store
WHERE store_id NOT IN (
						SELECT A.store_id
						FROM sale.store A, sale.orders B
						WHERE A.store_id = B.store_id
						AND	B.order_date BETWEEN '2018-07-22' AND '2018-07-28')
ORDER BY store_name ASC;
	

--- List customers with each order over 500$ and reside in the city of Charleston. List customers' first name and last name 
--- (both of the last name and first name in ascending order). 
--- (Use SampleRetail Database and paste your result in the box below.)
SELECT * FROM sale.customer


--- --
SELECT DISTINCT x.customer_id, x.first_name, x.last_name
FROM (
	SELECT A.customer_id, A.first_name, A.last_name
	FROM sale.customer A, sale.orders B, sale.order_item C
	WHERE A.customer_id = B.customer_id
	AND A.city = 'Charleston'
	) x
WHERE NOT EXISTS (
				  SELECT A.customer_id, C.order_id, SUM(quantity*list_price) sum_price
				  FROM sale.customer A, sale.orders B, sale.order_item C
				  WHERE  A.customer_id = B.customer_id
				  AND B.order_id = C.order_id
				  AND x.customer_id = A.customer_id
				  GROUP BY A.customer_id, C.order_id
				  HAVING SUM(quantity*list_price) < 500
				  )
ORDER BY 2,1


