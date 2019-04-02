'''
List the Company name and the number of calls for those companies with more than 18 calls.
'''

SELECT Company_name, COUNT(Company_name) as cc
FROM Customer
JOIN Caller
ON Customer.Company_ref = Caller.Company_ref
JOIN Issue
ON Issue.Caller_id = Caller.Caller_id
GROUP BY Company_name
HAVING cc > 18
ORDER BY Company_name

'''
Find the callers who have never made a call. Show first name and last name
'''

SELECT CONCAT(first_name, ' ', last_name) as name
FROM Caller
HAVING name NOT IN(SELECT DISTINCT CONCAT(First_name, ' ' ,Last_name)
FROM Issue
JOIN Caller
ON Issue.Caller_id = Caller.Caller_id)

'''
For each customer show: Company name, contact name, number of calls where the number of calls is fewer than 5
'''
