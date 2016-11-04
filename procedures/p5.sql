create or replace PROCEDURE EXPIRE_DATE 

AS

f_title VARCHAR(255);
idd varchar(255);

                    
cursor findbook is select b.btitle,b.bid from book b ,catalog_item C
                    where c.catid =b.bid and contract_term < sysdate+30;
                    
cursor findjournal is select j.jtitle ,j.jid from journal j,catalog_item C
                    where j.jid = c.catid and contract_term < sysdate+30;
                    
cursor findmagazine is select m.mtitle, m.mid  from magazine m,catalog_item C
                    where c.catid = m.mid and contract_term < sysdate+30;
                    
cursor findcp is select cp.cptitle,cp.cid from Conference_proceedings cp,catalog_item C
                    where cp.cid = c.catid and contract_term < sysdate+30;
                
BEGIN
  DBMS_OUTPUT.PUT_LINE('Search  near expiring catalogue inventory');
  DBMS_OUTPUT.PUT_LINE('Searching...');
  OPEN findbook;
  LOOP
      FETCH findbook INTO f_title,idd;
      IF findbook%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('    book:   ' || f_title);
       DBMS_OUTPUT.PUT_LINE(' Catalog id:'||idd);
  END LOOP;
  CLOSE findbook;

  OPEN findjournal;
  LOOP
      FETCH findjournal INTO f_title,idd;
      IF findjournal%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('     Journal:      ' ||f_title);
       DBMS_OUTPUT.PUT_LINE('    Catalog id:   '||idd);
  END LOOP;
  CLOSE findjournal;

  OPEN findmagazine ;
  LOOP
           FETCH findmagazine INTO f_title,idd;
      IF findmagazine%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('    magazine:      ' || f_title);
     DBMS_OUTPUT.PUT_LINE('     Catalog id:    '||idd);
  END LOOP;
  CLOSE findmagazine ;

  OPEN  findcp;
  LOOP
      FETCH  findcp INTO f_title,idd;
      IF  findcp%NOTFOUND THEN
          EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE('    Conference proceeding: ' || f_title);
   DBMS_OUTPUT.PUT_LINE   ('    Catalog id:            '||idd);
  END LOOP;
  CLOSE  findcp;
  DBMS_OUTPUT.PUT_LINE('End of Search!');
END;
/
