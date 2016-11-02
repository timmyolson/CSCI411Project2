-- 10) List catalog items that were published in the same state that a user is from and has retrieved.

SELECT R.catid, A.street, A.city, A.state
FROM Located_at A, Publishes P, Retrieve R, Lives_at L
WHERE R.pid = L.pid
AND R.catid = P.catid
AND A.pcid = P.pcid
AND A.street = L.street
AND A.city = L.city
AND A.state = L.state;

-- CATID      STREET                      CITY            STATE
-- ---------- --------------------------- --------------- --------------------
-- YZAQ6317   591-127 Id, Avenue          Dublin          Pennsylvania
