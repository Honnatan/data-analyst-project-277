-- Este codigo genera una tabla con las personas que tienen un promedio de ventas por debajo del promedio global.

select	CONCAT(e.first_name, ' ', e.last_name) as seller,
		ROUND(avg(s.quantity * p.price),2) as average_income
from sales s
join employees e 
	on s.sales_person_id = e.employee_id
join products p 
	on s.product_id = p.product_id 
group by concat(e.first_name, ' ', e.last_name)
having ROUND(avg(s.quantity * p.price),2) < (select ROUND(AVG(s.quantity*p.price ),2)
from sales s
join products p
	on s.product_id = p.product_id
)