#CREATING THE DATABASE AND TABLES
#-----------------------------------
# 1ST
Create Database `order-directory` ;
use `order-directory`;        

create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);

CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));
  
  CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );
  
  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)
  
  );
  
  CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );
  
  CREATE TABLE IF NOT EXISTS `orders` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );
  
  CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );
  #------------------------------------------------------------
  
  # INSERTING THE RECORDS
#--------------------------------------------------------------------
# 2ND
insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');


INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");

INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);

INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);

INSERT INTO `ORDERS` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDERS` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDERS` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDERS` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDERS` VALUES(30,3500,"2021-08-16",4,3);

INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);
#--------------------------------------------------------------------

# 3rd

SELECT COUNT(CUS_GENDER) FROM customer c inner join orders o on c.CUS_ID=o.CUS_ID WHERE O.ORD_AMOUNT>=3000  group by C.CUS_GENDER ;

#4th

select o.ORD_ID,o.ORD_AMOUNT,o.ORD_DATE,p.PRO_ID,p.PRO_NAME
 from orders o join product_details pd on o.PROD_ID=pd.PROD_ID
 join product p on p.PRO_ID=pd.PRO_ID
 where o.CUS_ID =2; 
 
 #5th
 
 select s.* from supplier s join product_details p on s.SUPP_ID=p.SUPP_ID 
 group by p.SUPP_ID having count(p.SUPP_ID)>1;
 
 #6th
 
 select category.* from `orders` inner join product_details
 on `orders`.prod_id=product_details.prod_id inner join
 product on product.pro_id=product_details.pro_id inner join
 category on category.cat_id=product.cat_id having min(`orders`.ord_amount);
 
 #7th
 
 select p.pro_id, p.pro_name from product p join
 product_details pd on p.PRO_ID = pd.PRO_ID join
 orders o on pd.prod_id = o.PROD_ID 
 where ORD_DATE > '2021-10-05';
 
 #8th
 
 select s.supp_id, supp_name, c.CUS_NAME,r.rat_ratstars from 
 supplier s join  rating r on s.SUPP_ID = r.SUPP_ID 
 join customer c on r.CUS_ID=c.CUS_ID order by RAT_RATSTARS desc
 limit 3;
 
 #9th
 
 select cus_name,cus_gender from customer where CUS_NAME like '%a' 
 or CUS_NAME like 'a%';
 
 #10th

 select sum(ord_amount) from orders o join customer c on o.cus_id = c.cus_id
 and cus_gender  = 'M';
 
 #11th
 
 select * from customer c left join orders o on c.cus_id = o.cus_id;
 
 #12th
 delimiter &&
 create procedure displayRating()
 begin
 select s.SUPP_ID,s.SUPP_NAME,r.rat_ratstars ,
 case
 when rat_ratstars > 4 then 'Genuine Supplier'
 when rat_ratstars > 2 then 'Average Supplier'
 else 'Supplier should not be considered'
 end as Verdict
 from supplier s join rating r on  s.supp_id = r.supp_id;
 end && 
call displayRating();
 

  

