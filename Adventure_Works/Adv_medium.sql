'''
6) A "Single Item Order" is a customer order where only one item is ordered.
Show the SalesOrderID and the UnitPrice for every Single Item Order.
'''

SELECT SalesOrderID, UnitPrice
FROM SalesOrderDetail
WHERE OrderQty = 1
GROUP BY SalesOrderID, UnitPrice

'''
7) Where did the racing socks go? List the product name and the CompanyName for all
Customers who ordered ProductModel Racing Socks.
'''

SELECT Product.name, Customer.CompanyName
FROM Product
JOIN ProductModel
ON Product.ProductModelID = ProductModel.ProductModelID
JOIN SalesOrderDetail
ON Product.ProductID = SalesOrderDetail.ProductID
JOIN SalesOrderHeader
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
JOIN Customer
ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE ProductModel.name = 'Racing Socks'

'''
8) Show the product description for culture fr for product with ProductID 736.
'''

SELECT ProductDescription.Description
FROM Product
JOIN ProductModel
ON ProductModel.ProductModelID = Product.ProductModelID
JOIN ProductModelProductDescription
ON ProductModelProductDescription.ProductModelID = ProductModel.ProductModelID
JOIN ProductDescription
ON ProductDescription.ProductDescriptionID = ProductModelProductDescription.ProductDescriptionID
WHERE Product.ProductID = 736 AND ProductModelProductDescription.Culture = 'fr'

'''
9) Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. For each order show the
CompanyName and the SubTotal and the total weight of the order.
'''

SELECT
  Customer.CompanyName,
  SalesOrderHeader.SubTotal,
  SUM(SalesOrderDetail.OrderQty * Product.weight)
FROM
  Product
  JOIN
    SalesOrderDetail
    ON Product.ProductID = SalesOrderDetail.ProductID
  JOIN
    SalesOrderHeader
    ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesorderID
  JOIN
    Customer
    ON SalesOrderHeader.CustomerID = Customer.CustomerID
GROUP BY
  SalesOrderHeader.SalesOrderID, SalesOrderHeader.SubTotal, Customer.CompanyName
ORDER BY
  SalesOrderHeader.SubTotal DESC;

'''
10) How many products in ProductCategory Cranksets have been sold to an address in London?
'''

SELECT COUNT(*)
FROM Product
JOIN ProductCategory
ON Product.ProductCategoryID = ProductCategory.ProductCategoryID
JOIN SalesOrderDetail
ON SalesOrderDetail.ProductID = Product.ProductID
JOIN SalesOrderHeader
ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN Address
ON SalesOrderHeader.BillToAddressID = Address.AddressID
WHERE ProductCategory.Name = 'Cranksets' AND Address.city = 'London'
