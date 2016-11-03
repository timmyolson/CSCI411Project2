-- 2) View or Retieve for a catalog item. Then update the search|retrieve table. - Micah

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE r (user_id IN char, search_title IN char) AS

item_found varchar2(10);
content varchar2(100);
user_found int;
CURSOR m_id IS SELECT M.mid, M.content
               FROM Magazine M
               WHERE M.mtitle = search_title;

CURSOR j_id IS SELECT J.jid, J.content
               FROM Journal J
               WHERE J.jtitle = search_title;

CURSOR b_id IS SELECT B.bid, B.content
               FROM Book B
               WHERE B.btitle = search_title;

CURSOR c_id IS SELECT CP.cid, CP.content
               FROM Conference_proceedings CP
               WHERE CP.cptitle = search_title;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Search for title: [' || search_title || '] from Catalog Items.');
  DBMS_OUTPUT.PUT_LINE('Searching...');
  OPEN m_id;
  LOOP
      FETCH m_id INTO item_found, content;
      IF m_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE m_id;

  OPEN j_id;
  LOOP
      FETCH j_id INTO item_found, content;
      IF j_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE j_id;

  OPEN b_id;
  LOOP
      FETCH b_id INTO item_found, content;
      IF b_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE b_id;

  OPEN c_id;
  LOOP
      FETCH c_id INTO item_found, content;
      IF c_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE c_id;

  SELECT COUNT(U.uname) INTO user_found FROM Users U WHERE U.uname = user_id;

  IF user_found = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Viewer');
  ELSE
      DBMS_OUTPUT.PUT_LINE('User');
  END IF;


  -- OPEN u_id;
  -- LOOP
  --     IF u_id%NOTFOUND THEN
  --         EXIT;
  --     END IF;
  --     DBMS_OUTPUT.PUT_LINE('Found ' || search_title || '!');
  --     DBMS_OUTPUT.PUT_LINE('Displaying content:');
  --     DBMS_OUTPUT.PUT_LINE(item_content);
  -- END LOOP;
  -- CLOSE u_id;
  DBMS_OUTPUT.PUT_LINE('End of Search!');
END;
/
