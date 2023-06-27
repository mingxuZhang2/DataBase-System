/*
 Navicat Premium Data Transfer

 Source Server         : DataBase
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : emp1

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 25/05/2023 10:14:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `catid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`catid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('c1', '设计类');
INSERT INTO `category` VALUES ('c2', '财务部');
INSERT INTO `category` VALUES ('c3', '营销类');
INSERT INTO `category` VALUES ('c4', '软件类');
INSERT INTO `category` VALUES ('c5', '运营部');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `depid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `depname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`depid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('d1', '开发部', '天津');
INSERT INTO `department` VALUES ('d2', '财务部', '北京');
INSERT INTO `department` VALUES ('d3', '市场部', '广州');
INSERT INTO `department` VALUES ('d4', '人才管理部', '天津');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `empid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `empname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int(11) NOT NULL,
  `sex` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `depid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`empid`) USING BTREE,
  INDEX `depid`(`depid`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`depid`) REFERENCES `department` (`depid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('10102', '张三', 34, '男', 'd1');
INSERT INTO `employee` VALUES ('10211', '李飞', 24, '男', 'd2');
INSERT INTO `employee` VALUES ('17114', '张伟', 36, '女', 'd1');
INSERT INTO `employee` VALUES ('18316', '王玲', 29, '女', 'd4');
INSERT INTO `employee` VALUES ('22020', '周成', 39, '男', 'd2');
INSERT INTO `employee` VALUES ('25348', '冯鑫', 27, '男', 'd1');
INSERT INTO `employee` VALUES ('28559', '李凤', 41, '女', 'd3');
INSERT INTO `employee` VALUES ('29346', '王鑫', 32, '男', 'd1');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `proid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `projectname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget` int(11) NOT NULL,
  `catid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`proid`) USING BTREE,
  INDEX `catid`(`catid`) USING BTREE,
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`catid`) REFERENCES `category` (`catid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('p1', '产品推广', 120000, 'c3');
INSERT INTO `project` VALUES ('p2', '广告设计', 40000, 'c1');
INSERT INTO `project` VALUES ('p3', '软件升级', 185000, 'c4');
INSERT INTO `project` VALUES ('p4', '服务器采购', 150000, 'c2');
INSERT INTO `project` VALUES ('p5', '办公用品采购', 80000, 'c2');
INSERT INTO `project` VALUES ('p6', '软件开发', 85000, 'c4');
INSERT INTO `project` VALUES ('p7', '软件维护', 130000, 'c2');
INSERT INTO `project` VALUES ('p8', '产品售后', 56000, 'c5');

-- ----------------------------
-- Table structure for workson
-- ----------------------------
DROP TABLE IF EXISTS `workson`;
CREATE TABLE `workson`  (
  `empid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `proid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `job` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enterdate` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`empid`, `proid`) USING BTREE,
  INDEX `proid`(`proid`) USING BTREE,
  CONSTRAINT `workson_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employee` (`empid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `workson_ibfk_2` FOREIGN KEY (`proid`) REFERENCES `project` (`proid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workson
-- ----------------------------
INSERT INTO `workson` VALUES ('10102', 'p1', '职员', '2020-12-21 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p2', '职员', '2020-11-27 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p3', '管理员', '2020-08-05 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p4', '管理员', '2021-05-18 22:09:01');
INSERT INTO `workson` VALUES ('10102', 'p5', '管理员', '2020-12-10 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p6', '职员', '2020-12-22 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p7', NULL, '2020-12-25 00:00:00');
INSERT INTO `workson` VALUES ('10102', 'p8', NULL, '2020-12-01 00:00:00');
INSERT INTO `workson` VALUES ('10211', 'p1', '分析员', '2021-05-18 22:09:14');
INSERT INTO `workson` VALUES ('10211', 'p6', '分析员', '2020-06-27 00:00:00');
INSERT INTO `workson` VALUES ('17114', 'p4', '职员', '2020-09-01 00:00:00');
INSERT INTO `workson` VALUES ('18316', 'p1', '职员', '2020-06-30 00:00:00');
INSERT INTO `workson` VALUES ('18316', 'p4', '职员', '2020-09-01 00:00:00');
INSERT INTO `workson` VALUES ('18316', 'p7', NULL, '2021-05-19 10:24:26');
INSERT INTO `workson` VALUES ('22020', 'p2', '管理员', '2021-05-18 22:24:17');
INSERT INTO `workson` VALUES ('22020', 'p8', '管理员', '2020-12-01 00:00:00');
INSERT INTO `workson` VALUES ('25348', 'p1', NULL, '2020-10-25 00:00:00');
INSERT INTO `workson` VALUES ('25348', 'p2', '分析员', '2020-08-06 00:00:00');
INSERT INTO `workson` VALUES ('25348', 'p4', '职员', '2021-05-18 22:24:22');
INSERT INTO `workson` VALUES ('28559', 'p1', '职员', '2020-06-12 00:00:00');
INSERT INTO `workson` VALUES ('28559', 'p3', '分析员', '2021-01-01 00:00:00');
INSERT INTO `workson` VALUES ('28559', 'p4', '分析员', '2021-05-18 22:24:31');
INSERT INTO `workson` VALUES ('29346', 'p1', '分析员', '2021-05-18 22:24:26');

SET FOREIGN_KEY_CHECKS = 1;
