-- Question 1: Acheieving 1NF
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

SELECT * FROM ProductDetail;

-- Question 2: Achieving 2NF

/*  Split OrderDetails table into two tables
Step 1: Create Orders table to store order specific data*/

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);
-- Step 2: Populate Orders Table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Step 3: Create OrderProducts table 
-- To store product-level details
CREATE TABLE OrderProducts (
    OrderID INT,   -- composite PK with Product
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
-- Step 3: Populate the OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Step 4: Drop the OrderDetails table(Optional)
DROP TABLE OrderDetails;


