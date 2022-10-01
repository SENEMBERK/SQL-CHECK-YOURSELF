---------- CHECK YOURSELF (FUNCTIONS)

--- List the product names in ascending order where the part from the beginning to the first space character is "Samsung" in the 
--- product_name column.
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM product.product

SELECT product_name    
FROM product.product
WHERE product_name LIKE 'Samsung %'
ORDER BY product_name;

--- Alternative
SELECT product_name
FROM product.product
WHERE LEFT (product_name, CHARINDEX(' ', product_name)) = 'Samsung'
ORDER BY product_name;

--- SUBSTRING(product_name, CHARINDEX(' ', product_name)+1, LEN(product_name)-CHARINDEX(' ', product_name)) product_brand

--- Write a query that returns streets in ascending order. The streets have an integer character lower than 5 after the "#" character end 
--- of the street. (use sale.customer table)
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT * FROM sale.customer


