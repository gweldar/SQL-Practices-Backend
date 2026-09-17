select
	cliente,
	gasto_total,
	primer_alquiler,
	ultimo_alquiler,
	datediff(ultimo_alquiler, primer_alquiler) as dias_como_cliente
from(
	select
		payment.customer_id as cliente,
		sum(amount) as gasto_total,
		min(rental_date) as primer_alquiler,
		max(rental_date) as ultimo_alquiler
	from payment
	inner join rental on rental.rental_id = payment.rental_id
	group by payment.customer_id
)as tabla
order by gasto_total desc 
limit 5;