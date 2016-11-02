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

--display what author wrote --doesnnt work, says procedure created while running nothing happens
create or replace PROCEDURE  Author_writes(
    Nam_e IN Person_p2.pname%TYPE
  )
IS
    CURSOR Catalog_item(
       Full_name Person_p2.pname%TYPE
    )
    IS
        SELECT c.*
            FROM Person_p2 P, Author_p2 a,  Writes_p2 W, catalog_item_p2 c
            
            WHERE P.pid = a.pid
            AND a.pid = W.pid
            AND w.catid= c.catid
            
            
            AND P.pname LIKE '%' || Nam_e||'%';
            
    Articlefind catalog_item_p2%ROWTYPE;
BEGIN
    FOR articlefind IN Catalog_item(Nam_e)
    LOOP
							 --articleid						--article title
        dbms_output.put_line(articlefind.catid|| chr(10) );
    END LOOP;


END Author_writes;

--2nd version which freezes up in cursor
create or replace PROCEDURE  Author_writes(x in varchar2) as catalog_item_p2 char(10);

cursor cur is
select distinct p.pname
from person_p2 p, book_p2 b,author_p2 a,journal_p2 j, magazine_p2 m, conference_proceedings_p2 cp,  catalog_item_p2 c , writes_p2 w

                where p.pname = X and
                p.pid= a.pid and
                a.pid=w.pid and
                w.catid =c.catid or
                j.jid=c.catid or
                 m.mid=c.catid or
                 b.bid=c.catid or
                cp.cid=c.catid   ;
   BEGIN
  open cur;
    dbms_output.put_line(X||' has written ');
        LOOP
            fetch cur into catalog_item_p2;
            IF cur%NOTFOUND
            THEN EXIT;
            END IF;
       dbms_output.put_line(catalog_item_p2);
       END LOOP;
  CLOSE cur;
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
