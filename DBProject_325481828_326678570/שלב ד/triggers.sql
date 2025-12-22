--פונקציה שרושמת ביומן רשומה של העדכון שהתבצע
CREATE OR REPLACE FUNCTION log_foodbasket_status_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- נרשם רק אם הסטטוס באמת השתנה
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO foodbasket_status_log
        (foodbasket_id, old_status, new_status)
        VALUES
        (OLD.foodbasket_id, OLD.status, NEW.status);
    END IF;

    RETURN NEW;
END;
$$;

-- בכל פעם שמתעדכן סטטוס של סל log_foodbasket_status_change טריגר שמפעיל את הפונקציה
CREATE TRIGGER trg_log_foodbasket_status_change
AFTER UPDATE OF status
ON foodbasket
FOR EACH ROW
EXECUTE FUNCTION log_foodbasket_status_change();




-- פונ שמעדכנת בטבלה את הדירוג החדש של העובד 
CREATE OR REPLACE FUNCTION update_courier_ranking() 
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$

BEGIN
	-- מחיקת הרשומות הישנות
	DELETE FROM courier_ranking WHERE courier_id = NEW.courier_id;

	-- הוספת הדירוג המעודכן
	INSERT INTO courier_ranking(courier_id, courier_name, foodbasket_count)
	SELECT 
		c.courier_id,
		c.courier_name,
		count (f.foodbasket_id) 
	FROM courier c
	LEFT JOIN foodbasket f
		  ON c.courier_id = f.courier_id 
	WHERE c.courier_id = NEW.courier_id
	GROUP BY c.courier_id, c.courier_name;
   
   RETURN NEW;
END;
$$

-- בכל פעם שמתבצע שיוך של עובד לסל update_courier_ranking טריגר שמפעיל את הפונקציה   
CREATE TRIGGER trg_update_courier_ranking
AFTER INSERT OR UPDATE ON foodbasket
FOR EACH ROW
EXECUTE FUNCTION update_courier_ranking();


