-- 第八周探索题2：在管理员连接中分段执行。
-- 第一部分：创建独立测试表并插入合法记录，执行一次。
CREATE DATABASE IF NOT EXISTS TPCH_Test CHARACTER SET utf8mb4;
USE TPCH_Test;
CREATE TABLE Entity_Integrity_Week08 (
    id INT,
    name VARCHAR(25),
    CONSTRAINT PK_Entity_Integrity_Week08 PRIMARY KEY (id)
) ENGINE = InnoDB;
INSERT INTO Entity_Integrity_Week08 (id, name) VALUES (1, '合法记录');
SELECT * FROM Entity_Integrity_Week08;

-- 第二部分：单独执行，预期主键重复错误。
INSERT INTO Entity_Integrity_Week08 (id, name) VALUES (1, '重复主键');

-- 第三部分：单独执行，预期主键不能为空的错误。
INSERT INTO Entity_Integrity_Week08 (id, name) VALUES (NULL, '空主键');

-- 第四部分：两次失败后验证，应仍只有(1,合法记录)。
SELECT * FROM Entity_Integrity_Week08;
