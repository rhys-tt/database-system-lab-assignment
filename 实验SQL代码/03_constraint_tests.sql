-- 任务三：故意触发约束冲突
USE TPCH;

-- 测试1：主键冲突。Region 中已存在 regionkey = 1。
INSERT INTO Region (regionkey, name, comment)
VALUES (1, 'DUPLICATE', '主键冲突测试');

-- 测试2：插入时外键冲突。Region 中不存在 regionkey = 999。
INSERT INTO Nation (nationkey, name, regionkey, comment)
VALUES (901, 'INVALID_NATION', 999, '引用不存在的地区');

-- 测试3准备：先一起执行这两条 INSERT，预期成功。
INSERT INTO Region (regionkey, name, comment)
VALUES (900, 'TEST_REGION', '外键删除测试地区');
INSERT INTO Nation (nationkey, name, regionkey, comment)
VALUES (900, 'TEST_NATION', 900, '外键删除测试国家');

-- 测试3：单独执行此 DELETE，预期被外键约束拒绝。
DELETE FROM Region WHERE regionkey = 900;

-- 测试3补充验证：报错后执行，预期关联记录仍然存在。
SELECT r.regionkey, r.name AS region_name,
       n.nationkey, n.name AS nation_name
FROM Region r
JOIN Nation n ON n.regionkey = r.regionkey
WHERE r.regionkey = 900;

-- 测试4：价格检查约束冲突。新主键900不与已有零件重复。
INSERT INTO Part (partkey, name, retailprice, comment)
VALUES (900, '测试零件', 0.00, '价格为零，应拒绝');

-- 测试5：库存检查约束冲突。
-- 零件1、供应商3都存在，且(1,3)组合尚不存在，避免其他约束干扰。
INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost, comment)
VALUES (1, 3, -1, 6.00, '负库存，应拒绝');

-- 收尾：完成全部报错截图后再执行，先删测试国家，再删测试地区。
DELETE FROM Nation WHERE nationkey = 900 AND regionkey = 900;
DELETE FROM Region WHERE regionkey = 900;

-- 清理验证：预期Region=5、Nation=5、Part=5、PartSupp=8。
SELECT 'Region' AS table_name, COUNT(*) AS row_count FROM Region
UNION ALL SELECT 'Nation', COUNT(*) FROM Nation
UNION ALL SELECT 'Part', COUNT(*) FROM Part
UNION ALL SELECT 'PartSupp', COUNT(*) FROM PartSupp;
