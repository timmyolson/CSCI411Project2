create or replace TRIGGER UserDelete
    AFTER DELETE
    ON Users
    FOR EACH ROW
DECLARE
    refs number;
BEGIN
    -- Check if  author is found.
    SELECT count(*) INTO refs
        FROM Person P, Author A
        WHERE P.pid = A.pid
        AND P.pid = :OLD.pid;


    IF refs = 0 THEN
        DELETE FROM Person P
            WHERE P.pid = :OLD.pid;
    END IF;
END;

SQL> select pname from person;

PNAME
------------------------------
Graiden Wilkins
Brandon Horton
Drew Lott
Michelle Farley
Reese Harper
Talon Shelton
Donald O. Hamnes
Stephanie Gordon
Jacob Wheeler
Victoria Holder
Aspen Ayala

PNAME
------------------------------
Melissa Hernandez
Bertha Santos
Barbara Page
Iliana Peterson
Conan Johns
Candice Clemons
Patricia Curtis
Neil Knowles
Olga Martinez
Upton Booker
Alyssa Gilmore

PNAME
------------------------------
Logan Oneil
Bryant A. Julstrom
Yolanda Glover
Charity Stevens
Allen Carr
Alexa Thomas
Bobby George

29 rows selected.

SQL> @p10
 20  /

Trigger created.

SQL> delete from users where pid=200;

1 row deleted.

SQL> select pname from person;

PNAME
------------------------------
Graiden Wilkins
Brandon Horton
Drew Lott
Michelle Farley
Reese Harper
Talon Shelton
Donald O. Hamnes
Stephanie Gordon
Jacob Wheeler
Victoria Holder
Aspen Ayala

PNAME
------------------------------
Melissa Hernandez
Bertha Santos
Barbara Page
Iliana Peterson
Conan Johns
Candice Clemons
Patricia Curtis
Neil Knowles
Olga Martinez
Upton Booker
Alyssa Gilmore

PNAME
------------------------------
Logan Oneil
Bryant A. Julstrom
Yolanda Glover
Charity Stevens
Allen Carr
Alexa Thomas

28 rows selected.