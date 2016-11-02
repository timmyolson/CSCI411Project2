-- 6) Give the number of items written, edited, total and the names of the three persons who have contributed the highest number of catalog items.

SELECT * FROM (
   SELECT temp.pname as Name, temp.Edits as Edits, COUNT(wp.catid) as Written, (temp.Edits + COUNT(wp.catid)) as Total
   FROM (
      SELECT ep.pname, ep.pid, COUNT(E.catid) as Edits
      FROM Person ep
        LEFT OUTER JOIN Edits E ON E.pid = ep.pid
      GROUP BY (ep.pname, ep.pid)
        ) temp
   LEFT OUTER JOIN Writes wp ON temp.pid = wp.pid
   GROUP BY (temp.pname, temp.Edits)
   ORDER BY (temp.Edits + COUNT(wp.catid)) DESC
)
WHERE ROWNUM <= 3;