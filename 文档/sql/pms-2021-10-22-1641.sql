/*
 Navicat Premium Data Transfer

 Source Server         : noblegasesgoo
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : 49.234.38.85:3306
 Source Schema         : pms

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 22/10/2021 16:40:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int(11) NULL DEFAULT NULL COMMENT '员工id',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `id_card` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nation_id` int(11) NULL DEFAULT NULL COMMENT '民族',
  `native_place` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politic_id` int(11) NULL DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现居地址',
  `department_id` int(11) NULL DEFAULT NULL COMMENT '所属部门ID',
  `job_level_id` int(11) NULL DEFAULT NULL COMMENT '职称ID',
  `position_id` int(11) NULL DEFAULT NULL COMMENT '职位ID',
  `engage_form` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聘用形式',
  `tiptop_degree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属专业',
  `university` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `begin_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `work_state` enum('实习','在职','离职','待转') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '在职' COMMENT '在职状态',
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
) ENGINE = InnoDB AUTO_INCREMENT = 418 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '韦梅', '女', '1999-11-20', '341502198810196427', '未婚', 1, '英市', 11, 'xia53@gangjing.cn', '15567487644', '贵州省洁市清城汕尾街d座 502246', 2, 5, 1, '劳动合同', '博士', '电子工程', '中国科学技术大学', '2018-10-16', '在职');
INSERT INTO `employee` VALUES (2, '王丹', '女', '1992-03-25', '350481197304037905', '未婚', 1, '关岭市', 2, 'jieqian@yahoo.com', '18762780051', '山西省合肥县西峰香港街C座 302114', 2, 8, 2, '劳动合同', '博士', '无', '北京大学', '2018-06-25', '在职');
INSERT INTO `employee` VALUES (3, '刘俊', '男', '1996-07-18', '130224197009132687', '未婚', 1, '萍县', 13, 'qiangfang@yahoo.com', '18663579680', '西藏自治区秀荣市海陵张家港街m座 576579', 3, 6, 3, '劳务合同', '博士', '护理学', '南京大学', '2017-08-15', '在职');
INSERT INTO `employee` VALUES (4, '刘玉珍', '女', '1993-07-10', '512000196701014288', '未婚', 1, '雷县', 5, 'fangyang@pinggang.cn', '13972309788', '西藏自治区张家港市双滦凌街V座 614280', 3, 8, 4, '劳动合同', '博士', '市场营销', '上海交通大学', '2019-02-21', '在职');
INSERT INTO `employee` VALUES (5, '孟秀兰', '女', '2000-01-08', '130601195204145457', '未婚', 1, '荆门县', 10, 'xliu@yahoo.com', '13319975239', '天津市辽阳市金平傅街j座 850761', 3, 4, 5, '劳动合同', '博士', '电子工程', '浙江大学', '2016-12-13', '在职');
INSERT INTO `employee` VALUES (6, '袁秀英', '男', '1990-05-07', '110107198510132428', '未婚', 1, '合肥县', 4, 'nawu@hotmail.com', '15984781796', '重庆市兰英市高明沈阳街d座 430329', 3, 7, 6, '劳务合同', '博士', '无', '中国人民大学', '2015-10-15', '在职');
INSERT INTO `employee` VALUES (7, '沈璐', '男', '1992-05-07', '520400196705056989', '未婚', 1, '合山县', 8, 'gaotao@hotmail.com', '14715158775', '浙江省坤县西峰余街C座 221697', 3, 6, 7, '劳务合同', '博士', '室内装修设计', '中国科学院大学', '2016-07-30', '在职');
INSERT INTO `employee` VALUES (8, '丁艳', '男', '2001-01-29', '542100199401152966', '未婚', 1, '玲市', 10, 'yong36@gmail.com', '18878249984', '江西省南昌县双滦王路E座 490503', 4, 6, 8, '劳动合同', '博士', '信息管理与信息系统', '中国科学技术大学', '2016-05-21', '在职');
INSERT INTO `employee` VALUES (9, '张瑞', '男', '1994-01-11', '330782198309077942', '未婚', 1, '银川市', 10, 'ping21@zengyi.net', '15510694655', '江西省太原市翔安刘街J座 815655', 4, 4, 9, '劳务合同', '博士', '信息管理与信息系统', '上海交通大学', '2018-01-15', '在职');
INSERT INTO `employee` VALUES (10, '黄柳', '男', '1999-10-03', '45142219420818691X', '未婚', 1, '北镇市', 3, 'juanliu@jieming.cn', '14523008198', '江苏省宁县南溪王路x座 227133', 1, 1, 10, '劳务合同', '博士', '市场营销', '南京大学', '2017-06-17', '在职');
INSERT INTO `employee` VALUES (11, '王慧', '女', '1994-07-09', '441223196008184592', '未婚', 1, '贵阳县', 8, 'xiahu@dengpan.net', '18288493616', '青海省长沙县山亭廖街v座 439792', 1, 1, 11, '劳务合同', '博士', '电子工程', '浙江大学', '2015-10-22', '在职');
INSERT INTO `employee` VALUES (12, '田龙', '男', '1991-07-21', '621026195512050072', '未婚', 1, '敏县', 11, 'epan@hotmail.com', '13130911244', '安徽省帆市东城唐路d座 819867', 2, 7, 1, '劳务合同', '博士', '电子工程', '中国科学技术大学', '2016-06-13', '在职');
INSERT INTO `employee` VALUES (13, '徐桂香', '男', '1997-03-06', '220101195011153893', '未婚', 1, '桂芝市', 8, 'mingxiong@guiyingna.cn', '15239681245', '广东省巢湖县和平王路V座 418151', 2, 5, 2, '劳务合同', '博士', '信息管理与信息系统', '中国人民大学', '2018-03-01', '在职');
INSERT INTO `employee` VALUES (14, '韩桂花', '女', '1993-03-13', '451200193609248217', '已婚', 1, '丽丽市', 13, 'vzhao@la.cn', '13091676162', '澳门特别行政区东莞市高港关岭街Z座 113957', 3, 3, 3, '劳务合同', '博士', '护理学', '清华大学', '2015-08-09', '在职');
INSERT INTO `employee` VALUES (15, '方勇', '女', '1993-03-31', '50022619560729008X', '已婚', 1, '银川县', 12, 'juan44@hotmail.com', '13599861266', '吉林省芳县南湖兰路y座 907387', 3, 3, 4, '劳务合同', '硕士', '室内装修设计', '北京大学', '2016-01-17', '在职');
INSERT INTO `employee` VALUES (16, '徐桂芝', '女', '1999-12-07', '350627193810292241', '已婚', 1, '玉梅县', 2, 'min11@hotmail.com', '18060545344', '海南省桂荣县锡山拉萨路m座 889598', 3, 8, 5, '劳动合同', '硕士', '市场营销', '南京大学', '2015-10-11', '在职');
INSERT INTO `employee` VALUES (17, '郭玉英', '女', '1991-05-13', '532626196803147428', '已婚', 1, '荆门市', 5, 'taozhang@hotmail.com', '13498131990', '贵州省玉英市长寿席路j座 607847', 3, 6, 6, '劳动合同', '硕士', '护理学', '清华大学', '2017-09-23', '在职');
INSERT INTO `employee` VALUES (18, '张波', '男', '1995-07-20', '341523193305302515', '已婚', 1, '淑英县', 4, 'chao28@yahoo.com', '13198353039', '甘肃省勇县金平合山街V座 343550', 3, 1, 7, '劳务合同', '硕士', '信息管理与信息系统', '中国科学院大学', '2015-05-24', '在职');
INSERT INTO `employee` VALUES (19, '陈桂英', '女', '1998-07-24', '320300198302021032', '已婚', 1, '西宁市', 12, 'leixiuying@lijun.cn', '15196790642', '江西省梧州县西峰林街g座 890108', 4, 2, 8, '劳务合同', '硕士', '室内装修设计', '中国人民大学', '2019-02-19', '在职');
INSERT INTO `employee` VALUES (20, '郭慧', '男', '1997-12-27', '370784196907163913', '已婚', 1, '冬梅市', 5, 'jingyi@lilong.cn', '18748925191', '浙江省淮安市西峰周路Q座 231298', 4, 2, 9, '劳务合同', '硕士', '室内装修设计', '复旦大学', '2018-05-20', '在职');
INSERT INTO `employee` VALUES (21, '王兰英', '女', '2001-01-14', '13062819460201540X', '已婚', 1, '北镇县', 2, 'nren@kc.cn', '13697605585', '河北省荆门县东丽徐路w座 733493', 1, 8, 10, '劳动合同', '硕士', '市场营销', '国防科技大学', '2017-11-22', '在职');
INSERT INTO `employee` VALUES (22, '张丽丽', '女', '1993-01-11', '44011419750119469X', '已婚', 1, '桂花市', 13, 'vcao@hotmail.com', '13499132244', '江苏省颖县黄浦吴路f座 348086', 1, 6, 11, '劳动合同', '硕士', '信息管理与信息系统', '中国科学技术大学', '2018-07-27', '在职');
INSERT INTO `employee` VALUES (23, '陈红', '女', '1991-05-07', '120101194008275509', '已婚', 1, '永安市', 4, 'fgu@hotmail.com', '14504492015', '宁夏回族自治区帆县山亭黄路Q座 528477', 2, 2, 1, '劳动合同', '硕士', '市场营销', '南京大学', '2018-06-24', '在职');
INSERT INTO `employee` VALUES (24, '范凤英', '女', '1994-11-12', '510122194703163917', '已婚', 1, '秀兰县', 6, 'yong19@34.cn', '13973512992', '海南省梧州市滨城李路f座 504377', 2, 6, 2, '劳动合同', '硕士', '电子工程', '北京大学', '2017-07-23', '在职');
INSERT INTO `employee` VALUES (25, '张兵', '男', '1990-09-06', '420701196603064012', '已婚', 1, '宜都市', 3, 'edeng@rd.cn', '15904360492', '西藏自治区桂珍市友好昆明街Y座 634021', 3, 6, 3, '劳务合同', '硕士', '市场营销', '中国人民大学', '2017-03-20', '在职');
INSERT INTO `employee` VALUES (26, '黄宁', '男', '1995-06-12', '510303198712060557', '已婚', 1, '玉英县', 11, 'xiuyingpan@gmail.com', '13377122856', '广东省莉市朝阳台北街x座 190715', 3, 4, 4, '劳动合同', '硕士', '护理学', '中国科学院大学', '2017-05-09', '在职');
INSERT INTO `employee` VALUES (27, '黄荣', '女', '1997-08-04', '14060319870325316X', '已婚', 1, '大冶市', 1, 'ihao@yahoo.com', '14528832529', '江西省六安县和平永安街r座 137243', 3, 4, 5, '劳务合同', '硕士', '无', '浙江大学', '2018-09-29', '在职');
INSERT INTO `employee` VALUES (28, '周雷', '男', '2001-12-03', '411201197212305874', '已婚', 1, '六安市', 7, 'ping89@wg.cn', '14550266014', '浙江省丹县黄浦北镇路G座 186275', 3, 4, 6, '劳动合同', '硕士', '电子工程', '中国科学院大学', '2017-10-04', '在职');
INSERT INTO `employee` VALUES (29, '周静', '女', '2001-03-14', '640105199111105559', '已婚', 1, '雪梅县', 6, 'xiajing@yahoo.com', '18912358599', '山西省瑜县怀柔北京路p座 691913', 3, 6, 7, '劳务合同', '硕士', '护理学', '北京大学', '2018-02-28', '在职');
INSERT INTO `employee` VALUES (30, '师婷婷', '男', '1998-09-14', '500241199402197190', '已婚', 1, '沈阳县', 2, 'pcui@hotmail.com', '14572285539', '福建省海口县江北陈路H座 259607', 4, 4, 8, '劳动合同', '本科', '信息管理与信息系统', '南京大学', '2017-02-22', '在职');
INSERT INTO `employee` VALUES (31, '邹平', '男', '1995-07-18', '469023197609079864', '已婚', 1, '沈阳县', 7, 'qiang09@hotmail.com', '15711044116', '甘肃省丽丽县永川石家庄街w座 788572', 4, 2, 9, '劳务合同', '本科', '市场营销', '浙江大学', '2019-02-27', '在职');
INSERT INTO `employee` VALUES (32, '蒋桂兰', '男', '2002-01-03', '451000198103141393', '已婚', 1, '通辽县', 2, 'xuli@yahoo.com', '14747861689', '台湾省斌县大兴潮州街Q座 620273', 1, 6, 10, '劳务合同', '本科', '电子工程', '浙江大学', '2019-01-30', '在职');
INSERT INTO `employee` VALUES (33, '何燕', '女', '1995-10-03', '211081194006172759', '已婚', 1, '伟市', 9, 'pqin@yahoo.com', '14510585247', '宁夏回族自治区健市和平蔡街X座 666462', 1, 6, 11, '劳动合同', '本科', '护理学', '复旦大学', '2018-05-08', '在职');
INSERT INTO `employee` VALUES (34, '马淑珍', '女', '2001-07-07', '130604198910150088', '已婚', 1, '成县', 7, 'leizou@yahoo.com', '13164981755', '湖北省太原县魏都安街c座 530374', 2, 8, 1, '劳动合同', '本科', '市场营销', '中国科学院大学', '2019-03-12', '在职');
INSERT INTO `employee` VALUES (35, '杨秀芳', '女', '1994-04-13', '130581196312068381', '已婚', 1, '合肥县', 11, 'pqian@jiena.cn', '13873572680', '重庆市璐县大东孙街P座 155477', 2, 4, 2, '劳动合同', '本科', '信息管理与信息系统', '中国科学院大学', '2017-07-21', '在职');
INSERT INTO `employee` VALUES (36, '邱洁', '女', '2000-09-29', '130101194910161225', '已婚', 1, '婷婷县', 8, 'czhou@yongluo.cn', '13841978850', '安徽省磊县南溪刘街U座 968626', 3, 5, 3, '劳务合同', '本科', '市场营销', '复旦大学', '2016-06-01', '在职');
INSERT INTO `employee` VALUES (37, '王桂花', '女', '1992-05-08', '140723194212128260', '已婚', 1, '呼和浩特市', 8, 'ping62@yahoo.com', '18029671014', '内蒙古自治区英县魏都台北街h座 836168', 3, 6, 4, '劳动合同', '本科', '中国语言文学', '浙江大学', '2015-09-26', '在职');
INSERT INTO `employee` VALUES (38, '刘畅', '女', '1995-12-27', '511000193311215215', '已婚', 1, '兴安盟县', 1, 'naxiong@yahoo.com', '13377530628', '河北省呼和浩特县大东王街A座 556099', 3, 1, 5, '劳动合同', '本科', '信息管理与信息系统', '中国科学技术大学', '2017-12-11', '在职');
INSERT INTO `employee` VALUES (39, '蒋欣', '男', '1994-04-02', '450225195711013399', '已婚', 1, '南宁市', 7, 'chenli@75.cn', '13808748993', '福建省杭州市南长天津街m座 127451', 3, 3, 6, '劳务合同', '本科', '无', '北京大学', '2016-04-15', '在职');
INSERT INTO `employee` VALUES (40, '王超', '男', '1991-03-18', '652901197112045159', '已婚', 1, '重庆市', 5, 'mengyong@xiongyu.cn', '18159666889', '广东省秀华县浔阳高街Q座 723731', 3, 5, 7, '劳务合同', '本科', '无', '中国人民大学', '2016-10-09', '在职');
INSERT INTO `employee` VALUES (41, '龚东', '女', '1993-04-15', '140107193503215615', '已婚', 1, '成都市', 5, 'guiying04@leilai.cn', '13611631710', '台湾省东莞县龙潭潜江路d座 593600', 4, 4, 8, '劳动合同', '本科', '室内装修设计', '南京大学', '2016-05-09', '在职');
INSERT INTO `employee` VALUES (42, '侯欢', '女', '1990-08-09', '341824193311150186', '已婚', 1, '龙县', 8, 'yangsu@fangpeng.net', '13821459885', '河南省哈尔滨县东丽呼和浩特路C座 743024', 4, 8, 9, '劳动合同', '本科', '中国语言文学', '复旦大学', '2015-11-18', '在职');
INSERT INTO `employee` VALUES (43, '赵玉华', '女', '1998-01-09', '341525197108234630', '未婚', 1, '博县', 2, 'xiuying33@dt.cn', '18682469543', '香港特别行政区晨县上街刘街e座 463619', 1, 1, 10, '劳动合同', '本科', '护理学', '南京大学', '2016-02-11', '在职');
INSERT INTO `employee` VALUES (44, '刘杨', '男', '1993-05-06', '610404193406165281', '未婚', 1, '玉兰县', 11, 'fangren@xg.cn', '15750031625', '台湾省玉兰市门头沟海门街p座 470818', 1, 2, 11, '劳动合同', '本科', '无', '上海交通大学', '2015-10-21', '在职');
INSERT INTO `employee` VALUES (45, '谢秀兰', '女', '1993-10-29', '450203200203284294', '未婚', 1, '六安县', 6, 'yangmo@59.cn', '15970698995', '澳门特别行政区秀芳市安次张路l座 926668', 2, 8, 1, '劳动合同', '本科', '室内装修设计', '国防科技大学', '2019-02-09', '在职');
INSERT INTO `employee` VALUES (46, '徐秀云', '男', '1997-07-22', '520621193005292541', '未婚', 1, '六盘水市', 8, 'zhengyan@yahoo.com', '15017588555', '山西省太原县滨城潜江路a座 670289', 2, 2, 2, '劳务合同', '大专', '护理学', '国防科技大学', '2015-10-26', '在职');
INSERT INTO `employee` VALUES (47, '秦艳', '男', '1993-11-26', '420581194004273164', '未婚', 1, '兵县', 3, 'guiying60@shikang.cn', '15048749906', '北京市建军县沈北新齐齐哈尔路a座 711455', 3, 5, 3, '劳动合同', '大专', '电子工程', '复旦大学', '2018-10-20', '在职');
INSERT INTO `employee` VALUES (48, '李瑞', '男', '1990-06-27', '231085198709305690', '未婚', 1, '建军县', 2, 'mindong@yahoo.com', '13974711811', '贵州省马鞍山市龙潭朱街L座 375799', 3, 8, 4, '劳务合同', '大专', '信息管理与信息系统', '国防科技大学', '2017-08-11', '在职');
INSERT INTO `employee` VALUES (49, '周倩', '男', '2001-01-10', '140926195508093145', '未婚', 1, '巢湖县', 10, 'qianjuan@yan.cn', '18792735131', '西藏自治区重庆市江北石家庄路G座 574433', 3, 1, 4, '劳动合同', '大专', '信息管理与信息系统', '复旦大学', '2018-11-09', '在职');
INSERT INTO `employee` VALUES (50, '宋阳', '女', '1993-05-17', '510921199204091277', '未婚', 1, '昆明市', 3, 'mwen@minyu.cn', '18826244663', '湖南省丽丽县清城李路P座 172795', 3, 8, 5, '劳动合同', '大专', '无', '国防科技大学', '2015-08-20', '在职');
INSERT INTO `employee` VALUES (51, '毛玉', '男', '1995-05-24', '230901193512038662', '未婚', 1, '哈尔滨县', 10, 'tshao@yaoliu.cn', '13921802030', '广东省晶县房山郑州路t座 474776', 3, 1, 6, '劳务合同', '大专', '护理学', '北京大学', '2016-11-16', '在职');
INSERT INTO `employee` VALUES (52, '陈红梅', '男', '1993-01-15', '36078120010301542X', '未婚', 1, '明市', 9, 'ptian@guiying.cn', '15660538227', '澳门特别行政区淑珍县华龙田路s座 526080', 3, 2, 7, '劳务合同', '大专', '市场营销', '南京大学', '2016-03-14', '在职');
INSERT INTO `employee` VALUES (53, '萧春梅', '女', '1994-07-14', '130225193503290451', '未婚', 1, '华县', 7, 'guiyingzeng@gmail.com', '15280462787', '河北省昆明市长寿顾街o座 728886', 4, 3, 8, '劳务合同', '大专', '中国语言文学', '国防科技大学', '2017-07-25', '在职');
INSERT INTO `employee` VALUES (54, '蔡琳', '女', '2001-04-07', '230801197307256970', '未婚', 1, '雪县', 6, 'yongkong@gmail.com', '13658227544', '澳门特别行政区小红市西夏刘路v座 917143', 4, 4, 9, '劳务合同', '大专', '中国语言文学', '复旦大学', '2016-02-17', '在职');
INSERT INTO `employee` VALUES (55, '谢杰', '男', '1990-07-04', '532524199902246363', '未婚', 1, '晨市', 12, 'junjin@yahoo.com', '13637320900', '内蒙古自治区辽阳市淄川刘路w座 282976', 1, 4, 10, '劳务合同', '大专', '市场营销', '中国人民大学', '2016-03-23', '在职');
INSERT INTO `employee` VALUES (56, '都利', '男', '2001-12-03', '410601196110227963', '未婚', 1, '东莞市', 3, 'wzeng@yahoo.com', '13388584730', '湖北省西宁县沙湾沈阳街Y座 767974', 1, 4, 11, '劳务合同', '大专', '信息管理与信息系统', '北京大学', '2016-07-26', '在职');

-- ----------------------------
-- Table structure for employee_ec
-- ----------------------------
DROP TABLE IF EXISTS `employee_ec`;
CREATE TABLE `employee_ec`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int(11) NULL DEFAULT NULL COMMENT '员工编号',
  `ec_date` date NULL DEFAULT NULL COMMENT '奖罚日期',
  `ec_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖罚原因',
  `ec_type` int(11) NULL DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id_index`(`employee_id`) USING BTREE,
  CONSTRAINT `employee_ec_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee_ec
-- ----------------------------

-- ----------------------------
-- Table structure for employee_remove
-- ----------------------------
DROP TABLE IF EXISTS `employee_remove`;
CREATE TABLE `employee_remove`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `employee_id` int(11) NULL DEFAULT NULL COMMENT '员工id',
  `after_dept_id` int(11) NULL DEFAULT NULL COMMENT '调动后部门',
  `after_job_id` int(11) NULL DEFAULT NULL COMMENT '调动后职位',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url',
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'path',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名',
  `icon_cls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否保持激活',
  `require_auth` tinyint(1) NULL DEFAULT NULL COMMENT '是否要求权限',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
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
INSERT INTO `menu` VALUES (10, '/employee/basic/**', '/emp/basic', 'EmpBasic', '员工基本资料', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (11, '/employee/advanced/**', '/emp/advanced', 'EmpAdvanced', '员工高级资料', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (12, '/personnel/entry/**', '/personnel/entry', 'PersonnelEntry', '员工入职', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (13, '/personnel/leave/**', '/personnel/leave', 'PersonnelLeave', '员工离职', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (14, '/personnel/remove/**', '/personnel/remove', 'PersonnelRemove', '员工调用', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (15, '/personnel/appraise/**', '/personnel/appraise', 'PersonnelAppraise', '员工试用期管理', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (16, '/statistics/personnel/**', '/sta/pers', 'StaPers', '人事信息统计', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (17, '/statistics/recored/**', '/sta/record', 'StaRecord', '人事记录统计', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (18, '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (19, '/system/cfg/**', '/sys/cfg', 'SysCfg', '系统管理', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (20, '/system/log/**', '/sys/log', 'SysLog', '操作日志管理', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (21, '/system/admin/**', '/sys/admin', 'SysAdmin', '操作员管理', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (22, '/system/data/**', '/sys/data', 'SysData', '备份恢复数据库', NULL, NULL, 1, 7, 1);
INSERT INTO `menu` VALUES (23, '/system/init/**', '/sys/init', 'SysInit', '初始化数据库', NULL, NULL, 1, 7, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '菜单id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '权限id',
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
INSERT INTO `menu_role` VALUES (17, 17, 1);
INSERT INTO `menu_role` VALUES (18, 18, 1);
INSERT INTO `menu_role` VALUES (19, 19, 1);
INSERT INTO `menu_role` VALUES (20, 20, 1);
INSERT INTO `menu_role` VALUES (21, 21, 1);
INSERT INTO `menu_role` VALUES (22, 22, 1);
INSERT INTO `menu_role` VALUES (23, 23, 1);

INSERT INTO `menu_role` VALUES (24, 2, 2);
INSERT INTO `menu_role` VALUES (25, 3, 2);
INSERT INTO `menu_role` VALUES (26, 4, 2);
INSERT INTO `menu_role` VALUES (27, 5, 2);
INSERT INTO `menu_role` VALUES (28, 6, 2);
INSERT INTO `menu_role` VALUES (29, 7, 2);
INSERT INTO `menu_role` VALUES (30, 8, 2);
INSERT INTO `menu_role` VALUES (31, 9, 2);
INSERT INTO `menu_role` VALUES (32, 10, 2);
INSERT INTO `menu_role` VALUES (33, 11, 2);
INSERT INTO `menu_role` VALUES (34, 12, 2);
INSERT INTO `menu_role` VALUES (35, 13, 2);
INSERT INTO `menu_role` VALUES (36, 14, 2);
INSERT INTO `menu_role` VALUES (37, 15, 2);
INSERT INTO `menu_role` VALUES (38, 16, 2);
INSERT INTO `menu_role` VALUES (39, 17, 2);
INSERT INTO `menu_role` VALUES (40, 18, 2);

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `add_date` date NULL DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '操作员ID',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dept_id` int(11) NOT NULL COMMENT '所属部门ID',
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
INSERT INTO `position` VALUES (15, 1, '会计-test', '2021-10-22 06:38:50', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `name_zh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_admin', '系统管理员');
INSERT INTO `role` VALUES (2, 'ROLE_hr', 'HR');
INSERT INTO `role` VALUES (10, 'ROLE_test', '测试角色');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
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
INSERT INTO `user` VALUES (1, '系统管理员', '18687572786', '71937538', '大连民族大学', 1, 'admin', '$2a$10$ogvUqZZAxrBwrmVI/e7.SuFYyx8my8d.9zJ6bs9lPKWvbD9eefyCe', 'http://192.168.10.100:8888/group1/M00/00/00/wKgKZF6oHzuAXnw9AABaLsrkrQQ148.jpg', NULL);
INSERT INTO `user` VALUES (2, 'HR1', '18000000000', '71937539', '大连民族大学', 1, 'hr1', '$2a$10$ogvUqZZAxrBwrmVI/e7.SuFYyx8my8d.9zJ6bs9lPKWvbD9eefyCe', 'http://192.168.10.100:8888/group1/M00/00/00/wKgKZF6oHzuAXnw9AABaLsrkrQQ148.jpg', NULL);
INSERT INTO `user` VALUES (3, 'TEST1', '18000000000', '71937539', '大连民族大学', 1, 'test1', '$2a$10$ogvUqZZAxrBwrmVI/e7.SuFYyx8my8d.9zJ6bs9lPKWvbD9eefyCe', 'http://192.168.10.100:8888/group1/M00/00/00/wKgKZF6oHzuAXnw9AABaLsrkrQQ148.jpg', NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id`) USING BTREE,
  INDEX `role_id_index`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 10);

SET FOREIGN_KEY_CHECKS = 1;
