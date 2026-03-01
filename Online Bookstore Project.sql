USE onlinebookstore;

select * from books;
SELECT * FROM Customers;
SELECT * FROM Orders;


# 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = "Fiction";

# 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950;

# 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country = "Canada";

# 4) Show orders placed in November 2023:
SELECT * FROM  Orders
WHERE MONTH(Order_Date) = 11 AND YEAR(Order_Date) = 2023;

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

# 5) Retrieve the total stock of books available:
SELECT SUM(Stock) as Total_Stock
FROM Books;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC 
LIMIT 1; 

#  7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;

# 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;

# 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;


# 10) Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY stock ASC
LIMIT 1;

# 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

# Advance Questions : 

# 1) Retrieve the total number of books sold for each genre:
SELECT b.genre, SUM(o.Quantity) as Total_Book_Sold
FROM Books b
JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY  b.genre;


# 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) as Avg_Price 
FROM Books
WHERE genre = "Fantasy";

# 3) List customers who have placed at least 2 orders:
SELECT C.Customer_ID, C.Name, COUNT(O.Order_ID) AS Order_Count
FROM Customers C
JOIN Orders O
ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.Name
HAVING COUNT(O.Order_ID) > 2;


# 4) Find the most frequently ordered book
SELECT O.Order_ID, B.Title, COUNT(O.Order_ID) AS Order_Count
FROM Books b
JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY O.Order_ID, B.Title
ORDER BY Order_Count DESC
LIMIT 1;

# 5) Show the top 3 most expensive books of 'Fantasy' Genre 
SELECT * FROM Books
WHERE genre = "Fantasy"
ORDER BY Price DESC
LIMIT 3;

# 6) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM Books b
JOIN Orders o
ON b.book_id=o.book_id
GROUP BY b.author
ORDER BY Total_Books_Sold DESC;

# 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City, o.Total_Amount as Total_Spent
FROM Customers c	
JOIN Orders o	
ON c.customer_id = o.customer_id
GROUP BY c.City
HAVING SUM(Total_Spent) > 30;

#Alternate
SELECT DISTINCT c.City, o.Total_Amount as Total_Spent
FROM Customers c	
JOIN Orders o	
ON c.customer_id = o.customer_id
WHERE o.Total_Amount > 30;

# 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, 
CAST(ROUND(SUM(o.total_amount), 2) AS DECIMAL(10, 2)) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC 
LIMIT 1;

# 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.Book_ID, b.Title, b.Stock, 
COALESCE(SUM(o.Quantity), 0) AS Order_Quantity, 
b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP bY b.Book_ID, b.Title
ORDER BY b.Book_ID
