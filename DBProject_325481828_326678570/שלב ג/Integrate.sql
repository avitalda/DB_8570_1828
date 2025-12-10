--הכנסה ערים חדשות לטבלת ערים, ע"פ טבלת השליחים
INSERT INTO city (city_id, city_name, region)
SELECT
    400 + ROW_NUMBER() OVER (ORDER BY courier_id) AS city_id,
    area AS city_name,
    NULL AS region
FROM courier  AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM city ci
    WHERE ci.city_name = c.area
);

--הכנסה ערים חדשות לטבלת ערים, ע"פ טבלת הצרכנים
INSERT INTO city (city_id, city_name, region)
SELECT
    450 + ROW_NUMBER() OVER (ORDER BY customer_id) AS city_id,
    area AS city_name,
    NULL AS region
FROM customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM city ci
    WHERE ci.city_name = c.area
);

-- הוספת תכונה עבור שכר או התנדבות בטבלה מתנדב
ALTER TABLE volunteer
ADD COLUMN salary TEXT DEFAULT 'N';

ALTER TABLE courier
ADD COLUMN salary TEXT DEFAULT 'Y';


--אינטגרציה בין טבלת שליחים לטבלת מתנדבים, מכניסים לטבלת מתנדבים
INSERT INTO volunteer (volunteer_id, volunteer_name, joiningdate, city_id, salary)
SELECT
    400 + ROW_NUMBER() OVER (ORDER BY c.courier_id) AS id,
	c.name,
	NULL AS joiningdate,
	ci.city_id,
	c.salary
FROM courier AS c
JOIN city ci ON ci.city_name = c.area
WHERE NOT EXISTS (
    SELECT 1
    FROM volunteer v
    WHERE v.volunteer_name = c.name
);

--עדכון שמות לצורך נוחות וכדי שיהיה תואם ל ERD
ALTER TABLE courier RENAME TO courier1;
ALTER TABLE volunteer RENAME TO courier;
ALTER TABLE courier RENAME COLUMN volunteer_id TO courier_id;
ALTER TABLE courier RENAME COLUMN volunteer_name TO courier_name;

--הוספת תכונות: תאריך יום הולדת ופרטי תשלום עבור המשפחות מהארגון
ALTER TABLE family
ADD COLUMN date_of_birth DATE DEFAULT NULL;

ALTER TABLE family
ADD COLUMN payment_details TEXT DEFAULT 'free';

--אינטגרציה בין טבלת משפחות לטבלת לקוחות, מכניסים לטבלת משפחות
INSERT INTO family (family_id, family_name, number_of_people, city_id, date_of_birth, payment_details)
SELECT
    400 + ROW_NUMBER() OVER (ORDER BY c.customer_id) AS id,
	c.name,
	NULL AS number_of_people,
	ci.city_id,
	c.date_of_birth,
	c.payment_details
FROM customer AS c
JOIN city ci ON ci.city_name = c.area
WHERE NOT EXISTS (
    SELECT 1
    FROM family f
    WHERE f.family_name = c.name
);

--שינוי שם עמודה בטבלת סלי מזון, מת"ז מתנדב לת"ז שליח
ALTER TABLE foodbasket RENAME COLUMN volunteer_id TO courier_id;


--אינטגרציה בין טבלת סלי מזון לטבלת הזמנה, מכניסים לטבלת סלי מזון
INSERT INTO foodbasket (foodbasket_id, kind, status, basketweight, dateofrecepit, family_id, courier_id)
SELECT
    400 + ROW_NUMBER() OVER (ORDER BY o.order_id) AS id,
	'restaurant' AS kind,
	'pending' AS status,
	NULL AS bastetweight,
	o.order_date,
	o.customer_id AS family_id,
	o.courier_id AS courier_id
FROM "order" AS o;

--אינטגרציה בין מצרכים לארוחות
--מה שמבדיל בינהן זה התכונה type
-- 1. מוסיפים עמודה חדשה 
ALTER TABLE groceries
ADD COLUMN type char(1);

-- 2. כל הרשומות הקיימות ב-groceries יקבלו type = 'B'
UPDATE groceries
SET type = 'B';

-- 3. מונעים ערכים לא תקינים + דורשים שהעמודה לא תהיה NULL
ALTER TABLE groceries
ALTER COLUMN type SET NOT NULL,
ADD CONSTRAINT groceries_type_chk
CHECK (type IN ('B', 'D'));

--הוספת העמודה area לטבלת supplier
ALTER TABLE supplier
ADD COLUMN area varchar(255) DEFAULT NULL;

--הכנסת נתונים של מסעדה לטבלת הספקים
INSERT INTO supplier (supplier_id, supplier_name, phone_number, area)
SELECT restaurant_id + 400,
       name,
       NULL,         -- אין לנו phone_number במסעדה, אז NULL
       area
FROM restaurant;

--הוספת עמודה של מזהה קטגוריה במצרכים
ALTER TABLE groceries
ADD COLUMN category_id bigint DEFAULT NULL;  

--מפתח זר לטבלת category:
ALTER TABLE groceries
ADD CONSTRAINT groceries_category_fk
FOREIGN KEY (category_id)
REFERENCES category(category_id);

--מחיקת מזהה ספק ממצטרכים
ALTER TABLE groceries
DROP CONSTRAINT IF EXISTS groceries_supplier_id_fkey;

ALTER TABLE groceries
DROP COLUMN supplier_id;


--הוספת ארוחות לטבלת מצרכים
INSERT INTO groceries (groceries_id,groceries_name, unit_price, type, category_id)
SELECT d.dish_id + 400 ,
       d.name,
       d.price,
       'D',
	   d.category_id
FROM dish d

--שינוי שם הטבלה
--supplier_groceries ל- menu_item מ- 
ALTER TABLE menu_item
RENAME TO supplier_groceries;

--שינוי שם עמודה "restaurant_id" → "supplier_id"
ALTER TABLE supplier_groceries
RENAME COLUMN restaurant_id TO supplier_id;

--שינוי שם עמודה "dish_id" → "groceries_id"
ALTER TABLE supplier_groceries
RENAME COLUMN dish_id TO groceries_id;

--הסרת מפתחות זרים כפי שהיו לפני השינוי
--הסרת מפתח זר של מזהה ארוחה
ALTER TABLE supplier_groceries
DROP CONSTRAINT IF EXISTS menu_item_dish_id_fkey;

--הסרת מפתח זר של מזהה מסעדה
ALTER TABLE supplier_groceries
DROP CONSTRAINT IF EXISTS menu_item_restaurant_id_fkey;

--הוספת מפתח זר של מזהה ספק
ALTER TABLE supplier_groceries
ADD CONSTRAINT supplier_groceries_supplier_fk
FOREIGN KEY (supplier_id)
REFERENCES supplier(supplier_id);

--הוספת מפתח זר של מזהה מצרך
ALTER TABLE supplier_groceries
ADD CONSTRAINT supplier_groceries_groceries_fk
FOREIGN KEY (groceries_id)
REFERENCES groceries(groceries_id);

--ליצור טבלת stage לטעינת ה־CSV
CREATE TABLE supplier_groceries_stage (
    supplier_id  int,
    groceries_id int,
    amount       numeric(10,2)
);

--מעדכנת את הטבלה הקודמת למזהים העדכניים שעשינו בבסיס נתונים החדש
UPDATE supplier_groceries
SET supplier_id = supplier_id + 400,
    groceries_id = groceries_id + 400
WHERE supplier_id BETWEEN 1 AND 40;

--העתקת נתונים מקובץ CSV 
--בדיוק אותם נתונים בטבלה הקודמת בין ספק למוצר עם ערך כמות רנדומלי
copy supplier_groceries_stage  (supplier_id,groceries_id, amount)
FROM 'C:\Users\AviyaTsabari\DB_8570_1828\groceries2_with_amount.csv'
WITH (FORMAT csv);

--להוסיף רק שורות חדשות לטבלה supplier_groceries (רק מה שאין התנגשות)
INSERT INTO supplier_groceries (supplier_id, groceries_id, amount)
SELECT sgs.supplier_id,
       sgs.groceries_id,
       sgs.amount
FROM supplier_groceries_stage sgs
ON CONFLICT (supplier_id, groceries_id) DO NOTHING;

--foodbasket_groceries ו order_item איחוד בין הטבלאות 
INSERT INTO foodbasket_groceries (foodbasket_id, groceries_id, quantity)
SELECT
	oi.order_id AS foodbasket_id,
	oi.dish_id AS groceries_id,
	oi.quantity AS quantity
FROM order_item AS oi

--שינו שם הטבלה מ"ארוחה-ערך תזונתי" ל"מוצרים- ערך תזונתי"
ALTER TABLE dish_nutrition
RENAME TO groceries_nutrition;

--שינוי שם עמודה ממזהה ארוחה למזהה מצרך
ALTER TABLE groceries_nutrition
RENAME COLUMN dish_id TO groceries_id;

-- הסרת מפתח ראשי לשינוי מזהים בטבלה groceries_nutrition
ALTER TABLE groceries_nutrition
DROP CONSTRAINT dish_nutrition_dish_id_fkey;

-- עדכון מזהה המצרך למזהה המצרך+400, כדי שנהיה עיקביים במספר המזהה בין כל הטבלאות בטבלה groceries_nutrition
UPDATE groceries_nutrition
SET groceries_id = groceries_id + 400;

--יצירת ה־foreign key מחדש שמצביע על groceries בטבלה groceries_nutrition
ALTER TABLE groceries_nutrition
ADD CONSTRAINT groceries_nutrition_groceries_id_fkey
FOREIGN KEY (groceries_id)
REFERENCES groceries(groceries_id)
ON DELETE CASCADE;


--הוספת רשומות חסרות עם ערכים רנדומליים בטבלה groceries_nutrition
INSERT INTO groceries_nutrition (groceries_id, nutrition_id, value)
SELECT 
    g.groceries_id,
    1 AS nutrition_id,  -- או מספר nutrition_id רלוונטי
    (floor(random() * 100) + 1) AS value
FROM groceries g
LEFT JOIN groceries_nutrition gn ON gn.groceries_id = g.groceries_id
WHERE gn.groceries_id IS NULL;
