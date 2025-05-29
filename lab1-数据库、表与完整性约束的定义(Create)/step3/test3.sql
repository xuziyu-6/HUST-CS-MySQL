# 请在以下空白处填写完成任务的语句，空白行可通过回车换行添加。
# 你也可以在命令行窗口完成任务，不过，在命令行键入的语句不会被保存。

-- 创建数据库MyDb  
CREATE DATABASE IF NOT EXISTS MyDb; -- 如果MyDb数据库不存在，则创建它  
  
-- 使用MyDb数据库  
USE MyDb; -- 选择MyDb数据库为当前数据库，接下来的操作将在这个数据库中进行  
  
-- 创建部门表dept  
CREATE TABLE dept (  
    deptNo INT NOT NULL, -- 部门编号，不允许为空  
    deptName VARCHAR(32), -- 部门名称，最大长度为32个字符  
    PRIMARY KEY (deptNo) -- 将部门编号设置为主键，确保每个部门编号的唯一性  
);  
  
-- 创建职工表staff  
CREATE TABLE staff (  
    staffNo INT NOT NULL, -- 职工编号，不允许为空  
    staffName VARCHAR(32), -- 职工姓名，最大长度为32个字符  
    gender CHAR(1), -- 性别，用1个字符表示（如'M'表示男，'F'表示女）  
    dob DATE, -- 出生日期，日期类型  
    salary NUMERIC(8,2), -- 工资，数值类型，总共8位，其中2位是小数部分  
    deptNo INT, -- 部门编号，引用dept表中的deptNo  
    PRIMARY KEY (staffNo), -- 将职工编号设置为主键，确保每个职工编号的唯一性  
    CONSTRAINT FK_staff_deptNo FOREIGN KEY (deptNo) REFERENCES dept(deptNo) -- 定义外键约束，确保staff表中的deptNo列是dept表中deptNo列的有效引用  
);


# 结束 