-- 2) List the title and type of catalog item that were written and edited by the same person.

COL title format a50

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

-- Title                                              TYPE
-- -------------------------------------------------- -------------------------
-- 10 Studies to Help Shape Your Health               Magazine
-- A Confederacy of Dunces                            Book
-- Animal Farm                                        Book
-- Low-power Depth-based Descending Stair Detection f Journal
-- or Smart Assistive Devices

-- Moby-Dick                                          Book
-- Off-Grid Food Preservation                         Magazine
-- Probabilistic neural networks structure optimizati Conference_proceedings
-- on through genetic algorithms for recognizing face
-- s under illumination variations

-- Serum Biochemistry of Lumpy Skin Disease Virus-Inf Journal
-- ected Cattle

-- The Trial                                          Book


-- Justification
-- The query starts by finding the catalog item that has been written and edited by the 
-- same person. It has to do this for each of the types of catalog item. Then
-- the title and type of that catalog item is passed up the query, where all of the
-- catalog items are then grouped together.
