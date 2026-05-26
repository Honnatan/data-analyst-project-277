-- Este codigo genera una tabla agrupada por fecha que cuenta el numero de clientes unicos en ese mes y el income de ese mes. 

select	TO_CHAR(s.sale_date, 'YYYY-MM') as selling_month, 
		count(DISTINCT(s.customer_id)) as total_customers,
		sum(s.quantity*p.price ) as income
from sales s
join products p
	on s.product_id = p.product_id 
group by TO_CHAR(s.sale_date, 'YYYY-MM')
order by TO_CHAR(s.sale_date, 'YYYY-MM');