-- Este codigo genera una tabla con los 10 vendedores con mejor Income.

with top10 as (select	s.sales_person_id,
		count(s.sales_person_id) as operations,
		SUM(s.quantity*p.price ) as income
FROM sales s
join products p
	on s.product_id = p.product_id 
group by s.sales_person_id
),

sellers as (select	employee_id,
					concat(first_name,' ',last_name) as seller
			from employees)
			
select	s.seller,
		t.operations,
		income
from top10 t 
join sellers s
	on t.sales_person_id = s.employee_id
order by income desc
limit 10;