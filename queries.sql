-- create a database 
create database vehicle_rental_system;

-- create users table 
create table users (
    user_id serial primary key,
    name varchar(100) not null,
    email varchar(150) unique,
    phone varchar(20) unique,
    role varchar(25)
  );

-- create vehicles table 
create table vehicles (
    vehicle_id serial primary key,
    name varchar(50) not null,
    type varchar(50),
    model varchar(50),
    registration_number varchar(50) unique,
    rental_price int,
    status varchar(25)
  );

-- create bookings table
create table bookings (
    booking_id serial primary key,
    user_id int references users (user_id),
    vehicle_id int references vehicles (vehicle_id),
    start_date date,
    end_date date,
    status varchar(30),
    total_cost int
  );

-- insert data
insert into users (user_id, name, email, phone, role) values
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');

insert into vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) values
(1, 'Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

insert into bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) values
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);


select * from users;
select * from vehicles;
select * from bookings;

-- query 1
select booking_id, users.name as customer_name, vehicles.name as vehicle_name, start_date, end_date, bookings.status from bookings
inner join users on bookings.user_id = users.user_id
inner join vehicles on bookings.vehicle_id = vehicles.vehicle_id;


-- query 2
select * from vehicles
where not exists ( select 1 from bookings where vehicle_id = vehicles.vehicle_id);

-- query 3
select * from vehicles where type='car' and status='available'

-- query 4
select vehicles.name as vehicle_name, count(bookings.vehicle_id) as total_bookings from vehicles 
join bookings on vehicles.vehicle_id=bookings.vehicle_id group by vehicles.name
having count(bookings.vehicle_id)>2;