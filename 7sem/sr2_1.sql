CREATE TRIGGER upd_id on 'Readers'
AFTER UPDATE
as
begin
IF EXISTS (SELECT * FROM 'Children'
            JOIN DELETED on 'Children'.id_readers = DELETED.id_readers)
begin
UPDATE 'CHILDREN'
SET id_readers=INSERTED.id_readers
end
ELSE
begin
UPDATE 'CHILDREN'
SET id_readers=INSERTED.id_readers
UPDATE 'PEOPLE'
SET id_readers=INSERTED.id_readers
end

