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

