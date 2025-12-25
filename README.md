# vehicle-rental-database

### Query 1: join

```sql
select booking_id, users.name as customer_name, vehicles.name as vehicle_name, start_date, end_date, bookings.status from bookings
inner join users on bookings.user_id = users.user_id
inner join vehicles on bookings.vehicle_id = vehicles.vehicle_id;
```

#### Explaination

Get all booking information with user name and vehicle name, Combines data from three tables: bookings, users and vehicles. Used INNER JOIN to combine all the table.

### Query 2: EXISTS

```sql
select * from vehicles where not exists
( select 1 from bookings where vehicle_id = vehicles.vehicle_id );
```

#### Explanation

Checks each vehicle one by one. use NOT EXISTS ensures no matching booking exists for that vehicle table. if no booking found, the vehicle is selected.

### Query 3: WHERE

```sql
select * from vehicles where type='car' and status='available'
```

#### Explanation

From vehicles table filters vehicles by type and staus

### Query 4: GROUP BY and HAVING

```sql
select vehicles.name as vehicle_name, count(bookings.vehicle_id) as total_bookings from vehicles
join bookings on vehicles.vehicle_id=bookings.vehicle_id group by vehicles.name
having count(bookings.vehicle_id)>2;
```

#### Explanation

Joins vehicles with bookings, COUNT calculates number of bookings each vehicle, GROUP BY groups results by vehicle, HAVING filters after counting results.
