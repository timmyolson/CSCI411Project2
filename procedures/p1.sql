-- 1) Find the username, email, and name of user's whose subscription has expired.

SET SERVEROUTPUT ON
COL sid FORMAT A15
COL slen FORMAT 999
COL begin_date FORMAT A15
COL fee FORMAT A10

CREATE OR REPLACE PROCEDURE emailExpiredUsers
AS
name VARCHAR(30);
username VARCHAR(30);
contact VARCHAR(50);

CURSOR findUsers IS SELECT P.pname, U.uname, P.email
                    FROM Creates C, Person P, Users U, Subscription S
                    WHERE C.pid = P.pid AND
                          U.pid = P.pid AND
                          C.sid = S.sid AND
                          ADD_MONTHS(S.begin_date, S.slen) < (SELECT SYSDATE
                                                              FROM DUAL);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Searching for users to contact about updating Subscriptions:');
  OPEN findUsers;
  LOOP
    FETCH findUsers INTO name, username, contact;
    IF findUsers%NOTFOUND THEN
      EXIT;
    END IF;
      DBMS_OUTPUT.PUT_LINE('Contact [' || name || '] details:');
      DBMS_OUTPUT.PUT_LINE('-   username: ' || username);
      DBMS_OUTPUT.PUT_LINE('-   email:    ' || contact);
  END LOOP;
  CLOSE findUsers;
  DBMS_OUTPUT.PUT_LINE('End of oudated Subscriptions!');
END;
/

EXEC emailExpiredUsers();

-- Verify ADD_MONTHS works as expected.
-- SELECT ADD_MONTHS(S.begin_date, S.slen), S.begin_date, S.slen
-- FROM Subscription S;

-- Output:
-- SQL> @p1
--
-- Procedure created.
--
-- Searching for users to contact about updating Subscriptions:
-- Contact [Donald O. Hamnes] details:
-- -   username: dhamnes
-- -   email:    dohamnes@stcloudstate.edu
-- Contact [Bertha Santos] details:
-- -   username: bsantos
-- -   email:    porta.elit@blanditat.org
-- Contact [Barbara Page] details:
-- -   username: bpage
-- -   email:    erat.Etiam@mollis.edu
-- End of oudated Subscriptions!
--
-- PL/SQL procedure successfully completed.
--
-- SQL>

-- Justification:
-- To contact users about extending their subscriptions we need to have an email address,
-- a name; to personalize the email, and a username; to remind the user of their credentials.
-- Users to contact are users which have expired subscriptions. These are found with Oracle's
-- ADD_MONTHS function which determines the subscription end date by adding the subscription
-- duration to the subscription start date. We fetch all tuples where the the end date is
-- less than the current system date (Oracle SYSDATE).
