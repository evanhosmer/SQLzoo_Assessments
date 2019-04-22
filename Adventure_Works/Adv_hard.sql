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
