CREATE TRIGGER finished on 'Договор'
AFTER INSERT,UPDATE
as
begin
IF EXISTS (SELECT * FROM INSERTED
            WHERE INSERTED.'Статус'='Вып')
UPDATE Надбавка
SET Итог=INSERTED.Сумма*0.1 + Итог
WHERE ФИО=(SELECT ФИО FROM Сотрудники
            JOIN Надбавка ON Сотрудники.ФИО=Надбавка.ФИО
            JOIN Договор ON Договор.id_c=Сотрудники.id_c)
SELECT CONCAT('Новое значение надбавки:', Надбавка.Итог)
end