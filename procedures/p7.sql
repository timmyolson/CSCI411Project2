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
