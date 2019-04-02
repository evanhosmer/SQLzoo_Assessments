'''
1) List the Company name and the number of calls for those companies with more than 18 calls.
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
2) Find the callers who have never made a call. Show first name and last name
'''

SELECT CONCAT(first_name, ' ', last_name) as name
FROM Caller
HAVING name NOT IN(SELECT DISTINCT CONCAT(First_name, ' ' ,Last_name)
FROM Issue
JOIN Caller
ON Issue.Caller_id = Caller.Caller_id)

'''
3) For each customer show: Company name, contact name, number of calls where the number of calls is fewer than 5
'''

SELECT t1.Company_name, t2.First_name, t2.Last_name, t1.cc
FROM
(SELECT Company_name, COUNT(Company_name) as cc
FROM Customer
JOIN Caller
ON Customer.Company_ref = Caller.Company_ref
JOIN Issue
ON Issue.Caller_id = Caller.Caller_id
GROUP BY Company_name
HAVING cc < 5) t1

INNER JOIN

(SELECT Company_name, First_name, Last_name
FROM Customer
JOIN Caller
ON Customer.Company_ref = Caller.Company_ref
WHERE Customer.Contact_id = Caller.Caller_Id
GROUP BY Company_name, First_name, Last_name) t2

ON t1.Company_name = t2.Company_name

'''
4) For each shift show the number of staff assigned. Beware that some roles may be NULL and that
the same person might have been assigned to multiple roles
'''

SELECT
	a.Shift_date,
	a.Shift_type,
	COUNT(DISTINCT role) AS cw
FROM
	(
		SELECT
			shift_date,
			shift_type,
			Manager AS role
		FROM
			Shift
		UNION ALL
		SELECT
			shift_date,
			shift_type,
			Operator AS role
		FROM
			Shift
		UNION ALL
		SELECT
			shift_date,
			shift_type,
			Engineer1 AS role
		FROM
			Shift
		UNION ALL
		SELECT
			shift_date,
			shift_type,
			Engineer2 AS role
		FROM
			Shift
	)
	AS a
GROUP BY
	a.Shift_date,
	a.Shift_type;

'''
5)Caller Harry claims that the operator who took his most recent call
was abusive and insulting. Find out who took the call (full name) and when.
'''

SELECT t2.first_name, t2.last_name, t1.Call_date
FROM
(SELECT *
FROM Issue
WHERE Caller_id = (SELECT Caller_id
FROM Caller
WHERE first_name = 'Harry')
ORDER BY Call_date DESC
LIMIT 1) t1

INNER JOIN

(SELECT Staff_code, First_name, Last_name
FROM Staff) t2

ON t2.staff_code = t1.Taken_by
