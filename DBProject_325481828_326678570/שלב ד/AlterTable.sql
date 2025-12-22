-- הוספת עמודת "בונוס" בטבלת "עובדים" 
ALTER TABLE courier
ADD COLUMN bonus NUMERIC(10,2) DEFAULT 0;


--טבלת דירוג עובדים, ע"פ מס הסלים שהם חילקו
CREATE TABLE courier_ranking (
    courier_id INT PRIMARY KEY,
    courier_name TEXT,
    foodbasket_count INT
);
-- פונקציה לעידכון טבלת דירוג עובדים
CREATE OR REPLACE FUNCTION rank_couriers_by_baskets_update()
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- מחיקת כל הרשומות הישנות בטבלת דירוג
    DELETE FROM courier_ranking;

    -- הוספת הדירוג החדש לטבלה
    INSERT INTO courier_ranking(courier_id, courier_name, foodbasket_count)
    SELECT 
        c.courier_id,
        c.courier_name,
        COUNT(f.foodbasket_id) AS foodbasket_count
    FROM courier c
    LEFT JOIN foodbasket f
        ON c.courier_id = f.courier_id 
       AND f.dateofrecepit <= CURRENT_DATE
    GROUP BY c.courier_id, c.courier_name
    ORDER BY foodbasket_count DESC;

END;
$$;

-- הפעלת הפונקציה
SELECT rank_couriers_by_baskets_update();

-- הכנסת ערך סל חדש ע"מ להפעיל את הטריגר
INSERT INTO foodbasket 
    (foodbasket_id, kind, status, basketweight, family_id, courier_id, dateofrecepit)
VALUES 
    (2000, 'restaurant', 'pending', 10.5, 1, 1, NULL);


--מחיקת הערכים התזונתיים של מוצרי הבסיס
delete from groceries_nutrition
where groceries_id <401

--הוספת ערכים תזונתיים לכל מוצרי הבסיס
COPY groceries_nutrition(groceries_id, nutrition_id, value)
FROM 'C:\Users\AviyaTsabari\DB_8570_1828\groceries_nutrition.csv'
DELIMITER ','
CSV HEADER;

--הוספת טבלת יומן תיעוד עבור עדכון סטטוס סל 
CREATE TABLE foodbasket_status_log (
    log_id SERIAL PRIMARY KEY,
    foodbasket_id INT NOT NULL,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
