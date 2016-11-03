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

-- Justification:
-- This procedure finds the catid of Catalog_item's that have expired. Expiration
-- is defined as contract_terms that are less than the Oracle SYSDATE (current date).
-- The procedure then deletes all items that are less than the current date. The
-- procedure is not very complex because of ON DELETE CASCADE, which was added to
-- tables; Journal, Magazine, Book, Conference_proceedings, Reference, Search,
-- Retrieve, Writes, Edits, and Publishes. A single DELETE FROM Catalog_item will
-- remove these entries, thanks to our table design.
