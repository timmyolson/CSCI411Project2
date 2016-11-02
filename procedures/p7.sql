-- 7) Remove a catalog item from the database whose contract has expired. - Tim

COL contract_term FORMAT A13

SELECT C.catid, C.contract_term
FROM Catalog_item C
WHERE C.contract_term < (SELECT SYSDATE
                         FROM DUAL);

CREATE OR REPLACE PROCEDURE deletePastTerm
AS
BEGIN
DELETE FROM Catalog_item C
WHERE C.contract_term < (SELECT SYSDATE
                         FROM DUAL);
END;
/

EXEC deletePastTerm();

SELECT C.catid, C.contract_term
FROM Catalog_item C
WHERE C.contract_term < (SELECT SYSDATE
                         FROM DUAL);

-- SQL> @p7
-- 
-- CATID      CONTRACT_TERM
-------- -------------
-- NJEQ6977   25-JAN-05
-- ABIQ2755   03-JUL-12
-- VMGS7843   22-MAY-11
-- ZNMF0012   02-NOV-16
-- 
-- 
-- Procedure created.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- no rows selected
-- 
-- SQL>
