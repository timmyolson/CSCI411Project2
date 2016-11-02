-- 8) Give the title of the catalog item as well as the author, of the item that has been retrieved the most.

COL title format a50

SELECT B.btitle as "Title", temp.num as "Times Retrieved"
FROM Book B,
(
  SELECT * FROM (
    SELECT R.catid, COUNT(R.catid) as num
    FROM Retrieve R
    GROUP BY R.catid
    ORDER BY COUNT(R.catid) DESC
  )
  WHERE ROWNUM = 1
) temp
WHERE temp.catid = B.bid
UNION
SELECT M.mtitle as "Title", temp.num as "Times Retrieved"
FROM Magazine M,
(
  SELECT * FROM (
    SELECT R.catid, COUNT(R.catid) as num
    FROM Retrieve R
    GROUP BY R.catid
    ORDER BY COUNT(R.catid) DESC
  )
  WHERE ROWNUM = 1
) temp
WHERE temp.catid = M.mid
UNION
SELECT J.jtitle as "Title", temp.num as "Times Retrieved"
FROM Journal J,
(
  SELECT * FROM (
    SELECT R.catid, COUNT(R.catid) as num
    FROM Retrieve R
    GROUP BY R.catid
    ORDER BY COUNT(R.catid) DESC
  )
  WHERE ROWNUM = 1
) temp
WHERE temp.catid = J.jid
UNION
SELECT C.cptitle as "Title", temp.num as "Times Retrieved"
FROM Conference_proceedings C,
(
  SELECT * FROM (
    SELECT R.catid, COUNT(R.catid) as num
    FROM Retrieve R
    GROUP BY R.catid
    ORDER BY COUNT(R.catid) DESC
  )
  WHERE ROWNUM = 1
) temp
WHERE temp.catid = C.cid;


-- Title                                              Times Retrieved
-- -------------------------------------------------- ---------------
-- Iterated mutation in an evolutionary algorithm for               6
--  Sudoku
