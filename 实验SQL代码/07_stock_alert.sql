USE TPCH;

-- 第一部分：创建日志表和触发器，整体执行一次。
CREATE TABLE StockAlert_Log (
    alert_id INT AUTO_INCREMENT,
    partkey INT,
    suppkey INT,
    alert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_StockAlert_Log PRIMARY KEY (alert_id)
) ENGINE = InnoDB;

DELIMITER $$
CREATE TRIGGER trg_partsupp_lowstock
AFTER UPDATE ON PartSupp
FOR EACH ROW
BEGIN
    IF NEW.availqty < 10 AND OLD.availqty >= 10 THEN
        INSERT INTO StockAlert_Log (partkey, suppkey)
        VALUES (NEW.partkey, NEW.suppkey);
    END IF;
END$$
DELIMITER ;

-- 第二部分：测试前检查。两条库存应分别为50、15；日志应为空。
SELECT partkey, suppkey, availqty
FROM PartSupp
WHERE (partkey = 4 AND suppkey = 4)
   OR (partkey = 5 AND suppkey = 5)
ORDER BY partkey;
SELECT * FROM StockAlert_Log ORDER BY alert_id;



-- 第四部分：测试2。单独执行本组并截图，日志仍应只有原先一条。
UPDATE PartSupp
SET availqty = 12
WHERE partkey = 5 AND suppkey = 5;

SELECT partkey, suppkey, availqty
FROM PartSupp WHERE partkey = 5 AND suppkey = 5;
SELECT * FROM StockAlert_Log ORDER BY alert_id;
