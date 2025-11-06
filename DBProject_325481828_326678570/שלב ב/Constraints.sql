-- Constraints.sql

--  טבלת Family – אילוץ NOT NULL
--שם משפחה לא יכול להיות חסר ערך
ALTER TABLE Family
ALTER COLUMN family_name SET NOT NULL;

--  טבלת FoodBasket – אילוץ DEFAULT
-- ערך ברירת מחדל בסטטוס סל הוא "ממתין"
ALTER TABLE FoodBasket
ALTER COLUMN status SET DEFAULT 'Pending';

--  טבלת Volunteer – אילוץ CHECK
-- בדיקה האם תאריך ההצטרפות של המתנדב הוא תקין- בין שנת 2000 לתאריך הנוכחי
ALTER TABLE Volunteer
ADD CONSTRAINT chk_join_year 
CHECK (joiningdate >= DATE '2020-01-01' AND joiningdate <= CURRENT_DATE);
