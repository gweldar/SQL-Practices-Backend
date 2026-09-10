select
first_name as nombre,
email,
address as direccion
from customer
inner join address on customer.address_id = address.address_id
where address.address_id < 100
order by last_name DESC 

