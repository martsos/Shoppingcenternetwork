DELIMITER $$

CREATE TRIGGER after_purchase_item_insert_decrease_inventory
AFTER INSERT ON purchase_items
FOR EACH ROW
BEGIN
    DECLARE v_store_id INT;

    SELECT store_id INTO v_store_id
    FROM purchases
    WHERE purchase_id = NEW.purchase_id;

    UPDATE inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id
      AND store_id = v_store_id;

END$$

DELIMITER ;