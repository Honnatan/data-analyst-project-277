-- Este codigo genera una tabla con los 10 vendedores con mejor Income.

with top10 as (select	sales_person_id,
		count(sales_person_id) as operations,
		SUM(quantity) as income
FROM sales
group by sales_person_id
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