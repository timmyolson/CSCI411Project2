-- 2) View or Retieve for a catalog item. Then update the search|retrieve table. - Micah

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE Retrieve_item (user_id IN char, search_title IN char) AS

item_title varchar2(100);
item_found varchar2(10);
content varchar2(200);
user_found int;
view_num int;
u_id int;
CURSOR m_id IS SELECT M.mtitle, M.mid, M.content
               FROM Magazine M
               WHERE M.mtitle = search_title;

CURSOR j_id IS SELECT J.jtitle, J.jid, J.content
               FROM Journal J
               WHERE J.jtitle = search_title;

CURSOR b_id IS SELECT B.btitle, B.bid, B.content
               FROM Book B
               WHERE B.btitle = search_title;

CURSOR c_id IS SELECT CP.cptitle, CP.cid, CP.content
               FROM Conference_proceedings CP
               WHERE CP.cptitle = search_title;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Search for title: [' || search_title || '] from Catalog Items.');
  DBMS_OUTPUT.PUT_LINE('Searching...');
  OPEN m_id;
  LOOP
      FETCH m_id INTO item_title, item_found, content;
      IF m_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE m_id;

  OPEN j_id;
  LOOP
      FETCH j_id INTO item_title, item_found, content;
      IF j_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE j_id;

  OPEN b_id;
  LOOP
      FETCH b_id INTO item_title, item_found, content;
      IF b_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE b_id;

  OPEN c_id;
  LOOP
      FETCH c_id INTO item_title, item_found, content;
      IF c_id%NOTFOUND THEN
          EXIT;
      END IF;
  END LOOP;
  CLOSE c_id;

  SELECT COUNT(U.uname) INTO user_found FROM Users U WHERE U.uname = user_id;


  IF user_found = 0 THEN
      DBMS_OUTPUT.PUT_LINE(user_id || ' is not a validated User');
      DBMS_OUTPUT.PUT_LINE('Found ' || item_found || '!');
      DBMS_OUTPUT.PUT_LINE('No content will be displayed');

      SELECT vid INTO view_num FROM (SELECT vid FROM Viewer ORDER BY vid DESC) WHERE ROWNUM = 1;
      INSERT INTO Viewer (vid) VALUES (view_num+5);
      INSERT INTO Search (vid,catid) VALUES (view_num+5,item_found);
      COMMIT;
  ELSE
      SELECT U.pid INTO u_id FROM Users U WHERE U.uname = user_id;

      DBMS_OUTPUT.PUT_LINE('User ' || user_id || ' validated');
      DBMS_OUTPUT.PUT_LINE('Found ' || item_found || '!');
      DBMS_OUTPUT.PUT_LINE('Displaying content:');
      DBMS_OUTPUT.PUT_LINE(content);

      INSERT INTO Retrieve (pid,catid,r_date) VALUES (u_id,item_found,to_char(sysdate, 'dd-mon-yyyy'));
      COMMIT;
  END IF;

  DBMS_OUTPUT.PUT_LINE('End of Search!');
END;
/

exec Retrieve_item('dhamnes','The Old Man and the Sea');
exec Retrieve_item('tolson','The Old Lady Who Swallowed a Fly');

-- Search for title: [The Old Man and the Sea] from Catalog Items.
-- Searching...
-- User dhamnes validated
-- Found SQXZ1306!
-- Displaying content:
-- The content of book: The Old Man...
-- End of Search!

-- PL/SQL procedure successfully completed.

-- Search for title: [The Old Lady Who Swallowed a Fly] from Catalog Items.
-- Searching...
-- tolson is not a validated User
-- Found IBNV2946!
-- No content will be displayed
-- End of Search!

-- PL/SQL procedure successfully completed.
