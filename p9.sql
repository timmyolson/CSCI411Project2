-- 9) Update a user's subscription status (the user extends this period). - Tim

SELECT U.uname, S.begin_date, S.slen
FROM Users U, Subscription S, Creates C
WHERE U.pid = C.pid AND
      S.sid = C.sid;

CREATE OR REPLACE PROCEDURE updateSubsciption(
  username IN char,
  months   IN number
)
AS
BEGIN
UPDATE Subscription S
SET S.begin_date = ADD_MONTHS(S.begin_date, S.slen),
    S.slen = months
WHERE S.sid = (SELECT C.sid
               FROM Creates C, Users U
               WHERE U.pid = C.pid AND
                     U.uname = username);
END;
/

EXEC updateSubsciption('tshelton', 6);
EXEC updateSubsciption('omartinez', 6);
EXEC updateSubsciption('gwilkins', 12);
EXEC updateSubsciption('vholder', 9);
EXEC updateSubsciption('bsantos', 1);
EXEC updateSubsciption('tshelton', 6);

SELECT U.uname, S.begin_date, S.slen
FROM Users U, Subscription S, Creates C
WHERE U.pid = C.pid AND
      S.sid = C.sid;

-- Output:
-- SQL> @p9
-- 
-- UNAME        BEGIN_DATE      SLEN
-- ------------ --------------- ----
-- gwilkins     19-NOV-19         12
-- rharper      19-APR-19         23
-- tshelton     23-SEP-23         12
-- dhamnes      10-JUN-10          3
-- jwheeler     24-MAY-24          2
-- vholder      21-JAN-21          8
-- bsantos      05-JAN-05         18
-- bpage        07-SEP-07         12
-- ipeterson    31-AUG-31          8
-- omartinez    27-OCT-27         12
-- 
-- 10 rows selected.
-- 
-- 
-- Procedure created.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- PL/SQL procedure successfully completed.
-- 
-- 
-- UNAME        BEGIN_DATE      SLEN
-- ------------ --------------- ----
-- gwilkins     19-NOV-20         12
-- rharper      19-APR-19         23
-- tshelton     23-MAR-25          6
-- dhamnes      10-JUN-10          3
-- jwheeler     24-MAY-24          2
-- vholder      21-SEP-21          9
-- bsantos      05-JUL-06          1
-- bpage        07-SEP-07         12
-- ipeterson    31-AUG-31          8
-- omartinez    27-OCT-28          6
-- 
-- 10 rows selected.
-- 
-- SQL>
