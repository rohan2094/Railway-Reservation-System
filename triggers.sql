CREATE FUNCTION product_expiration_date()
RETURNS trigger AS $BODY$

BEGIN
IF new.expirationDate > CURRENT_TIMESTAMP THEN
    INSERT INTO Product VALUES (new).*; 
END IF;
RETURN NULL;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER verify_expiration_date BEFORE INSERT OR UPDATE ON Product 
FOR EACH ROW EXECUTE PROCEDURE product_expiration_date();
