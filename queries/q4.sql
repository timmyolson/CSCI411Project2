-- 4) List the names and full addresses of people who live at the same location as a publishing company, as well as the name of the company located at that address.

SELECT P.pname, L.street, L.city, L.state, C.pcname
FROM Lives_at L, Person P, Located_at A, Publishing_company C
WHERE P.pid = L.pid
AND C.pcid = A.pcid
AND L.street = A.street
AND L.city = A.city
AND L.state = A.state;