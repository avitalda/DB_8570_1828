INSERT INTO City VALUES
(1, 'Jerusalem', 'Center'),
(2, 'Tel Aviv', 'Center'),
(3, 'Haifa', 'North');

INSERT INTO Volunteer VALUES
(1, 'Avi Cohen', DATE '2023-01-10', 1),
(2, 'Dana Levi', DATE '2022-05-14', 2),
(3, 'Noam Ben Ami', DATE '2024-02-20', 3);

INSERT INTO Family VALUES
(1, 'Rosen Family', 4, 1),
(2, 'Shalev Family', 6, 2),
(3, 'Baruch Family', 5, 3);

INSERT INTO Supplier VALUES
(1, 'FreshMarket Ltd', '054-7777777'),
(2, 'Tnuva', '03-1234567'),
(3, 'Supersal', '050-3334444');

INSERT INTO Groceries VALUES
(1, 'Rice', 6.50),
(2, 'Pasta', 4.20),
(3, 'Oil', 12.00);

INSERT INTO Supplier_Groceries VALUES
(1, 1, 6.00),
(2, 2, 4.00),
(3, 3, 11.50);

INSERT INTO FoodBasket VALUES
(1, 'Basic', 'Ready', 15.2),
(2, 'Family', 'Pending', 25.8),
(3, 'Holiday', 'Delivered', 30.0);

INSERT INTO FoodBasket_Groceries VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1);

INSERT INTO Volunteer_FoodBasket VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Family_FoodBasket VALUES
(1, 1, DATE '2024-02-01'),
(2, 2, DATE '2024-03-12'),
(3, 3, DATE '2024-04-10');
