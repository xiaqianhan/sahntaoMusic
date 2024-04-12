-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: music_act
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `ev_forum`
--

DROP TABLE IF EXISTS `ev_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ev_forum` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation` int NOT NULL COMMENT '话题编号',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布人账号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户昵称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布时间',
  `user_pic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户头像',
  `thumbsUp` int DEFAULT '0' COMMENT '点赞数量',
  `commentNum` int DEFAULT '0' COMMENT '评论数量',
  `forwardNum` int DEFAULT '0' COMMENT '转发量',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话内容',
  `fabulous` int NOT NULL DEFAULT '1' COMMENT '是否点赞，1为未点赞，0为点赞',
  `forward` int NOT NULL DEFAULT '1' COMMENT '是否转发，1为未转发，0为转发',
  PRIMARY KEY (`id`),
  KEY `forum_conversation_IDX` (`conversation`) USING BTREE,
  KEY `forum_id_IDX` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='论坛列表数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ev_forum`
--

LOCK TABLES `ev_forum` WRITE;
/*!40000 ALTER TABLE `ev_forum` DISABLE KEYS */;
INSERT INTO `ev_forum` VALUES (1,87546325,'威整天',NULL,'1','2021-10-22 11:24:32','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image1.jpg',0,0,0,'擎天柱你个大傻逼',1,1),(2,3086616,'123456','null','山河令','2024-04-06 22:11:05','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image1.jpg',1,0,0,'111',1,1),(3,86146886,'123456','红蜘蛛','','2024-04-07 23:41:21','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image6.jpg',0,0,0,'123',1,1),(4,721177,'123456','红蜘蛛','天台','2024-04-07 23:48:57','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image6.jpg',0,0,0,'测试',1,1),(5,87693131,'123456','红蜘蛛','爱情排行榜-伴奏','2024-04-07 23:49:27','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image6.jpg',0,0,0,'测试',1,1);
/*!40000 ALTER TABLE `ev_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ev_forumdetailed`
--

DROP TABLE IF EXISTS `ev_forumdetailed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ev_forumdetailed` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation` int NOT NULL COMMENT '话题列表编号',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户昵称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发表时间',
  `user_pic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '用户头像',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户发表评论信息',
  PRIMARY KEY (`id`),
  KEY `ev_forumDetailed_id_IDX` (`id`,`conversation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会话列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ev_forumdetailed`
--

LOCK TABLES `ev_forumdetailed` WRITE;
/*!40000 ALTER TABLE `ev_forumdetailed` DISABLE KEYS */;
INSERT INTO `ev_forumdetailed` VALUES (1,3086616,'123456','null','','2024-04-06 23:43:51',NULL,'1111');
/*!40000 ALTER TABLE `ev_forumdetailed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ev_lovemusic`
--

DROP TABLE IF EXISTS `ev_lovemusic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ev_lovemusic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '用户账号',
  `file_id` varchar(255) NOT NULL COMMENT '音乐id',
  `singer` varchar(255) DEFAULT NULL COMMENT '歌手名称',
  `url` varchar(255) NOT NULL COMMENT '歌曲地址',
  `type` int NOT NULL COMMENT '1为喜欢，2为收藏',
  `titlename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '音乐名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='我喜欢的音乐';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ev_lovemusic`
--

LOCK TABLES `ev_lovemusic` WRITE;
/*!40000 ALTER TABLE `ev_lovemusic` DISABLE KEYS */;
INSERT INTO `ev_lovemusic` VALUES (6,'123456','58936','陈默之','http://www.kumeiwp.com/sub/filestores/2022/12/10/5ff9c2d60f85ccbfd16d2ee51f889a5a.mp3',1,'排行(伴奏)'),(7,'123456','58936','陈默之','http://www.kumeiwp.com/sub/filestores/2022/12/10/5ff9c2d60f85ccbfd16d2ee51f889a5a.mp3',2,'排行(伴奏)'),(9,'123456','11111','郭兰英','http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/music1.mp3',1,'南泥湾'),(10,'123456','11111','郭兰英','http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/music1.mp3',2,'南泥湾');
/*!40000 ALTER TABLE `ev_lovemusic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ev_mybook`
--

DROP TABLE IF EXISTS `ev_mybook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ev_mybook` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户昵称',
  `bookNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书本编号',
  `bookType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书本类型，1为小说，2为漫画，3为历史，4为教材，5为科学，6为人文',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书本名称',
  `amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '付款金额',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书本描述',
  `contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '卖家联系方式',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '书本图片',
  `salesVolume` int NOT NULL DEFAULT '0' COMMENT '销售量',
  `purchase` int NOT NULL DEFAULT '0' COMMENT '商品购买量',
  PRIMARY KEY (`id`),
  KEY `ev_bookCity_id_IDX` (`id`,`username`,`bookNumber`,`bookType`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='我的商品列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ev_mybook`
--

LOCK TABLES `ev_mybook` WRITE;
/*!40000 ALTER TABLE `ev_mybook` DISABLE KEYS */;
/*!40000 ALTER TABLE `ev_mybook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ev_users`
--

DROP TABLE IF EXISTS `ev_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ev_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户昵称',
  `user_pic` varchar(255) NOT NULL DEFAULT '1' COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`),
  KEY `ev_users_id_IDX` (`id`,`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ev_users`
--

LOCK TABLES `ev_users` WRITE;
/*!40000 ALTER TABLE `ev_users` DISABLE KEYS */;
INSERT INTO `ev_users` VALUES (1,'123456','123456','红蜘蛛','http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image6.jpg','1950343156@qq.com');
/*!40000 ALTER TABLE `ev_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-12  9:57:11
