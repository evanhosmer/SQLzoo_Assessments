'''
11) Coincidence. Have two guests with the same surname ever stayed in the hotel on the evening?
Show the last name and both first names. Do not include duplicates.
'''

SELECT DISTINCT t1.last_name, t1.first_name, t2.first_name
FROM
(SELECT *
FROM booking
JOIN guest
ON booking.guest_id = guest.id) t1
JOIN
(SELECT *
FROM booking
JOIN guest
ON booking.guest_id = guest.id) t2
ON (t1.last_name = t2.last_name)
AND t1.booking_date <= t2.booking_date
AND DATE_ADD(t1.booking_date, INTERVAL (t1.nights - 1) DAY) >= t2.booking_date
AND t1.first_name > t2.first_name
ORDER BY t1.last_name

'''
12) Check out per floor. The first digit of the room number indicates the floor – e.g. room 201 is on the
2nd floor. For each day of the week beginning 2016-11-14 show how many rooms are being vacated that day by
floor number. Show all days in the correct order.
'''

SELECT
  DATE_ADD(booking_date, INTERVAL nights DAY) AS i,
  SUM(CASE WHEN room_no LIKE '1%' THEN 1 ELSE 0 END) AS 1st,
  SUM(CASE WHEN room_no LIKE '2%' THEN 1 ELSE 0 END) AS 2nd,
  SUM(CASE WHEN room_no LIKE '3%' THEN 1 ELSE 0 END) AS 3rd
FROM
	booking
WHERE
	DATE_ADD(booking_date, INTERVAL nights DAY) BETWEEN '2016-11-14' AND '2016-11-20'
GROUP BY
	i;

'''
13) Free rooms? List the rooms that are free on the day 25th Nov 2016.
'''
