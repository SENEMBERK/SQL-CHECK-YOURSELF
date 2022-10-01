---------- CHECK YOURSELF (CASE EXPRESSION)

--- List counts of orders on the weekend and weekdays. (First weekend)
--- (Use SampleRetail Database and paste your result in the box below.)

SELECT COUNT(order_id) TotalOrders,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Saturday' THEN 1 END) Saturday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Sunday' THEN 1 END) Sunday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Monday' THEN 1 END) Monday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Tuesday' THEN 1 END) Tuesday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Wednesday' THEN 1 END) Wednesday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Thursday' THEN 1 END) Thursday,
	   COUNT(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Friday' THEN 1 END) Friday 
FROM sale.orders

--- Alternative


SELECT *
FROM (
	SELECT	CASE 
			WHEN DATENAME(weekday, order_date) IN ('SATURDAY', 'SUNDAY') THEN 'WEEKEND' ELSE 'WEEKDAY' END WEEKD, order_id
	FROM SALE.orders
	) A
PIVOT
(
COUNT (order_id)
FOR WEEKD
IN ([weekend], [weekday])
) AS pivot_table


--- Classify staff according to the count of orders they receive as follows:
--- a) 'High-Performance Employee' if the number of orders is greater than 400
--- b) 'Normal-Performance Employee' if the number of orders is between 100 and 400
--- c) 'Low-Performance Employee' if the number of orders is between 1 and 100
--- d) 'No Order' if the number of orders is 0
--- Then, list the staff's first name, last name, employee class, and count of orders.  (Count of orders and first names in ascending order)

SELECT * FROM sale.staff
SELECT * FROM sale.orders

SELECT	A.staff_id, 
		A.first_name, 
		A.last_name,
		COUNT(B.order_id) AS order_count,
		CASE 
			WHEN COUNT(B.order_id) > 400 THEN 'High-Performance Employee'
			WHEN COUNT(B.order_id) > 100 AND COUNT(B.order_id) <= 400 THEN 'Normal_Performance_Employee'
			WHEN COUNT(B.order_id) >= 1 AND COUNT(B.order_id) <= 400 THEN 'Low_Performance_Employee'
			WHEN COUNT(B.order_id) = 0 THEN 'No_Order'			
		END employee_class
FROM sale.staff A
LEFT JOIN sale.orders B
ON A.staff_id = B.staff_id
GROUP BY A.staff_id, A.first_name, A.last_name
ORDER BY COUNT(B.order_id)


SELECT	A.staff_id, 
		A.first_name, 
		A.last_name,
		COUNT(DISTINCT B.order_id) AS order_count
FROM sale.staff A
LEFT JOIN sale.orders B
ON A.staff_id = B.staff_id
GROUP BY A.staff_id, A.first_name, A.last_name
ORDER BY COUNT(B.order_id)

--- Alternative

select first_name, last_name, 
case when cnt_order > 400 then 'High-Performance Employee'
 when cnt_order between 100 and 400 then 'Normal-Performance Employee'
  when cnt_order between 1 and 100 then 'Low-Performance Employee'
 else 'No Order' end as employeeclass, cnt_order
from
(
SELECT	a.staff_id, a.first_name, a.last_name, count(b.order_id) cnt_order
FROM	SALE.staff A left join SALE.orders B
on	A.staff_id = b.staff_id 
group by a.staff_id,a.first_name, a.last_name
) a
order by cnt_order, first_name

