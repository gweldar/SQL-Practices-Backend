select 
	nombre_categoria,
	total_recaudado,
	total_alquileres,
	precio_promedio,
	porcentaje_del_total
	from(
		select
			category.name as nombre_categoria,
			sum(amount)as total_recaudado,
			count(rental.rental_id) as total_alquileres,
			avg(payment.amount) as precio_promedio,
			(sum(payment.amount) / sum(sum(payment.amount))over()) * 100 as porcentaje_del_total
		from category
		inner join film_category on film_category.category_id = category.category_id
		inner join inventory on inventory.film_id = film_category.film_id
		inner join rental on inventory.inventory_id = rental.inventory_id
		inner join payment on payment.rental_id = rental.rental_id
		group by category.name
	) as tabla
	where total_recaudado > 1000
	order by total_recaudado desc;
