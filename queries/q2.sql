-- 2) List the title and type of catalog item that were written and edited by the same person.

SELECT B.btitle as "Title", temp.type
FROM Book B,
(
  SELECT C.catid, C.type
  FROM Catalog_item C, Writes W, Edits E
  WHERE W.pid = E.pid
  AND C.catid = W.catid
) temp
WHERE temp.catid = B.bid
UNION
SELECT M.mtitle as "Title", temp.type
FROM Magazine M,
(
  SELECT C.catid, C.type
  FROM Catalog_item C, Writes W, Edits E
  WHERE W.pid = E.pid
  AND C.catid = W.catid
) temp
WHERE temp.catid = M.mid
UNION
SELECT J.jtitle as "Title", temp.type
FROM Journal J,
(
  SELECT C.catid, C.type
  FROM Catalog_item C, Writes W, Edits E
  WHERE W.pid = E.pid
  AND C.catid = W.catid
) temp
WHERE temp.catid = J.jid
UNION
SELECT C.cptitle as "Title", temp.type
FROM Conference_proceedings C,
(
  SELECT C.catid, C.type
  FROM Catalog_item C, Writes W, Edits E
  WHERE W.pid = E.pid
  AND C.catid = W.catid
) temp
WHERE temp.catid = C.cid;