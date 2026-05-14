show databases;
create database rac_shipping_company;
use  rac_shipping_company;

create table port (
port_id int auto_increment,
name varchar(255) not null,
city varchar(255) not null,
country varchar(255) not null,
primary key(port_id)
);

create table port_office (
port_office_id int auto_increment,
address varchar(255) not null,
telephone varchar(10) not null,
email varchar(255) not null,
port_id int,
primary key(port_office_id),
foreign key (port_id) references port(port_id)
);


create table service_route (
route_id int auto_increment,
name varchar(255) not null,
primary key (route_id)
);

drop table service_route_port;

create table service_route_port (
route_id int,
port_id int,
sequence int,
primary key (route_id, port_id),
foreign key (route_id) references service_route (route_id),
foreign key (port_id) references port (port_id)
);

ALTER TABLE service_route_port 
MODIFY COLUMN sequence INT;

	create table vessel_type (
	vessel_type_id int auto_increment,
	name varchar(255) not null,
	length_overall float,
	capacity int,
	no_of_crew int,
	primary key(vessel_type_id)
	);

create table vessel (
vessel_id int auto_increment,
imo int unique,
name varchar(255) not null,
vessel_type_id int not null,
speed int not null,
gross_tonnage float not null,
dead_weight_tonnage float not null,
length float not null,
breadth float not null,
date_built date,
primary key (vessel_id),
foreign key (vessel_type_id) references vessel_type (vessel_type_id)
);

drop table schedule;
create table schedule (
schedule_id int auto_increment,
vessel_id int,
status enum('Active','Inactive'),
primary key (schedule_id),
foreign key (vessel_id) references vessel (vessel_id)
);
ALTER TABLE schedule 
MODIFY COLUMN status ENUM('Future', 'Current', 'Complete');


create table schedule_port (
Schedule_id int,
port_id int,
arrival_date date,
depature_date date,
primary key (schedule_id, port_id),
foreign key (schedule_id) references schedule (schedule_id),
foreign key (port_id) references port (port_id)
);

create table crew_member (
crew_id int auto_increment,
name varchar(255) not null,
role varchar(255) not null,
vessel_id int,
primary key (crew_id),
foreign key (vessel_id) references vessel (vessel_id)
);

create table customer (
customer_id int auto_increment,
name varchar(255) not null,
telephone varchar(10) not null,
primary key (customer_id)
);

create table container_type (
container_type_id int auto_increment,
name varchar(255),
ex_length float,
ex_width float,
ex_height float,
in_length float,
in_width float,
in_height float,
mgw float,
tare_weight float,
net_weight float,
primary key (container_type_id)
);

create table container (
container_id int auto_increment,
container_type_id int,
primary key (container_id),
foreign key(container_type_id) references container_type(container_type_id)
);

create table booking (
booking_id int auto_increment,
customer_id int not null,
origin_port int,
destination_port int,
tariff float,
status enum('New','Inprogress','Complete'),
vessel_id int,
primary key (booking_id),
foreign key (customer_id) references customer (customer_id),
foreign key (vessel_id) references vessel (vessel_id),
foreign key (origin_port) references port (port_id),
foreign key (destination_port) references port (port_id)
);

create table booking_container (
booking_id int,
container_id int,
goods_description varchar(255),
primary key (booking_id, container_id),
foreign key(booking_id) references booking(booking_id),
foreign key(container_id) references container(container_id)
);

-- Data Entering to the tables

INSERT INTO vessel_type ( name, length_overall, capacity, no_of_crew) 
VALUES 
  ('A', 399.98, 23992, 5),
  ('G', 399.98, 20125, 6),
  ('T', 368.47, 13808, 7),
  ('F', 333.96, 12118, 8),
  ('L', 334.98, 9466, 9),
  ('S', 299.99, 6944, 10),
  ('E', 299.99, 6332, 11),
  ('B', 211.90, 2882, 12),
  ('O', 195.00, 2634, 13),
  ('C', 172.07, 1778, 14);
  
  select * from vessel_type;

show create table vessel;

 insert into vessel (imo,name,vessel_type_id,speed,gross_tonnage,dead_weight_tonnage,length,breadth,date_built)
 values
 ('7074543', 'Royal Gold',1, 23, 235579, 254999, 399.98, 61.50, '2021-07-28'),
 ('7185633', 'Royal Sofia',2, 23, 219079, 199089, 399.98, 58.80, '2018-04-02'),
 ('7112098', 'Royal Louie',3, 23, 219400, 199089, 399.98, 58.80, '2019-12-13'),
 ('7265846', 'Royal Ark', 4, 23, 148667, 152344, 368.47, 51.00, '2013-06-16'),
 ('7332329', 'Royal Faith',5, 23, 117340, 127076, 333.96, 48.40, '2020-03-02'),
 (7000001, 'Royal Alpha', 1, 23, 230000, 250000, 399.98, 61.50, '2020-05-10'),
 (7000002, 'Royal Beta', 1, 23, 230500, 250500, 399.98, 61.50, '2021-07-15'),
 (7100001, 'Royal Gamma', 2, 23, 220000, 200000, 399.98, 58.80, '2018-08-25'),
 (7100002, 'Royal Delta', 2, 23, 219500, 199500, 399.98, 58.80, '2017-06-30'),
 (7200001, 'Royal Theta', 3, 23, 150000, 155000, 368.47, 51.00, '2015-09-20'),
 (7200002, 'Royal Epsilon', 3, 23, 149500, 154500, 368.47, 51.00, '2016-12-05'),
 (7300001, 'Royal Zeta', 4, 23, 125000, 135000, 333.96, 48.40, '2020-01-14'),
 (7300002, 'Royal Eta', 4, 23, 124500, 134500, 333.96, 48.40, '2021-11-08'),
 (7400001, 'Royal Lambda', 5, 23, 105000, 110000, 334.98, 48.00, '2019-04-17'),
 (7400002, 'Royal Mu', 5, 23, 104500, 109500, 334.98, 48.00, '2017-10-29'),
 (7500001, 'Royal Sigma', 6, 23, 90000, 95000, 299.99, 43.00, '2015-07-21'),
 (7500002, 'Royal Tau', 6, 23, 89500, 94500, 299.99, 43.00, '2016-05-12'),
 (7600001, 'Royal Upsilon', 7, 23, 85000, 90000, 299.99, 42.80, '2014-02-18'),
 (7600002, 'Royal Phi', 7, 23, 84500, 89500, 299.99, 42.80, '2013-09-05'),
 (7700001, 'Royal Chi', 8, 23, 60000, 65000, 211.90, 35.00, '2012-03-14'),
 (7700002, 'Royal Psi', 8, 23, 59500, 64500, 211.90, 35.00, '2011-06-27'),
 (7800001, 'Royal Omega', 9, 23, 50000, 55000, 195.00, 32.50, '2010-08-22'),
 (7800002, 'Royal Eos', 9, 23, 49500, 54500, 195.00, 32.50, '2009-11-11'),
 (7900001, 'Royal Nova', 10, 23, 45000, 50000, 172.07, 30.00, '2008-05-30'),
 (7900002, 'Royal Stella', 10, 23, 44500, 49500, 172.07, 30.00, '2007-12-19');
 
 show create table schedule;
 insert into schedule (vessel_id,status)
 values
 (1, 'Future'),
 (2, 'Current'),
 (3, 'Complete'),
 (4, 'Future'),
 (5, 'Current'),
 (6, 'Complete'),
 (7, 'Future'),
 (8, 'Current'),
 (9, 'Complete'),
 (10, 'Future'),
 (11, 'Current'),
 (12, 'Complete'),
 (13, 'Future'),
 (14, 'Current'),
 (15, 'Complete'),
 (16, 'Future'),
 (17, 'Current'),
 (18, 'Complete'),
 (19, 'Future'),
 (20, 'Current'),
 (21, 'Complete'),
 (22, 'Future'),
 (23, 'Current'),
 (24, 'Complete'),
 (25, 'Future');

insert into port (name, city, country)  
values  
('Port of Los Angeles', 'Los Angeles', 'United States'),
('Port of Long Beach', 'Long Beach', 'United States'),
('Port of New York', 'New York', 'United States'),
('Port of Rotterdam', 'Rotterdam', 'Netherlands'),
('Port of Singapore', 'Singapore', 'Singapore'),
('Port of Hamburg', 'Hamburg', 'Germany'),
('Port of Shanghai', 'Shanghai', 'China'),
('Port of Busan', 'Busan', 'South Korea'),
('Port of Tokyo', 'Tokyo', 'Japan'),
('Port of Colombo', 'Colombo', 'Sri Lanka'),
('Port of Dubai', 'Dubai', 'United Arab Emirates'),
('Port of Sydney', 'Sydney', 'Australia'),
('Port of Santos', 'Santos', 'Brazil'),
('Port of Durban', 'Durban', 'South Africa'),
('Port of Vancouver', 'Vancouver', 'Canada'),
('Port of Barcelona', 'Barcelona', 'Spain'),
('Port of Istanbul', 'Istanbul', 'Turkey'),
('Port of London', 'London', 'United Kingdom'),
('Port of Mumbai', 'Mumbai', 'India'),
('Port of Mombasa', 'Mombasa', 'Kenya'),
('Port of Cape Town', 'Cape Town', 'South Africa'),
('Port of Seattle', 'Seattle', 'United States'),
('Port of Jebel Ali', 'Jebel Ali', 'United Arab Emirates');

DELETE FROM port
WHERE port_id BETWEEN 16 AND 30;

select * from port;

insert into port_office (address, telephone, email, port_id)  
VALUES  
('100 Harbor Way, Los Angeles, United States', '0890123456', 'contact@losangelesport.com', 1),  
('200 Seaside Ave, Long Beach, United States', '0901234567', 'contact@longbeachport.com', 2),  
('300 Marine Blvd, New York, United States', '0912345678', 'contact@newyorkport.com', 3),  
('400 Dockyard Rd, Rotterdam, Netherlands', '0923456789', 'contact@rotterdamport.com', 4),  
('500 Cargo Ln, Singapore, Singapore', '0934567890', 'contact@singaporeport.com', 5),  
('600 Portview Dr, Hamburg, Germany', '0945678901', 'contact@hamburgport.com', 6),  
('700 Trade Rd, Shanghai, China', '0956789012', 'contact@shanghaiport.com', 7),  
('800 Ocean St, Busan, South Korea', '0967890123', 'contact@busanport.com', 8),  
('900 Pier Ln, Tokyo, Japan', '0978901234', 'contact@tokyoport.com', 9),  
('1000 Harbor Rd, Colombo, Sri Lanka', '0989012345', 'contact@colomboport.com', 10),  
('1100 Marine St, Dubai, United Arab Emirates', '0990123456', 'contact@dubaiport.com', 11),  
('1200 Coast Rd, Sydney, Australia', '0910234567', 'contact@sydneyport.com', 12),  
('1300 Bay Ave, Santos, Brazil', '0921345678', 'contact@santosport.com', 13),  
('1400 Terminal Dr, Durban, South Africa', '0932456789', 'contact@durbanport.com', 14),  
('1500 Shipyard Ln, Vancouver, Canada', '0943567890', 'contact@vancouverport.com', 15); 

insert into port_office (address, telephone, email, port_id) 
values 
('707 Trade Route, Barcelona, Spain', '0505050505', 'contact@barcelonaport.com', 31),
('808 Bosphorus Ave, Istanbul, Turkey', '0606060606', 'contact@istanbulport.com', 32),
('909 Thames Street, London, UK', '0707070707', 'contact@londonport.com', 33),
('111 Gateway Rd, Mumbai, India', '0808080808', 'contact@mumbaiport.com', 34),
('222 Coastline Dr, Mombasa, Kenya', '0909090909', 'contact@mombasaport.com', 35),
('333 Harbor Street, Cape Town, South Africa', '0123456789', 'contact@capetownport.com', 36),
('444 Bay Ave, Seattle, United States', '0234567890', 'contact@seattleport.com', 37),
('555 Gulf Terminal, Jebel Ali, UAE', '0345678901', 'contact@jebelaliport.com', 38);


insert into schedule_port (schedule_id, port_id, arrival_date, depature_date)
values
(1, 1, '2025-04-01', '2025-04-02'),  -- Route 1 arrives at Le Havre
(1, 2, '2025-04-03', '2025-04-04'),  -- Route 1 arrives at Antwerp
(2, 3, '2025-04-05', '2025-04-06'),  -- Route 2 arrives at Charleston
(2, 4, '2025-04-07', '2025-04-08'),  -- Route 2 arrives at Miami
(3, 5, '2025-04-09', '2025-04-10'),  -- Route 3 arrives at Altamira
(3, 6, '2025-04-11', '2025-04-12'),  -- Route 3 arrives at Veracruz
(4, 7, '2025-04-13', '2025-04-14'),  -- Route 4 arrives at Houston
(4, 8, '2025-04-15', '2025-04-16'),  -- Route 4 arrives at Los Angeles
(4, 9, '2025-04-17', '2025-04-18'),  -- Route 4 arrives at Long Beach
(5, 10, '2025-04-19', '2025-04-20'), -- Route 5 arrives at New York
(5, 11, '2025-04-21', '2025-04-22'), -- Route 5 arrives at Rotterdam
(6, 12, '2025-04-23', '2025-04-24'), -- Route 6 arrives at Singapore
(6, 13, '2025-04-25', '2025-04-26'), -- Route 6 arrives at Hamburg
(7, 14, '2025-04-27', '2025-04-28'), -- Route 7 arrives at Shanghai
(7, 15, '2025-04-29', '2025-04-30'); -- Route 7 arrives at Busan

insert into service_route (name) 
values
('Atlantic Express'), 
('Pacific Connect'), 
('Euro-Asia Trade Lane'), 
('Americas Cargo Route'), 
('Mediterranean Shipping Line'), 
('Asia-Pacific Link'), 
('Northern Freight Network'), 
('Southern Ocean Logistics'), 
('Transatlantic Express'), 
('Indian Ocean Trade Route'), 
('Latin America Gateway'), 
('African Trade Corridor'), 
('US West Coast Express'), 
('Europe-Middle East Bridge'), 
('China-EU Cargo Line'); 

select* from port;
insert into service_route_port (route_id, port_id, sequence) 
values 
-- Atlantic Express
(1, 3, 1),  -- New York
(1, 4, 2),  -- Rotterdam
(1, 1, 3);  -- Port of Los Angeles

insert into service_route_port (route_id, port_id, sequence) 
values
-- Pacific Connect
(2, 7, 1),  -- Shanghai
(2, 9, 2),  -- Tokyo
(2, 1, 3);  -- Port of Los Angeles

insert into service_route_port (route_id, port_id, sequence) 
values
-- Euro-Asia Trade Lane
(3, 6, 1),  -- Hamburg
(3, 5, 2),  -- Singapore
(3, 8, 3);  -- Busan

insert into service_route_port (route_id, port_id, sequence) 
values
-- Americas Cargo Route
(4, 3, 1),  -- Port of New York
(4, 2, 2),  -- Port of Long Beach
(4, 6, 3);  -- Port of Hamburg

insert into service_route_port (route_id, port_id, sequence) 
values
-- Mediterranean Shipping Line
(5, 2, 1),  -- Port of Long Beach
(5, 31, 2), -- Barcelona
(5, 32, 3); -- Istanbul

insert into service_route_port (route_id, port_id, sequence) 
values
-- Asia-Pacific Link
(6, 10, 1), -- Port of Colombo
(6, 12, 2), -- Sydney
(6, 7, 3);  -- Shanghai

insert into service_route_port (route_id, port_id, sequence) 
values
-- Northern Freight Network
(7, 37, 1), -- Port of Seattle
(7, 4, 2),  -- Rotterdam
(7, 6, 3);  -- Hamburg

insert into service_route_port (route_id, port_id, sequence) 
values
-- Southern Ocean Logistics
(8, 13, 1), -- Santos
(8, 14, 2), -- Durban
(8, 5, 3);  -- Singapore

insert into service_route_port (route_id, port_id, sequence) 
values
-- Transatlantic Express
(9, 3, 1),  -- Port of New York
(9, 33, 2), -- London
(9, 2, 3);  -- Port of Long Beach

insert into service_route_port (route_id, port_id, sequence) 
values
-- Indian Ocean Trade Route
(10, 11, 1), -- Port of Dubai
(10, 34, 2), -- Mumbai
(10, 10, 3); -- Port of Colombo

insert into service_route_port (route_id, port_id, sequence) 
values
-- Latin America Gateway
(11, 6, 1),  -- Veracruz
(11, 13, 2), -- Santos
(11, 14, 3), -- Port of Durban

-- African Trade Corridor
(12, 14, 1), -- Durban
(12, 35, 2), -- Mombasa
(12, 36, 3), -- Cape Town

-- US West Coast Express
(13, 1, 1),  -- Port of Los Angeles
(13, 2, 2),  -- Port of Long Beach
(13, 37, 3), -- Seattle

-- Europe-Middle East Bridge
(14, 6, 1), -- Hamburg
(14, 11, 2), -- Dubai
(14, 38, 3), -- Jebel Ali

-- China-EU Cargo Line
(15, 7, 1),  -- Shanghai
(15, 4, 2),  -- Rotterdam
(15, 2, 3);  -- Port of Long Beach

select * from service_route_port;
select * from vessel;

insert into crew_member (name, role, vessel_id)
values
('John Doe', 'Captain', 1),
('Jane Smith', 'First Officer', 1),
('Mark Johnson', 'Engineer', 2),
('Emily Davis', 'Deckhand', 2),
('David Brown', 'Cook', 3),
('Sophia Wilson', 'Second Officer', 3),
('James Lee', 'Chief Engineer', 4),
('Olivia Harris', 'Deckhand', 4),
('Liam Clark', 'Captain', 5),
('Mason Lewis', 'First Officer', 5),
('Isabella Robinson', 'Engineer', 6),
('Ethan Walker', 'Cook', 6),
('Amelia Scott', 'Second Officer', 7),
('Lucas Young', 'Deckhand', 7),
('Charlotte King', 'Chief Engineer', 8),
('Benjamin Allen', 'Captain', 8),
('Mia Adams', 'First Officer', 9),
('Alexander Carter', 'Engineer', 9),
('Grace Mitchell', 'Cook', 10),
('Jacob Perez', 'Deckhand', 10),
('William Collins', 'Second Officer', 11),
('Harper Morgan', 'Captain', 11),
('Ella Stewart', 'First Officer', 12),
('Samuel King', 'Engineer', 12),
('Chloe Baker', 'Deckhand', 13);


Select * from crew_member;

insert into customer (name, telephone) 
values 
('Mia Johnson', '0734567890'),
('James Brown', '0745678901'),
('Charlotte Lee', '0789012345'),
('Jack Wilson', '0790123456'),
('Ava Davis', '0701234567'),
('Benjamin Clark', '0728901234'),
('Isabella White', '0767890123'),
('Lucas Harris', '0778901234'),
('Amelia Martin', '0789012346'),
('Henry Walker', '0792345678');


Select * from customer;

insert into  booking (customer_id, origin_port, destination_port, tariff, status, vessel_id)
values
(1, 1, 2, 5000.00, 'New', 1),  -- Customer Alex Carter, Port of Los Angeles to Port of Long Beach, Royal Gold
(2, 4, 5, 4500.00, 'Inprogress', 2),  -- Sophia Bennett, Port of Rotterdam to Port of Singapore, Royal Sofia
(3, 3, 6, 6000.00, 'Complete', 3),  -- Daniel Harris, Port of New York to Port of Hamburg, Royal Louie
(4, 7, 8, 5500.00, 'New', 4),  -- Olivia Turner, Port of Shanghai to Port of Busan, Royal Ark
(5, 2, 3, 4800.00, 'Inprogress', 5),  -- Ethan Mitchell, Port of Long Beach to Port of New York, Royal Faith
(6, 9, 10, 5200.00, 'Complete', 6),  -- James Brown, Port of Tokyo to Port of Colombo, Royal Faith
(7, 10, 11, 5300.00, 'New', 7),  -- Isabella White, Port of Colombo to Port of Dubai, Royal Louie
(8, 13, 14, 4700.00, 'Inprogress', 8),  -- Lucas Harris, Port of Santos to Port of Durban, Royal Sofia
(9, 14, 15, 5900.00, 'Complete', 9),  -- Charlotte Lee, Port of Durban to Port of Cape Town, Royal Gold
(10, 11, 12, 6000.00, 'New', 10);  -- Jack Wilson, Port of Dubai to Port of Sydney, Royal Ark

INSERT INTO booking (customer_id, origin_port, destination_port, tariff, status, vessel_id)
VALUES

(1, 2, 6, 6200.00, 'Inprogress', 3),  -- Alex Carter, Port of Long Beach to Port of Hamburg, Royal Louie
(1, 3, 9, 7000.00, 'New', 6),  -- Alex Carter, Port of New York to Port of Tokyo, Royal Faith

(2, 5, 7, 5000.00, 'Complete', 4),  -- Sophia Bennett, Port of Singapore to Port of Shanghai, Royal Ark
(2, 7, 12, 6400.00, 'New', 10);  -- Sophia Bennett, Port of Shanghai to Port of Sydney, Royal Ark

insert into container_type (name, ex_length, ex_width, ex_height, in_length, in_width, in_height, mgw, tare_weight, net_weight) 
values 
('20’ Steel Dry Cargo Container', 6.058, 2.438, 2.591, 5.898, 2.352, 2.385, 30480, 2400, 28080),
('40’ Steel Dry Cargo Container', 12.192, 2.438, 2.591, 12.032, 2.352, 2.385, 30480, 3800, 26680),
('40’ Hi-Cube Steel Dry Cargo Container', 12.192, 2.438, 2.896, 12.032, 2.352, 2.690, 30480, 4000, 26480),
('45’ Hi-Cube Steel Dry Cargo Container', 13.716, 2.438, 2.896, 13.556, 2.352, 2.690, 34000, 4800, 29200),
('20’ Full Height Open Top Container', 6.058, 2.438, 2.591, 5.898, 2.352, 2.385, 30480, 2500, 27980),
('40’ Full Height Open Top Container', 12.192, 2.438, 2.591, 12.032, 2.352, 2.385, 30480, 4200, 26280),
('40’ Hi-Cube Open Top Container', 12.192, 2.438, 2.896, 12.032, 2.352, 2.690, 30480, 4500, 25980),
('20’ Flat Rack Container with Collapsible End', 6.058, 2.438, 2.591, 5.898, 2.352, 2.385, 34000, 2500, 31500),
('40’ Flat Rack Container with Collapsible End', 12.192, 2.438, 2.591, 12.032, 2.352, 2.385, 45000, 4800, 40200),
('40’ Flat Rack Hi-Cube Container', 12.192, 2.438, 2.896, 12.032, 2.352, 2.690, 45000, 5000, 40000),
('40’ Steel Refrigerated Cargo Container', 12.192, 2.438, 2.591, 12.032, 2.352, 2.385, 34000, 4600, 29400);

Select* from container_type;

insert into  container (container_type_id) 
values 
(1),  -- 20’ Steel Dry Cargo Container
(2),  -- 40’ Steel Dry Cargo Container
(3),  -- 40’ Hi-Cube Steel Dry Cargo Container
(4),  -- 45’ Hi-Cube Steel Dry Cargo Container
(5),  -- 20’ Full Height Open Top Container
(6),  -- 40’ Full Height Open Top Container
(7),  -- 40’ Hi-Cube Open Top Container
(8),  -- 20’ Flat Rack Container with Collapsible End
(9),  -- 40’ Flat Rack Container with Collapsible End
(10), -- 40’ Flat Rack Hi-Cube Container
(11); -- 40’ Steel Refrigerated Cargo Container

select* from container;

INSERT INTO booking_container (booking_id, container_id, goods_description)
VALUES
(1, 1, 'Electronics - Laptops'),
(1, 2, 'Furniture - Office Chairs'),
(2, 3, 'Textiles - Clothing'),
(2, 4, 'Electronics - Smartphones'),
(3, 5, 'Automobiles - Car Parts'),
(3, 6, 'Chemicals - Cleaning Agents'),
(4, 7, 'Machinery - Industrial Equipment'),
(4, 8, 'Automobiles - Motorbikes'),
(5, 9, 'Furniture - Wooden Tables'),
(5, 10, 'Textiles - Fabrics'),
(6, 1, 'Electronics - Home Appliances'),
(6, 2, 'Chemicals - Paints'),
(7, 3, 'Foodstuff - Canned Goods'),
(7, 4, 'Furniture - Sofas'),
(8, 5, 'Clothing - Fashion Apparel'),
(8, 6, 'Electronics - TVs'),
(9, 7, 'Electronics - Computer Parts'),
(9, 8, 'Automobiles - Tires'),
(10, 9, 'Foodstuff - Spices'),
(10, 10, 'Machinery - Hydraulic Pumps');


Select* from booking;
SHOW TABLES;

-- ----------------------------------------------------------------------------------------------------
-- Maintaining details of the service routing network in order to work out the routing of the vessels.

select sr.name as 'Service_route' , p.name as 'port', srp.sequence as 'Arriving Sequence'
from service_route sr
inner join service_route_port srp on (sr.route_id = srp.route_id)
inner join port p on (p.port_id = srp. port_id)
order by sr.name, srp.sequence;

-- Enable customers to search for sailing schedules

select v.imo as ship_id, v.name as vessel_name , s.schedule_id, s.status, p.name as port, sp.arrival_date, sp.depature_date
from vessel v
inner join  schedule s on (v.vessel_id =s.vessel_id)
inner join schedule_port sp on (s.schedule_id =sp.schedule_id)
inner join port p on (sp.port_id = p.port_id);

-- Enable customers to track cargo

select b.booking_id, v.name as vessel_name, s.schedule_id as Schedule, p.name as port, sp.arrival_date, sp.depature_date
from booking as b
inner join vessel v on (b.vessel_id = v.vessel_id)
inner join  schedule s on (v.vessel_id =s.vessel_id)
inner join schedule_port sp on (s.schedule_id = sp.schedule_id)
inner join port p on (sp.port_id = p.port_id)
where b.booking_id = 4
AND (sp.port_id = b.origin_port OR sp.port_id = b.destination_port); 

-- Record details of goods conveyed

select  v.name as vessel_name, s.schedule_id as Schedule, bc.goods_description
from vessel as v
inner join booking b on ( v.vessel_id= b.vessel_id)
inner join booking_container bc on ( b.booking_id =bc.booking_id)
inner join  schedule s on (v.vessel_id =s.vessel_id);

select ct.container_type_id, ct.name, bc.booking_id, vt.capacity
from container_type as ct
inner join container c on(ct.container_type_id = c.container_id)
inner join booking_container bc on ( c.container_id = bc.container_id)
inner join booking b on (bc.booking_id = b.booking_id)
inner join vessel v on (b.vessel_id = v.vessel_id)
inner join vessel_type vt on ( v.vessel_type_id =vt.vessel_type_id);

select v.name as vessel_name ,count(cm.crew_id) as crew_count
from vessel as v
inner join crew_member cm on (v.vessel_id =cm.vessel_id)
group by v.name;

-- Enable customers to search for containers and book containers.
-- search for available containers
select c.container_id, ct.name as container_type, ct.in_length, ct.in_width, ct.in_height, 
       ct.mgw, ct.tare_weight, ct.net_weight,
       round(ct.in_width * ct.in_height * ct.in_length) as available_capacity
from container c
join container_type ct on c.container_type_id = ct.container_type_id
where c.container_id not in (
    select bc.container_id from booking_container bc
);


-- Production of vessel schedules which will utilise the allocation of cargo efficiently for the transportation of goods.

select v.name as vessel_name, s.schedule_id,s.status, 
    round(vt.capacity, 2) as total_capacity, 
    round(coalesce(SUM(ct.ex_length * ct.ex_width * ct.ex_height), 0), 2) AS utilized_capacity, 
    round(vt.capacity - coalesce(SUM(ct.ex_length * ct.ex_width * ct.ex_height), 0), 2) AS available_capacity
from schedule s
inner join vessel v on s.vessel_id = v.vessel_id
inner join vessel_type vt on v.vessel_type_id = vt.vessel_type_id
left join booking b on s.vessel_id = b.vessel_id
left join booking_container bc on b.booking_id = bc.booking_id
left join container c on bc.container_id = c.container_id
left join container_type ct on c.container_type_id = ct.container_type_id
where s.status in ('Future', 'Current') 
group by v.vessel_id, s.schedule_id
order by s.schedule_id;





select * from schedule;
select * from port;
select * from vessel;
select * from service_route_port;


select * from booking;
select * from container_type;
select * from crew_member;
select * from schedule;

select * from customer;
select * from schedule_port;
select * from booking_container;
select * from container;

insert into  schedule (vessel_id,status) 
values (25,'Current');
