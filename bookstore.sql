/*
Navicat MySQL Data Transfer

Source Server         : m
Source Server Version : 50554
Source Host           : localhost:3306
Source Database       : bookstore

Target Server Type    : MYSQL
Target Server Version : 50554
File Encoding         : 65001

Date: 2017-09-09 20:29:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `categoryId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id_fk` (`categoryId`),
  CONSTRAINT `category_id_fk` FOREIGN KEY (`categoryId`) REFERENCES `categorys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of books
-- ----------------------------

-- ----------------------------
-- Table structure for categorys
-- ----------------------------
DROP TABLE IF EXISTS `categorys`;
CREATE TABLE `categorys` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `des` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of categorys
-- ----------------------------

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(20) NOT NULL,
  `code` varchar(200) DEFAULT NULL,
  `actived` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `photo` (`phone`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES ('6ffc996d-b9ae-492e-aa94-829505af3206', '111', '111', '111', '111', '597186244@qq.com', '97bc3bfd-e392-47d0-bf4b-2d71f7ce2a96', '\0');
INSERT INTO `customers` VALUES ('b9f984b3-6e7d-450f-863f-6d6dc747bbc3', '123', '', '123', '123', '123', 'c5a29064-b417-4667-86a3-0754593f6045', '\0');

-- ----------------------------
-- Table structure for functions
-- ----------------------------
DROP TABLE IF EXISTS `functions`;
CREATE TABLE `functions` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of functions
-- ----------------------------
INSERT INTO `functions` VALUES ('1', '主页', '/BookStore/manage/index.jsp');
INSERT INTO `functions` VALUES ('2', '消息', '/BookStore/manage/message.jsp');
INSERT INTO `functions` VALUES ('3', '添加分类', '/BookStore/manage/addCategory.jsp');
INSERT INTO `functions` VALUES ('4', '查询分类', '/BookStore/servlet/ManageServlet?op=listCategories');
INSERT INTO `functions` VALUES ('5', '添加书籍', '/BookStore/servlet/ManageServlet?op=addBookUI');
INSERT INTO `functions` VALUES ('6', '查询书籍', '/BookStore/servlet/ManageServlet?op=listBooks');

-- ----------------------------
-- Table structure for orderitems
-- ----------------------------
DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE `orderitems` (
  `id` varchar(100) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `ordernum` varchar(100) DEFAULT NULL,
  `bookid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ordernum_fk` (`ordernum`),
  KEY `bookid_fk` (`bookid`),
  CONSTRAINT `bookid_fk` FOREIGN KEY (`bookid`) REFERENCES `books` (`id`),
  CONSTRAINT `ordernum_fk` FOREIGN KEY (`ordernum`) REFERENCES `orders` (`ordernum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderitems
-- ----------------------------

-- ----------------------------
-- Table structure for ordernum
-- ----------------------------
DROP TABLE IF EXISTS `ordernum`;
CREATE TABLE `ordernum` (
  `prefix` date DEFAULT NULL,
  `num` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordernum
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `ordernum` varchar(100) NOT NULL,
  `price` float(8,2) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `customerId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ordernum`),
  KEY `customerId_fk` (`customerId`),
  CONSTRAINT `customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for role_function
-- ----------------------------
DROP TABLE IF EXISTS `role_function`;
CREATE TABLE `role_function` (
  `r_id` varchar(100) NOT NULL,
  `f_id` varchar(100) NOT NULL,
  PRIMARY KEY (`r_id`,`f_id`),
  KEY `function_id_fk` (`f_id`),
  CONSTRAINT `function_id_fk` FOREIGN KEY (`f_id`) REFERENCES `functions` (`id`),
  CONSTRAINT `role_id_fk1` FOREIGN KEY (`r_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_function
-- ----------------------------
INSERT INTO `role_function` VALUES ('1', '1');
INSERT INTO `role_function` VALUES ('2', '1');
INSERT INTO `role_function` VALUES ('1', '2');
INSERT INTO `role_function` VALUES ('2', '2');
INSERT INTO `role_function` VALUES ('1', '3');
INSERT INTO `role_function` VALUES ('1', '4');
INSERT INTO `role_function` VALUES ('1', '5');
INSERT INTO `role_function` VALUES ('2', '5');
INSERT INTO `role_function` VALUES ('1', '6');
INSERT INTO `role_function` VALUES ('2', '6');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `des` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', '超级管理员', '可以访问任何页面');
INSERT INTO `roles` VALUES ('2', '普通管理员', '书籍部分');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `u_id` varchar(100) NOT NULL,
  `r_id` varchar(100) NOT NULL,
  PRIMARY KEY (`u_id`,`r_id`),
  KEY `role_id_fk2` (`r_id`),
  CONSTRAINT `role_id_fk2` FOREIGN KEY (`r_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1');
INSERT INTO `user_role` VALUES ('2', '2');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'admin', '123');
INSERT INTO `users` VALUES ('2', 'aa', '123');
