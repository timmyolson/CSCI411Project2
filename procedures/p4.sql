-- 4) Search catalog items - Tim

SET SERVEROUTPUT ON
COL mid FORMAT A8
COL mtitle FORMAT A50
COL jvol FORMAT 99
COL content FORMAT A65

CREATE OR REPLACE PROCEDURE searchCatalog(
  searchTerm IN char
)
AS
id varchar2(10);
CURSOR id_mag IS SELECT M.mid
                 FROM Magazine M
                 WHERE M.mtitle LIKE '%' || searchTerm ||'%';

CURSOR id_jor IS SELECT J.jid
                 FROM Journal J
                 WHERE J.jtitle LIKE '%' || searchTerm ||'%';

CURSOR id_bok IS SELECT B.bid
                 FROM Book B
                 WHERE B.btitle LIKE '%' || searchTerm ||'%';

CURSOR id_con IS SELECT CP.cid
                 FROM Conference_proceedings CP
                 WHERE CP.cptitle LIKE '%' || searchTerm ||'%';
BEGIN
  DBMS_OUTPUT.PUT_LINE('Search term: [' || searchTerm || '] running against Catalog Items.');
  DBMS_OUTPUT.PUT_LINE('Searching...');
  OPEN id_mag;
  LOOP
      FETCH id_mag INTO id;
      IF id_mag%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('-    Magazine:  ' || id);
  END LOOP;
  CLOSE id_mag;

  OPEN id_jor;
  LOOP
      FETCH id_jor INTO id;
      IF id_jor%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('-    Journal:   ' || id);
  END LOOP;
  CLOSE id_jor;

  OPEN id_bok;
  LOOP
      FETCH id_bok INTO id;
      IF id_bok%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('-    Book:      ' || id);
  END LOOP;
  CLOSE id_bok;

  OPEN id_con;
  LOOP
      FETCH id_con INTO id;
      IF id_con%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('-    Conference: ' || id);
  END LOOP;
  CLOSE id_con;
  DBMS_OUTPUT.PUT_LINE('End of Search!');
END;
/

EXEC searchCatalog('Canada');
EXEC searchCatalog('Bitcoin');
EXEC searchCatalog('The Trial');
EXEC searchCatalog('software');
EXEC searchCatalog('of');

-- Output:
-- SQL> @p4.sql
--
-- Procedure created.
--
-- Search term: [Canada] running against Catalog Items.
-- Searching...
-- -    Magazine:  RYMF2195
-- End of Search!
--
-- PL/SQL procedure successfully completed.
--
-- Search term: [Bitcoin] running against Catalog Items.
-- Searching...
-- -    Magazine:  HPNL1208
-- End of Search!
--
-- PL/SQL procedure successfully completed.
--
-- Search term: [The Trial] running against Catalog Items.
-- Searching...
-- -    Book:      HZLE2432
-- End of Search!
--
-- PL/SQL procedure successfully completed.
--
-- Search term: [software] running against Catalog Items.
-- Searching...
-- -    Conference: ITCL7144
-- End of Search!
--
-- PL/SQL procedure successfully completed.
--
-- Search term: [of] running against Catalog Items.
-- Searching...
-- -    Journal:   YZAQ6317
-- -    Journal:   ZNMF0012
-- -    Journal:   NSYD3340
-- -    Journal:   NPPH3852
-- -    Book:      QEDL4413
-- -    Conference: IXNJ8371
-- -    Conference: ITCL7144
-- End of Search!
--
-- PL/SQL procedure successfully completed.
--
-- SQL>
