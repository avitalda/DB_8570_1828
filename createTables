CREATE TABLE City (
    city_id INTEGER PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    region VARCHAR(50)
);

CREATE TABLE Volunteer (
    volunteer_id INTEGER PRIMARY KEY,
    volunteer_name VARCHAR(50) NOT NULL,
    joiningdate DATE,
    city_id INTEGER,
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

CREATE TABLE Family (
    family_id INTEGER PRIMARY KEY,
    family_name VARCHAR(50) NOT NULL,
    number_of_people INTEGER,
    city_id INTEGER,
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

CREATE TABLE FoodBasket (
    foodbasket_id INTEGER PRIMARY KEY,
    kind VARCHAR(30),
    status VARCHAR(20),
    basketweight NUMERIC(6,2),
	family_id INTEGER,
	volunteer_id INTEGER,
	FOREIGN KEY (family_id) REFERENCES Family(family_id),
	FOREIGN KEY (volunteer_id) REFERENCES Volunteer(volunteer_id)
);

CREATE TABLE Groceries (
    groceries_id INTEGER PRIMARY KEY,
    groceries_name VARCHAR(50) NOT NULL,
    unit_price NUMERIC(8,2),
	supplier_id INTEGER,
	FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Supplier (
    supplier_id INTEGER PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15)
);

CREATE TABLE FoodBasket_Groceries (
    foodbasket_id INTEGER,
    groceries_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (foodbasket_id, groceries_id),
    FOREIGN KEY (foodbasket_id) REFERENCES FoodBasket(foodbasket_id),
    FOREIGN KEY (groceries_id) REFERENCES Groceries(groceries_id)
);


