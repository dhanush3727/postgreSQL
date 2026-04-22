-- Stored Procedure
CREATE PROCEDURE create_order(id INT, item TEXT)
LANGUAGE plpgsql -- This is the procedural language for PostgreSQL
AS $$ -- Delimiter for the procedure body
BEGIN
	INSERT INTO orders(customer_id, product)
	VALUES (id, item);
END;
$$;

CALL create_order(2, 'HandBag');
SELECT * FROM orders;

-- Functions
CREATE FUNCTION get_orders_by_user(u_id INT)
RETURNS INT -- specify data type
LANGUAGE plpgsql
AS $$
DECLARE total INT; -- variable declaration
BEGIN 
	SELECT COUNT(*) INTO total FROM orders
	WHERE customer_id = u_id;

	RETURN total;
END;
$$;

SELECT get_orders_by_user(2);