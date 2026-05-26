-- Este codigo genera una tabla con los ingresos de los vendedores por dia de la semana. 

select	concat(e.first_name, ' ', e.last_name) as seller,
		TO_CHAR(s.sale_date , 'Day') as day_of_week,
		floor(sum(s.quantity*p.price )) as income
from sales s
join employees e 
	on s.sales_person_id = e.employee_id
join products p
	on s.product_id = p.product_id
group by concat(e.first_name, ' ', e.last_name),TO_CHAR(s.sale_date , 'Day');