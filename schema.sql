-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Address` (
  `AddressID` varchar(8) NOT NULL,
  `UserID` varchar(8) NOT NULL,
  `Address_Type` varchar(20) NOT NULL,
  `AddressLine1` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `Province` varchar(45) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `PostalCode` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`AddressID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Buyers`
--

DROP TABLE IF EXISTS `Buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Buyers` (
  `BuyerID` varchar(8) NOT NULL,
  `UserID` varchar(8) NOT NULL,
  `USER_TYPE` varchar(1) NOT NULL,
  `MembershipID` varchar(8) DEFAULT NULL,
  `FName` varchar(45) NOT NULL,
  `LName` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) NOT NULL DEFAULT 'xxx-xxx-xxxx',
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`UserID`,`USER_TYPE`),
  CONSTRAINT `buyers_chk_1` CHECK ((`USER_TYPE` = _utf8mb4'B'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `DepartmentID` varchar(8) NOT NULL,
  `DepName` varchar(45) NOT NULL,
  `ContactFName` text NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Discount`
--

DROP TABLE IF EXISTS `Discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discount` (
  `DiscountID` varchar(8) NOT NULL,
  `DiscountPrecent` decimal(5,2) NOT NULL,
  PRIMARY KEY (`DiscountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Membership`
--

DROP TABLE IF EXISTS `Membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Membership` (
  `MembershipID` varchar(8) NOT NULL,
  `MembershipType` varchar(45) NOT NULL,
  PRIMARY KEY (`MembershipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Offer`
--

DROP TABLE IF EXISTS `Offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Offer` (
  `OfferID` varchar(8) NOT NULL,
  `ProductID` varchar(8) DEFAULT NULL,
  `DiscountID` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`OfferID`),
  KEY `fk_Product_has_Discount_Discount1_idx` (`DiscountID`),
  KEY `fk_Product_has_Discount_Product1_idx` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `OrderID` varchar(8) NOT NULL,
  `UserID` varchar(8) NOT NULL,
  `ShipperID` varchar(8) NOT NULL,
  `OrderDate` date NOT NULL,
  `RequiredDate` date NOT NULL,
  `Freight` decimal(10,0) NOT NULL,
  `SalesTax` decimal(10,0) NOT NULL,
  `TimeStamp` timestamp NOT NULL,
  `TransactStatus` varchar(25) NOT NULL,
  `InvoiceAmount` int NOT NULL,
  `PaymentDate` date NOT NULL,
  `ItemQuantity` int DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `UserID_idx` (`UserID`),
  KEY `ShipperID_idx` (`ShipperID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Orders_has_Product`
--

DROP TABLE IF EXISTS `Orders_has_Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders_has_Product` (
  `OrderProductID` varchar(8) NOT NULL,
  `Orders_OrderID` varchar(8) NOT NULL,
  `Product_ProductID` varchar(8) NOT NULL,
  PRIMARY KEY (`OrderProductID`),
  KEY `fk_Orders_has_Product_Product1_idx` (`Product_ProductID`),
  KEY `fk_Orders_has_Product_Orders1_idx` (`Orders_OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `PaymentID` varchar(8) NOT NULL,
  `OrderID` varchar(8) NOT NULL,
  `Payment_Type` varchar(1) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `OrderID_idx` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_CreditCard`
--

DROP TABLE IF EXISTS `Payment_CreditCard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_CreditCard` (
  `CreditCardID` varchar(8) NOT NULL,
  `PaymentID` varchar(8) NOT NULL,
  `CreditCardNum` varchar(20) NOT NULL,
  `CardExpM` int NOT NULL,
  `CardExpY` int NOT NULL,
  `CardSecurityNumber` varchar(45) NOT NULL,
  `CardAddress` varchar(45) NOT NULL,
  `CardCity` varchar(45) NOT NULL,
  `CardPostalCode` varchar(45) NOT NULL,
  PRIMARY KEY (`CreditCardID`),
  KEY `PaymentID_idx` (`PaymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment_Giftcard`
--

DROP TABLE IF EXISTS `Payment_Giftcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_Giftcard` (
  `GiftcardID` varchar(8) NOT NULL,
  `PaymentID` varchar(8) NOT NULL,
  `GiftCardNumber` char(16) NOT NULL,
  `GiftcardExpMM` char(2) NOT NULL,
  `GiftcardExpYYYY` varchar(4) NOT NULL,
  PRIMARY KEY (`GiftcardID`),
  KEY `PaymentID_idx` (`PaymentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `ProductID` varchar(8) NOT NULL,
  `DepartmentID` varchar(8) NOT NULL,
  `Category` varchar(45) NOT NULL,
  `IDSKU` varchar(8) NOT NULL,
  `ProductName` varchar(45) NOT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(10,0) NOT NULL,
  `Ranking` int DEFAULT NULL,
  `ProductDesc` text,
  `UnitsInStock` int DEFAULT NULL,
  `UnitsInOrder` int DEFAULT NULL,
  `Picture` blob,
  `UnitPriceEuro` decimal(10,0) DEFAULT NULL,
  `UnitPriceUSD` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `ReviewID` varchar(8) NOT NULL,
  `ProductID` varchar(8) NOT NULL,
  `CustomerReview` varchar(45) DEFAULT NULL,
  `Rating` tinyint(1) NOT NULL,
  PRIMARY KEY (`ReviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sellers`
--

DROP TABLE IF EXISTS `Sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sellers` (
  `SellerID` varchar(8) NOT NULL,
  `UserID` varchar(8) NOT NULL,
  `USER_TYPE` varchar(1) NOT NULL,
  `CompanyName` varchar(45) NOT NULL,
  `ContactFName` varchar(45) NOT NULL,
  `ContactLName` varchar(45) NOT NULL,
  `ContactPosition` varchar(45) NOT NULL,
  `Phone` varchar(15) NOT NULL DEFAULT 'xxx-xxx-xxxx',
  `Email` varchar(45) NOT NULL,
  `Logo` blob,
  PRIMARY KEY (`UserID`,`USER_TYPE`),
  KEY `UserID_idx` (`UserID`),
  CONSTRAINT `sellers_chk_1` CHECK ((`USER_TYPE` = _utf8mb3'S'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shipper`
--

DROP TABLE IF EXISTS `Shipper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipper` (
  `ShipperID` varchar(8) NOT NULL,
  `ShipperName` varchar(45) DEFAULT NULL,
  `ContactName` varchar(45) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ShipperID`),
  UNIQUE KEY `ShipperID_UNIQUE` (`ShipperID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shopping Cart`
--

DROP TABLE IF EXISTS `Shopping Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shopping Cart` (
  `ShoppingCartID` varchar(8) NOT NULL,
  `ProductID` varchar(8) NOT NULL,
  `OrderStatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ShoppingCartID`),
  KEY `ProductID_idx` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `UserID` varchar(8) NOT NULL,
  `UserFName` varchar(45) NOT NULL,
  `UserLName` varchar(45) NOT NULL,
  `USER_TYPE` varchar(1) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `DateCreated` date NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Wishlist`
--

DROP TABLE IF EXISTS `Wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wishlist` (
  `WishlistID` varchar(8) NOT NULL,
  `ProductID` varchar(8) NOT NULL,
  PRIMARY KEY (`WishlistID`),
  KEY `ProductID_idx` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-12 19:11:28
