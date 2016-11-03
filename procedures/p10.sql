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
