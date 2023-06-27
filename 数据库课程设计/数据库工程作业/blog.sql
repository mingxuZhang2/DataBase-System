/*
 Navicat Premium Data Transfer

 Source Server         : DataBase
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 21/05/2023 20:35:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `CommentID` int(11) NOT NULL AUTO_INCREMENT,
  `CommentContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` int(11) NULL DEFAULT NULL,
  `PostID` int(11) NULL DEFAULT NULL,
  `CommentDate` date NULL DEFAULT NULL,
  PRIMARY KEY (`CommentID`) USING BTREE,
  INDEX `comment_ibfk_1`(`UserID`) USING BTREE,
  INDEX `comment_ibfk_2`(`PostID`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `post` (`PostID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '2131231', 20, 1, '2023-05-19');
INSERT INTO `comment` VALUES (2, '全微分个旅法师', 19, 2, '2023-05-21');
INSERT INTO `comment` VALUES (3, '分额外分而测我', 19, 2, '2023-05-21');
INSERT INTO `comment` VALUES (4, '期望微分物权法而过去', 19, 2, '2023-05-21');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `CourseID` int(11) NOT NULL AUTO_INCREMENT,
  `CourseName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TeacherID` int(11) NULL DEFAULT NULL,
  `CourseCapacity` int(11) NULL DEFAULT 30,
  PRIMARY KEY (`CourseID`) USING BTREE,
  INDEX `TeacherID`(`TeacherID`) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`TeacherID`) REFERENCES `user` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '测试更新', 19, 300);
INSERT INTO `course` VALUES (3, '第二课程', 19, 20);

-- ----------------------------
-- Table structure for courseinfo
-- ----------------------------
DROP TABLE IF EXISTS `courseinfo`;
CREATE TABLE `courseinfo`  (
  `CourseID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `StudentName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Grade` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`CourseID`, `StudentID`) USING BTREE,
  INDEX `courseinfo_ibfk_2`(`StudentID`) USING BTREE,
  CONSTRAINT `courseinfo_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `courseinfo_ibfk_2` FOREIGN KEY (`StudentID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of courseinfo
-- ----------------------------
INSERT INTO `courseinfo` VALUES (1, 9, 'Student1', 60);
INSERT INTO `courseinfo` VALUES (1, 10, 'Student2', 60);
INSERT INTO `courseinfo` VALUES (1, 11, 'Student3', 60);
INSERT INTO `courseinfo` VALUES (1, 12, 'Student4', 60);
INSERT INTO `courseinfo` VALUES (1, 13, 'Student5', 60);
INSERT INTO `courseinfo` VALUES (1, 14, 'Student6', 60);
INSERT INTO `courseinfo` VALUES (1, 15, 'Student7', 60);
INSERT INTO `courseinfo` VALUES (1, 16, 'Student8', 60);
INSERT INTO `courseinfo` VALUES (1, 17, 'Student9', 60);
INSERT INTO `courseinfo` VALUES (1, 20, '123', 60);

-- ----------------------------
-- Table structure for enrollment
-- ----------------------------
DROP TABLE IF EXISTS `enrollment`;
CREATE TABLE `enrollment`  (
  `EnrollmentID` int(11) NOT NULL AUTO_INCREMENT,
  `StudentID` int(11) NULL DEFAULT NULL,
  `CourseID` int(11) NULL DEFAULT NULL,
  `Grade` float NULL DEFAULT NULL,
  `EnrolledStudents` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`EnrollmentID`) USING BTREE,
  INDEX `enrollment_ibfk_1`(`StudentID`) USING BTREE,
  INDEX `enrollment_ibfk_2`(`CourseID`) USING BTREE,
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enrollment
-- ----------------------------
INSERT INTO `enrollment` VALUES (1, 9, 1, 60, 0);
INSERT INTO `enrollment` VALUES (2, 10, 1, 60, 0);
INSERT INTO `enrollment` VALUES (3, 11, 1, 60, 0);
INSERT INTO `enrollment` VALUES (4, 12, 1, 60, 0);
INSERT INTO `enrollment` VALUES (5, 13, 1, 60, 0);
INSERT INTO `enrollment` VALUES (6, 14, 1, 60, 0);
INSERT INTO `enrollment` VALUES (7, 15, 1, 60, 0);
INSERT INTO `enrollment` VALUES (8, 16, 1, 60, 0);
INSERT INTO `enrollment` VALUES (9, 17, 1, 60, 0);
INSERT INTO `enrollment` VALUES (10, 18, 1, 60, 0);
INSERT INTO `enrollment` VALUES (22, 20, 1, 60, 0);
INSERT INTO `enrollment` VALUES (23, 20, 3, NULL, 0);

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `PostID` int(11) NOT NULL AUTO_INCREMENT,
  `PostTitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PostContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` int(11) NULL DEFAULT NULL,
  `PostDate` date NULL DEFAULT NULL,
  `PostPermission` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  PRIMARY KEY (`PostID`) USING BTREE,
  INDEX `post_ibfk_1`(`UserID`) USING BTREE,
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, '123', '123', 20, '2023-05-19', 'student');
INSERT INTO `post` VALUES (2, '仍无法', '分为', 19, '2023-05-21', 'all');

-- ----------------------------
-- Table structure for search_history
-- ----------------------------
DROP TABLE IF EXISTS `search_history`;
CREATE TABLE `search_history`  (
  `SearchID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NULL DEFAULT NULL,
  `SearchContent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `SearchDate` datetime(0) NOT NULL,
  PRIMARY KEY (`SearchID`) USING BTREE,
  INDEX `UserID`(`UserID`) USING BTREE,
  CONSTRAINT `search_history_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of search_history
-- ----------------------------
INSERT INTO `search_history` VALUES (1, 20, '', '2023-05-19 14:02:25');
INSERT INTO `search_history` VALUES (2, 20, '1', '2023-05-19 14:03:07');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserPassword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserType` enum('Student','Teacher') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (9, 'Student1', 'password1', 'Student');
INSERT INTO `user` VALUES (10, 'Student2', 'password2', 'Student');
INSERT INTO `user` VALUES (11, 'Student3', 'password3', 'Student');
INSERT INTO `user` VALUES (12, 'Student4', 'password4', 'Student');
INSERT INTO `user` VALUES (13, 'Student5', 'password5', 'Student');
INSERT INTO `user` VALUES (14, 'Student6', 'password6', 'Student');
INSERT INTO `user` VALUES (15, 'Student7', 'password7', 'Student');
INSERT INTO `user` VALUES (16, 'Student8', 'password8', 'Student');
INSERT INTO `user` VALUES (17, 'Student9', 'password9', 'Student');
INSERT INTO `user` VALUES (18, 'Student10', 'password10', 'Student');
INSERT INTO `user` VALUES (19, 'Teacher1', 'pbkdf2:sha256:600000$SBUpQEazY28aAoLd$872fb60da5a4d6e1767644783982f172f16fbf27934390a202720c45f81823a0', 'Teacher');
INSERT INTO `user` VALUES (20, '123', 'pbkdf2:sha256:600000$shBuzpLtKMqHJpCB$2bddc2136c067b6ed5ffec11463262e27acc59ba55c3ca8f180887a354bcbc31', 'Student');
INSERT INTO `user` VALUES (21, 'tea', 'pbkdf2:sha256:600000$SBUpQEazY28aAoLd$872fb60da5a4d6e1767644783982f172f16fbf27934390a202720c45f81823a0', 'Teacher');
INSERT INTO `user` VALUES (22, 'stu', 'pbkdf2:sha256:600000$9EYyOwjvOONuJiZ1$960219a811ba423665c6aff4f35246b744158ca21bc3da9468a4a44df68fbeff', 'Student');

-- ----------------------------
-- View structure for studentcourseview
-- ----------------------------
DROP VIEW IF EXISTS `studentcourseview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `studentcourseview` AS select `user`.`UserID` AS `StudentID`,`user`.`UserName` AS `StudentName`,`course`.`CourseID` AS `CourseID`,`enrollment`.`Grade` AS `Grade` from ((`user` join `course` on((`user`.`UserID` = `course`.`TeacherID`))) join `enrollment` on(((`course`.`CourseID` = `enrollment`.`CourseID`) and (`user`.`UserID` = `enrollment`.`StudentID`))));

-- ----------------------------
-- View structure for user_comment_view
-- ----------------------------
DROP VIEW IF EXISTS `user_comment_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_comment_view` AS select `u`.`UserName` AS `UserName`,`u`.`UserID` AS `UserID`,`c`.`CommentID` AS `CommentID`,`c`.`CommentContent` AS `CommentContent`,`c`.`CommentDate` AS `CommentDate`,`c`.`PostID` AS `PostID` from (`user` `u` join `comment` `c` on((`u`.`UserID` = `c`.`UserID`)));

-- ----------------------------
-- View structure for view2
-- ----------------------------
DROP VIEW IF EXISTS `view2`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view2` AS select `user`.`UserID` AS `StudentID`,`user`.`UserName` AS `StudentName`,`course`.`CourseName` AS `CourseName`,`enrollment`.`Grade` AS `Grade` from ((`user` join `enrollment` on((`user`.`UserID` = `enrollment`.`StudentID`))) join `course` on((`course`.`CourseID` = `enrollment`.`CourseID`)));

-- ----------------------------
-- Function structure for enrollment_partition_func
-- ----------------------------
DROP FUNCTION IF EXISTS `enrollment_partition_func`;
delimiter ;;
CREATE FUNCTION `enrollment_partition_func`(p_course_id INT)
 RETURNS int(11)
BEGIN
    DECLARE partition_id INT;
    SET partition_id = p_course_id % 10; 
    RETURN partition_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for UpdateCourseID
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateCourseID`;
delimiter ;;
CREATE PROCEDURE `UpdateCourseID`(IN p_OldCourseID INT,
    IN p_NewCourseID INT)
BEGIN
    -- 约束条件：新的课程ID必须是正整数
    IF p_NewCourseID <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'New Course ID must be a positive integer.';
    ELSE
        -- 执行更新操作
        UPDATE Course
        SET CourseID = p_NewCourseID
        WHERE CourseID = p_OldCourseID;

        UPDATE Enrollment
        SET CourseID = p_NewCourseID
        WHERE CourseID = p_OldCourseID;

        UPDATE CourseInfo
        SET CourseID = p_NewCourseID
        WHERE CourseID = p_OldCourseID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for UpdateStudentGrade
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateStudentGrade`;
delimiter ;;
CREATE PROCEDURE `UpdateStudentGrade`(IN p_StudentID INT,
    IN p_Grade INT)
BEGIN
    -- 约束条件：成绩必须在0-100之间
    IF p_Grade < 0 OR p_Grade > 100 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Grade must be between 0 and 100.';
    ELSE
        UPDATE CourseInfo
        SET Grade = p_Grade
        WHERE StudentID=P_studentID;
        
        -- 执行更新操作
        UPDATE Enrollment
        SET Grade = p_Grade
        WHERE CourseID IN (
            SELECT CourseID
            FROM CourseInfo
            WHERE StudentID = p_StudentID
        ) AND StudentID = p_StudentID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table course
-- ----------------------------
DROP TRIGGER IF EXISTS `check_user_type_trigger`;
delimiter ;;
CREATE TRIGGER `check_user_type_trigger` BEFORE INSERT ON `course` FOR EACH ROW BEGIN
    DECLARE user_type VARCHAR(20);
    
    -- 获取当前用户的类别
    SELECT UserType INTO user_type FROM user WHERE UserID = NEW.TeacherID;
    
    -- 检查用户类别，只允许Teacher类的用户创建课程
    IF user_type != 'Teacher' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You do not have permission to create a course.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table course
-- ----------------------------
DROP TRIGGER IF EXISTS `update_enrollment_course_id_trigger`;
delimiter ;;
CREATE TRIGGER `update_enrollment_course_id_trigger` AFTER UPDATE ON `course` FOR EACH ROW BEGIN
    IF NEW.CourseID <> OLD.CourseID THEN
        UPDATE enrollment SET CourseID = NEW.CourseID WHERE CourseID = OLD.CourseID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table course
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_course_trigger`;
delimiter ;;
CREATE TRIGGER `delete_course_trigger` AFTER DELETE ON `course` FOR EACH ROW BEGIN
    -- 删除对应的CourseInfo记录
    DELETE FROM CourseInfo WHERE CourseID = OLD.CourseID;
    
    -- 删除对应的Enrollment记录
    DELETE FROM Enrollment WHERE CourseID = OLD.CourseID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table enrollment
-- ----------------------------
DROP TRIGGER IF EXISTS `check_grade_range_insert_trigger`;
delimiter ;;
CREATE TRIGGER `check_grade_range_insert_trigger` BEFORE INSERT ON `enrollment` FOR EACH ROW BEGIN
    IF NEW.Grade < 0 OR NEW.Grade > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '成绩范围异常';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table enrollment
-- ----------------------------
DROP TRIGGER IF EXISTS `enroll_course_trigger`;
delimiter ;;
CREATE TRIGGER `enroll_course_trigger` AFTER INSERT ON `enrollment` FOR EACH ROW BEGIN
    -- 检查是否插入的课程ID在CourseInfo表中存在
    IF NEW.CourseID IN (SELECT CourseID FROM CourseInfo) THEN
        -- 插入对应的CourseInfo记录，包括学生姓名
        INSERT INTO CourseInfo (CourseID, StudentID, StudentName, Grade)
        SELECT NEW.CourseID, NEW.StudentID, User.UserName, NULL
        FROM User
        WHERE User.UserID = NEW.StudentID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table enrollment
-- ----------------------------
DROP TRIGGER IF EXISTS `check_grade_range_update_trigger`;
delimiter ;;
CREATE TRIGGER `check_grade_range_update_trigger` BEFORE UPDATE ON `enrollment` FOR EACH ROW BEGIN
    IF NEW.Grade < 0 OR NEW.Grade > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '成绩范围异常';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table enrollment
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_enrollment_trigger`;
delimiter ;;
CREATE TRIGGER `delete_enrollment_trigger` AFTER DELETE ON `enrollment` FOR EACH ROW BEGIN
    -- 删除对应的CourseInfo记录
    DELETE FROM CourseInfo WHERE CourseID = OLD.CourseID AND StudentID = OLD.StudentID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `validate_username_trigger`;
delimiter ;;
CREATE TRIGGER `validate_username_trigger` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    IF EXISTS(SELECT 1 FROM `user` WHERE UserName = NEW.UserName) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username already exists';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
