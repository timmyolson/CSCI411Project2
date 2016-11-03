--this procedure will only catalogue id
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



---- this will give book id and book title .. coudn't implement for journal , magazines and other
create or replace PROCEDURE  Author_writes(
    Nam_e IN Person.pname%TYPE
  )
as
    CURSOR book_cur(
       Full_name Person.pname%TYPE
    )
    IS
        SELECT distinct b.*
            FROM Person P, Author a,  Writes W, catalog_item c, book b, journal j, magazine m, CONFERENCE_PROCEEDINGS cp
            
            WHERE P.pid = a.pid             AND a.pid = W.pid          
            AND (w.catid= b.bid    or   w.catid= j.jid or w.catid=cp.cid or w.catid= m.mid) 
            
            AND P.pname LIKE '%' || Nam_e||'%';
            
   bookfind book%ROWTYPE;

    
BEGIN
    FOR bookfind IN book_cur(Nam_e)
    LOOP
							 --articleid						--article title
        dbms_output.put_line(' book Title:   '||bookfind.btitle|| chr(10)||' book ID:   '||bookfind.bid || chr(10) );
         --  dbms_output.put_line( );
    END LOOP;
    
