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
