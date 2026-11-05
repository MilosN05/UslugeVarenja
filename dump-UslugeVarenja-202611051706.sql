-- MySQL dump 10.13  Distrib 9.7.2, for Linux (x86_64)
--
-- Host: localhost    Database: UslugeVarenja
-- ------------------------------------------------------
-- Server version	9.7.2

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '12f5a803-d6ea-11f1-8b1e-de1cf3a2c67f:1-12';

--
-- Table structure for table `Mesto`
--

DROP TABLE IF EXISTS `Mesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mesto` (
  `idMesto` bigint NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `postanskiBroj` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`idMesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mesto`
--

LOCK TABLES `Mesto` WRITE;
/*!40000 ALTER TABLE `Mesto` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Narucilac`
--

DROP TABLE IF EXISTS `Narucilac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Narucilac` (
  `idNarucilac` bigint NOT NULL AUTO_INCREMENT,
  `ime` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `brojTelefona` varchar(100) NOT NULL,
  `adresa` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `idMesto` bigint NOT NULL,
  PRIMARY KEY (`idNarucilac`),
  KEY `Narucilac_Mesto_FK` (`idMesto`),
  CONSTRAINT `Narucilac_Mesto_FK` FOREIGN KEY (`idMesto`) REFERENCES `Mesto` (`idMesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Narucilac`
--

LOCK TABLES `Narucilac` WRITE;
/*!40000 ALTER TABLE `Narucilac` DISABLE KEYS */;
/*!40000 ALTER TABLE `Narucilac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Racun`
--

DROP TABLE IF EXISTS `Racun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Racun` (
  `idRacun` bigint NOT NULL AUTO_INCREMENT,
  `datumIzdavanja` date NOT NULL,
  `datumPlacanja` date DEFAULT NULL,
  `nacinPlacanja` enum('gotovina','kartica') DEFAULT NULL,
  `ukupanIznos` double NOT NULL,
  `idNarucilac` bigint NOT NULL,
  `idVarilac` bigint NOT NULL,
  PRIMARY KEY (`idRacun`),
  KEY `Racun_Varilac_FK` (`idVarilac`),
  KEY `Racun_Narucilac_FK` (`idNarucilac`),
  CONSTRAINT `Racun_Narucilac_FK` FOREIGN KEY (`idNarucilac`) REFERENCES `Narucilac` (`idNarucilac`),
  CONSTRAINT `Racun_Varilac_FK` FOREIGN KEY (`idVarilac`) REFERENCES `Varilac` (`idVarilac`),
  CONSTRAINT `Racun_CHECK` CHECK ((`ukupanIznos` > 0)),
  CONSTRAINT `Racun_CHECK_1` CHECK ((`idNarucilac` > 0)),
  CONSTRAINT `Racun_CHECK_2` CHECK ((`idVarilac` > 0)),
  CONSTRAINT `Racun_CHECK_3` CHECK ((`datumPlacanja` >= `datumIzdavanja`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Racun`
--

LOCK TABLES `Racun` WRITE;
/*!40000 ALTER TABLE `Racun` DISABLE KEYS */;
/*!40000 ALTER TABLE `Racun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sertifikat`
--

DROP TABLE IF EXISTS `Sertifikat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sertifikat` (
  `idSertifikat` bigint NOT NULL AUTO_INCREMENT,
  `standard` enum('ISO') NOT NULL,
  `naziv` varchar(100) NOT NULL,
  PRIMARY KEY (`idSertifikat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sertifikat`
--

LOCK TABLES `Sertifikat` WRITE;
/*!40000 ALTER TABLE `Sertifikat` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sertifikat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StavkaRacuna`
--

DROP TABLE IF EXISTS `StavkaRacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StavkaRacuna` (
  `idRacun` bigint NOT NULL,
  `rb` bigint NOT NULL,
  `napomena` varchar(200) DEFAULT NULL,
  `trajanjeUSatima` bigint NOT NULL,
  `cenaPoSatu` double NOT NULL,
  `iznos` double DEFAULT NULL,
  PRIMARY KEY (`idRacun`,`rb`),
  CONSTRAINT `StavkaRacuna_CHECK` CHECK ((`trajanjeUSatima` > 0)),
  CONSTRAINT `StavkaRacuna_CHECK_1` CHECK ((`cenaPoSatu` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StavkaRacuna`
--

LOCK TABLES `StavkaRacuna` WRITE;
/*!40000 ALTER TABLE `StavkaRacuna` DISABLE KEYS */;
/*!40000 ALTER TABLE `StavkaRacuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Varilac`
--

DROP TABLE IF EXISTS `Varilac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Varilac` (
  `idVarilac` bigint NOT NULL AUTO_INCREMENT,
  `korisnickoIme` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `brojTelefona` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idVarilac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Varilac`
--

LOCK TABLES `Varilac` WRITE;
/*!40000 ALTER TABLE `Varilac` DISABLE KEYS */;
/*!40000 ALTER TABLE `Varilac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VarilacSertifikat`
--

DROP TABLE IF EXISTS `VarilacSertifikat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VarilacSertifikat` (
  `idVarilac` bigint NOT NULL AUTO_INCREMENT,
  `idSertifikat` bigint NOT NULL,
  `datumSticanja` date NOT NULL,
  `datumValidnosti` date NOT NULL,
  PRIMARY KEY (`idVarilac`,`idSertifikat`),
  KEY `VarilacSertifikat_Sertifikat_FK` (`idSertifikat`),
  CONSTRAINT `VarilacSertifikat_Sertifikat_FK` FOREIGN KEY (`idSertifikat`) REFERENCES `Sertifikat` (`idSertifikat`),
  CONSTRAINT `VarilacSertifikat_Varilac_FK` FOREIGN KEY (`idVarilac`) REFERENCES `Varilac` (`idVarilac`),
  CONSTRAINT `VarilacSertifikat_CHECK` CHECK ((`datumSticanja` < `datumValidnosti`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VarilacSertifikat`
--

LOCK TABLES `VarilacSertifikat` WRITE;
/*!40000 ALTER TABLE `VarilacSertifikat` DISABLE KEYS */;
/*!40000 ALTER TABLE `VarilacSertifikat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VrstaVarenja`
--

DROP TABLE IF EXISTS `VrstaVarenja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VrstaVarenja` (
  `idVrstaVarenja` bigint NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `opis` varchar(200) DEFAULT NULL,
  `cenaPoSatuAktuelno` double NOT NULL,
  PRIMARY KEY (`idVrstaVarenja`),
  CONSTRAINT `VrstaVarenja_CHECK` CHECK ((`cenaPoSatuAktuelno` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VrstaVarenja`
--

LOCK TABLES `VrstaVarenja` WRITE;
/*!40000 ALTER TABLE `VrstaVarenja` DISABLE KEYS */;
/*!40000 ALTER TABLE `VrstaVarenja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'UslugeVarenja'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-05 17:06:21
