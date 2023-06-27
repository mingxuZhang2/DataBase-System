/*
 Navicat Premium Data Transfer

 Source Server         : DataBase
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : p4

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 19/05/2023 11:10:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `Cno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Tno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Cno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1-111', '体育', '999');
INSERT INTO `course` VALUES ('3-105', '计算机导论', '825');
INSERT INTO `course` VALUES ('3-245', '操作系统', '804');
INSERT INTO `course` VALUES ('6-166', '数字电路', '856');
INSERT INTO `course` VALUES ('9-888', '高等数学', '831');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `low` int(11) NULL DEFAULT NULL,
  `upp` int(11) NULL DEFAULT NULL,
  `rank` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (90, 100, 'A');
INSERT INTO `grade` VALUES (80, 89, 'B');
INSERT INTO `grade` VALUES (70, 79, 'C');
INSERT INTO `grade` VALUES (60, 69, 'D');
INSERT INTO `grade` VALUES (0, 59, 'E');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `Sno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Degree` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Sno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('107', '3-105', '91');
INSERT INTO `score` VALUES ('109', '3-245', '68');
INSERT INTO `score` VALUES ('110', '1-111', '100');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `Sno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Sname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Ssex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Sbirthday` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Class` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Sno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('101', '刘争', '男', '1976', '95033');
INSERT INTO `student` VALUES ('105', '匡明', '男', '1975', '95031');
INSERT INTO `student` VALUES ('107', '王丽', '女', '1976', '95033');
INSERT INTO `student` VALUES ('108', '曾华', '男', '1977', '95033');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `Tno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Tname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Tsex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Tbirthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Prof` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Depart` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Tno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('804', '李成', '男', '1958', '副教授', '计算机系');
INSERT INTO `teacher` VALUES ('825', '王平', '女', '1972', '助教', '计算机系');
INSERT INTO `teacher` VALUES ('831', '刘兵', '女', '1977', '助教', '电子工程系');
INSERT INTO `teacher` VALUES ('856', '张旭', '男', '1969', '讲师', '电子工程系');

SET FOREIGN_KEY_CHECKS = 1;
