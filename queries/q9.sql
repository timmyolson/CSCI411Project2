-- 9) Give the name and phone number of the publishing company who has published the most conference proceedings.

SELECT * FROM (
   SELECT PC.pcname, PC.phone
   FROM Publishes P, Conference_proceedings C, Publishing_company PC
   WHERE P.catid = C.cid
   AND PC.pcid = P.pcid
   GROUP BY (PC.pcname, PC.phone)
   ORDER BY COUNT(C.cid) DESC
)
WHERE ROWNUM = 1;