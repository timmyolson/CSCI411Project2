-- 10) List catalog items that were published in the same state that a user is from and 
--     has retrieved.

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


-- Justification:
-- The address of a user is found by joining the pid of the retrieval of the user
-- with the pid of the addresses lived at. Then the publishing company of that catalog 
-- item retreived is selected. Finally, the if the full address matches (street, city,
-- and state) the row is a match and is reported.