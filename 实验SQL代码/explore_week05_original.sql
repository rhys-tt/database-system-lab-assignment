-- 第五周探索任务
USE tpch;

-- 3.4 探索1：预期外键错误
INSERT INTO Nation(nationkey,name,regionkey,comment)
VALUES(99,'虚构国家',999,'测试外键');

-- 3.4 探索2：华为供应的零件库存减少50
UPDATE PartSupp
SET availqty = availqty - 50
WHERE suppkey = (
    SELECT suppkey FROM Supplier WHERE name = '华为'
);
SELECT PS.partkey,PS.suppkey,PS.availqty,S.name
FROM PartSupp PS JOIN Supplier S ON PS.suppkey=S.suppkey
WHERE S.name='华为';

-- 3.5 探索1：亚洲顾客视图
CREATE VIEW V_Asia_Customer AS
SELECT C.*
FROM Customer C
JOIN Nation N ON C.nationkey = N.nationkey
JOIN Region R ON N.regionkey = R.regionkey
WHERE R.name = 'ASIA';
SELECT * FROM V_Asia_Customer;

-- 3.6 探索1及删除索引
CREATE UNIQUE INDEX idx_part_name_unique ON Part(name);
SELECT partkey,name FROM Part LIMIT 1;
INSERT INTO Part(partkey,name,mfgr,brand,type,size,retailprice,container,comment)
VALUES(9001,'外壳C','测试厂商','TEST','typeA',10,100.00,'袋','重复名字测试');
DROP INDEX idx_part_name_unique ON Part;
