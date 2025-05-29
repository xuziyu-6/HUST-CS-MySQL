use MyDb;
-- (1) 为表Staff添加主码，假设staffNo字段已存在并且是唯一标识每个员工的  
-- 使用ALTER TABLE语句修改表结构，添加PRIMARY KEY约束  
alter table Staff   
add primary key(staffNo);  
  
-- (2) Dept.mgrStaffNo是外码，对应的主码是Staff.staffNo  
-- 为表Dept的mgrStaffNo字段添加外键约束，并命名为FK_Dept_mgrStaffNo  
-- REFERENCES关键字用于指定外键参照的表和字段  
alter table Dept   
add constraint FK_Dept_mgrStaffNo   
FOREIGN KEY (mgrStaffNo) REFERENCES Staff(staffNo);  
  
-- (3) Staff.dept是外码，对应的主码是Dept.deptNo  
-- 为表Staff的dept字段添加外键约束，并命名为FK_Staff_dept  
-- REFERENCES关键字用于指定外键参照的表和字段  
alter table Staff   
add constraint FK_Staff_dept   
FOREIGN KEY (dept) REFERENCES Dept(deptNo);  
  
-- (4) 为表Staff添加check约束，规则为：gender的值只能为F或M  
-- 使用ALTER TABLE语句修改表结构，添加CHECK约束  
-- CHECK关键字用于指定字段必须满足的条件  
alter table Staff   
add constraint CK_Staff_gender   
check(gender in ('F','M'));  
  
-- (5) 为表Dept添加unique约束：deptName不允许重复  
-- 使用ALTER TABLE语句修改表结构，添加UNIQUE约束  
-- UNIQUE关键字用于指定字段的值必须是唯一的  
alter table Dept   
add constraint UN_Dept_deptName   
UNIQUE(deptName);