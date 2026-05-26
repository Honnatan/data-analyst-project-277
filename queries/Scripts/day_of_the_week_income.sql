-- Este codigo genera una tabla con los ingresos de los vendedores por dia de la semana. 

with day_inc as (select	concat(e.first_name, ' ', e.last_name) as seller,
		s.sale_date as day_of_week,
		floor(sum(s.quantity)) as income
from sales s
join employees e 
	on s.sales_person_id = e.employee_id
group by concat(e.first_name, ' ', e.last_name),s.sale_date)

select	seller,
		TO_CHAR(day_of_week, 'Day') as day_of_week,
		income
from day_inc;