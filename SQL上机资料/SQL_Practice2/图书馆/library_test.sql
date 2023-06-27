/*
 Navicat Premium Data Transfer

 Source Server         : DataBase
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : library_test

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 20/05/2023 22:58:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bookid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bookname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `catid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`bookid`) USING BTREE,
  INDEX `fk_book_catid`(`catid`) USING BTREE,
  CONSTRAINT `fk_book_catid` FOREIGN KEY (`catid`) REFERENCES `category` (`catid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('b001', '货币银行学', '李双伟', 55, 'c2');
INSERT INTO `book` VALUES ('b003', '数据库系统全书', '加西亚-莫里纳', 65, 'c1');
INSERT INTO `book` VALUES ('b007', '微观经济学', '喻德坚', 48, 'c2');
INSERT INTO `book` VALUES ('b009', '算法导论', '科曼', 85, 'c1');
INSERT INTO `book` VALUES ('b010', '数据挖掘概念与技术', '韩家炜', 55, 'c1');
INSERT INTO `book` VALUES ('b012', 'DB2数据库性能调整和优化', '牛新庄', 68, 'c1');
INSERT INTO `book` VALUES ('b014', '数学分析原理', '卢丁', 28, 'c3');
INSERT INTO `book` VALUES ('b016', '现代量子力学', 'J.J.Sakurai', 36, 'c3');
INSERT INTO `book` VALUES ('b021', '现代操作系统', 'Tanenbaum', 55, 'c1');
INSERT INTO `book` VALUES ('b023', '编译原理', 'alfred v．aho', 55, 'c1');
INSERT INTO `book` VALUES ('b025', '数据库系统概念', '西尔伯沙茨', 69.5, 'c1');
INSERT INTO `book` VALUES ('b032', '马克思主义基本原理概论', '邓晓辉', 17.8, 'c4');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `stuid` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bookid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `borrowdate` datetime(0) NOT NULL,
  INDEX `fk_borrow_bookid`(`bookid`) USING BTREE,
  INDEX `fk_borrow_stuid`(`stuid`) USING BTREE,
  CONSTRAINT `fk_borrow_bookid` FOREIGN KEY (`bookid`) REFERENCES `book` (`bookid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_borrow_stuid` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('200810111', 'b003', '2010-10-08 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b023', '2010-10-08 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b014', '2010-10-10 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b021', '2010-10-10 00:00:00');
INSERT INTO `borrow` VALUES ('200910121', 'b003', '2010-10-09 00:00:00');
INSERT INTO `borrow` VALUES ('200910121', 'b014', '2010-10-09 00:00:00');
INSERT INTO `borrow` VALUES ('201010121', 'b014', '2010-10-13 00:00:00');
INSERT INTO `borrow` VALUES ('201021109', 'b001', '2010-10-15 00:00:00');
INSERT INTO `borrow` VALUES ('201021109', 'b012', '2010-10-15 00:00:00');
INSERT INTO `borrow` VALUES ('1200910211', 'b009', '2010-10-15 00:00:00');
INSERT INTO `borrow` VALUES ('1200910211', 'b010', '2010-10-18 00:00:00');
INSERT INTO `borrow` VALUES ('1200910211', 'b021', '2010-10-19 00:00:00');
INSERT INTO `borrow` VALUES ('1200910211', 'b023', '2010-10-10 00:00:00');
INSERT INTO `borrow` VALUES ('1201022135', 'b016', '2010-10-25 00:00:00');
INSERT INTO `borrow` VALUES ('201021109', 'b003', '2010-10-08 00:00:00');
INSERT INTO `borrow` VALUES ('201010121', 'b003', '2010-10-13 00:00:00');
INSERT INTO `borrow` VALUES ('1201022135', 'b025', '2010-10-13 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b025', '2010-10-09 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b007', '2010-10-11 00:00:00');
INSERT INTO `borrow` VALUES ('200810111', 'b032', '2010-10-13 00:00:00');
INSERT INTO `borrow` VALUES ('1201022135', 'b003', '2010-10-10 00:00:00');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `catid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`catid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('c1', '计算机技术', 1300);
INSERT INTO `category` VALUES ('c2', '经济', 1100);
INSERT INTO `category` VALUES ('c3', '数理科学', 2300);
INSERT INTO `category` VALUES ('c4', '政治', 500);

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `majorid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `majorname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `department` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`majorid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('m1', '计算机科学与技术', '计算机与控制工程学院');
INSERT INTO `major` VALUES ('m2', '信息安全', '计算机与控制工程学院');
INSERT INTO `major` VALUES ('m3', '金融工程', '金融学院');
INSERT INTO `major` VALUES ('m4', '政治学', '周恩来政府管理学院');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `stuid` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stuname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `majorid` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`stuid`) USING BTREE,
  INDEX `fk_student_majorid`(`majorid`) USING BTREE,
  CONSTRAINT `fk_student_majorid` FOREIGN KEY (`majorid`) REFERENCES `major` (`majorid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1200910211', '周昕', '研究生', 'm1');
INSERT INTO `student` VALUES ('1201022020', '张三', '研究生', 'm2');
INSERT INTO `student` VALUES ('1201022135', '吴城', '研究生', 'm4');
INSERT INTO `student` VALUES ('200810111', '王玲', '本科生', 'm2');
INSERT INTO `student` VALUES ('200910121', '王菲', '本科生', 'm3');
INSERT INTO `student` VALUES ('201010121', '李飞', '本科生', 'm3');
INSERT INTO `student` VALUES ('201021109', '赵四', '本科生', 'm1');

SET FOREIGN_KEY_CHECKS = 1;
