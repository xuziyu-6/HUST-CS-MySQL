-- 删除数据库如果存在并创建新数据库
drop database if exists flight_booking;
create database flight_booking;
use flight_booking;

-- 设置字符集和外键检查
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 创建航空公司表
DROP TABLE IF EXISTS airline;
CREATE TABLE airline (
    airline_id int NOT NULL AUTO_INCREMENT, -- 航空公司ID，自增
    name varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 航空公司名称
    iata char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- IATA代码
    airport_id int NOT NULL, -- 机场ID
    PRIMARY KEY (airline_id) USING BTREE, -- 主键
    UNIQUE INDEX iata_unq (iata) USING BTREE, -- 唯一索引
    INDEX base_airport_idx (airport_id) USING BTREE, -- 索引
    CONSTRAINT airline_ibfk_1 FOREIGN KEY (airport_id) REFERENCES airport (airport_id) ON DELETE RESTRICT ON UPDATE RESTRICT -- 外键关联
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建飞机表
DROP TABLE IF EXISTS airplane;
CREATE TABLE airplane (
    airplane_id int(0) NOT NULL AUTO_INCREMENT, -- 飞机ID，自增
    type varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 飞机类型
    capacity smallint(0) NOT NULL, -- 容量
    identifier varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 飞机标识
    airline_id int(0) NOT NULL, -- 航空公司ID
    PRIMARY KEY (airplane_id) USING BTREE, -- 主键
    INDEX airplane_ibfk_1 (airline_id) USING BTREE, -- 索引
    CONSTRAINT airplane_ibfk_1 FOREIGN KEY (airline_id) REFERENCES airline (airline_id) ON DELETE RESTRICT ON UPDATE RESTRICT -- 外键关联
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建机场表
DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
    airport_id int NOT NULL AUTO_INCREMENT, -- 机场ID，自增
    iata char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- IATA代码
    icao char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- ICAO代码
    name varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 机场名称
    city varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 城市
    country varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 国家
    latitude decimal(11, 8) NULL DEFAULT NULL, -- 纬度
    longitude decimal(11, 8) NULL DEFAULT NULL, -- 经度
    PRIMARY KEY (airport_id) USING BTREE, -- 主键
    UNIQUE INDEX iata_unq (iata) USING BTREE, -- 唯一索引
    UNIQUE INDEX icao_unq (icao) USING BTREE, -- 唯一索引
    INDEX name_idx (name) USING BTREE -- 索引
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建乘客表
DROP TABLE IF EXISTS passenger;
CREATE TABLE passenger (
    passenger_id int NOT NULL AUTO_INCREMENT, -- 乘客ID，自增
    id char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 身份证号
    firstname varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 名
    lastname varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 姓
    mail varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 邮箱
    phone varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 电话
    sex char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 性别
    dob date NULL DEFAULT NULL, -- 出生日期
    PRIMARY KEY (passenger_id) USING BTREE, -- 主键
    UNIQUE INDEX id_unq (id) USING BTREE -- 唯一索引
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建机票表
DROP TABLE IF EXISTS ticket;
CREATE TABLE ticket (
    ticket_id int NOT NULL AUTO_INCREMENT, -- 机票ID，自增
    flight_id int NOT NULL, -- 航班ID
    seat char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 座位
    passenger_id int NOT NULL, -- 乘客ID
    price decimal(10, 2) NOT NULL, -- 价格
    user_id int NOT NULL, -- 用户ID
    PRIMARY KEY (ticket_id) USING BTREE, -- 主键
    INDEX flight_idx (flight_id) USING BTREE, -- 索引
    INDEX passenger_idx (passenger_id) USING BTREE, -- 索引
    INDEX ticket_ibfk_3 (user_id) USING BTREE, -- 索引
    CONSTRAINT ticket_ibfk_1 FOREIGN KEY (flight_id) REFERENCES flight (flight_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT ticket_ibfk_2 FOREIGN KEY (passenger_id) REFERENCES passenger (passenger_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT ticket_ibfk_3 FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT -- 外键关联
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建用户表
DROP TABLE IF EXISTS user;
CREATE TABLE user (
    user_id int NOT NULL AUTO_INCREMENT, -- 用户ID，自增
    firstname varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 名
    lastname varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 姓
    dob date NOT NULL, -- 出生日期
    sex char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 性别
    email varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 邮箱
    phone varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL, -- 电话
    username varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 用户名
    password char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 密码
    admin_tag tinyint NOT NULL DEFAULT 0, -- 管理员标志
    PRIMARY KEY (user_id) USING BTREE, -- 主键
    UNIQUE INDEX user_unq (username) USING BTREE -- 唯一索引
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建航班计划表
DROP TABLE IF EXISTS flightschedule;
CREATE TABLE flightschedule (
    flight_no char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 航班号
    from int NOT NULL, -- 出发地
    to int NOT NULL, -- 目的地
    departure time NOT NULL, -- 出发时间
    arrival time NOT NULL, -- 到达时间
    duration smallint NOT NULL, -- 飞行时长
    airline_id int NOT NULL, -- 航空公司ID
    monday tinyint NULL DEFAULT 0, -- 星期一
    tuesday tinyint NULL DEFAULT 0, -- 星期二
    wednesday tinyint NULL DEFAULT 0, -- 星期三
    thursday tinyint NULL DEFAULT 0, -- 星期四
    friday tinyint NULL DEFAULT 0, -- 星期五
    saturday tinyint NULL DEFAULT 0, -- 星期六
    sunday tinyint NULL DEFAULT 0, -- 星期日
    PRIMARY KEY (flight_no) USING BTREE, -- 主键
    INDEX from_idx (from) USING BTREE, -- 索引
    INDEX to_idx (to) USING BTREE, -- 索引
    INDEX airline_idx (airline_id) USING BTREE, -- 索引
    CONSTRAINT flightschedule_ibfk_1 FOREIGN KEY (from) REFERENCES airport (airport_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flightschedule_ibfk_2 FOREIGN KEY (to) REFERENCES airport (airport_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flightschedule_ibfk_3 FOREIGN KEY (airline_id) REFERENCES airline (airline_id) ON DELETE RESTRICT ON UPDATE RESTRICT -- 外键关联
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 创建航班表
DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
    flight_id int NOT NULL AUTO_INCREMENT, -- 航班ID，自增
    flight_no char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, -- 航班号
    from int NOT NULL, -- 出发地
    to int NOT NULL, -- 目的地
    departure datetime NOT NULL, -- 出发时间
    arrival datetime NOT NULL, -- 到达时间
    duration smallint NOT NULL, -- 飞行时长
    airline_id int NOT NULL, -- 航空公司ID
    airplane_id int NOT NULL, -- 飞机ID
    PRIMARY KEY (flight_id) USING BTREE, -- 主键
    INDEX from_idx (from) USING BTREE, -- 索引
    INDEX to_idx (to) USING BTREE, -- 索引
    INDEX airline_idx (airline_id) USING BTREE, -- 索引
    INDEX airplane_idx (airplane_id) USING BTREE, -- 索引
    INDEX flightno (flight_no) USING BTREE, -- 索引
    CONSTRAINT flight_ibfk_1 FOREIGN KEY (from) REFERENCES airport (airport_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flight_ibfk_2 FOREIGN KEY (to) REFERENCES airport (airport_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flight_ibfk_3 FOREIGN KEY (airline_id) REFERENCES airline (airline_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flight_ibfk_4 FOREIGN KEY (airplane_id) REFERENCES airplane (airplane_id) ON DELETE RESTRICT ON UPDATE RESTRICT, -- 外键关联
    CONSTRAINT flight_ibfk_5 FOREIGN KEY (flight_no) REFERENCES flightschedule (flight_no) ON DELETE RESTRICT ON UPDATE RESTRICT -- 外键关联
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- 恢复外键检查
SET FOREIGN_KEY_CHECKS = 1;
