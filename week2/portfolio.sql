-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week2_portfolio' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week2_portfolio;
CREATE DATABASE week2_portfolio;
-- connect via psql
\c week2_portfolio

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE customers (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone_number varchar[10],
    address text,
    PRIMARY KEY (id)
);


CREATE TABLE orders (
    id SERIAL,
    type_of_photoshoot TEXT,
    pay_amount INT,
    date DATE NOT NULL,
    payment_method_id INT NOT NULL,
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE payments (
    id SERIAL,
    payment_method TEXT NOT NULL UNIQUE,
    PRIMARY KEY (id)
);


CREATE TABLE events (
    id SERIAL,
    date DATE NOT NULL,
    location_id INT NOT NULL,
    equipment_id INT NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE equipments (
    id SERIAL,
    name text not NULL,
    PRIMARY KEY (id)
);


CREATE TABLE locations (
    id SERIAL,
    address_line TEXT NOT NULL,
    town TEXT NOT NULL,
    state CHARACTER(2) NOT NULL,
    zip_code CHARACTER(5) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE photos (
    id SERIAL,
    name TEXT NOT NULL,
    event_id INT NOT NULL,
    equipment_id INT NOT NULL,
    location_id INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (id)
);


-- Bridges and relations--

CREATE TABLE events_locations (
    event_id INT NOT NULL,
    location_id INT NOT NULL,
    PRIMARY KEY (event_id, location_id)
);




--- Add foreign key constraints

-- Orders--

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_events
FOREIGN KEY (event_id)
REFERENCES events;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_payment
FOREIGN KEY (payment_method_id)
REFERENCES payments;

-- EVENTS--

ALTER TABLE events
ADD CONSTRAINT fk_events_location
FOREIGN KEY (location_id)
REFERENCES locations;

ALTER TABLE events
ADD CONSTRAINT fk_events_equipments 
FOREIGN KEY (equipment_id) 
REFERENCES equipments;

-- PHOTOS--


ALTER TABLE photos
ADD CONSTRAINT fk_photos_events
FOREIGN KEY (event_id)
REFERENCES photos;

ALTER TABLE photos
ADD CONSTRAINT fk_photos_equipments
FOREIGN KEY (equipment_id)
REFERENCES equipments;

ALTER TABLE photos
ADD CONSTRAINT fk_photos_locations
FOREIGN KEY (location_id)
REFERENCES locations;

ALTER TABLE photos
ADD CONSTRAINT fk_photos_customers
FOREIGN KEY (customer_id)
REFERENCES customers;

--events_locations--

ALTER TABLE events_locations
ADD CONSTRAINT fk_events_locations_locations
FOREIGN KEY (location_id)
REFERENCES locations;

ALTER TABLE events_locations
ADD CONSTRAINT fk_events_locations_events
FOREIGN KEY (event_id)
REFERENCES events;



