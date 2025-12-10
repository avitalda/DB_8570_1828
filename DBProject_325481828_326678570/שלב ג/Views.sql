--מבט מנקודת המבט של האגף המקורי
--משלב FoodBasket + FoodBasket_Groceries + Groceries + Family
--נותן: שם משפחה + מספר סלים + ערך כספי כולל של כל המוצרים שקיבלו.
CREATE VIEW family_basket_summary AS
SELECT 
    f.family_id,
    f.family_name,
    COUNT(DISTINCT fb.foodbasket_id) AS total_baskets,
    COALESCE(SUM(g.unit_price * fbg.quantity), 0) AS total_value
FROM Family f
LEFT JOIN FoodBasket fb ON fb.family_id = f.family_id
LEFT JOIN FoodBasket_Groceries fbg ON fbg.foodbasket_id = fb.foodbasket_id
LEFT JOIN Groceries g ON g.groceries_id = fbg.groceries_id
GROUP BY f.family_id, f.family_name;

--בדיקת המבט
SELECT * 
FROM family_basket_summary

--כל המשפחות שקיבלו סלים בשווי מעל 500 ש"ח
SELECT * 
FROM family_basket_summary
WHERE total_value > 500;

--סידור המשפחות לפי מספר הסלים שקיבלו מהכי הרבה להכי מעט
SELECT *
FROM family_basket_summary
ORDER BY total_baskets DESC;

--מבט מנקודת המבט של האגף שקיבלנו
