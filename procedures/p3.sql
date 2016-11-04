-- 3) Display an article written by an author. - Ashish

create or replace PROCEDURE  Author_writes(author_name in char)as

title varchar2(255);
cat_id varchar2(255);

cursor bfind is select b.btitle, b.bid
                FROM Person P, Writes W, book b
                WHERE P.pname = author_name
                AND P.pid = W.pid                
                AND W.catid = b.bid;
 
cursor jfind is select j.jtitle, j.jid 
                From Person P, Writes W, Journal j
                WHERE P.pname = author_name
                AND P.pid = W.pid          
                AND W.catid = j.jid;  
                   
 
cursor mfind is select m.mtitle, m.mid 
                From Person P, Writes W, magazine m
                WHERE P.pname = author_name
                AND P.pid = W.pid          
                AND W.catid = m.mid;  

cursor cpfind is select cp.cptitle, cp.cid 
                 From Person P, Writes W, Conference_proceedings cp
                 WHERE P.pname = author_name
                 AND P.pid = W.pid
                 AND W.catid = cp.cid;  
                   
BEGIN
  DBMS_OUTPUT.PUT_LINE('Search for author: [' || author_name || ']  in Database ');
  DBMS_OUTPUT.PUT_LINE('Searching...');
 
  OPEN bfind;
  LOOP
      FETCH bfind INTO title, cat_id;
      IF bfind%NOTFOUND THEN
          EXIT;
      END IF;
      dbms_output.put_line(' book Title:   '||title||' book ID:   '||cat_id  );
  END LOOP;
  CLOSE bfind;
  
  OPEN jfind;
  LOOP
      FETCH jfind INTO title, cat_id;
      IF  jfind%NOTFOUND THEN
          EXIT;
      END IF;
       dbms_output.put_line(' journal Title:   '||title||' journal ID:   '||cat_id  );
  END LOOP;
  CLOSE jfind;

  OPEN mfind;
  LOOP
      FETCH mfind INTO title, cat_id;
      IF  mfind%NOTFOUND THEN
          EXIT;
      END IF;
           dbms_output.put_line(' magazine Title:   '||title||' journal ID:   '||cat_id  );
  END LOOP;
  CLOSE mfind;
  
    OPEN cpfind;
  LOOP
      FETCH cpfind INTO title, cat_id;
      IF  cpfind%NOTFOUND THEN
          EXIT;
      END IF;
       dbms_output.put_line(' conference proceeding Title:   '||title||' conference proceeding ID:  '||cat_id  );
  END LOOP;
  CLOSE cpfind;

  DBMS_OUTPUT.PUT_LINE('End of Search!');
END;
/

exec Author_writes('Alexa Thomas');
exec Author_writes('Aspen Ayala');

-- Search for author: [Alexa Thomas]  in Database
-- Searching...
-- book Title:   The Old Lady Who Swallowed a Fly book ID:   IBNV2946
-- book Title:   Wuthering Heights book ID:   NJEQ6977
-- book Title:   The Trial book ID:   HZLE2432
-- magazine Title:   How is Bitcoin money journal ID:   HPNL1208
-- magazine Title:   Can you change how you feel about money? journal ID:
-- YQHH6457
-- End of Search!

-- PL/SQL procedure successfully completed.

-- Search for author: [Aspen Ayala]  in Database
-- Searching...
-- journal Title:   Potential of Native Organic Feeding Stuffs in Poultry
-- Production journal ID:   YZAQ6317
-- journal Title:   Remarque en toy telle marque journal ID:   ERRZ8161
-- End of Search!

-- PL/SQL procedure successfully completed.