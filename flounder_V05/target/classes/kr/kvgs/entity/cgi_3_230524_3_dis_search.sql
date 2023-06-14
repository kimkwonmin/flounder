-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: project-db-stu.smhrd.com    Database: cgi_3_230524_3
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dis_search`
--

DROP TABLE IF EXISTS `dis_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dis_search` (
  `ds_id` int NOT NULL AUTO_INCREMENT,
  `ds_name` varchar(100) NOT NULL,
  `ds_simple` varchar(500) NOT NULL,
  `ds_url` varchar(500) NOT NULL,
  `ds_cause` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dis_search`
--

LOCK TABLES `dis_search` WRITE;
/*!40000 ALTER TABLE `dis_search` DISABLE KEYS */;
INSERT INTO `dis_search` VALUES (1,'람도바이러스병','지느러미나 체표에 출혈증상이 나타나고, 복수가 고이거나 근육내에 출혈 또는 울혈이 특징적으로 관찰되며, 아가미 빈혈, 생식선 발적, 담낭의 황색화와 팽만증상이 관찰','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV006&fshCd=611301','바이러스성질병'),(2,'에드워드병','수류를 따라 빙빙 도는 행동, 체색 흑화, 지느러미 및 복부 발적 및 충혈, 복부팽만, 탈장','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB004&fshCd=611301','세균성질병'),(3,'림포시스티스','머리 및 체표 전체의 지느러미에 종양이 생성','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV001&fshCd=611301','바이러스성질병'),(4,'바이러스성 신경괴사증','신경세포에 감염되어 신경조직을 괴사시켜 대량폐사를 유발하고 수직감염에 의해 전염','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV007&fshCd=611301','바이러스성질병'),(5,'바이러스성 출혈성 패혈증 바이러스','체색흑화, 복수저류로 인한 복부팽만과 탈장, 아가미 퇴색 등이 관찰','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV009&fshCd=611301','바이러스성질병'),(6,'백점병','체표와 지느러미에 미세한 흰점이 관찰되며 심한 경우 아가미 뿐만 아니라 안구 등에서도 흰 점이 나타난다','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IP006&fshCd=611301','기생충성질병'),(7,'버나바이러스병','주로 치어기에 발생하며 복부가 팽만되거나 뇌부근에 출혈과 발적증상','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV005&fshCd=611301','바이러스성질병'),(8,'비브리오증','체색의 흑화, 지느러미 출혈 및 결손, 부분적 발적과 궤양 ','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB005&fshCd=611301','세균성질병'),(9,'상피증생증','자어기에 나타나며, 지느러미 및 체표가 흐릿하게 변하고, 특히 지느러미 끝 부분이 말려들어 가는 듯한 증상','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV002&fshCd=611301','바이러스성질병'),(10,'스쿠티카병','표피가 박리되고 근육층이 노출되는 궤양증, 체표 염증, 지느러미 연조 및 꼬리자루 노출, 두부손상','https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IP007&fshCd=611301','기생충성질병');
/*!40000 ALTER TABLE `dis_search` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-28 21:16:57
