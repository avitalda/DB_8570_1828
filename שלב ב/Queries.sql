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


### רשימת המתנדבים והעיר שלהם, כולל מספר המשפחות שהם עזרו להם ממוין לפי שם המשפחה. 
SELECT 
    v.volunteer_name,
    c.city_name,
    COUNT(DISTINCT fb.family_id) AS families_helped
FROM volunteer v
JOIN city c ON v.city_id = c.city_id
JOIN foodbasket fb ON fb.volunteer_id = v.volunteer_id
GROUP BY v.volunteer_name, c.city_name
ORDER BY families_helped DESC;

