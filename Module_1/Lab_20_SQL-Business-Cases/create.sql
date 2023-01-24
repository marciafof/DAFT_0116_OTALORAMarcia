-- CREATE DATABASE lab_mysql;
USE lab_mysql;

CREATE TABLE cars (
ID INT AUTO_INCREMENT PRIMARY KEY,
VIN varchar(20), 
Manufacturer varchar(50),
Model varchar(50),
Year int,
Color varchar(20)

-- PRIMARY KEY(carsID)
-- 
);
-- ALTER TABLE cars ADD Id INT NOT NULL AUTO_INCREMENT;



CREATE TABLE salespersons (
ID INT AUTO_INCREMENT PRIMARY KEY,
StaffId varchar(10),
Name varchar (100),
Store varchar (100)

);


CREATE TABLE customers (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerId int,
  Name varchar (100),
  Phone varchar(50),
  Email varchar (50),
  Address varchar (140),
  City varchar (50),
  State_province varchar (50),
  Country varchar(50),
  Postal varchar (50)

);

CREATE TABLE invoice (
ID INT AUTO_INCREMENT PRIMARY KEY,
Invoice_Number int,
Date date,
Car int,
Customer int,
Sales_Person int,

FOREIGN KEY (Customer) REFERENCES customers(ID),
FOREIGN KEY (Car) REFERENCES cars(ID),
FOREIGN KEY (Sales_Person) REFERENCES salespersons(ID)

);