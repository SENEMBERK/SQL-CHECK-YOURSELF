---------- CHECK YOURSELF (JOINS & VIEW)

--- Write a query that returns the order date of the product named "Sony - 5.1-Ch. 3D / Smart Blu-ray Home Theater System - Black".
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM product.product
SELECT * FROM sale.orders
SELECT * FROM sale.order_item

SELECT 
    A.product_name,
	B.order_id,
	B.order_date
FROM product.product A
INNER JOIN sale.order_item C
	ON A.product_id = C.product_id
INNER JOIN sale.orders B
	ON B.order_id = C.order_id
WHERE product_name LIKE '%Sony - 5.1-Ch. 3D / Smart Blu-ray Home Theater System - Black%'
ORDER BY B.order_date;



--- Write a query that returns orders of the products branded "Seagate". It should be listed Product names and order IDs of all the products 
--- ordered or not ordered. (order_id in ascending order)
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM product.product
SELECT * FROM product.brand
SELECT * FROM sale.orders
SELECT * FROM sale.order_item

SELECT 
    A.product_name,
	B.brand_name,
	C.order_id
FROM product.product A
INNER JOIN product.brand B
	ON A.brand_id = B.brand_id
INNER JOIN sale.order_item C
	ON A.product_id = C.product_id
WHERE B.brand_name LIKE '%Seagate%';


