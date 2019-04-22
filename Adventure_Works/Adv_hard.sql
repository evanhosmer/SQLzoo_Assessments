'''
11) For every customer with a Main Office in Dallas show AddressLine1 of the Main Office and AddressLine1 of the
Shipping address - if there is no shipping address leave it blank. Use one row per customer.
'''

SELECT
  Customer.CompanyName,
  MAX(CASE WHEN AddressType = 'Main Office' THEN AddressLine1 ELSE '' END) AS 'Main Office Address',
  MAX(CASE WHEN AddressType = 'Shipping' THEN AddressLine1 ELSE '' END) AS 'Shipping Address'
FROM
  Customer
  JOIN
    CustomerAddress
    ON Customer.CustomerID = CustomerAddress.CustomerID
  JOIN
    Address
    ON CustomerAddress.AddressID = Address.AddressID
WHERE
  Address.City = 'Dallas'
GROUP BY
  Customer.CompanyName;

'''
12) For each order show the SalesOrderID and SubTotal calculated three ways:
A) From the SalesOrderHeader
B) Sum of OrderQty*UnitPrice
C) Sum of OrderQty*ListPrice
'''

SELECT SalesOrderHeader.SalesOrderID,
SalesOrderHeader.SubTotal,
SUM(OrderQty * UnitPrice),
SUM(OrderQty * ListPrice)
FROM
SalesOrderHeader
JOIN
SalesOrderDetail
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
JOIN
Product
ON SalesOrderDetail.ProductID = Product.ProductID
GROUP BY SalesOrderHeader.SalesOrderID, SalesOrderHeader.Subtotal

'''
13) Show the best selling item by value
'''

SELECT
  Product.Name,
  SUM(SalesOrderDetail.OrderQty * SalesOrderDetail.UnitPrice) AS Total_Sale_Value
FROM
  Product
  JOIN
    SalesOrderDetail
    ON Product.ProductID = SalesOrderDetail.ProductID
GROUP BY
  Product.Name
ORDER BY
  Total_Sale_Value DESC;
