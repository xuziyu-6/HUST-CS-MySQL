use finance1;  
  
-- 如果存在名为before_property_inserted的触发器，则删除它  
drop trigger if exists before_property_inserted;  
  
-- 设置定界符为
$$
，以便在触发器定义中能够使用分号  
delimiter 
$$
  
  
-- 创建一个触发器before_property_inserted，在property表插入新记录之前触发  
CREATE TRIGGER before_property_inserted BEFORE INSERT ON property  
FOR EACH ROW   
BEGIN  
    -- 检查新插入记录的pro_type字段是否在允许的范围内（1, 2, 3）  
    IF (NEW.pro_type NOT IN (1,2,3)) THEN  
        -- 如果不在允许的范围内，设置错误消息并抛出异常  
        SET @msg = CONCAT('type ', NEW.pro_type, ' is illegal!');  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;  
    END IF;  
  
    -- 如果pro_type为1，则检查finances_product表中是否存在对应的记录  
    IF (NEW.pro_type = 1) THEN  
        -- 使用子查询检查finances_product表中是否存在p_id等于NEW.pro_pif_id的记录  
        IF (SELECT COUNT(*) FROM finances_product WHERE p_id = NEW.pro_pif_id) = 0 THEN  
            -- 如果不存在，设置错误消息并抛出异常  
            SET @msg = CONCAT('finances product #', NEW.pro_pif_id, ' not found!');  
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;  
        END IF;  
    END IF;  
  
    -- 如果pro_type为2，则检查insurance表中是否存在对应的记录  
    IF (NEW.pro_type = 2) THEN  
        -- 使用子查询检查insurance表中是否存在i_id等于NEW.pro_pif_id的记录  
        IF (SELECT COUNT(*) FROM insurance WHERE i_id = NEW.pro_pif_id) = 0 THEN  
            -- 如果不存在，设置错误消息并抛出异常  
            SET @msg = CONCAT('insurance #', NEW.pro_pif_id, ' not found!');  
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;  
        END IF;  
    END IF;  
  
    -- 如果pro_type为3，则检查fund表中是否存在对应的记录  
    IF (NEW.pro_type = 3) THEN  
        -- 使用子查询检查fund表中是否存在f_id等于NEW.pro_pif_id的记录  
        IF (SELECT COUNT(*) FROM fund WHERE f_id = NEW.pro_pif_id) = 0 THEN  
            -- 如果不存在，设置错误消息并抛出异常  
            SET @msg = CONCAT('fund #', NEW.pro_pif_id, ' not found!');  
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;  
        END IF;  
    END IF;  
  
END
$$
  
  
-- 恢复默认的定界符为分号  
delimiter ;