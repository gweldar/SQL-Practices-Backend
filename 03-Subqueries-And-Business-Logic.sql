select 
	customer.customer_id as id,
	first_name as nombre,
	last_name as apellido,
	sum(payment.amount) as dinero_total
from customer
inner join payment on payment.customer_id = customer.customer_id
group by customer.customer_id, first_name, last_name
having sum(payment.amount) > (
	select avg(dinero_total)
	from (
		select sum(amount) as dinero_total
		from payment
		group by customer_id
	) as tabla_gastos
)
order by dinero_total desc;