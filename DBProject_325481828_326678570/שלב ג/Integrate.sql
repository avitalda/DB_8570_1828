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
