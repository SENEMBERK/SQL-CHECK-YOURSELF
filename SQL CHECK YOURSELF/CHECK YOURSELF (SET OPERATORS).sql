---------- CHECK YOURSELF (SET OPERATORS)

--- Detect the store that does not have a product named "Samsung Galaxy Tab S3 Keyboard Cover" in its stock. (Paste the store name in 
--- the box below.)
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM product.stock
SELECT * FROM product.product
SELECT * FROM sale.store

SELECT product_id 
FROM product.product
WHERE product_name = 'Samsung Galaxy Tab S3 Keyboard Cover'

SELECT store_name
FROM sale.store
WHERE store_id NOT IN (
						SELECT A.store_id
						FROM sale.store A, product.stock B
						WHERE A.store_id = B.store_id
						AND B.product_id = 320)

)

--- Alternative
SELECT store_id, store_name
FROM sale.store
EXCEPT
SELECT A.store_id, store_name
FROM sale.store A, product.stock B, product.product C
WHERE A.store_id = B.store_id
AND B.product_id = C.product_id
AND C.product_name = 'Samsung Galaxy Tab S3 Keyboard Cover'


--- List in ascending order the stores where both "Samsung Galaxy Tab S3 Keyboard Cover" and "Apple - Pre-Owned iPad 3 - 64GB - Black" 
--- are stocked.
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT product_id 
FROM product.product
WHERE product_name = 'Apple - Pre-Owned iPad 3 - 64GB - Black'

SELECT store_name
FROM sale.store
WHERE store_id IN (
				   SELECT A.store_id
				   FROM sale.store A, product.stock B, product.product C
				   WHERE A.store_id = B.store_id
						AND B.product_id = C.product_id
						AND C.product_name = 'Samsung Galaxy Tab S3 Keyboard Cover'
				   INTERSECT
				   SELECT A.store_id
				   FROM sale.store A, product.stock B, product.product C
				   WHERE A.store_id = B.store_id
						AND B.product_id = C.product_id
						AND C.product_name = 'Apple - Pre-Owned iPad 3 - 64GB - Black')
ORDER BY store_name;

