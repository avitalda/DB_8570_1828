--פרוצדורה שמוסיפה מענק לטבלה "עובד" עבור מתנדב, עפ"י מספר הסלים שחילק

CREATE OR REPLACE PROCEDURE calculate_courier_bonus( IN p_courier_id int)
LANGUAGE plpgsql
AS $$
DECLARE
	p_salary TEXT;
	p_foodbasket_count INT;
	p_bonus NUMERIC(10,2);
	
BEGIN
	SELECT salary
	INTO p_salary
	FROM courier 
	WHERE courier_id = p_courier_id; 

	-- בדיקה האם העובד קיים במאגר
	IF NOT FOUND THEN
			RAISE EXCEPTION 'courier % dosenwt exist', p_courier_id;
	END IF;

	-- בדיקה האם עובד מקבל משכורת או לא
	IF p_salary <> 'N' THEN 
		RAISE NOTICE 'courier % received salary- no bonuse', p_courier_id;
	-- בדיקה כמה סלים המתנדב חילק
	ELSE
		SELECT COUNT(*)
		INTO p_foodbasket_count
		FROM foodbasket
		WHERE courier_id = p_courier_id AND dateofrecepit <= CURRENT_DATE;

		--חישוב מענק
		p_bonus := p_foodbasket_count * 10;

		--עדכון המענק בטבלת העובדים
		UPDATE courier 
		SET bonus = p_bonus
		WHERE courier_id = p_courier_id;

		RAISE NOTICE 'courier % received bonuse', p_courier_id;
		
	END IF;
-- טיפול בשגיאות
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE NOTICE 'ERROR: %', SQLERRM;

END;
$$;
























--פרוצדורה שמוסיפה מענק לטבלה "עובד" עבור מתנדב, עפ"י מספר הסלים שחילק
   
    CREATE OR REPLACE PROCEDURE calculate_courier_bonus( IN p_courier_id int)
      
    LANGUAGE plpgsql
      
    AS $$
      
    DECLARE
      
      p_salary TEXT;

      p_foodbasket_count INT;

      p_bonus NUMERIC(10,2);

      
    BEGIN
      
      SELECT salary
      
      INTO p_salary
      
      FROM courier 
      
      WHERE courier_id = p_courier_id;

    
      -- בדיקה האם העובד קיים במאגר
    
      IF NOT FOUND THEN
        
          RAISE EXCEPTION 'courier % dosenwt exist', p_courier_id;

      END IF;

    
      -- בדיקה האם עובד מקבל משכורת או לא
    
        IF p_salary <> 'N' THEN 
        
        RAISE NOTICE 'courier % received salary- no bonuse', p_courier_id;

    
    -- בדיקה כמה סלים המתנדב חילק
     
        ELSE
        
        SELECT COUNT(*)
        
        INTO p_foodbasket_count
        
        FROM foodbasket
        
        WHERE courier_id = p_courier_id AND dateofrecepit <= CURRENT_DATE;

    
        --חישוב מענק
       
        p_bonus := p_foodbasket_count * 10;

    
        --עדכון המענק בטבלת העובדים
      
        UPDATE courier 
          
        SET bonus = p_bonus
          
        WHERE courier_id = p_courier_id;

    
        RAISE NOTICE 'courier % received bonuse', p_courier_id;

        
      END IF;

    -- טיפול בשגיאות
    
    EXCEPTION
      
      WHEN OTHERS THEN
      
        ROLLBACK;

        RAISE NOTICE 'ERROR: %', SQLERRM;

    
    END;

    $$;

