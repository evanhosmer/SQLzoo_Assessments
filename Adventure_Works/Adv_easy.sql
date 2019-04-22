'''
1) Show the first name and the email address of customer with CompanyName Bike World
'''

SELECT Firstname, EmailAddress
FROM Customer
WHERE CompanyName = 'Bike World'

'''
2) Show the CompanyName for all customers with an address in City Dallas
'''

SELECT CompanyName
FROM Customer
JOIN CustomerAddress
ON Customer.CustomerID = CustomerAddress.CustomerID
JOIN Address
ON Address.AddressID = CustomerAddress.AddressID
WHERE Address.City = 'Dallas'

'''
3 How many items with ListPrice more than $1000 have been sold?
'''

SELECT COUNT(*)
FROM SalesOrderDetail
WHERE UnitPrice > 1000

'''
4) Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
'''

SELECT CompanyName, SubTotal, TaxAmt, Freight
FROM SalesOrderHeader
JOIN Customer
ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE SubTotal > 100000

'''
5) Find the number of left racing socks (Racing Socks, L) ordered by CompanyName Riding Cycles
'''

SELECT OrderQty FROM
(SELECT *
FROM SalesOrderDetail
WHERE ProductID = (SELECT ProductID FROM Product WHERE Name = 'Racing Socks, L')) t1
JOIN
(SELECT * FROM SalesOrderHeader) t2
ON
(t1.SalesOrderID = t2.SalesOrderID)
WHERE CustomerID = (SELECT CustomerID FROM Customer WHERE CompanyName = 'Riding Cycles')
