CREATE TABLE City (
    City_ID INT PRIMARY KEY,
    City_Name VARCHAR(50) NOT NULL,
    Region VARCHAR(50)
);

CREATE TABLE Volunteer (
    Volunteer_ID INT PRIMARY KEY,
    Volunteer_Name VARCHAR(50) NOT NULL,
    JoiningDate DATE,
    City_ID INT REFERENCES City(City_ID)
);

CREATE TABLE Family (
    Family_ID INT PRIMARY KEY,
    Family_Name VARCHAR(50) NOT NULL,
    Number_Of_People INT,
    City_ID INT REFERENCES City(City_ID)
);

CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15)
);

CREATE TABLE Groceries (
    Groceries_ID INT PRIMARY KEY,
    Groceries_Name VARCHAR(50) NOT NULL,
    Unit_Price NUMERIC(8,2)
);

CREATE TABLE Supplier_Groceries (
    Supplier_ID INT REFERENCES Supplier(Supplier_ID),
    Groceries_ID INT REFERENCES Groceries(Groceries_ID),
    OrderPrice NUMERIC(8,2),
    PRIMARY KEY (Supplier_ID, Groceries_ID)
);

CREATE TABLE FoodBasket (
    FoodBasket_ID INT PRIMARY KEY,
    Kind VARCHAR(30),
    Status VARCHAR(20),
    BasketWeight NUMERIC(6,2)
);

CREATE TABLE FoodBasket_Groceries (
    FoodBasket_ID INT REFERENCES FoodBasket(FoodBasket_ID),
    Groceries_ID INT REFERENCES Groceries(Groceries_ID),
    Quantity INT,
    PRIMARY KEY (FoodBasket_ID, Groceries_ID)
);

CREATE TABLE Volunteer_FoodBasket (
    Volunteer_ID INT REFERENCES Volunteer(Volunteer_ID),
    FoodBasket_ID INT REFERENCES FoodBasket(FoodBasket_ID),
    PRIMARY KEY (Volunteer_ID, FoodBasket_ID)
);

CREATE TABLE Family_FoodBasket (
    Family_ID INT REFERENCES Family(Family_ID),
    FoodBasket_ID INT REFERENCES FoodBasket(FoodBasket_ID),
    DateOfReceipt DATE,
    PRIMARY KEY (Family_ID, FoodBasket_ID)
);

