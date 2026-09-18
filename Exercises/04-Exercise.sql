select
	categoria,
	total_alquileres,
	ingresos_totales,
	precio_promedio_alquiler,
	costo_reemplazo_inventario
from(
	select
		name as categoria,
		count(rental.rental_id) as total_alquileres,
		sum(payment.amount) as ingresos_totales,
		avg(payment.amount) as precio_promedio_alquiler,
		sum(film.replacement_cost) as costo_reemplazo_inventario
		from category
		inner join film_category on film_category.category_id = category.category_id
		inner join film on film.film_id = film_category.film_id
		inner join inventory on inventory.film_id = film.film_id
		inner join rental on rental.inventory_id = inventory.inventory_id
		inner join payment on payment.rental_id = rental.rental_id
		group by category.category_id
) as tabla
where ingresos_totales> 3000
order by ingresos_totales desc 