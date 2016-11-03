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
