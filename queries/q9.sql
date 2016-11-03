-- 9) Give the name and phone number of the publishing company who has published the most 
--    conference proceedings.

SELECT * FROM (
   SELECT PC.pcname, PC.phone
   FROM Publishes P, Conference_proceedings C, Publishing_company PC
   WHERE P.catid = C.cid
   AND PC.pcid = P.pcid
   GROUP BY (PC.pcname, PC.phone)
   ORDER BY COUNT(C.cid) DESC
)
WHERE ROWNUM = 1;

-- PCNAME                                                                           PHONE
-- -------------------------------------------------------------------------------- --------------------
-- IASTED International Conference on Artificial Intelligence and Applications      (557) 247-1698


-- Justification:
-- First, conference proceedings are selected. Then those Publishing Companies who published
-- conference proceedings are selected. These rows are ordered by the number of items 
-- it has published. The top publisher is then reported.