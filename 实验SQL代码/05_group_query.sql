-- 任务五：按供应商所在国家进行聚合统计
USE TPCH;

SELECT n.name AS nation_name,
       COUNT(DISTINCT s.suppkey) AS supplier_count,
       COUNT(DISTINCT ps.partkey) AS part_type_count,
       SUM(ps.availqty) AS total_availqty,
       AVG(ps.supplycost) AS avg_supplycost
FROM Nation n
JOIN Supplier s ON s.nationkey = n.nationkey
JOIN PartSupp ps ON ps.suppkey = s.suppkey
GROUP BY n.nationkey, n.name
HAVING SUM(ps.availqty) > 500
ORDER BY total_availqty DESC, n.nationkey;
