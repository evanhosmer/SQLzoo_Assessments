'''
1) Guest 1183. Give the booking_date and the number of nights for guest 1183.
'''

SELECT booking_date, nights
FROM booking
WHERE guest_id = '1183'

'''
2)
When do they get here? List the arrival time and the first and
last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.
'''

SELECT arrival_time, guest.first_name, guest.last_name
FROM booking
JOIN guest
ON booking.guest_id = guest.id
WHERE booking.booking_date = '2016-11-05'
ORDER BY arrival_time

'''
3) Look up daily rates. Give the daily rate that should be paid for bookings with ids 5152, 5165,
5154 and 5295. Include booking id, room type, number of occupants and the amount.
'''
