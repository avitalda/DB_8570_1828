###select

###1.
### מציגה את שם המשפחה של מקבל הסל, את העיר שלו, ואת שם המתנדב שחילק את הסל,
###אך רק עבור הסלים שחולקו על ידי מתנדבים שהצטרפו בשנת 2024
SELECT 
    f.family_name,
    v.volunteer_name,
    c.city_name,
FROM foodbasket fb
JOIN family f ON fb.family_id = f.family_id
JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
JOIN city c ON f.city_id = c.city_id
WHERE EXTRACT(YEAR FROM v.joiningdate) = 2024
ORDER BY v.volunteer_id DESC;

###2.
### מציגה את כל הסלים שחולקו בשנת 2025, 
###כולל התאריך בו חולק הסל (ממויין לפי סדר עולה), שם המשפחה של המקבל, שם המתנדב שהעביר את הסל, וסוג הסל.
SELECT 
    f.family_name,
    v.volunteer_name,
    fb.kind,
    fb.dateofreceipt
FROM foodbasket fb
JOIN family f ON fb.family_id = f.family_id
JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
JOIN city c ON f.city_id = c.city_id
WHERE EXTRACT(YEAR FROM fb.dateofreceipt) = 2025
ORDER BY fb.dateofreceipt ASC;

###3.
###כמות המצרכים הכוללת שקבלה כל משפחה.
SELECT 
    f.family_name,
    SUM(fg.quantity) AS total_items,
    COUNT(DISTINCT fb.foodbasket_id) AS baskets_count
FROM family f
JOIN foodbasket fb ON f.family_id = fb.family_id
JOIN foodbasket_groceries fg ON fb.foodbasket_id = fg.foodbasket_id
GROUP BY f.family_name
ORDER BY total_items DESC;

###4.
### רשימת המתנדבים והעיר שלהם , כולל מספר המשפחות שהם עזרו להם ממוין לפי שם המשפחה. 
SELECT 
    v.volunteer_name,
    c.city_name,
    COUNT(DISTINCT fb.family_id) AS families_helped
FROM volunteer v
JOIN city c ON v.city_id = c.city_id
JOIN foodbasket fb ON fb.volunteer_id = v.volunteer_id
GROUP BY v.volunteer_name, c.city_name
ORDER BY families_helped DESC;

###5
###רשימת ספקים שסיפקו סחורה שערכה הכולל מעל לממוצע הכללי של כל הספקים — עם חישוב תת־שאילתא להשוואה לערך ממוצע.
SELECT 
    s.supplier_name,
    ROUND(SUM(g.unit_price * fg.quantity), 2) AS total_value_supplied
FROM Supplier s
JOIN Groceries g ON s.supplier_id = g.supplier_id
JOIN FoodBasket_Groceries fg ON g.groceries_id = fg.groceries_id
GROUP BY s.supplier_name
HAVING SUM(g.unit_price * fg.quantity) > (
    SELECT AVG(total_value)
    FROM (
        SELECT SUM(g2.unit_price * fg2.quantity) AS total_value
        FROM Groceries g2
        JOIN FoodBasket_Groceries fg2 ON g2.groceries_id = fg2.groceries_id
        GROUP BY g2.supplier_id
    ) AS supplier_totals
)
ORDER BY total_value_supplied DESC;


###6
###מציג בכל עיר – כמה מתנדבים יש וכמה סלים נמסרו בפועל (סטטוס 'delivered')
SELECT 
    c.city_name AS city,
    COUNT(DISTINCT v.volunteer_id) AS total_volunteers,
    COUNT(fb.foodbasket_id) AS total_baskets_delivered
FROM city c
JOIN volunteer v ON c.city_id = v.city_id
LEFT JOIN foodbasket fb ON v.volunteer_id = fb.volunteer_id
WHERE fb.status = 'delivered'
GROUP BY c.city_name
ORDER BY total_baskets_delivered DESC;


###7
###מציגה את כל הסלים שעדיין לא נמסרו למרות שעברו 7 ימים ממועד המסירה הצפוי.
אפשר להוסיף דוח מעקב על “משלוחים תקועים” במערכת.
 SELECT 
    fb.foodbasket_id,
    fb.kind,
    fb.status,
    fb.dateofrecepit,
    v.volunteer_name,
    f.family_name,
    (CURRENT_DATE - fb.dateofrecepit) AS days_since_sent
FROM foodbasket fb
JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
JOIN family f ON fb.family_id = f.family_id
WHERE fb.status <> 'delivered'
  AND (CURRENT_DATE - fb.dateofrecepit) > 7
ORDER BY days_since_sent DESC;
   


###8
###






###update
###1.
###מעדכן את הסוג של הסל שתאריך החלוקה המשוער שלו הוא 16\6 (לא משנה באיזה שנה) לסוג "חג"
UPDATE foodbasket
SET kins = 'holiday'
WHERE EXTRACT(MONTH FROM dateofreceipt) = 6
  AND EXTRACT(DAY FROM dateofreceipt) = 16;

###2.
### מעדכנת את הסטטוס של הסלים כך שכל סל שתאריך המסירה המשוער שלו עוד לא היה יעודכן מ'נמסר' ל'ממתין'. (תקינות נתונים)
UPDATE foodbasket
SET status = 'pending'
WHERE dateofrecepit <= CURRENT_DATE
  AND status = 'delivered';

###3.
### פקודת עדכון שמוסיפה לעמודה של dateOfRecepit
###-תאריך המסירה המשוער של סל המזון ערך רנדומלי בין תחילת שנת 2020 לשנת 2026.
UPDATE foodbasket
SET dateofrecepit =
    DATE '2020-01-01' 
    + (floor(random() * ((current_date+365 - DATE '2020-01-01')::int))) * INTERVAL '1 day';












