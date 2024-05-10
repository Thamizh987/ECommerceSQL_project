create table customers (
 customer_id int not null primary key,
 customer_name varchar(50) not null,
 email varchar(50),
 shipping_address varchar(80)
);

create table orders (
 order_id int not null primary key,
 customer_id int not null,
 order_date date not null,
 total_amount decimal not null
);

create table orders_details (
 order_detail_id int not null primary key,
 order_id int not null,
 product_id int not null,
 qty int not null,
 order_price decimal not null
);

create table products (
 product_id int not null primary key,
 product_name varchar(50) not null,
 description varchar(80),
 price decimal not null,
 stock_quantity int
);
INSERT INTO Customers (customer_id, customer_name, email, shipping_address) VALUES
  (1, 'John Smith', 'john.smith@example.com', '123 Main St, Anytown');
  INSERT INTO Customers (customer_id, customer_name, email, shipping_address) VALUES
  (2, 'Jane Doe', 'jane.doe@example.com', '456 Elm St, AnotherTown');
  INSERT INTO Customers (customer_id, customer_name, email, shipping_address) VALUES
  (3, 'Michael Johnson', 'michael.johnson@example.com', '789 Oak St, Somewhere');
  INSERT INTO Customers (customer_id, customer_name, email, shipping_address) VALUES
  (4, 'Emily Wilson', 'emily.wilson@example.com', '567 Pine St, Nowhere');
  INSERT INTO Customers (customer_id, customer_name, email, shipping_address) VALUES
  (5, 'David Brown', 'david.brown@example.com', '321 Maple St, Anywhere');

select * from [dbo].[Customers];

INSERT INTO Products (product_id, product_name, description, price, stock_quantity) values
  (1, 'iPhone X', 'Apple iPhone X, 64GB', 999, 10);
  INSERT INTO Products (product_id, product_name, description, price, stock_quantity) values
  (2, 'Galaxy S9', 'Samsung Galaxy S9, 128GB', 899, 5);
  INSERT INTO Products (product_id, product_name, description, price, stock_quantity) values
  (3, 'iPad Pro', 'Apple iPad Pro, 11-inch', 799, 8);
  INSERT INTO Products (product_id, product_name, description, price, stock_quantity) values
  (4, 'Pixel 4a', 'Google Pixel 4a, 128GB', 499, 12);
  INSERT INTO Products (product_id, product_name, description, price, stock_quantity) values
  (5, 'MacBook Air', 'Apple MacBook Air, 13-inch', 1099, 3);

  select * from Products;

  INSERT INTO Orders (order_id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 0);
  INSERT INTO Orders (order_id, customer_id, order_date, total_amount) values
(2, 2, '2023-02-15', 0);
  INSERT INTO Orders (order_id, customer_id, order_date, total_amount) values
(3, 3, '2023-03-10', 0);
  INSERT INTO Orders (order_id, customer_id, order_date, total_amount) values
(4, 4, '2023-04-05', 0);
  INSERT INTO Orders (order_id, customer_id, order_date, total_amount) values
(5, 5, '2023-05-20', 0);

Select * from Orders;

INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
  (1, 1, 1, 1, 999);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (2, 2, 2, 1, 899);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (3, 3, 3, 2, 799);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (4, 3, 1, 1, 999);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (5, 4, 4, 1, 499);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (6, 4, 4, 1, 499);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (7, 5, 5, 1, 1099);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (8, 5, 1, 1, 999);
 INSERT INTO orders_details (order_detail_id, order_id, product_id, qty, order_price) values
 (9, 5, 3, 1, 799);

 Select * from orders_details;

 update orders set total_amount = (select SUM( qty * order_price ) from orders_details 
 Where orders.order_id=orders_details.order_id );


 // Retrieve the order ID, customer names and total amounts for orders that have a total amount greater than $1000.

 Select customer_name,order_id,total_amount from Customers INNER JOIN orders
 ON Customers.customer_id=orders.customer_id
 WHERE total_amount>1000;

 //Retrieve the total quantity of each product sold.

 SELECT product_name AS Product_Name,qty AS Quantity_Sold FROM products INNER JOIN orders_details
 ON products.product_id = orders_details.product_id;

 /*Retrieve the order details (order ID, product name, quantity) for orders with a
 quantity greater than the average quantity of all orders.*/

 Select Order_ID,Product_Name, Qty
From Orders_Details
Inner Join Products 
On orders_details.product_id=products.product_id
Where Qty> (Select Avg(Qty) From Orders_Details)

// Retrieve the order IDs and the number of unique products included in each order.

SELECT Order_ID, COUNT(DISTINCT Product_ID) AS Unique_Products_SOld
FROM Orders_Details
GROUP BY Order_ID;

// Retrieve the total number of products sold for each month in the year 2023. Display the month along with the total number of products.

SELECT Month(Order_Date) AS Month, 
SUM(Qty) AS Total_Products_Sold 
FROM Orders 
JOIN Orders_Details 
ON Orders.Order_ID = Orders_Details.Order_ID 
WHERE Year(Order_Date) = 2023 
GROUP BY month(Order_Date) ORDER BY Month;

/* Retrieve the total number of products sold for each month in the year 2023
where the total number of products sold were greater than 2. Display the month along with the total number of products.*/

SELECT month(Order_Date) AS Month,
SUM(Qty) AS Total_Products_Sold
FROM Orders JOIN Orders_Details ON Orders.Order_ID = Orders_Details.Order_ID
WHERE YEAR(Order_Date) = 2023
GROUP BY month(Order_Date)
HAVING SUM(Qty) > 2

/* Retrieve the order IDs and the order amount based on the following criteria:

a. If the total_amount > 1000 then ‘High Value’

b. If it is less than or equal to 1000 then ‘Low Value’

c. Output should be — order IDs, order amount and Value */

SELECT order_id, total_amount, 
 CASE 
  WHEN total_amount > 1000 
  THEN 'High Value' 
  ELSE 'Low Value' 
 END AS Value 
FROM Orders;

/* Retrieve the order IDs and the order amount based on the following criteria:

a. If the total_amount > 1000 then ‘High Value’

b. If it is less than 1000 then ‘Low Value’

c. If it is equal to 1000 then ‘Medium Value’

Also, please only print the ‘High Value’ products. Output should be — order IDs, order amount and Value */

SELECT order_id, total_amount, order_value
FROM (
SELECT order_id,
total_amount,
CASE
 WHEN total_amount > 1000 THEN 'High Value'
 WHEN total_amount = 1000 THEN 'Medium Value'
 ELSE 'Low Value'
END AS order_value
FROM Orders) as sub
WHERE order_value = 'High Value';
