
ALTER TABLE courier
ADD COLUMN bonus NUMERIC(10,2) DEFAULT 0;

--מחיקת הערכים התזונתיים של מוצרי הבסיס
delete from groceries_nutrition
where groceries_id <401

--הוספת ערכים תזונתיים לכל מוצרי הבסיס
COPY groceries_nutrition(groceries_id, nutrition_id, value)
FROM 'C:\Users\AviyaTsabari\DB_8570_1828\groceries_nutrition.csv'
DELIMITER ','
CSV HEADER;
