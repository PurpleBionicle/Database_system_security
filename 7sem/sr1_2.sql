Create proc Stud_Rasp
@фио_ст varchar(25) = NULL
@фио_пр varchar(25) = NULL
@тема_курсача varchar(35) = NULL
as
IF @FIO is NULL OR @group is NULL
begin
  Print N'Введите данные'
  Return
end
IF Not Exists(SELECT ФИО_ст FROM Студент Where ФИО_ст=@фио_ст) OR
 Not Exists(SELECT ФИО_пр FROM Препод Where ФИО_пр=@фио_пр)
begin
  Print N'Введите корректные данные'
  Return
end

    -- Если у преподавателя нет доступных мест, выводим сообщение
IF (SELECT COUNT(*) FROM Курсовой WHERE ФИО_пр=@фио_пр) >= (SELECT Нагрузка FROM Препод WHERE ФИО_пр=@фио_пр)
BEGIN
    PRINT 'У преподавателя нет доступных мест на курсовом проекте'
END
ELSE
BEGIN
    -- Записываем студента на курсовой проект
    INSERT INTO Курсовой (№_зачетки, ФИО_пр, Тема)
    VALUES ((SELECT №_зачетки FROM Студент WHERE ФИО_ст = @фио_ст), @фио_пр, @тема_курсача)
END