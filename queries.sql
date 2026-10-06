-- Este codigo genera una tabla con grupos de edades y cuantas personas hacen parte de ese grupo

with tab as (select	customer_id,
		concat(first_name,' ', last_name) as full_name,
		age,
		case 
			when age between 16 and 25 then '16-25'
			when age between 26 and 40 then '26-40'
			when age > 40 then '40+'
			else 'no category'
		end	age_category
from customers)

select age_category,
	   count(age_category) as age_count
from tab
group by age_category
order by age_category;

-- Este codigo genera una tabla agrupada por fecha que cuenta el numero de clientes unicos en ese mes y el income de ese mes. 

select	TO_CHAR(s.sale_date, 'YYYY-MM') as selling_month, 
		count(DISTINCT(s.customer_id)) as total_customers,
		sum(s.quantity*p.price ) as income
from sales s
join products p
	on s.product_id = p.product_id 
group by TO_CHAR(s.sale_date, 'YYYY-MM')
order by TO_CHAR(s.sale_date, 'YYYY-MM');

-- Este comando cuenta el número total de clientes en la tabla customers
select COUNT(customer_id) as customers_count from customers;

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

-- Codigo para las personas que cuando compraron por primera vez habia promocion

SELECT
    -- s.customer_id,
	concat(c.first_name, ' ', c.last_name ) as customer,
    s.sale_date,
    concat(e.first_name, ' ', e.last_name ) as seller
    
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY sale_date
        ) AS rn
    FROM sales
) s
JOIN products p 
    ON s.product_id = p.product_id
JOIN employees e  
	ON s.sales_person_id  = e.employee_id
JOIN customers c 
	ON s.customer_id = c.customer_id 
WHERE s.rn = 1 AND p.price = 0;
