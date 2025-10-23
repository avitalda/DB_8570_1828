
SELECT * FROM City;
SELECT * FROM Volunteer;
SELECT * FROM Family;
SELECT * FROM Supplier;
SELECT * FROM Groceries;
SELECT * FROM Supplier_Groceries;
SELECT * FROM FoodBasket;
SELECT * FROM FoodBasket_Groceries;
SELECT * FROM Volunteer_FoodBasket;
SELECT * FROM Family_FoodBasket;

SELECT COUNT(*) AS City_Count FROM City;
SELECT COUNT(*) AS Volunteer_Count FROM Volunteer;
SELECT COUNT(*) AS Family_Count FROM Family;
SELECT COUNT(*) AS Supplier_Count FROM Supplier;
SELECT COUNT(*) AS Groceries_Count FROM Groceries;
SELECT COUNT(*) AS Supplier_Groceries_Count FROM Supplier_Groceries;
SELECT COUNT(*) AS FoodBasket_Count FROM FoodBasket;
SELECT COUNT(*) AS FoodBasket_Groceries_Count FROM FoodBasket_Groceries;
SELECT COUNT(*) AS Volunteer_FoodBasket_Count FROM Volunteer_FoodBasket;
SELECT COUNT(*) AS Family_FoodBasket_Count FROM Family_FoodBasket;
