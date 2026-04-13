-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: universidade
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sexo` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'Luan','luan@gmail.com','M'),(2,'Evelen','evelen@gmail.com','F'),(3,'Gustavo','gustavos@gmail.com','M'),(4,'Eduardo','eduardo@gmail.com','M'),(5,'Carlos','carlos@email.com','M'),(6,'Fernanda','fernanda@email.com','F'),(7,'Lucas','lucas@email.com','M'),(8,'Juliana','juliana@email.com','F'),(9,'Pedro','pedro@email.com','M'),(10,'Camila','camila@email.com','F');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `carga_horaria` int DEFAULT NULL,
  `vagas` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_vagas` CHECK ((`vagas` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'Pedagogia',200,0),(2,'Historia',200,0),(3,'Sitema Para Internet',180,0),(4,'cc',250,0);
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplinas`
--

LOCK TABLES `disciplinas` WRITE;
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` VALUES (1,'Banco de dados'),(2,'Logica de Programacao'),(3,'Didatica'),(4,'Historia Antiga'),(5,'Fundamentos de Computacao');
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matricula`
--

DROP TABLE IF EXISTS `matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matricula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aluno_id` int DEFAULT NULL,
  `curso_id` int DEFAULT NULL,
  `data_matricula` date DEFAULT NULL,
  `semestre` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_matricula` (`aluno_id`,`curso_id`),
  KEY `curso_id` (`curso_id`),
  CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`),
  CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matricula`
--

LOCK TABLES `matricula` WRITE;
/*!40000 ALTER TABLE `matricula` DISABLE KEYS */;
INSERT INTO `matricula` VALUES (1,1,1,'2024-01-10','2024.1'),(2,2,1,'2024-01-11','2024.1'),(3,3,2,'2024-01-12','2024.1'),(4,4,2,'2024-01-13','2024.1'),(5,5,3,'2024-01-14','2024.1'),(6,6,3,'2024-01-15','2024.1'),(7,7,1,'2024-01-16','2024.1'),(8,8,2,'2024-01-17','2024.1'),(9,9,3,'2024-01-18','2024.1'),(10,10,1,'2024-01-19','2024.1'),(11,1,2,'2024-02-01','2024.1'),(12,2,3,'2024-02-02','2024.1'),(13,3,1,'2024-02-03','2024.1'),(14,4,3,'2024-02-04','2024.1'),(15,5,1,'2024-02-05','2024.1'),(16,6,2,'2024-02-06','2024.1'),(17,7,3,'2024-02-07','2024.1'),(18,8,1,'2024-02-08','2024.1'),(19,9,2,'2024-02-09','2024.1'),(20,10,3,'2024-02-10','2024.1'),(21,1,4,'2026-01-20','2026.1'),(22,3,4,'2026-01-21','2026.1'),(23,9,4,'2026-01-20','2026.1'),(24,10,4,'2026-01-28','2026.1');
/*!40000 ALTER TABLE `matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matricula_disciplina`
--

DROP TABLE IF EXISTS `matricula_disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matricula_disciplina` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matricula_id` int DEFAULT NULL,
  `disciplina_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  KEY `disciplina_id` (`disciplina_id`),
  CONSTRAINT `matricula_disciplina_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matricula` (`id`),
  CONSTRAINT `matricula_disciplina_ibfk_2` FOREIGN KEY (`disciplina_id`) REFERENCES `disciplinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matricula_disciplina`
--

LOCK TABLES `matricula_disciplina` WRITE;
/*!40000 ALTER TABLE `matricula_disciplina` DISABLE KEYS */;
INSERT INTO `matricula_disciplina` VALUES (1,22,1),(2,23,1),(3,20,2),(4,3,1),(5,3,2),(6,4,4),(7,8,2);
/*!40000 ALTER TABLE `matricula_disciplina` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-05  3:28:11
