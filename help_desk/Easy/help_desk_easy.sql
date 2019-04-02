'''
There are three issues that include the words "index" and "Oracle". Find the call_date for each of them
'''

SELECT call_date, call_ref
FROM Issue
WHERE Detail LIKE '%index%' AND Detail LIKE '%Oracle%'

'''
Samantha Hall made three calls on 2017-08-14. Show the date and time for each
'''

SELECT LEFT(call_date, 10) as Date, RIGHT(call_date, 8) AS Time
FROM Issue
WHERE caller_id = (SELECT caller_id FROM Caller WHERE first_name = 'Samantha' AND last_name = 'Hall')
HAVING DATE = '2017-08-14'

'''
There are 500 calls in the system (roughly). Write a query that shows the number that have each status.
'''

SELECT status, COUNT(*) as Volume
FROM Issue
GROUP BY status

'''
Calls are not normally assigned to a manager but it does happen.
How many calls have been assigned to staff who are at Manager Level?
'''

SELECT COUNT(*) as mlcc
FROM Issue
WHERE assigned_to IN (SELECT Staff_code
FROM Staff
WHERE Level_Code IN ('4','5','7'))

'''
Show the manager for each shift. Your output should include the shift date and type;
also the first and last name of the manager.
'''

SELECT Shift_date, Shift_type, first_name, last_name
FROM Shift
JOIN Staff
ON Shift.Manager = Staff.Staff_code
ORDER BY Shift_date
