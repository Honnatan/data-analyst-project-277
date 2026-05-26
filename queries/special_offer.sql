-- Este codigo genera una tabla con nombre de cliente que haya tenido una oferta junto con la fecha y nombre de vendedor. 

select	concat(c.first_name,' ',c.last_name) as customer,
		s.sale_date as sale_date,
		concat(e.first_name,' ',e.last_name) as seller
from sales s
join products p
	on s.product_id = p.product_id
join employees e 
	on s.sales_person_id = e.employee_id
join customers c 
	on s.customer_id = c.customer_id 
where p.price = 0;