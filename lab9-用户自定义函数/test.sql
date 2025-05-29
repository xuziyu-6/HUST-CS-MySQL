-- 使用名为finance1的数据库  
use finance1;  
  
-- 允许在函数创建者之外的用户创建或修改具有不安全特性的函数  
-- 这通常是因为函数内使用了某些不允许在二进制日志中复制的操作  
set global log_bin_trust_function_creators=1;  
  
-- 如果存在名为get_deposit的函数，则删除它  
drop function IF EXISTS get_deposit;  
  
-- 注意：下面的注释中提到函数名为get_Records，但实际的函数名是get_deposit  
/*  
   用create function语句创建符合以下要求的函数：  
   依据客户编号计算该客户所有储蓄卡的存款总额。  
   函数名为：get_deposit（这里使用了get_deposit，而不是注释中提到的get_Records）。函数的参数名可以自己命名:  
*/  
  
-- 修改默认的语句结束符，以便在函数体内使用多个语句  
delimiter 
$$
  
  
create function get_deposit(client_id int)  
returns numeric(10,2) -- 返回存款总额的数据类型，这里使用了可以存储两位小数的数值类型  
begin  
    -- 声明一个变量来存储存款总额  
    DECLARE total_dep DECIMAL(10,2); -- 使用DECIMAL类型而不是INT，因为需要存储小数  
  
	-- 从bank_card表中查询指定客户编号和类型为"储蓄卡"的存款总额，并将结果赋值给total_dep变量  
    SELECT SUM(b_balance) INTO total_dep   
    FROM bank_card  
    WHERE b_c_id = client_id AND b_type = '储蓄卡'; -- 注意字符串应使用单引号而不是双引号  
  
    -- 返回存款总额  
    RETURN total_dep;  
  
end
$$
  
  
-- 恢复默认的语句结束符  
delimiter ;  
  
/*    
   应用该函数查询存款总额在100万以上的客户身份证号，姓名和存储总额(total_deposit)，  
   结果依存款总额从高到低排序    
*/  
SELECT  c_id_card, c_name, get_deposit(c_id) AS total_deposit    
FROM client  
WHERE get_deposit(c_id) >= 1000000 -- 注意这里100万应表示为1000000，而不是100万（字符串）  
ORDER BY total_deposit DESC;  
  
/*  代码文件结束     */