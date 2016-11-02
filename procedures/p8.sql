-- 8) Update a user's email address. - Tim

SET SERVEROUTPUT ON
COL pid FORMAT 999
COL pname FORMAT A20
COL uname FORMAT A12
COL email FORMAT A40

SELECT *
FROM Person P
WHERE P.pid = 120 OR
      P.pid = 108 OR
      P.pid = 117 OR
      P.pid = 125;

CREATE OR REPLACE PROCEDURE changeEmail(
  username IN char,
  newEmail IN char
)
AS
BEGIN
UPDATE Person P
SET P.email = newEmail
WHERE P.pid = (SELECT U.pid
               FROM Users U
               WHERE U.uname = username);
END;
/

EXEC changeEmail('jwheeler', '18wheelerLover@gmail.com');
EXEC changeEmail('rharper', 'reeses-pieces@mars.com');
EXEC changeEmail('tshelton', 'eaglesTalon@birdwatcher.mn');
EXEC changeEmail('bpage', 'turningAnotherPage@yahoo.com');

SELECT *
FROM Person P
WHERE P.pid = 120 OR
      P.pid = 108 OR
      P.pid = 117 OR
      P.pid = 125;

-- Output:

-- SQL> @p8.sql
--
--  PID PNAME                EMAIL
-- ---- -------------------- ----------------------------------------
--  108 Reese Harper         magna.Nam@metus.co.uk
--  117 Talon Shelton        molestie.sodales@Proinnonmassa.com
--  120 Jacob Wheeler        quam.a.felis@morbitristiquesenectus.ca
--  125 Barbara Page         erat.Etiam@mollis.edu
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
--  PID PNAME                EMAIL
-- ---- -------------------- ----------------------------------------
--  108 Reese Harper         reeses-pieces@mars.com
--  117 Talon Shelton        eaglesTalon@birdwatcher.mn
--  120 Jacob Wheeler        18wheelerLover@gmail.com
--  125 Barbara Page         turningAnotherPage@yahoo.com
--
-- SQL>
