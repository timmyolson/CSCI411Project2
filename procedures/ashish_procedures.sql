--delete user only ; cannot delete author_p2
create or replace TRIGGER UserDelete
    AFTER DELETE
    ON Users_p2
    FOR EACH ROW
DECLARE
    refs number;
BEGIN
    -- Check if  author is found.
    SELECT count(*) INTO finder
        FROM Person_p2 P, Author_p2 A
        WHERE P.pid = A.pid
        AND P.pid = :OLD.pid;


    IF refs = 0 THEN
        DELETE FROM Person_p2 P
            WHERE P.pid = :OLD.pid;
    END IF;
END;

--display what author wrote --
create or replace PROCEDURE  Author_writes(
    Nam_e IN Person.pname%TYPE
  )
IS
    CURSOR Catalog_cur(
       Full_name Person.pname%TYPE
    )
    IS
        SELECT distinct c.*
            FROM Person P, Author a,  Writes W, catalog_item c
            
            WHERE P.pid = a.pid
            AND a.pid = W.pid
            AND w.catid= c.catid
            
            
            AND P.pname LIKE '%' || Nam_e||'%';
            
    Articlefind catalog_item%ROWTYPE;
BEGIN
    FOR articlefind IN Catalog_cur(Nam_e)
    LOOP
							 --articleid						--article title
        dbms_output.put_line(articlefind.catid || chr(10) );
    END LOOP;
END Author_writes;

--check expiration and display the catid and title... data overflow and repeat
--COL contract_term FORMAT A15
create or replace PROCEDURE EXPIRE_DATE 

AS
title VARCHAR(255);
idd VARCHAR(55);

CURSOR findcatalog IS SELECT c.catid, m.mtitle , j.jtitle , b.btitle, cp.cptitle
     FROM catalog_item_p2 C, book_p2 b, magazine_p2 m, journal_p2 j, conference_proceedings_p2 cp
                    WHERE (C.catid = b.bid or
                          C.catid  = m.mid or
                           C.catid  = cp.cid or
                          C.catid  = j.jid )and
                          c.contract_term<=sysdate+30;
                         -- ADD_MONTHS(C.contract_term) < =( SYSDATE+30);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Searching for expiring contracts:');
  OPEN findcatalog;
  LOOP
    FETCH findcatalog INTO  idd,title,title,title,title;
    IF findcatalog%NOTFOUND THEN
      EXIT;
    END IF;
       DBMS_OUTPUT.PUT_LINE('-   id:    ' || idd);
      DBMS_OUTPUT.PUT_LINE('-   title: ' || title);
     
  END LOOP;
  CLOSE findcatalog;
  DBMS_OUTPUT.PUT_LINE('DOne!');
END;
