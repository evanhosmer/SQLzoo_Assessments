'''
6) Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings.
 You should JOIN to the rate table using room_type_requested and occupants.
'''

SELECT SUM(nights*amount) as Amount_owed
FROM booking
JOIN rate
ON booking.room_type_requested = rate.room_type AND booking.occupants = rate.occupancy
WHERE guest_id = (SELECT id FROM guest WHERE first_name = 'Ruth' AND last_name = 'Cadbury')

'''
7) Including Extras. Calculate the total bill for booking 5346 including extras.
'''

SELECT SUM((nights*amount) + extra.amount)
FROM booking
JOIN rate
ON booking.room_type_requested = rate.room_type AND booking.occupants = rate.occupancy
JOIN extra
ON booking.booking_id = extra.booking_id
WHERE booking.booking_id = '5346'

'''
8) Edinburgh Residents. For every guest who has the word “Edinburgh” in their address show the total number of nights booked.
Be sure to include 0 for those guests who have never had a booking.
Show last name, first name, address and number of nights. Order by last name then first name.
'''

SELECT last_name, first_name, address, coalesce(SUM(nights), 0)
FROM guest
LEFT OUTER JOIN booking
ON guest.id = booking.guest_id
WHERE guest.address LIKE '%Edinburgh%'
GROUP BY last_name, first_name, address
ORDER BY last_name

'''
9)
How busy are we? For each day of the week beginning 2016-11-25 show the number of bookings starting that day.
Be sure to show all the days of the week in the correct order.
'''

SELECT booking_date, COUNT(*) as arrivals
FROM booking
WHERE booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY booking_date
ORDER BY booking_date

'''
10)
How many guests? Show the number of guests in the hotel on the night of 2016-11-21.
Include all occupants who checked in that day but not those who checked out.
'''

SELECT SUM(occupants)
FROM booking
WHERE booking_date <= '2016-11-21' AND DATE_ADD(booking_date, INTERVAL nights DAY) > '2016-11-21'
