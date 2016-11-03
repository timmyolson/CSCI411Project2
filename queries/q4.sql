-- 4) List the names and full addresses of people who live at the same location as a publishing company, 
--    as well as the name of the company located at that address.

SELECT P.pname as person, L.street, L.city, L.state, C.pcname as "Publish Company"
FROM Lives_at L, Person P, Located_at A, Publishing_company C
WHERE P.pid = L.pid
AND C.pcid = A.pcid
AND L.street = A.street
AND L.city = A.city
AND L.state = A.state;

-- PERSON              STREET                      CITY                     STATE                PUBLISH COMPANY
-- ------------------- --------------------------- ------------------------ -------------------- ----------------------
-- Victoria Holder     243 Lacus. Rd.              Dollard-des-Ormeaux      Quebec               GeoArabia
-- Reese Harper        591-127 Id, Avenue          Dublin                   Pennsylvania         African Zoology
-- Candice Clemons     823-6082 Aliquet Street     M??nster                 Nebraska             Ancient Philosophy
-- Bertha Santos       823-6082 Aliquet Street     M??nster                 Nebraska             Ancient Philosophy


-- Justification:
-- Starting with person, we have to associate each one with their address. Then the same thing
-- is done to find the location of each publishing company. Finally, the full addresses 
-- (street, city and state) are compared and matches are selected.