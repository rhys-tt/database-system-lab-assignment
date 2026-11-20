-- 第七周探索任务3：审计员角色。分两个连接执行。
-- 第一部分：在root管理员连接中执行一次。
CREATE ROLE 'auditor'@'%';
GRANT SELECT ON tpch.* TO 'auditor'@'%';

CREATE USER 'audit_user'@'localhost' IDENTIFIED BY 'Audit_Lab2026!';
GRANT 'auditor'@'%' TO 'audit_user'@'localhost';
SET DEFAULT ROLE 'auditor'@'%' TO 'audit_user'@'localhost';

SHOW GRANTS FOR 'auditor'@'%';
SHOW GRANTS FOR 'audit_user'@'localhost';

-- 第二部分：新建Navicat连接，以audit_user登录后执行。
SELECT CURRENT_USER() AS login_account, CURRENT_ROLE() AS active_role;
SELECT * FROM tpch.Customer;

UPDATE tpch.Customer SET acctbal = acctbal WHERE custkey = -701;
