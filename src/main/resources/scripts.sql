CREATE DATABASE Reservation

USE Reservation

CREATE TABLE USER
(
ID INT NOT NULL AUTO_INCREMENT,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
EMAIL VARCHAR(50),
PASSWORD VARCHAR(20),
PRIMARY KEY (ID),
UNIQUE KEY(EMAIL)
)

CREATE TABLE FLIGHT
(
ID INT NOT NULL AUTO_INCREMENT,
FLIGHT_NUMBER VARCHAR(20) NOT NULL,
OPERATING_AIRLINES VARCHAR(20) NOT NULL,
DEPARTURE_CITY VARCHAR(20) NOT NULL,
ARRIVAL_CITY VARCHAR(20) NOT NULL,
DATE_OF_DEPARTURE DATE NOT NULL,
ESTIMATED_DEPARTURE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (ID)
)

CREATE TABLE PASSENGER
(
ID INT NOT NULL AUTO_INCREMENT,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
MIDDLE_NAME VARCHAR(20),
EMAIL VARCHAR(50),
PHONE VARCHAR(10),
PRIMARY KEY (ID)
)

CREATE TABLE RESERVATION
(
ID INT NOT NULL AUTO_INCREMENT,
CHECKED_IN TINYINT(1),
NUMBER_OF_BAGS INT,
PASSENGER_ID INT,
FLIGHT_ID INT,
CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (ID),
FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGER(ID) ON DELETE CASCADE,
FOREIGN KEY (FLIGHT_ID) REFERENCES FLIGHT(ID)
)

SELECT * FROM USER

SELECT * FROM PASSENGER

SELECT * FROM FLIGHT

SELECT * FROM RESERVATION

insert into flight values(1, 'AA1', 'American Airlines', 'AUS', 'NYC', STR_TO_DATE('02-05-2018', '%m-%d-%Y'), '2018-02-05 03:14:07')
insert into flight values(2, 'AA2', 'American Airlines', 'AUS', 'NYC', STR_TO_DATE('02-05-2018', '%m-%d-%Y'), '2018-02-05 05:14:07')
insert into flight values(3, 'AA3', 'American Airlines', 'AUS', 'NYC', STR_TO_DATE('02-05-2018', '%m-%d-%Y'), '2018-02-05 06:14:07')
insert into flight values(4, 'SW1', 'South West', 'AUS', 'NYC', STR_TO_DATE('02-05-2018', '%m-%d-%Y'), '2018-02-05 07:14:07')
insert into flight values(5, 'UA1', 'United Airlines', 'NYC', 'DAL', STR_TO_DATE('02-05-2018', '%m-%d-%Y'), '2018-02-05 10:14:07')

select flight0_.id as id1_0_, flight0_.arrival_city as arrival_2_0_, flight0_.date_of_departure as date_of_3_0_, flight0_.departure_city as departur4_0_, flight0_.estimated_departure_time as estimate5_0_, flight0_.flight_number as flight_n6_0_, flight0_.operating_airlines as operatin7_0_ from flight flight0_

CREATE TABLE ROLE
(
ID INT NOT NULL AUTO_INCREMENT,
NAME VARCHAR(20),
PRIMARY KEY (ID))

CREATE TABLE user_role
(
user_id int,
role_id int,
FOREIGN KEY (user_id) REFERENCES user(id),
FOREIGN KEY (role_id) REFERENCES role(id)
)

insert into role values(1, 'ADMIN')

insert into user_role values(10,1)

select * from role

delete from user_role
delete from user 

select * from user

insert into user (email, first_name, last_name, password) values ('necmi3@aa.com', 'NEcmi', null, '$2a$10$IJ66gG9Rm99ZWNIUUxJmNeHS4cVR7YLNPLF4m5MLNyFBMmgBRiuNi')

ALTER table USER modify password Varchar(100)