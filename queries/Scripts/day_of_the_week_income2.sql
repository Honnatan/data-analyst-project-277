-- Este codigo genera una tabla con los ingresos de los vendedores por dia de la semana. 

select	concat(e.first_name, ' ', e.last_name) as seller,
		TO_CHAR(s.sale_date , 'Day') as day_of_week,
		floor(sum(s.quantity)) as income
from sales s
join employees e 
	on s.sales_person_id = e.employee_id
group by concat(e.first_name, ' ', e.last_name),TO_CHAR(s.sale_date , 'Day');