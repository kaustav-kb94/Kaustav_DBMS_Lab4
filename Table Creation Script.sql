
-- TABLE creation script

create database `order-directory`;

use `order-directory`;

create table supplier (
 SUPP_ID int primary key,
 SUPP_NAME varchar(50)  NOT NULL,
 SUPP_CITY varchar(50) NOT NULL,
 SUPP_PHONE varchar(50) NOT NULL
);

create table customer (
 CUS_ID int primary key,
 CUS_NAME varchar(20)  NOT NULL,
 CUS_PHONE varchar(10) NOT NULL,
 CUS_CITY varchar(30) NOT NULL,
 CUS_GENDER char
);

create table category (
 CAT_ID int primary key,
 CAT_NAME varchar(20)  NOT NULL
);

create table product (
 PRO_ID int primary key,
 PRO_NAME varchar(20)  NOT NULL DEFAULT "Dummy",
 PRO_DESC varchar(60),
 CAT_ID int,
 FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID)
);

create table supplier_pricing (
 PRICING_ID int primary key,
 PRO_ID int,
 SUPP_ID int,
 SUPP_PRICE int DEFAULT 0,
 FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID),
 FOREIGN KEY (SUPP_ID) REFERENCES supplier(SUPP_ID)
);

create table `order` (
ORD_ID int primary key,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE,
CUS_ID INT NOT NULL,
PRICING_ID INT NOT NULL,
FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID),
FOREIGN KEY (PRICING_ID) REFERENCES supplier_pricing(PRICING_ID)
);


CREATE TABLE rating (
RAT_ID INT primary key,
ORD_ID INT NOT NULL,
RAT_RATSTARS INT NOT NULL,
FOREIGN KEY (ORD_ID) REFERENCES `order`(ORD_ID)
);


