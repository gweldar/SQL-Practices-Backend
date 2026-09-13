select
cliente,
fecha_pago,
importe,
importe_anterior,
total_gastado
from(
select
customer_id as cliente,
payment_date as fecha_pago,
amount as importe,
lag(amount) over (partition by customer_id order by payment_date asc) as importe_anterior,
sum(amount) over (partition by customer_id order by payment_date asc) as total_gastado
from payment
) as subconsulta_gastos
where total_gastado >= 30 