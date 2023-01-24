/*
,ID ,VIN ,Manufacturer ,Model ,Year ,Color |
,--- ,--- ,--- ,--- ,--- ,--- |
,0 ,3K096I98581DHSNUP ,Volkswagen ,Tiguan ,2019 ,Blue |
,1 ,ZM8G7BEUQZ97IH46V ,Peugeot ,Rifter ,2019 ,Red |
,2 ,RKXVNNIHLVVZOUB4M ,Ford ,Fusion ,2018 ,White |
,3 ,HKNDGS7CU31E9Z7JW ,Toyota ,RAV4 ,2018 ,Silver |
,4 ,DAM41UDN3CHU2WVF6 ,Volvo ,V60 ,2019 ,Gray |
,5 ,DAM41UDN3CHU2WVF6 ,Volvo ,V60 Cross Country ,2019 ,Gray |

### Customers

,ID ,Customer ID ,Name ,Phone ,Email ,Address ,City ,State/Province ,Country ,Postal |
,--- ,--- ,--- ,--- ,--- ,--- ,--- ,--- ,--- ,--- |
,0 ,10001 ,Pablo Picasso ,+34 636 17 63 82 ,- ,Paseo de la Chopera, 14 ,Madrid ,Madrid ,Spain ,28045 |
,1 ,20001 ,Abraham Lincoln ,+1 305 907 7086 ,- ,120 SW 8th St ,Miami ,Florida ,United States ,33130 |
,2 ,30001 ,Napoléon Bonaparte ,+33 1 79 75 40 00 ,- ,40 Rue du Colisée ,Paris ,Île-de-France ,France ,75008 |

### Salespersons

,ID ,Staff ID ,Name ,Store |
,--- ,--- ,--- ,--- |
,0 ,00001 ,Petey Cruiser ,Madrid |
,1 ,00002 ,Anna Sthesia ,Barcelona |
,2 ,00003 ,Paul Molive ,Berlin |
,3 ,00004 ,Gail Forcewind ,Paris |
,4 ,00005 ,Paige Turner ,Mimia |
,5 ,00006 ,Bob Frapples ,Mexico City |
,6 ,00007 ,Walter Melon ,Amsterdam |
,7 ,00008 ,Shonda Leer ,São Paulo |

### Invoices

,ID ,Invoice Number ,Date ,Car ,Customer ,Sales Person |
,--- ,--- ,--- ,--- ,--- ,--- |
,0 ,852399038 ,22-08-2018 ,0 ,1 ,3 |
,1 ,731166526 ,31-12-2018 ,3 ,0 ,5 |
,2 ,271135104 ,22-01-2019 ,2 ,2 ,7 |
*/

USE lab_mysql;

INSERT INTO cars (ID,
VIN, 
Manufacturer,
Model,
Year,
Color
)
VALUES cars
(0,"3K096I98581DHSNUP", "Volkswagen", "Tiguan", 2019 ,"Blue"),
(NULL,"ZM8G7BEUQZ97IH46V" ,"Peugeot" ,"Rifter" ,2019 ,"Red" ),
(NULL,"RKXVNNIHLVVZOUB4M" ,"Ford" ,"Fusion" ,2018 ,"White" ),
(NULL,"HKNDGS7CU31E9Z7JW" ,"Toyota" ,"RAV4" ,2018 ,"Silver" ),
( NULL,"DAM41UDN3CHU2WVF6" ,"Volvo" ,"V60" ,2019 ,"Gray" ),
(NULL,"DAM41UDN3CHU2WVF6" ,"Volvo" ,"V60 Cross Country" ,2019 ,"Gray" );

INSERT INTO customers (ID,
CustomerId,
Name,
Phone, 
Email, 
Address, 
City, 
State_province, 
Country, 
Postal)
VALUES 
(1, 10001 ,"Pablo Picasso" ,"+34 636 17 63 82" , NULL ,"Paseo de la Chopera, 14", "Madrid" ,"Madrid" ,"Spain" ,28045),
(NULL, 20001 ,"Abraham Lincoln" ,"+1 305 907 7086" , NULL ,"120 SW 8th St", "Miami" ,"Florida" ,"United States" ,33130),
(NULL, 30001 ,"Napoléon Bonaparte" ,"+33 1 79 75 40 00" , NULL,"40 Rue du Colisée" ,"Paris" ,"Île-de-France" ,"France" ,75008);

INSERT INTO salespersons(ID, StaffId,
Name,
Store)
VALUES
(0, 00001 ,"Petey Cruiser" ,"Madrid"),
(NULL, 00002 ,"Anna Sthesia" ,"Barcelona"),
(NULL, 00003 ,"Paul Molive" ,"Berlin"),
(NULL,00004 ,"Gail Forcewind" ,"Paris"),
(NULL, 00005 ,"Paige Turner" ,"Mimia"),
(NULL,00006 ,"Bob Frapples" ,"Mexico City"),
(NULL,00007 ,"Walter Melon" ,"Amsterdam"),
( NULL, 00008 ,"Shonda Leer" ,"São Paulo");

INSERT INTO invoice(ID, Invoice_Number,
Date,
Car,
Customer,
Sales_Person)
VALUES
(0 ,852399038 ,STR_TO_DATE("22-08-2018","%d-%m-%Y") ,1 ,1 ,3),
(1 ,731166526 ,STR_TO_DATE("31-12-2018","%d-%m-%Y") ,3 ,1 ,5),
(2 ,271135104 ,STR_TO_DATE("22-01-2019","%d-%m-%Y") ,2 ,2 ,7);