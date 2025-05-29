 # 请将利用MySQL Workbench软件的Modeling工具，经forward engineering 导出的创建schema的SQL语句完整粘到此处：
 
-- 临时禁用唯一性检查和外键检查
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; -- 保存并禁用唯一性检查
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; -- 保存并禁用外键检查
SET @OLD_SQL_MODE=@@SQL_MODE, 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; -- 设置SQL模式

-- 创建数据库模式并切换到该模式
CREATE SCHEMA IF NOT EXISTS rbac DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ; -- 创建数据库模式
USE rbac ; -- 切换到rbac数据库模式

-- 创建角色表
CREATE TABLE IF NOT EXISTS rbac.aprole (
    RoleNo INT NOT NULL COMMENT '角色编号', -- 角色编号
    RoleName CHAR(20) NOT NULL COMMENT '角色名', -- 角色名
    Comment VARCHAR(50) NULL DEFAULT NULL COMMENT '角色描述', -- 角色描述
    Status SMALLINT NULL DEFAULT NULL COMMENT '角色状态', -- 角色状态
    PRIMARY KEY (RoleNo)) -- 主键
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8mb4 
    COLLATE = utf8mb4_0900_ai_ci 
    COMMENT = '角色表'; -- 表注释

-- 创建用户表
CREATE TABLE IF NOT EXISTS rbac.apuser(
    UserID CHAR(8) NOT NULL COMMENT '用户工号', -- 用户工号
    UserName CHAR(8) NULL DEFAULT NULL COMMENT '用户姓名', -- 用户姓名
    Comment VARCHAR(50) NULL DEFAULT NULL COMMENT '用户描述', -- 用户描述
    PassWord CHAR(32) NULL DEFAULT NULL COMMENT '口令', -- 口令
    Status SMALLINT NULL DEFAULT NULL COMMENT '状态', -- 状态
    PRIMARY KEY (UserID), -- 主键
    UNIQUE INDEX ind_username (UserName ASC) VISIBLE) -- 唯一索引
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci 
    COMMENT = '用户表'; -- 表注释

-- 创建角色分配表
CREATE TABLE IF NOT EXISTS rbac.apgroup (
    UserID CHAR(8) NOT NULL COMMENT '用户编号', -- 用户编号
    RoleNo INT NOT NULL COMMENT '角色编号', -- 角色编号
    PRIMARY KEY (UserID, RoleNo), -- 主键
    INDEX FK_apGroup_apRole (RoleNo ASC) VISIBLE, -- 索引
    CONSTRAINT FK_apGroup_apRole FOREIGN KEY (RoleNo) REFERENCES rbac.aprole(RoleNo), -- 外键关联
    CONSTRAINT FK_apGroup_apUser FOREIGN KEY (UserID) REFERENCES rbac.apuser(UserID)) -- 外键关联
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8mb4 
    COLLATE = utf8mb4_0900_ai_ci 
    COMMENT = '角色分配表'; -- 表注释

-- 创建功能模块登记表
CREATE TABLE IF NOT EXISTS rbac.apmodule (
    ModNo BIGINT NOT NULL COMMENT '模块编号', -- 模块编号
    ModID CHAR(10) NULL DEFAULT NULL COMMENT '系统或模块的代码', -- 系统或模块的代码
    ModName CHAR(20) NULL DEFAULT NULL COMMENT '系统或模块的名称', -- 系统或模块的名称
    PRIMARY KEY (ModNo)) -- 主键
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8mb4 
    COLLATE = utf8mb4_0900_ai_ci 
    COMMENT = '功能模块登记表'; -- 表注释

-- 创建角色权限表
CREATE TABLE IF NOT EXISTS rbac.apright (
    RoleNo INT NOT NULL COMMENT '角色编号', -- 角色编号
    ModNo BIGINT NOT NULL COMMENT '模块编号', -- 模块编号
    PRIMARY KEY (RoleNo, ModNo), -- 主键
    INDEX FK_apRight_apModule (ModNo ASC) VISIBLE, -- 索引
    CONSTRAINT FK_apRight_apModule 
    FOREIGN KEY (ModNo) 
    REFERENCES rbac.apmodule(ModNo), -- 外键关联
    CONSTRAINT FK_apRight_apRole
    FOREIGN KEY (RoleNo) 
    REFERENCES rbac.aprole(RoleNo)) -- 外键关联
    ENGINE = InnoDB 
    DEFAULT CHARACTER SET = utf8mb4 
    COLLATE = utf8mb4_0900_ai_ci 
    COMMENT = '角色权限表'; -- 表注释

-- 恢复SQL模式、外键检查和唯一性检查
SET SQL_MODE=@OLD_SQL_MODE; -- 恢复SQL模式
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; -- 恢复外键检查
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; -- 恢复唯一性检查

 
 
 