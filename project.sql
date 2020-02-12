    
BEGIN
  FOR c IN ( SELECT table_name FROM user_tables WHERE table_name not LIKE 'A1_%' )
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
  END LOOP;
END;
/

-- tables
-- Table: CategoryProduct
CREATE TABLE CategoryProduct (
    IdCategory integer  NOT NULL,
    Type varchar2(30)  NOT NULL,
    CONSTRAINT CategoryProduct_pk PRIMARY KEY (IdCategory)
) ;

-- Table: City
CREATE TABLE City (
    idCity varchar2(50)  NOT NULL,
    Name varchar2(50)  NOT NULL,
    idRegion varchar2(50)  NOT NULL,
    CONSTRAINT City_pk PRIMARY KEY (idCity)
) ;

-- Table: Consultant
CREATE TABLE Consultant (
    IdConsultant integer  NOT NULL,
    Name varchar2(40)  NOT NULL,
    Surname varchar2(40)  NOT NULL,
    PhoneNumber varchar2(20)  NOT NULL,
    CONSTRAINT Consultant_pk PRIMARY KEY (IdConsultant)
) ;

-- Table: ContactInfo
CREATE TABLE ContactInfo (
    IdContactInfo integer  NOT NULL,
    idPurchase integer  NOT NULL,
    IdConsultant integer  NOT NULL,
    CONSTRAINT ContactInfo_pk PRIMARY KEY (IdContactInfo)
) ;

-- Table: Country
CREATE TABLE Country (
    idCountry integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    CONSTRAINT Country_pk PRIMARY KEY (idCountry)
) ;

-- Table: Customer
CREATE TABLE Customer (
    IdCustomer integer  NOT NULL,
    Name varchar2(40)  NOT NULL,
    Surname varchar2(40)  NOT NULL,
    Address varchar2(40)  NOT NULL,
    PhoneNumber varchar2(20)  NOT NULL,
    Balance float(20)  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (IdCustomer)
) ;

-- Table: DeliveryAddress
CREATE TABLE DeliveryAddress (
    IDAdress integer  NOT NULL,
    AddressStreet varchar2(50)  NOT NULL,
    IdCustomer integer  NOT NULL,
    idZipCode integer  NOT NULL,
    CONSTRAINT DeliveryAddress_pk PRIMARY KEY (IDAdress)
) ;

-- Table: Manufacturer
CREATE TABLE Manufacturer (
    idManufacturer integer  NOT NULL,
    ManufacturerName varchar2(50)  NOT NULL,
    CONSTRAINT Manufacturer_pk PRIMARY KEY (idManufacturer)
) ;

-- Table: Product
CREATE TABLE Product (
    idProduct integer  NOT NULL,
    Name varchar2(60)  NOT NULL,
    Price float(20)  NOT NULL,
    Weight float(20)  NOT NULL,
    Ammount integer  NOT NULL,
    CategoryProduct integer  NOT NULL,
    idManufacturer integer  NOT NULL,
    CONSTRAINT Product_pk PRIMARY KEY (idProduct)
) ;

-- Table: Purchase
CREATE TABLE Purchase (
    idPurchase integer  NOT NULL,
    IdCustomer integer  NOT NULL,
    Date_of_purchase timestamp  NOT NULL,
    idPurchaseStatus integer  NOT NULL,
    IDAdress integer  NOT NULL,
    CONSTRAINT Purchase_pk PRIMARY KEY (idPurchase)
) ;

-- Table: PurchaseStatus
CREATE TABLE PurchaseStatus (
    idPurchaseStatus integer  NOT NULL,
    StatusDescription varchar2(50)  NOT NULL,
    CONSTRAINT PurchaseStatus_pk PRIMARY KEY (idPurchaseStatus)
) ;

-- Table: Purchase_Product
CREATE TABLE Purchase_Product (
    IdPurc_Product integer  NOT NULL,
    idPurchase integer  NOT NULL,
    idProduct integer  NOT NULL,
    Quantity integer  NOT NULL,
    CONSTRAINT Purchase_Product_pk PRIMARY KEY (IdPurc_Product)
) ;

-- Table: Region
CREATE TABLE Region (
    idRegion varchar2(50)  NOT NULL,
    Name varchar2(50)  NOT NULL,
    idCountry integer  NOT NULL,
    CONSTRAINT Region_pk PRIMARY KEY (idRegion)
) ;

-- Table: Review
CREATE TABLE Review (
    Review_Id integer  NOT NULL,
    Rating number(1)  NOT NULL,
    Text varchar2(150)  NOT NULL,
    idProduct integer  NOT NULL,
    IdCustomer integer  NOT NULL,
    CONSTRAINT Review_pk PRIMARY KEY (Review_Id)
) ;

-- Table: ShoppingCart
CREATE TABLE ShoppingCart (
    CartID integer  NOT NULL,
    IdCustomer integer  NOT NULL,
    DateAdded timestamp  NOT NULL,
    CONSTRAINT ShoppingCart_pk PRIMARY KEY (CartID)
) ;

-- Table: ShoppingCart_Product
CREATE TABLE ShoppingCart_Product (
    idProduct integer  NOT NULL,
    CartID integer  NOT NULL,
    Quantity integer  NOT NULL,
    CONSTRAINT ShoppingCart_Product_pk PRIMARY KEY (idProduct,CartID)
) ;

-- Table: ZipCode
CREATE TABLE ZipCode (
    idZipCode integer  NOT NULL,
    idCity varchar2(50)  NOT NULL,
    CONSTRAINT ZipCode_pk PRIMARY KEY (idZipCode)
) ;

CREATE TABLE Top_Customers (
    id integer  NOT NULL,
    idCustomer integer NOT NULL,
    name varchar2(50),
    surname varchar2(50),
    balance float(20),
    CONSTRAINT TB_pk PRIMARY KEY (id)
);
-- Reference: City_Region (table: City)
ALTER TABLE City ADD CONSTRAINT City_Region
    FOREIGN KEY (idRegion)
    REFERENCES Region (idRegion);   

-- Reference: ContactInfo_Consultant (table: ContactInfo)
ALTER TABLE ContactInfo ADD CONSTRAINT ContactInfo_Consultant
    FOREIGN KEY (IdConsultant)
    REFERENCES Consultant (IdConsultant);

-- Reference: ContactInfo_Purchase (table: ContactInfo)
ALTER TABLE ContactInfo ADD CONSTRAINT ContactInfo_Purchase
    FOREIGN KEY (idPurchase)
    REFERENCES Purchase (idPurchase);

-- Reference: DeliveryAddress_Customer (table: DeliveryAddress)
ALTER TABLE DeliveryAddress ADD CONSTRAINT DeliveryAddress_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);

-- Reference: DeliveryAddress_ZipCode (table: DeliveryAddress)
ALTER TABLE DeliveryAddress ADD CONSTRAINT DeliveryAddress_ZipCode
    FOREIGN KEY (idZipCode)
    REFERENCES ZipCode (idZipCode);

-- Reference: Product_Dictionary (table: Product)
ALTER TABLE Product ADD CONSTRAINT Product_Dictionary
    FOREIGN KEY (CategoryProduct)
    REFERENCES CategoryProduct (IdCategory);

-- Reference: Product_Manufacturer (table: Product)
ALTER TABLE Product ADD CONSTRAINT Product_Manufacturer
    FOREIGN KEY (idManufacturer)
    REFERENCES Manufacturer (idManufacturer);

-- Reference: Purchase_Customer (table: Purchase)
ALTER TABLE Purchase ADD CONSTRAINT Purchase_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);

-- Reference: Purchase_DeliveryAddress (table: Purchase)
ALTER TABLE Purchase ADD CONSTRAINT Purchase_DeliveryAddress
    FOREIGN KEY (IDAdress)
    REFERENCES DeliveryAddress (IDAdress);

-- Reference: Purchase_Product_Product (table: Purchase_Product)
ALTER TABLE Purchase_Product ADD CONSTRAINT Purchase_Product_Product
    FOREIGN KEY (idProduct)
    REFERENCES Product (idProduct);

-- Reference: Purchase_Product_Purchase (table: Purchase_Product)
ALTER TABLE Purchase_Product ADD CONSTRAINT Purchase_Product_Purchase
    FOREIGN KEY (idPurchase)
    REFERENCES Purchase (idPurchase);

-- Reference: Purchase_PurchaseStatus (table: Purchase)
ALTER TABLE Purchase ADD CONSTRAINT Purchase_PurchaseStatus
    FOREIGN KEY (idPurchaseStatus)
    REFERENCES PurchaseStatus (idPurchaseStatus);

-- Reference: Region_Country (table: Region)
ALTER TABLE Region ADD CONSTRAINT Region_Country
    FOREIGN KEY (idCountry)
    REFERENCES Country (idCountry);

-- Reference: Review_Customer (table: Review)
ALTER TABLE Review ADD CONSTRAINT Review_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);

-- Reference: Review_Product (table: Review)
ALTER TABLE Review ADD CONSTRAINT Review_Product
    FOREIGN KEY (idProduct)
    REFERENCES Product (idProduct);

-- Reference: ShoppingCart_Customer (table: ShoppingCart)
ALTER TABLE ShoppingCart ADD CONSTRAINT ShoppingCart_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);

-- Reference: ShoppingCart_Product_Product (table: ShoppingCart_Product)
ALTER TABLE ShoppingCart_Product ADD CONSTRAINT ShoppingCart_Product_Product
    FOREIGN KEY (idProduct)
    REFERENCES Product (idProduct);

-- Reference: ShoppingCart_Product_ShopC (table: ShoppingCart_Product)
ALTER TABLE ShoppingCart_Product ADD CONSTRAINT ShoppingCart_Product_ShopC
    FOREIGN KEY (CartID)
    REFERENCES ShoppingCart (CartID);

-- Reference: ZipCode_City (table: ZipCode)
ALTER TABLE ZipCode ADD CONSTRAINT ZipCode_City
    FOREIGN KEY (idCity)
    REFERENCES City (idCity);

-- End of file.

INSERT INTO Country (idCountry, Name)
VALUES (1,'Poland');

INSERT INTO Country (idCountry, Name)
VALUES (2,'India');

INSERT INTO Country (idCountry, Name)
VALUES (3,'Russia');

INSERT INTO Country (idCountry, Name)
VALUES (4,'USA');

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (1,'Mazowietski', 1);

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (2,'Krakowski', 1);

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (3,'Wladiwostok', 3);

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (4,'Moskowski', 3);

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (5,'Delhi', 2);

INSERT INTO Region (idRegion, Name,idCountry)
VALUES (6,'Washinghton', 4);

INSERT INTO City (idCity, Name,idRegion)
VALUES (1,'Warsaw', 1);

INSERT INTO City (idCity, Name,idRegion)
VALUES (2,'Krakow', 2);

INSERT INTO City (idCity, Name,idRegion)
VALUES (3,'Washinghton', 6);

INSERT INTO City (idCity, Name,idRegion)
VALUES (4,'Winston', 6);

INSERT INTO ZipCode (idZipcode,idCity)
VALUES (111,1);

INSERT INTO ZipCode 
VALUES (112,1);

INSERT INTO ZipCode 
VALUES (231,2);

INSERT INTO ZipCode 
VALUES (713,4);

INSERT INTO ZipCode
Values(741,3);

INSERT INTO Customer(idCustomer,Name,Surname,Address,PhoneNumber,balance)
Values(1,'Mark','Twenn','Wolna24','567788545',65);

INSERT INTO Customer
Values(2,'John','Bread','Siwila3','56542113',41);

INSERT INTO Customer
Values(3,'William','Straign','Prosta55','91911423',2);

INSERT INTO Customer
Values(4,'Mike','Ponser','Mezewa31','41232144',4);

INSERT INTO Customer
Values(5,'Artur','Jones','Willyamsa24','41232144',242);

INSERT INTO DeliveryAddress(IDAdress, AddressStreet,IdCustomer,idZipCode)
Values(1,'Mazowska14',1,111);

INSERT INTO DeliveryAddress
Values(2,'Wilanowska133',2,111);

INSERT INTO DeliveryAddress
Values(3,'Maiewska17',3,231);

INSERT INTO DeliveryAddress
Values(4,'Maiewska20',4,231);

INSERT INTO PurchaseStatus
Values(1,'Expected to send');

INSERT INTO PurchaseStatus
Values(2,'On the way');

INSERT INTO PurchaseStatus
Values(3,'Delivered to the post office');

INSERT INTO Purchase
Values(1,1,TO_DATE('13-APR-2019 12:04:17', 'DD-MON-YYYY HH24:MI:SS'),1,1);

INSERT INTO Purchase
Values(2,2,TO_DATE('14-APR-2019 15:54:12', 'DD-MON-YYYY HH24:MI:SS'),1,2);

INSERT INTO Purchase
Values(3,3,TO_DATE('16-APR-2019 09:18:31', 'DD-MON-YYYY HH24:MI:SS'),2,3);

INSERT INTO Purchase
Values(4,5,TO_DATE('18-APR-2019 19:15:41', 'DD-MON-YYYY HH24:MI:SS'),3,4);

INSERT INTO Purchase
Values(5,1,TO_DATE('22-APR-2019 19:15:41', 'DD-MON-YYYY HH24:MI:SS'),1,1);


INSERT INTO Consultant
Values(1,'John','Sammer','+4285302413');

INSERT INTO Consultant
Values(2,'Sam','Mikeson','+421202442');

INSERT INTO Consultant
Values(3,'Bake','Miller','+513255623');

INSERT INTO ContactInfo
Values(1,1,2);

INSERT INTO ContactInfo
Values(2,2,1);

INSERT INTO ContactInfo
Values(3,3,3);

INSERT INTO ContactInfo
Values(4,4,1);

INSERT INTO CategoryProduct
Values(1,'Processor');

INSERT INTO CategoryProduct
Values(2,'RAM');

INSERT INTO CategoryProduct
Values(3,'Graphic Card');

INSERT INTO CategoryProduct
Values(4,'Motherboard');

INSERT INTO Manufacturer
Values(1,'Intel');

INSERT INTO Manufacturer
Values(2,'AMD');

INSERT INTO Manufacturer
Values(3,'NVIDIA');

INSERT INTO Manufacturer
Values(4,'WD');

INSERT INTO Manufacturer
Values(5,'Kingston');

INSERT INTO Product
Values(1,'Core i7 7700',600,1.1,14,1,1);

INSERT INTO Product
Values(2,'Core i5 6350',420,0.9,7,1,1);

INSERT INTO Product
Values(3,'Ryzen 5 2700',390,0.83,16,1,2);

INSERT INTO Product
Values(4,'Geforce GTX 2060',720,2.1,12,3,3);

INSERT INTO Product
Values(5,'Radeon RX420',700,2.1,12,3,2);

INSERT INTO Product
Values(6,'Green 3200 8GB',250,0.5,19,2,4);

INSERT INTO Product
Values(7,'CORE I9 9900K',1000,1,4,1,1);

INSERT INTO Purchase_product
VALUES(1,1,4,1);

INSERT INTO Purchase_product
VALUES(2,2,4,1);

INSERT INTO Purchase_product
VALUES(3,3,4,2);

INSERT INTO Purchase_product
VALUES(4,4,2,1);

INSERT INTO REVIEW
VALUES(1,8,'QUITE GOOD',1,2);

INSERT INTO REVIEW
VALUES(2,9,'One of the best for its price...',3,4);

INSERT INTO REVIEW
VALUES(3,4,'Bad quality ',5,3);

INSERT INTO REVIEW
VALUES(5,7,'GOOD PERFORMANCE ',5,2);

INSERT INTO REVIEW
VALUES(4,6,'Very expencive',6,4);

INSERT INTO REVIEW
VALUES(6,9,'SO happy ',6,1);

INSERT INTO REVIEW
VALUES(7,8,' ',6,2);

INSERT INTO SHOPPINGCART
VALUES(1,4,TO_DATE('15-APR-2019'));

INSERT INTO SHOPPINGCART
VALUES(2,2,TO_DATE('15-APR-2019'));

INSERT INTO SHOPPINGCART
VALUES(3,1,TO_DATE('16-APR-2019'));

INSERT INTO SHOPPINGCART_PRODUCT
VALUES(1,1,1);

INSERT INTO SHOPPINGCART_PRODUCT
VALUES(2,1,1);

INSERT INTO SHOPPINGCART_PRODUCT
VALUES(4,2,1);

SELECT * FROM Consultant;

-- 2 SELECT statements that includes at least two tables and contains WHERE clause
--1) SHOW THE INFO ABOUT THE CUSTOMERS AND THE INFORMATION ABOUT THE DELIVERY ADDRESS whose id starting with 2
SELECT *
FROM customer c JOIN deliveryaddress da ON c.idcustomer=da.idcustomer
WHERE c.idcustomer > 2;

SELECT pr.name, rev.rating, rev.text
FROM Review rev INNER JOIN Product pr ON rev.idproduct=pr.idproduct
WHERE rev.rating < 8
ORDER BY rev.rating DESC;

SELECT * FROM review;

-- 2 SELECT statements with aggregate functions

-- 1)the average price of the INTEL processors
SELECT AVG(p.price) as "AVERAGE PRICE"
FROM product p JOIN manufacturer mf ON p.idManufacturer=mf.idManufacturer
WHERE mf.idManufacturer=1;

SELECT *
FROM product;

-- 2)a products with at least 2 reviews
SELECT p.name, count(rev.idproduct) AS "NUM OF REVIEWS"
FROM product p INNER JOIN review rev ON p.idproduct=rev.idproduct
GROUP BY p.name
HAVING count(rev.idproduct) >= 2;   

SELECT *
FROM review;

-- 1 SELECT statement with subquery
-- find the product with price more expenive than the most expencive graphic card
SELECT p.name, p.price
FROM product p
Where p.price > ( SELECT MAX(p2.price)
                    FROM product p2 JOIN categoryProduct cp ON p2.categoryProduct=cp.idcategory
                    WHERE cp.type='Graphic Card');
                    
SELECT *
FROM product;

-- 1 SELECT statement with correlated subquery
-- for each product find it's recent purchase 
SELECT p.name, pur.date_of_purchase
FROM  purchase_product pp join  purchase pur ON pur.idPurchase=pp.idpurchase
                            join product p ON pp.idproduct=p.idproduct
WHERE pur.date_of_purchase = (SELECT MAX(pur2.date_of_purchase)
                                FROM purchase pur2 join purchase_product pp2 ON pur2.idPurchase=pp2.idpurchase
                                WHERE pp.idProduct=pp2.idProduct );
                                
SELECT *
FROM purchase;

--------------------------------------------------------------------------------------------------------------------------------
-- 3 TRIGGERS WITH CURSORS 
SET SERVEROUTPUT ON
    
-- 1) CREATE A TRIGGER WHICH SHOWS THE ALL NAMES OF COUNTRIES BEFORE INSERTING THE NEW ONE
/
CREATE OR REPLACE TRIGGER COUNTRIES_N
BEFORE INSERT ON COUNTRY
FOR EACH ROW 
DECLARE
CURSOR COUNTRIES IS
    SELECT NAME
    FROM COUNTRY;
CNTR varchar2(50);
BEGIN
OPEN COUNTRIES;
LOOP
    FETCH COUNTRIES INTO CNTR;
    DBMS_OUTPUT.put_line('COUNTRY: ' || CNTR);
    EXIT WHEN COUNTRIES%NOTFOUND;
END LOOP;
CLOSE COUNTRIES;
END;
/

DELETE COUNTRY WHERE idCountry = 6;
INSERT INTO Country (idCountry, Name)
VALUES (6,'Morocco');


--2)CREATE TRIGGER THAY AFTER ANY CHANGE WILL PRINT OLD,NEW AND DEFFERENCE PRICES FROM PRODUCT AND SHOW ALL MANUFACTURERS
/
CREATE OR REPLACE TRIGGER PRINT_PRICE_CHANGES
  AFTER UPDATE ON PRODUCT
  FOR EACH ROW
DECLARE
    PRICE_DIFF number;
CURSOR MANUFS IS
    SELECT MANUFACTURERNAME
    FROM MANUFACTURER;
MS varchar2(50);
BEGIN
OPEN MANUFS;
LOOP
    FETCH MANUFS INTO MS;
    DBMS_OUTPUT.put_line('MANUFACTURER: ' || MS);
    EXIT WHEN MANUFS%NOTFOUND;
END LOOP;
CLOSE MANUFS;

    PRICE_DIFF  := :new.PRICE  - :old.PRICE;
    dbms_output.put('OLD PRICE: ' || :old.PRICE);
    dbms_output.put('  NEW PRICE: ' || :new.PRICE);
    dbms_output.put_line('  Difference ' || PRICE_DIFF);
END;
/

--test
SELECT *
FROM PRODUCT;

UPDATE PRODUCT 
SET PRICE = 540
WHERE IDPRODUCT = 3;

-- 3)CREATE TRIGGER WHICH BEFORE CREATING THE REVIEW WILL ADD THE 'null' if the review text is empty
/
CREATE OR REPLACE TRIGGER EMPTY_TEXT
BEFORE INSERT ON REVIEW
FOR EACH ROW
DECLARE
CURSOR TEXTM IS
    SELECT REVIEW_ID
    FROM REVIEW
    WHERE LENGTH(TEXT) <= 1;
N INTEGER;
BEGIN
OPEN TEXTM;
LOOP
    FETCH TEXTM INTO N;
    UPDATE REVIEW
    SET TEXT = 'null' WHERE REVIEW_ID = N;
    DBMS_OUTPUT.put_line('REVIEW: ' || N);
    EXIT WHEN TEXTM%NOTFOUND;
END LOOP;
CLOSE TEXTM;
END;

/
--test
SELECT * FROM REVIEW;

DELETE FROM REVIEW WHERE REVIEW_ID = 8;
INSERT INTO REVIEW
VALUES(8,2,'BAD ',4,5);
INSERT INTO REVIEW
VALUES(9,2,' ',4,5);
-- 3 processes(cursors,exception)
-- 1)CREATE PROCESS ADD_BONUS THAT WILL ADD 200 TO THE BALANCE OF CUSTOMER WHO HAS MORE THAN 2 PURCHASES
SET SERVEROUTPUT ON
/
CREATE OR REPLACE PROCEDURE ADD_BONUS 
AS
CUSTOMER_NOT_EXISTS EXCEPTION;
CURSOR CUSTOMERS IS
    SELECT C.IDCUSTOMER
    FROM CUSTOMER C,PURCHASE P
    WHERE P.IDCUSTOMER=C.IDCUSTOMER
    GROUP BY C.IDCUSTOMER
    HAVING COUNT(P.IDPURCHASE) > 2;
CUST_ID INTEGER;
NUBER_OF_CUSTOMERS INTEGER;
BEGIN
SELECT C.IDCUSTOMER INTO NUBER_OF_CUSTOMERS
    FROM CUSTOMER C,PURCHASE P
    WHERE P.IDCUSTOMER=C.IDCUSTOMER
    GROUP BY P.IDCUSTOMER
    HAVING COUNT(P.IDPURCHASE) > 2;
IF (NUBER_OF_CUSTOMERS < 1) THEN RAISE CUSTOMER_NOT_EXISTS;
ELSE 
    OPEN CUSTOMERS;
    LOOP
        FETCH CUSTOMERS INTO CUST_ID;
        EXIT WHEN CUSTOMERS%NOTFOUND;
        UPDATE CUSTOMER
        SET BALANCE = (BALANCE + 200) WHERE IDCUSTOMER = CUST_ID;
    END LOOP;
    COMMIT;
    CLOSE CUSTOMERS;
END IF;
EXCEPTION WHEN CUSTOMER_NOT_EXISTS THEN DBMS_OUTPUT.put_line('CUSTOMER WITH A SUCH NUMBER OF PURCHAES DOESNT EXISTS');
END;
/

--TEST
INSERT INTO Purchase
Values(9,1,TO_DATE('28-APR-2019 19:15:41', 'DD-MON-YYYY HH24:MI:SS'),3,1);
    
  SELECT C.IDCUSTOMER,C.BALANCE,COUNT(P.IDPURCHASE)
    FROM CUSTOMER C,PURCHASE P
    WHERE P.IDCUSTOMER=C.IDCUSTOMER
    GROUP BY C.IDCUSTOMER,C.BALANCE
    HAVING COUNT(P.IDPURCHASE) > 2;
    
        
    EXEC ADD_BONUS;
    
    DELETE PURCHASE 
    WHERE IDPURCHASE = 6;

--2) CREATE A PROCEDURE WHICH WILL DELETE ALL PURCHASE RECORDS WHOSE DATE EXCEEDS GIVEN AS A PARAMETER
    SET SERVEROUTPUT ON
    /
CREATE OR REPLACE PROCEDURE DELETE_PURCHASE(
     DT TIMESTAMP)
AS
    NO_SUCH_PURCHASE EXCEPTION;
    DATES_ID INTEGER;
    CURSOR DATE_PURCHASE IS
        SELECT IDPURCHASE
        FROM PURCHASE
        WHERE DATE_OF_PURCHASE < DT;
BEGIN
SELECT COUNT(IDPURCHASE)INTO DATES_ID 
        FROM PURCHASE
        WHERE DATE_OF_PURCHASE < DT;
IF (DATES_ID < 1) THEN RAISE NO_SUCH_PURCHASE;
ELSE 
    OPEN DATE_PURCHASE;
        LOOP
        FETCH DATE_PURCHASE INTO DATES_ID;
        EXIT WHEN DATE_PURCHASE%NOTFOUND;
        DELETE FROM CONTACTINFO WHERE IDPURCHASE = DATES_ID;
        DELETE FROM PURCHASE_PRODUCT WHERE IDPURCHASE = DATES_ID;
        DELETE FROM PURCHASE WHERE IDPURCHASE = DATES_ID;
        END LOOP;
    COMMIT;
    CLOSE DATE_PURCHASE;
END IF;
EXCEPTION WHEN NO_SUCH_PURCHASE THEN DBMS_OUTPUT.put_line('THERE IS NO SUCH A PURCHASE EXISTS');
END;
/
--TEST
SELECT * FROM PURCHASE;
EXEC DELETE_PURCHASE(TO_DATE('12-APR-2019 15:54:12', 'DD-MON-YYYY HH24:MI:SS'));

--3) CREATE A PROCEDURE WHICH INCREASE THE PRICE OF THE PRODUCT BY GIVEN MANUFACTURER AND INCREASING PERCENT AS ARGUMENT
SET SERVEROUTPUT ON
/
CREATE OR REPLACE PROCEDURE INCREASE_PRICE(
    PERCENTAGE NUMBER,
    MANUFACTURERN VARCHAR2)
AS
    NO_SUCH_MANUFACTURER EXCEPTION;
    IDMAN INTEGER;
    MANNUMB INTEGER;
    CURSOR MANUFACTURERS IS 
        SELECT IDMANUFACTURER
        FROM MANUFACTURER
        WHERE MANUFACTURERNAME LIKE MANUFACTURERN;
BEGIN
SELECT COUNT(IDMANUFACTURER) INTO MANNUMB
        FROM MANUFACTURER
        WHERE MANUFACTURERNAME LIKE MANUFACTURERN;
IF(MANNUMB < 1) THEN RAISE NO_SUCH_MANUFACTURER;
ELSE
 OPEN MANUFACTURERS;
    LOOP
        FETCH MANUFACTURERS INTO IDMAN;
        EXIT WHEN MANUFACTURERS%NOTFOUND;
        UPDATE PRODUCT
        SET PRICE = (PRICE + PRICE*PERCENTAGE) WHERE IDMANUFACTURER = IDMAN;
    END LOOP;
    COMMIT;
    CLOSE MANUFACTURERS;
END IF;
EXCEPTION WHEN NO_SUCH_MANUFACTURER THEN DBMS_OUTPUT.put_line('THERE IS NO SUCH A MANUFACTURER EXISTS');
END;
/

SELECT * FROM PRODUCT;
SELECT * FROM MANUFACTURER;
EXEC INCREASE_PRICE(0.2,'DD');
EXEC INCREASE_PRICE(0.1,'Intel');

-- 4)CREATE PROCEDURE WHICH WILL ADD CUSTOMERS WHO HAS BALANCE GREATER THAN 500 TO THE TABLE TOP_Customers
/
CREATE OR REPLACE PROCEDURE TOB_BALANCE_CUSTOMERS
AS
    NO_SUCH_CUSTOMER EXCEPTION;
    countppl INTEGER;
    X INTEGER;
CURSOR CUSTOMERS IS 
        SELECT IDCUSTOMER,NAME,SURNAME,BALANCE
        FROM CUSTOMER
        WHERE BALANCE > 200;
    fetchinto customers%rowtype;
BEGIN
SELECT COUNT(IDCUSTOMER) INTO countppl
        FROM CUSTOMER
        WHERE BALANCE > 200;
IF(countppl < 1) THEN RAISE NO_SUCH_CUSTOMER;
ELSE
 OPEN CUSTOMERS;
    LOOP
        FETCH CUSTOMERS INTO fetchinto;
        EXIT WHEN CUSTOMERS%NOTFOUND;
        SELECT NVL(MAX(ID)+1,1) INTO X FROM TOP_CUSTOMERS;
        INSERT INTO Top_customers(id, idcustomer, name, surname, balance) VALUES(X,fetchinto.idcustomer,fetchinto.name,fetchinto.surname,fetchinto.balance);
    END LOOP;
    COMMIT;
    CLOSE CUSTOMERS;
END IF;
EXCEPTION WHEN NO_SUCH_CUSTOMER THEN DBMS_OUTPUT.put_line('THERE IS NO SUCH A CUSTOMER EXISTS');
END;
/

--test
EXEC TOB_BALANCE_CUSTOMERS;
Select * from Top_customers;

SELECT NVL(MAX(ID)+1,1) FROM TOP_CUSTOMERS;


