/*
 Navicat Premium Data Transfer

 Source Server         : MySQLForDBMSC
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : pms

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 27/10/2021 13:54:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int NULL DEFAULT NULL COMMENT '员工id',
  `app_date` date NULL DEFAULT NULL COMMENT '考评日期',
  `app_result` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评结果',
  `app_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  CONSTRAINT `appraise_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of appraise
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `parent_id` int NULL DEFAULT NULL COMMENT '父id',
  `dept_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `is_parent` tinyint(1) NULL DEFAULT 0 COMMENT '是否上级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '财务部', 0, '.1', 1, 0);
INSERT INTO `department` VALUES (2, '市场部', 0, '.1', 1, 0);
INSERT INTO `department` VALUES (3, '技术部', 0, '.1', 1, 0);
INSERT INTO `department` VALUES (4, '运维部', 0, '.1', 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `id_card` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nation_id` int NULL DEFAULT NULL COMMENT '民族',
  `native_place` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politic_id` int NULL DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现居地址',
  `department_id` int NULL DEFAULT NULL COMMENT '所属部门ID',
  `job_level_id` int NULL DEFAULT NULL COMMENT '职称ID',
  `position_id` int NULL DEFAULT NULL COMMENT '职位ID',
  `engage_form` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聘用形式',
  `tiptop_degree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属专业',
  `university` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `begin_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `work_state` enum('实习','在职','离职','待转') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '在职' COMMENT '在职状态',
  `conversion_date` date NULL DEFAULT NULL COMMENT '转正日期',
  `leave_date` date NULL DEFAULT NULL COMMENT '离职日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `department_id_index`(`department_id`) USING BTREE,
  INDEX `job_level_id_index`(`job_level_id`) USING BTREE,
  INDEX `position_id_index`(`position_id`) USING BTREE,
  INDEX `nation_id_index`(`nation_id`) USING BTREE,
  INDEX `politic_id_index`(`politic_id`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`job_level_id`) REFERENCES `job_level` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nation_id`) REFERENCES `nation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politic_id`) REFERENCES `politics_status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 476 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '赵力民1', '男', '2000-04-28', '123456789023456781', '未婚', 1, '昆明市', 11, '2632816823@qq.com', '12345678901', '辽宁省大连市 502246', 2, 5, 1, '劳动合同', '博士', '软件工程', '大连民族大学', '2018-10-16', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (2, '苏贞涛2', '男', '1992-03-25', '123456789023456781', '未婚', 1, '贵阳市', 2, '2632816823@qq.com', '12345678901', '辽宁省大连市 302114', 2, 8, 2, '劳动合同', '博士', '计算机科学与技术', '大连民族大学', '2018-06-25', '离职', '2021-10-14', '2021-10-26');
INSERT INTO `employee` VALUES (3, '刘泽民3', '男', '1996-07-18', '123456789023456781', '未婚', 1, '成都市', 13, '2632816823@qq.com', '12345678901', '辽宁省大连市 576579', 3, 6, 3, '劳务合同', '博士', '软件工程', '大连民族大学', '2017-08-15', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (4, '寇江波4', '男', '1993-07-10', '123456789023456781', '未婚', 1, '内蒙古', 5, '2632816823@qq.com', '12345678901', '辽宁省大连市 614280', 3, 8, 4, '劳动合同', '博士', '软件工程', '大连民族大学', '2019-02-21', '待转', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (5, '吴显超5', '男', '2000-01-08', '123456789023456781', '未婚', 1, '贵阳市', 10, '2632816823@qq.com', '12345678901', '辽宁省大连市 850761', 3, 4, 5, '劳动合同', '博士', '计算机科学与技术', '大连民族大学', '2016-12-13', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (6, '伍柯帆6', '男', '1990-05-07', '123456789023456781', '未婚', 1, '衡阳市', 4, '2632816823@qq.com', '12345678901', '辽宁省大连市 430329', 3, 7, 6, '劳务合同', '博士', '计算机科学与技术', '大连民族大学', '2015-10-15', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (7, '赵力民7', '男', '1992-05-07', '123456789023456781', '未婚', 1, '衡阳市', 8, '123123123123@qq.com', '12345678901', '辽宁省大连市 221697', 3, 6, 7, '劳务合同', '博士', '计算机科学与技术', '大连民族大学', '2016-07-30', '实习', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (8, '苏贞涛8', '男', '2001-01-29', '123456789023456781', '未婚', 1, '衡阳市', 10, '123123123123@gmail.com', '12345678901', '辽宁省大连市 490503', 4, 6, 8, '劳动合同', '博士', '计算机科学与技术', '大连民族大学', '2016-05-21', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (9, '刘泽民9', '男', '1994-01-11', '123456789023456781', '未婚', 1, '银川市', 10, '123123123123@zengyi.net', '12345678901', '辽宁省大连市 815655', 4, 4, 9, '劳务合同', '博士', '计算机科学与技术', '大连民族大学', '2018-01-15', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (10, '赵力民10', '男', '1999-10-03', '123456789023456781', '未婚', 1, '北镇市', 3, '123123123@jieming.cn', '12345678901', '辽宁省大连市 227133', 1, 1, 10, '劳务合同', '博士', '计算机科学与技术', '大连民族大学', '2017-06-17', '实习', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (11, '苏贞涛11', '男', '1994-07-09', '123456789023456781', '未婚', 1, '贵阳县', 8, '123123123@dengpan.net', '12345678901', '辽宁省大连市 439792', 1, 1, 11, '劳务合同', '博士', '计算机科学与技术', '大连民族大学', '2015-10-22', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (12, '刘泽民12', '男', '1991-07-21', '123456789023456781', '未婚', 1, '敏县', 11, '123123123@hotmail.com', '12345678901', '辽宁省大连市 819867', 2, 7, 1, '劳务合同', '博士', '软件工程', '大连民族大学', '2016-06-13', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (13, '寇江波13', '男', '1997-03-06', '123456789023456781', '未婚', 1, '昆明市', 8, '123123123@guiyingna.cn', '12345678901', '辽宁省大连市 418151', 2, 5, 2, '劳务合同', '博士', '网络工程', '大连民族大学', '2018-03-01', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (14, '吴显超14', '男', '1993-03-13', '123456789023456781', '未婚', 1, '贵阳市', 13, '12312312312@la.cn', '12345678901', '辽宁省大连市 113957', 3, 3, 3, '劳务合同', '博士', '软件工程', '大连民族大学', '2015-08-09', '待转', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (15, '伍柯帆15', '男', '1993-03-31', '123456789023456781', '未婚', 1, '成都市', 12, '345345345@hotmail.com', '12345678901', '辽宁省大连市 907387', 3, 3, 4, '劳务合同', '硕士', '计算机科学与技术', '大连民族大学', '2016-01-17', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (16, '赵力民16', '男', '1999-12-07', '123456789023456781', '未婚', 1, '内蒙古', 2, '123123123@hotmail.com', '12345678901', '辽宁省大连市 889598', 3, 8, 5, '劳动合同', '硕士', '计算机科学与技术', '大连民族大学', '2015-10-11', '在职', '2021-10-14', NULL);
INSERT INTO `employee` VALUES (17, '苏贞涛17', '男', '1991-05-13', '123456789023456781', '未婚', 1, '贵阳市', 5, '345345345@hotmail.com', '12345678901', '辽宁省大连市 607847', 3, 6, 6, '劳动合同', '硕士', '计算机科学与技术', '大连民族大学', '2017-09-23', '离职', '2021-10-14', '2021-10-26');
INSERT INTO `employee` VALUES (18, '刘泽民18', '男', '1995-07-20', '123456789023456781', '未婚', 1, '衡阳市', 4, '123123123@yahoo.com', '12345678901', '辽宁省大连市 343550', 3, 1, 7, '劳务合同', '硕士', '计算机科学与技术', '大连民族大学', '2015-05-24', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (19, '寇江波19', '男', '1998-07-24', '123456789023456781', '未婚', 1, '昆明市', 12, '345636346@lijun.cn', '12345678901', '辽宁省大连市 890108', 4, 2, 8, '劳务合同', '硕士', '计算机科学与技术', '大连民族大学', '2019-02-19', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (20, '吴显超20', '男', '1997-12-27', '123456789023456781', '未婚', 1, '贵阳市', 5, '5464564@lilong.cn', '12345678901', '辽宁省大连市 231298', 4, 2, 9, '劳务合同', '硕士', '计算机科学与技术', '大连民族大学', '2018-05-20', '实习', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (21, '伍柯帆21', '男', '2001-01-14', '123456789023456781', '未婚', 1, '成都市', 2, '5678567567@kc.cn', '12345678901', '辽宁省大连市 733493', 1, 8, 10, '劳动合同', '硕士', '计算机科学与技术', '大连民族大学', '2017-11-22', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (22, '赵力民22', '男', '1993-01-11', '123456789023456781', '未婚', 1, '内蒙古', 13, '567567567@hotmail.com', '12345678901', '辽宁省大连市 348086', 1, 6, 11, '劳动合同', '硕士', '软件工程', '大连民族大学', '2018-07-27', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (23, '苏贞涛23', '男', '1991-05-07', '123456789023456781', '未婚', 1, '贵阳市', 4, 'fgu@234234234.com', '12345678901', '辽宁省大连市 528477', 2, 2, 1, '劳动合同', '硕士', '网络工程', '大连民族大学', '2018-06-24', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (24, '刘泽民24', '男', '1994-11-12', '123456789023456781', '未婚', 1, '衡阳市', 6, '234234234@34.cn', '12345678901', '辽宁省大连市 504377', 2, 6, 2, '劳动合同', '硕士', '网络工程', '大连民族大学', '2017-07-23', '实习', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (25, '寇江波25', '男', '1990-09-06', '123456789023456781', '未婚', 1, '昆明市', 3, '64536456456@rd.cn', '12345678901', '辽宁省大连市 634021', 3, 6, 3, '劳务合同', '硕士', '软件工程', '大连民族大学', '2017-03-20', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (26, '吴显超26', '男', '1995-06-12', '123456789023456781', '未婚', 1, '贵阳市', 11, '234234234@gmail.com', '12345678901', '辽宁省大连市 190715', 3, 4, 4, '劳动合同', '硕士', '计算机科学与技术', '大连民族大学', '2017-05-09', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (27, '伍柯帆27', '男', '1997-08-04', '123456789023456781', '未婚', 1, '成都市', 1, '456456456@yahoo.com', '12345678901', '辽宁省大连市 137243', 3, 4, 5, '劳务合同', '硕士', '计算机科学与技术', '大连民族大学', '2018-09-29', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (28, '赵力民28', '男', '2001-12-03', '123456789023456781', '未婚', 1, '内蒙古', 7, '234234234@wg.cn', '12345678901', '辽宁省大连市 186275', 3, 4, 6, '劳动合同', '硕士', '计算机科学与技术', '大连民族大学', '2017-10-04', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (29, '苏贞涛29', '男', '2001-03-14', '123456789023456781', '未婚', 1, '贵阳市', 6, '5466786@yahoo.com', '12345678901', '辽宁省大连市 691913', 3, 6, 7, '劳务合同', '硕士', '网络工程', '大连民族大学', '2018-02-28', '离职', '2021-10-15', '2021-10-26');
INSERT INTO `employee` VALUES (30, '刘泽民30', '男', '1998-09-14', '123456789023456781', '未婚', 1, '衡阳市', 2, '2345346@hotmail.com', '12345678901', '辽宁省大连市 259607', 4, 4, 8, '劳动合同', '本科', '网络工程', '大连民族大学', '2017-02-22', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (31, '寇江波31', '男', '1995-07-18', '123456789023456781', '未婚', 1, '昆明市', 7, '765567567@hotmail.com', '12345678901', '辽宁省大连市 788572', 4, 2, 9, '劳务合同', '本科', '计算机科学与技术', '大连民族大学', '2019-02-27', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (32, '吴显超32', '男', '2002-01-03', '123456789023456781', '未婚', 1, '贵阳市', 2, '23412341234@yahoo.com', '12345678901', '辽宁省大连市 620273', 1, 6, 10, '劳务合同', '本科', '软件工程', '大连民族大学', '2019-01-30', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (33, '伍柯帆33', '男', '1995-10-03', '123456789023456781', '未婚', 1, '昆明市', 9, '5436457457@yahoo.com', '12345678901', '辽宁省大连市 666462', 1, 6, 11, '劳动合同', '本科', '软件工程', '大连民族大学', '2018-05-08', '待转', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (34, '赵力民34', '男', '2001-07-07', '123456789023456781', '未婚', 1, '贵阳市', 7, '12434234@yahoo.com', '12345678901', '辽宁省大连市 530374', 2, 8, 1, '劳动合同', '本科', '网络工程', '大连民族大学', '2019-03-12', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (35, '苏贞涛35', '男', '1994-04-13', '123456789023456781', '未婚', 1, '昆明市', 11, '3463463457457@jiena.cn', '12345678901', '辽宁省大连市 155477', 2, 4, 2, '劳动合同', '本科', '网络工程', '大连民族大学', '2017-07-21', '在职', '2021-10-15', NULL);
INSERT INTO `employee` VALUES (36, '刘泽民36', '男', '2000-09-29', '123456789023456781', '未婚', 1, '贵阳市', 8, '23423435@yongluo.cn', '12345678901', '辽宁省大连市 968626', 3, 5, 3, '劳务合同', '本科', '软件工程', '大连民族大学', '2016-06-01', '实习', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (37, '寇江波37', '男', '1992-05-08', '123456789023456781', '未婚', 1, '衡阳市', 8, '234124124@yahoo.com', '12345678901', '辽宁省大连市 836168', 3, 6, 4, '劳动合同', '本科', '软件工程', '大连民族大学', '2015-09-26', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (38, '吴显超38', '男', '1995-12-27', '123456789023456781', '未婚', 1, '昆明市', 1, '3242346346@yahoo.com', '12345678901', '辽宁省大连市 556099', 3, 1, 5, '劳动合同', '本科', '计算机科学与技术', '大连民族大学', '2017-12-11', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (39, '伍柯帆39', '男', '1994-04-02', '123456789023456781', '未婚', 1, '贵阳市', 7, '234234234@75.cn', '12345678901', '辽宁省大连市 127451', 3, 3, 6, '劳务合同', '本科', '计算机科学与技术', '大连民族大学', '2016-04-15', '离职', '2021-10-23', '2021-10-26');
INSERT INTO `employee` VALUES (40, '赵力民41', '男', '1991-03-18', '123456789023456781', '未婚', 1, '成都市', 5, '2342345235@xiongyu.cn', '12345678901', '辽宁省大连市 723731', 3, 5, 7, '劳务合同', '本科', '计算机科学与技术', '大连民族大学', '2016-10-09', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (41, '苏贞涛42', '男', '1993-04-15', '123456789023456781', '未婚', 1, '内蒙古', 5, '123123123@leilai.cn', '12345678901', '辽宁省大连市 593600', 4, 4, 8, '劳动合同', '本科', '网络工程', '大连民族大学', '2016-05-09', '实习', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (42, '刘泽民42', '男', '1990-08-09', '123456789023456781', '未婚', 1, '昆明市', 8, '123123123@fangpeng.net', '12345678901', '辽宁省大连市 743024', 4, 8, 9, '劳动合同', '本科', '网络工程', '大连民族大学', '2015-11-18', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (43, '寇江波43', '男', '1998-01-09', '123456789023456781', '未婚', 1, '贵阳市', 2, '3245235235@dt.cn', '12345678901', '辽宁省大连市 463619', 1, 1, 10, '劳动合同', '本科', '网络工程', '大连民族大学', '2016-02-11', '待转', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (44, '吴显超44', '男', '1993-05-06', '123456789023456781', '未婚', 1, '成都市', 11, '124124124@xg.cn', '12345678901', '辽宁省大连市 470818', 1, 2, 11, '劳动合同', '本科', '计算机科学与技术', '大连民族大学', '2015-10-21', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (45, '赵力民45', '男', '1993-10-29', '123456789023456781', '未婚', 1, '内蒙古', 6, '14352523@59.cn', '12345678901', '辽宁省大连市 926668', 2, 8, 1, '劳动合同', '本科', '软件工程', '大连民族大学', '2019-02-09', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (46, '苏贞涛46', '男', '1997-07-22', '123456789023456781', '未婚', 1, '贵阳市', 8, '1241235256@yahoo.com', '12345678901', '辽宁省大连市 670289', 2, 2, 2, '劳务合同', '大专', '软件工程', '大连民族大学', '2015-10-26', '待转', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (47, '刘泽民4', '男', '1993-11-26', '123456789023456781', '未婚', 1, '衡阳市', 3, '124512341234@shikang.cn', '12345678901', '辽宁省大连市 711455', 3, 5, 3, '劳动合同', '大专', '软件工程', '大连民族大学', '2018-10-20', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (48, '寇江波48', '男', '1990-06-27', '123456789023456781', '未婚', 1, '昆明市', 2, '546456235@yahoo.com', '12345678901', '辽宁省大连市 375799', 3, 8, 4, '劳务合同', '大专', '网络工程', '大连民族大学', '2017-08-11', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (49, '吴显超49', '男', '2001-01-10', '123456789023456781', '未婚', 1, '贵阳市', 10, '124123432@yan.cn', '12345678901', '辽宁省大连市 574433', 3, 1, 4, '劳动合同', '大专', '网络工程', '大连民族大学', '2018-11-09', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (50, '伍柯帆50', '男', '1993-05-17', '123456789023456781', '未婚', 1, '成都市', 3, '24535135@minyu.cn', '12345678901', '辽宁省大连市 172795', 3, 8, 5, '劳动合同', '大专', '网络工程', '大连民族大学', '2015-08-20', '实习', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (51, '赵力民51', '男', '1995-05-24', '123456789023456781', '未婚', 1, '内蒙古', 10, '123125346@yaoliu.cn', '12345678901', '辽宁省大连市 474776', 3, 1, 6, '劳务合同', '大专', '网络工程', '大连民族大学', '2016-11-16', '待转', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (52, '苏贞涛52', '男', '1993-01-15', '123456789023456781', '未婚', 1, '贵阳市', 9, '2355263467@guiying.cn', '12345678901', '辽宁省大连市 526080', 3, 2, 7, '劳务合同', '大专', '软件工程', '大连民族大学', '2016-03-14', '离职', '2021-10-23', '2021-10-26');
INSERT INTO `employee` VALUES (53, '刘泽民53', '男', '1994-07-14', '123456789023456781', '未婚', 1, '昆明市', 7, '12412452345@gmail.com', '12345678901', '辽宁省大连市 728886', 4, 3, 8, '劳务合同', '大专', '软件工程', '大连民族大学', '2017-07-25', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (54, '寇江波54', '男', '2001-04-07', '123456789023456781', '未婚', 1, '贵阳市', 6, '12413525@gmail.com', '12345678901', '辽宁省大连市 917143', 4, 4, 9, '劳务合同', '大专', '网络工程', '大连民族大学', '2016-02-17', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (55, '吴显超55', '男', '1990-07-04', '123456789023456781', '未婚', 1, '成都市', 12, '12312453456@yahoo.com', '12345678901', '辽宁省大连市 282976', 1, 4, 10, '劳务合同', '大专', '网络工程', '大连民族大学', '2016-03-23', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (56, '伍柯帆56', '男', '2001-12-03', '123456789023456781', '未婚', 1, '内蒙古', 3, '5436346@yahoo.com', '12345678901', '辽宁省大连市 767974', 1, 4, 11, '劳务合同', '大专', '软件工程', '大连民族大学', '2016-07-26', '在职', '2021-10-23', NULL);
INSERT INTO `employee` VALUES (476, '赵力民test', '男', '2000-11-20', '341234568810196427', '未婚', 1, '英市', 11, 'xia53@gangjing.cn', '15567487644', '贵州省洁市清城汕尾街', 2, 5, 1, '劳动合同', '博士', '电子工程', '中国科学技术大学', '2021-10-27', '离职', '2021-10-27', '2021-10-27');

-- ----------------------------
-- Table structure for employee_ec
-- ----------------------------
DROP TABLE IF EXISTS `employee_ec`;
CREATE TABLE `employee_ec`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int NULL DEFAULT NULL COMMENT '员工编号',
  `ec_date` date NULL DEFAULT NULL COMMENT '奖罚日期',
  `ec_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖罚原因',
  `ec_type` int NULL DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id_index`(`employee_id`) USING BTREE,
  CONSTRAINT `employee_ec_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee_ec
-- ----------------------------

-- ----------------------------
-- Table structure for employee_entry
-- ----------------------------
DROP TABLE IF EXISTS `employee_entry`;
CREATE TABLE `employee_entry`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int NULL DEFAULT NULL COMMENT '员工id',
  `application_date` date NULL DEFAULT NULL COMMENT '申请提交日期',
  `entry_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  CONSTRAINT `employee_entry_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee_entry
-- ----------------------------
INSERT INTO `employee_entry` VALUES (1, 476, '2021-10-27', NULL, '', 0);

-- ----------------------------
-- Table structure for employee_leave
-- ----------------------------
DROP TABLE IF EXISTS `employee_leave`;
CREATE TABLE `employee_leave`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int NULL DEFAULT NULL COMMENT '员工id',
  `application_date` date NULL DEFAULT NULL COMMENT '申请提交日期',
  `leave_date` date NULL DEFAULT NULL COMMENT '离职日期',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  CONSTRAINT `employee_leave_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee_leave
-- ----------------------------
INSERT INTO `employee_leave` VALUES (2, 476, '2021-10-27', NULL, '', 0);

-- ----------------------------
-- Table structure for employee_remove
-- ----------------------------
DROP TABLE IF EXISTS `employee_remove`;
CREATE TABLE `employee_remove`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int NULL DEFAULT NULL COMMENT '员工id',
  `after_dept_id` int NULL DEFAULT NULL COMMENT '调动后部门',
  `after_job_id` int NULL DEFAULT NULL COMMENT '调动后职位',
  `remove_date` date NULL DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  CONSTRAINT `employee_remove_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee_remove
-- ----------------------------

-- ----------------------------
-- Table structure for job_level
-- ----------------------------
DROP TABLE IF EXISTS `job_level`;
CREATE TABLE `job_level`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称名称',
  `title_level` enum('正高级','副高级','中级','初级','员级') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称等级',
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_level
-- ----------------------------
INSERT INTO `job_level` VALUES (1, '教授', '正高级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (2, '副教授', '副高级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (3, '助教', '初级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (4, '讲师', '中级', '2020-03-31 16:20:34', 0);
INSERT INTO `job_level` VALUES (5, '初级工程师', '初级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (6, '中级工程师', '中级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (7, '高级工程师', '副高级', '2020-03-31 16:20:34', 1);
INSERT INTO `job_level` VALUES (8, '骨灰级工程师', '正高级', '2020-03-31 16:20:34', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url',
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'path',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名',
  `icon_cls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否保持激活',
  `require_auth` tinyint(1) NULL DEFAULT NULL COMMENT '是否要求权限',
  `parent_id` int NULL DEFAULT NULL COMMENT '父id',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_id_index`(`parent_id`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/', NULL, NULL, '所有', NULL, NULL, NULL, NULL, 1);
INSERT INTO `menu` VALUES (2, '/', '/home', 'Home', '部门管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (3, '/', '/home', 'Home', '岗位管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (4, '/', '/home', 'Home', '员工资料', 'fa fa-user-circle-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (5, '/', '/home', 'Home', '人事管理', 'fa fa-address-card-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (6, '/', '/home', 'Home', '统计管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (7, '/', '/home', 'Home', '系统管理', 'fa fa-bar-chart', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (8, '/dept/query/**', '/dept/query', 'DeptQuery', '部门查询', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (9, '/position/query/**', '/position/query', 'PositionQuery', '岗位查询', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (10, '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本员工信息', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (11, '/personnel/entry/**', '/personnel/entry', 'PersonnelEntry', '员工入职管理', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (12, '/personnel/leave/**', '/personnel/leave', 'PersonnelLeave', '员工离职管理', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (13, '/statistics/**', '/statistics', 'StatisticsPers', '人事信息统计', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (14, '/system/basic/**', '/system/basic', 'SystemBasic', '当前用户基础信息', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (15, '/system/cfg/**', '/system/cfg', 'SystemCfg', '系统管理', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (16, '/system/user/**', '/system/user', 'SystemUser', '操作员管理', NULL, NULL, 1, 7, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int NULL DEFAULT NULL COMMENT '菜单id',
  `role_id` int NULL DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 766 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (1, 1, 1);
INSERT INTO `menu_role` VALUES (2, 2, 1);
INSERT INTO `menu_role` VALUES (3, 3, 1);
INSERT INTO `menu_role` VALUES (4, 4, 1);
INSERT INTO `menu_role` VALUES (5, 5, 1);
INSERT INTO `menu_role` VALUES (6, 6, 1);
INSERT INTO `menu_role` VALUES (7, 7, 1);
INSERT INTO `menu_role` VALUES (8, 8, 1);
INSERT INTO `menu_role` VALUES (9, 9, 1);
INSERT INTO `menu_role` VALUES (10, 10, 1);
INSERT INTO `menu_role` VALUES (11, 11, 1);
INSERT INTO `menu_role` VALUES (12, 12, 1);
INSERT INTO `menu_role` VALUES (13, 13, 1);
INSERT INTO `menu_role` VALUES (14, 14, 1);
INSERT INTO `menu_role` VALUES (15, 15, 1);
INSERT INTO `menu_role` VALUES (16, 16, 1);
INSERT INTO `menu_role` VALUES (17, 1, 2);
INSERT INTO `menu_role` VALUES (18, 2, 2);
INSERT INTO `menu_role` VALUES (19, 3, 2);
INSERT INTO `menu_role` VALUES (20, 4, 2);
INSERT INTO `menu_role` VALUES (21, 5, 2);
INSERT INTO `menu_role` VALUES (22, 6, 2);
INSERT INTO `menu_role` VALUES (23, 7, 2);
INSERT INTO `menu_role` VALUES (24, 8, 2);
INSERT INTO `menu_role` VALUES (25, 9, 2);
INSERT INTO `menu_role` VALUES (26, 10, 2);
INSERT INTO `menu_role` VALUES (27, 13, 2);
INSERT INTO `menu_role` VALUES (28, 14, 2);
INSERT INTO `menu_role` VALUES (29, 1, 3);
INSERT INTO `menu_role` VALUES (30, 2, 3);
INSERT INTO `menu_role` VALUES (31, 3, 3);
INSERT INTO `menu_role` VALUES (32, 4, 3);
INSERT INTO `menu_role` VALUES (33, 5, 3);
INSERT INTO `menu_role` VALUES (34, 6, 3);
INSERT INTO `menu_role` VALUES (35, 7, 3);
INSERT INTO `menu_role` VALUES (36, 8, 3);
INSERT INTO `menu_role` VALUES (37, 9, 3);
INSERT INTO `menu_role` VALUES (38, 10, 3);
INSERT INTO `menu_role` VALUES (39, 11, 3);
INSERT INTO `menu_role` VALUES (40, 12, 3);
INSERT INTO `menu_role` VALUES (41, 13, 3);
INSERT INTO `menu_role` VALUES (42, 14, 3);

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES (1, '汉族');
INSERT INTO `nation` VALUES (2, '蒙古族');
INSERT INTO `nation` VALUES (3, '回族');
INSERT INTO `nation` VALUES (4, '藏族');
INSERT INTO `nation` VALUES (5, '维吾尔族');
INSERT INTO `nation` VALUES (6, '苗族');
INSERT INTO `nation` VALUES (7, '彝族');
INSERT INTO `nation` VALUES (8, '壮族');
INSERT INTO `nation` VALUES (9, '布依族');
INSERT INTO `nation` VALUES (10, '朝鲜族');
INSERT INTO `nation` VALUES (11, '满族');
INSERT INTO `nation` VALUES (12, '侗族');
INSERT INTO `nation` VALUES (13, '瑶族');
INSERT INTO `nation` VALUES (14, '白族');
INSERT INTO `nation` VALUES (15, '土家族');
INSERT INTO `nation` VALUES (16, '哈尼族');
INSERT INTO `nation` VALUES (17, '哈萨克族');
INSERT INTO `nation` VALUES (18, '傣族');
INSERT INTO `nation` VALUES (19, '黎族');
INSERT INTO `nation` VALUES (20, '傈僳族');
INSERT INTO `nation` VALUES (21, '佤族');
INSERT INTO `nation` VALUES (22, '畲族');
INSERT INTO `nation` VALUES (23, '高山族');
INSERT INTO `nation` VALUES (24, '拉祜族');
INSERT INTO `nation` VALUES (25, '水族');
INSERT INTO `nation` VALUES (26, '东乡族');
INSERT INTO `nation` VALUES (27, '纳西族');
INSERT INTO `nation` VALUES (28, '景颇族');
INSERT INTO `nation` VALUES (29, '柯尔克孜族');
INSERT INTO `nation` VALUES (30, '土族');
INSERT INTO `nation` VALUES (31, '达斡尔族');
INSERT INTO `nation` VALUES (32, '仫佬族');
INSERT INTO `nation` VALUES (33, '羌族');
INSERT INTO `nation` VALUES (34, '布朗族');
INSERT INTO `nation` VALUES (35, '撒拉族');
INSERT INTO `nation` VALUES (36, '毛难族');
INSERT INTO `nation` VALUES (37, '仡佬族');
INSERT INTO `nation` VALUES (38, '锡伯族');
INSERT INTO `nation` VALUES (39, '阿昌族');
INSERT INTO `nation` VALUES (40, '普米族');
INSERT INTO `nation` VALUES (41, '塔吉克族');
INSERT INTO `nation` VALUES (42, '怒族');
INSERT INTO `nation` VALUES (43, '乌孜别克族');
INSERT INTO `nation` VALUES (44, '俄罗斯族');
INSERT INTO `nation` VALUES (45, '鄂温克族');
INSERT INTO `nation` VALUES (46, '崩龙族');
INSERT INTO `nation` VALUES (47, '保安族');
INSERT INTO `nation` VALUES (48, '裕固族');
INSERT INTO `nation` VALUES (49, '京族');
INSERT INTO `nation` VALUES (50, '塔塔尔族');
INSERT INTO `nation` VALUES (51, '独龙族');
INSERT INTO `nation` VALUES (52, '鄂伦春族');
INSERT INTO `nation` VALUES (53, '赫哲族');
INSERT INTO `nation` VALUES (54, '门巴族');
INSERT INTO `nation` VALUES (55, '珞巴族');
INSERT INTO `nation` VALUES (56, '基诺族');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `add_date` date NULL DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `user_id` int NULL DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oplog
-- ----------------------------

-- ----------------------------
-- Table structure for politics_status
-- ----------------------------
DROP TABLE IF EXISTS `politics_status`;
CREATE TABLE `politics_status`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of politics_status
-- ----------------------------
INSERT INTO `politics_status` VALUES (1, '中共党员');
INSERT INTO `politics_status` VALUES (2, '中共预备党员');
INSERT INTO `politics_status` VALUES (3, '共青团员');
INSERT INTO `politics_status` VALUES (4, '民革党员');
INSERT INTO `politics_status` VALUES (5, '民盟盟员');
INSERT INTO `politics_status` VALUES (6, '民建会员');
INSERT INTO `politics_status` VALUES (7, '民进会员');
INSERT INTO `politics_status` VALUES (8, '农工党党员');
INSERT INTO `politics_status` VALUES (9, '致公党党员');
INSERT INTO `politics_status` VALUES (10, '九三学社社员');
INSERT INTO `politics_status` VALUES (11, '台盟盟员');
INSERT INTO `politics_status` VALUES (12, '无党派民主人士');
INSERT INTO `politics_status` VALUES (13, '普通公民');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dept_id` int NOT NULL COMMENT '所属部门ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `position_ibfk_1`(`dept_id`) USING BTREE,
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES (1, 2, '运营总监', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (2, 2, '市场总监', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (3, 3, '技术总监', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (4, 3, '前端工程师', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (5, 3, '后端工程师', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (6, 3, '大数据工程师', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (7, 3, '测试工程师', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (8, 4, '运维总监', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (9, 4, '运维工程师', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (10, 1, '财务总监', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (11, 1, '会计', '2021-10-31 16:20:34', 1);
INSERT INTO `position` VALUES (12, 1, '会计-test', '2021-10-22 06:38:50', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `name_zh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_admin', '系统管理员');
INSERT INTO `role` VALUES (2, 'ROLE_hr', 'HR');
INSERT INTO `role` VALUES (3, 'ROLE_manager', '管理员');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `user_face` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '系统管理员', '18687572786', '71937538', '大连民族大学', 1, 'admin', '$2a$10$c3zq9anAFN2OACMoqkKHEuiQ3xpa6o38MnRSI7aLCjpJE7fz9gB1.', '', NULL);
INSERT INTO `user` VALUES (2, 'HR1', '18000000000', '71937539', '大连民族大学', 1, 'hr1', '$2a$10$c3zq9anAFN2OACMoqkKHEuiQ3xpa6o38MnRSI7aLCjpJE7fz9gB1.', '', NULL);
INSERT INTO `user` VALUES (3, 'nanager1', '18000000000', '71937539', '族', 1, 'manager1', '$2a$10$c3zq9anAFN2OACMoqkKHEuiQ3xpa6o38MnRSI7aLCjpJE7fz9gB1.', NULL, NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id`) USING BTREE,
  INDEX `role_id_index`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);

SET FOREIGN_KEY_CHECKS = 1;
