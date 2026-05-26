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