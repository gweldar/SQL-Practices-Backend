select 
    id_cliente,
	id_alquiler,
	fecha_alquiler,
	orden_alquiler
	from(
		select
			customer_id as id_cliente,
			rental_id as id_alquiler,
			rental_date as fecha_alquiler,
			row_number() over(partition by customer_id order by rental_date desc) as orden_alquiler
		from rental
		) as tabla_ordem
		where orden_alquiler <= 3
		order by id_cliente asc, fecha_alquiler desc