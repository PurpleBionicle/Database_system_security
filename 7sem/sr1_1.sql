Create proc Stud_Rasp
@FIO varchar(25) = NULL
@group varchar(6) = NULL
as
IF @FIO is NULL OR @group is NULL
begin
  Print N'Введите данные'
  Return
end
IF Not Exists(SELECT ФИО FROM Студенты Where ФИО=@FIO) OR
 Not Exists(SELECT №_группы FROM Распределние Where №_группы=@group)
begin
  Print N'Введите корректные данные'
  Return
end

-- Проверяем, не превышает ли новая группа 25 студентов
IF (SELECT COUNT(*) FROM Распределние Where №_группы=@group) < 25 THEN
  -- Обновляем номер группы для студента
  UPDATE Распределение
  SET номер_группы = @новый_номер_группы
  WHERE номер_зачетки = (SELECT номер_зачетки FROM Студенты WHERE ФИО = @ФИО_студента);

  -- Добавляем коммит транзакции
  COMMIT;
ELSE
      -- Выводим сообщение о невозможности переписи
    Print N'Невозможно переписать студента в выбранную группу, так как она содержит уже 25 студентов.'