-- Este codigo genera una tabla con las personas que tienen un promedio de ventas por debajo del promedio global.

select	concat(e.first_name, ' ', e.last_name) as seller,
		round(avg(s.quantity ),2) as average_income
from sales s
join employees e 
	on s.sales_person_id = e.employee_id
group by concat(e.first_name, ' ', e.last_name)
having round(avg(s.quantity ),2) < (select ROUND(AVG(quantity),2)
from sales
)