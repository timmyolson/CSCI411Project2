-- 6) Allow an author to submit work. - Tim

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE addWork(
  author_pid IN NUMBER,
  editor_pid IN NUMBER,
  ref_catid  IN CHAR,
  pub_pcid   IN NUMBER,
  new_catid  IN CHAR,
  pub_type   IN CHAR,
  new_title  IN CHAR,
  new_cont   IN CHAR,
  new_vol    IN CHAR
)
AS
author_flag INT;
editor_flag INT;
catid_flag  INT;
ref_flag    INT;
pub_flag    INT;
BEGIN
  SELECT COUNT(A.pid)    INTO author_flag FROM Author A WHERE A.pid = author_pid;
  SELECT COUNT(E.pid)    INTO editor_flag FROM Editor E WHERE E.pid = editor_pid;
  SELECT COUNT(C.catid)  INTO ref_flag    FROM Catalog_item C WHERE C.catid = ref_catid;
  SELECT COUNT(Pub.pcid) INTO pub_flag    FROM Publishing_Company Pub WHERE Pub.pcid = pub_pcid;
  SELECT COUNT(C.catid)  INTO catid_flag  FROM Catalog_item C WHERE C.catid = new_catid;

  IF (author_flag = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Author: ' || author_pid || ' cannot continue!');
    RETURN;
  END IF;

  IF (editor_flag = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Editor: ' || editor_pid || ' cannot continue!');
    RETURN;
  END IF;

  IF (catid_flag = 1) THEN
    DBMS_OUTPUT.PUT_LINE('New Catalog ID already exists: ' || new_catid || ' cannot continue!');
    RETURN;
  END IF;

  IF (ref_flag = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Referenceing Catalog ID: ' || ref_catid || ' cannot continue!');
    RETURN;
  END IF;

  IF (pub_flag = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Publishing Company: ' || pub_pcid || ' cannot continue!');
    RETURN;
  END IF;

  INSERT INTO Catalog_item (catid,contract_term,type) VALUES (new_catid,SYSDATE+36500,pub_type);
  INSERT INTO Writes (catid,pid) VALUES (new_catid,author_pid);
  INSERT INTO Edits  (catid,pid) VALUES (new_catid,editor_pid);
  INSERT INTO Publishes (catid,pcid,publish_date) VALUES (new_catid,pub_pcid,SYSDATE);
  INSERT INTO Reference (catid,cite_id) VALUES (new_catid,ref_catid);
  --
  IF (pub_type = 'Conference_proceedings') THEN
    INSERT INTO Conference_proceedings VALUES (new_catid,new_title,new_cont);
  END IF;
  IF (pub_type = 'Book') THEN
    INSERT INTO Book VALUES (new_catid,new_title,new_vol,new_cont);
  END IF;
  IF (pub_type = 'Magazine') THEN
    INSERT INTO Magazine VALUES (new_catid,new_title,new_vol,new_cont);
  END IF;
  IF (pub_type = 'Journal') THEN
    INSERT INTO Journal VALUES (new_catid,new_title,new_vol,new_cont);
  END IF;

  DBMS_OUTPUT.PUT_LINE('The ' || pub_type || ' has been added to the Database!');
  DBMS_OUTPUT.PUT_LINE('-    CATID:   ' || new_catid);
  DBMS_OUTPUT.PUT_LINE('-    Author:  ' || author_pid);
  DBMS_OUTPUT.PUT_LINE('-    Title:   ' || new_title);
  DBMS_OUTPUT.PUT_LINE('-    Content: ' || new_title);
  DBMS_OUTPUT.PUT_LINE('-    Edition: ' || new_vol);
  DBMS_OUTPUT.PUT_LINE('-    Editor:  ' || editor_pid);
  DBMS_OUTPUT.PUT_LINE('-    Ref:     ' || ref_catid);

END;
/

EXEC  addWork(118, 108, 'BKGN1857', 45671, 'ILBA3245', 'Book', 'The Hobbit', 'In a hole in the ground there lived a hobbit', 1);
EXEC  addWork(118, 345, 'BKGN1857', 45671, 'ILBA3245', 'Book', 'The Hobbit', 'In a hole in the ground there lived a hobbit', 1);
EXEC  addWork(118, 107, 'BKGN1857', 45671, 'ILBA3245', 'Book', 'The Hobbit', 'In a hole in the ground there lived a hobbit', 1);

-- SQL> @p6
--
-- Procedure created.
--
-- The Book has been added to the Database!
-- -    CATID:   ILBA3245
-- -    Author:  118
-- -    Title:   The Hobbit
-- -    Content: The Hobbit
-- -    Edition: 1
-- -    Editor:  108
-- -    Ref:     BKGN1857
--
-- PL/SQL procedure successfully completed.
--
-- Invalid Editor: 345 cannot continue!
--
-- PL/SQL procedure successfully completed.
--
-- New Catalog ID already exists: ILBA3245 cannot continue!
--
-- PL/SQL procedure successfully completed.
--
-- SQL>

-- SELECT DISTINCT C.catid, B.btitle
-- FROM Author A, Editor E, Catalog_item C,
--      Publishing_Company Pub, Reference R, Book B
-- WHERE A.pid     = 118 AND
--       E.pid     = 108 AND
--       R.cite_id = 'BKGN1857' AND
--       C.catid   = 'ILBA3245' AND
--       B.btitle  = 'The Hobbit';

-- CATID      BTITLE
-- ---------- ----------------------------------------
-- ILBA3245   The Hobbit

-- Justification:
-- To add entries to the database we have to do some verification. It is important
-- to verify the author, editors, reference, and publishing companies. We must also
-- make sure that the new catalog ID does not exist. To efficiently error check input
-- parameters we select a COUNT of the instances, this results in a boolean value.
-- After we do error checking for this all of the values are then added to the Database.
