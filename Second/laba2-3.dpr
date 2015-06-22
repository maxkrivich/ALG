program laba23;
{$APPTYPE CONSOLE}
uses SysUtils, Windows;
type
  bday = record
    d: Integer;
    m: Integer;
    y: Integer;
  end;
  person = record
    f: string[20];
    i: string[20];
    o: string[20];
    a: string[20];
    g: bday;
    p: Integer;
  end;
  list = array of person;
  filis = file of person;

procedure ReadFile(var student: list; var f1: filis);
var
  i: Integer;
begin
  Assign(f1, 'StudentList.txt');
  Reset(f1);
  i := 0;
  while not (EOF(f1)) do
  begin
    SetLength(student, Length(student) + 1);
    read(f1, student[i]);
    inc(i);
  end;
  CloseFile(f1);
end;

procedure print(student: list; var f1: filis);
var
  i: Integer;
begin
  i := 0;
  Assign(f1, 'StudentList.txt');
  Reset(f1);
  while not Eof(f1) do
  begin
    read(f1, student[i]);
    write(i + 1, '. ', student[i].f, ' ', student[i].i, ' ', student[i].o, '  ',
      student[i].a, '  ', student[i].g.d, '.', student[i].g.m, '.',
      student[i].g.y,
      '  ', student[i].p);
    Writeln;
    inc(i);
  end;
  CloseFile(f1);
end;

procedure Sort(var student: list); forward;

procedure AddStudent(var student: list; var f1: filis);
var
  s: string;
  i: integer;
begin
  SetLength(student, Length(student) + 1);
  write('Введите фамилию студента: ');
  Readln(student[High(student)].f);
  write('Введите имя студента: ');
  Readln(student[High(student)].i);
  write('Введите отчетсво студента: ');
  Readln(student[High(student)].o);
  write('Введите адрес студента: ');
  Readln(student[High(student)].a);
  write('Ведите дату в формате (дд.мм.гггг): ');
  readln(s);
  student[High(student)].g.d := StrToInt(Copy(s, 1, 2));
  student[High(student)].g.m := StrToInt(Copy(s, 4, 2));
  student[High(student)].g.y := StrToInt(Copy(s, 7, 4));
  write('Введите средний балл: ');
  Readln(student[High(student)].p);
  Sort(student);
  Assign(f1, 'StudentList.txt');
  Rewrite(f1);
  for i := 0 to High(student) do
    write(f1, student[i]);
  CloseFile(f1);
end;

procedure DeleteStudent(var student: list; var f5, f1: filis);
var
  j, n: Integer;
begin
  write('Введите номер студента в списке: ');
  readln(n);
  n := n - 1;
  Assign(f5, 'Deleted.txt');
  Rewrite(f5);
  write(f5, student[n]);
  if (n >= Low(student)) and (n <= High(student)) then
  begin
    for j := n + 1 to Length(student) - 1 do
      student[j - 1] := student[j];
    SetLength(student, Length(student) - 1);
  end
  else
    Writeln('Ошибка ввода');
  CloseFile(f5);
  Assign(f1, 'StudentList.txt');
  Rewrite(f1);
  for j := 0 to High(student) do
    write(f1, student[j]);
  CloseFile(f1);
end;

procedure FindStudent(student: list);
var
  i, n, y: Integer;
  s: string;
  d: bday;
  l: Boolean;
begin
  Writeln;
  Writeln('1.По фамилии студента');
  Writeln('2.По диапазону успеваемости');
  writeln('3.По дате рождения');
  Writeln;
  write('Сделайте свой выбор: ');
  Readln(n);
  case n of
    1:
      begin
        write('Введите фамилию студента: ');
        readln(s);
        Writeln;
        l := False;
        for i := low(student) to High(student) do
          if AnsiLowerCase(student[i].f) = AnsiLowerCase(s) then
          begin
            l := True;
            write(i + 1, '. ', student[i].f, ' ', student[i].i, ' ',
              student[i].o, '  ', student[i].a, '  ', student[i].g.d, '.',
              student[i].g.m, '.', student[i].g.y, '  ', student[i].p);
            Break;
          end;
        if l = False then
          Writeln('Не найден =[');
        Writeln;
      end;
    2:
      begin
        write('от: ');
        readln(n);
        write('до: ');
        readln(y);
        Writeln;
        l := False;
        for i := Low(student) to High(student) do
          if (student[i].p >= n) and (student[i].p <= y) then
          begin
            write(i + 1, '. ', student[i].f, ' ', student[i].i, ' ',
              student[i].o, '  ', student[i].a, '  ', student[i].g.d, '.',
              student[i].g.m, '.', student[i].g.y, '  ', student[i].p);
            Writeln;
            l := True;
          end;
        if l = False then
          Writeln('Не найден =[');
        Writeln;
      end;
    3:
      begin
        write('Введите день: ');
        Readln(d.d);
        write('Введите месяц: ');
        Readln(d.m);
        write('Введите год: ');
        Readln(d.y);
        l := False;
        for i := Low(student) to High(student) do
          if (d.d = student[i].g.d) and (d.m = student[i].g.m) and (d.y =
            student[i].g.y) then
          begin
            l := true;
            write(i + 1, '. ', student[i].f, ' ', student[i].i, ' ',
              student[i].o, '  ', student[i].a, '  ', student[i].g.d, '.',
              student[i].g.m, '.', student[i].g.y, '  ', student[i].p);
            Writeln;
          end;
        if l = False then
          Writeln('Не найден =[');
      end;
  else
    writeln('Ошибка ввода!');
  end;
end;

procedure Sort(var student: list);
var
  tmp: person;
  i, j: Integer;
begin
  for i := Low(student) to High(student) - 1 do
    for j := i + 1 to High(student) do
      if AnsiLowerCase(student[i].f) > AnsiLowerCase(student[j].f) then
      begin
        tmp := student[i];
        student[i] := student[j];
        student[j] := tmp;
      end;
end;

procedure SortP(student: list; var f2, f3, f4: filis);
var
  i, n: Integer;
begin
  Writeln;
  Assign(f2, 'High.txt');
  Assign(f3, 'Middle.txt');
  Assign(f4, 'Low.txt');
  Rewrite(f2);
  Rewrite(f3);
  Rewrite(f4);
  for i := Low(student) to High(student) do
  begin
    if (student[i].p >= 70) and (student[i].p <= 100) then
      write(f2, student[i]);
    if (student[i].p >= 50) and (student[i].p <= 69) then
      write(f3, student[i]);
    if (student[i].p >= 0) and (student[i].p <= 49) then
      write(f4, student[i]);
  end;
  CloseFile(f2);
  CloseFile(f3);
  CloseFile(f4);
  Writeln('Просмотр группы: ');
  Writeln('1.Высоким');
  Writeln('2.Среднем');
  Writeln('3.Низким');
  Writeln;
  write('Сделайте свой выбор: ');
  Readln(i);
  n := 0;
  case i of
    1:
      begin
        Assign(f2, 'High.txt');
        Reset(f2);
        while not Eof(f2) do
        begin
          read(f2, student[n]);
          write(n + 1, '. ', student[n].f, ' ', student[n].i, ' ', student[n].o,
            '  ', student[n].a, '  ', student[n].g.d, '.', student[n].g.m, '.',
            student[n].g.y, '  ', student[n].p);
          Writeln;
          inc(n);
        end;
        CloseFile(f2);
      end;

    2:
      begin
        Assign(f3, 'Middle.txt');
        Reset(f3);
        while not Eof(f3) do
        begin
          read(f3, student[n]);
          write(n + 1, '. ', student[n].f, ' ', student[n].i, ' ', student[n].o,
            '  ', student[n].a, '  ', student[n].g.d, '.', student[n].g.m, '.',
            student[n].g.y, '  ', student[n].p);
          Writeln;
          inc(n);
        end;
        CloseFile(f3);
      end;
    3:
      begin
        Assign(f4, 'Low.txt');
        Reset(f4);
        while not Eof(f4) do
        begin
          read(f4, student[n]);
          write(n + 1, '. ', student[n].f, ' ', student[n].i, ' ', student[n].o,
            '  ', student[n].a, '  ', student[n].g.d, '.', student[n].g.m, '.',
            student[n].g.y, '  ', student[n].p);
          Writeln;
          inc(n);
        end;
        CloseFile(f4);
      end

  end;

end;

var
  student: list;
  n: Integer;
  f1, f2, f3, f4, f5: filis;
  t: Boolean;
begin
  t := True;
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  Writeln('                           Лабораторная работа №3');
  Writeln('                            Кривич Максим КБ-11');

  while (n <> 6) do
  begin
    writeln('--------------------------------------------------------------------------------');
    if t = True then
      Writeln(' 0.Загрузка дынных с файла');
    t := False;
    Writeln(' 1.Просмотр всей группы');
    Writeln(' 2.Поиск студента');
    Writeln(' 3.Добавления нового студента');
    Writeln(' 4.Удалить студента с заданным номером в списке');
    Writeln(' 5.Классификация по категориям');
    Writeln(' 6.Выход из программы');
    writeln;
    write('  Сделайте свой выбор: ');
    Readln(n);
    writeln('--------------------------------------------------------------------------------');
    case n of
      0:
        begin
          ReadFile(student, f1);
          if t=False then
            Writeln('                            Файлы успешно загружены!');
        end;
      1: print(student, f1);
      2: FindStudent(student);
      3: AddStudent(student, f1);
      4: DeleteStudent(student, f5, f1);
      5: SortP(student, f2, f3, f4);
      6: Break;
      42:
        begin
          Assign(f1, 'StudentList.txt');
          Rewrite(f1);
          CloseFile(f1);
          Assign(f2, 'High.txt');
          Assign(f3, 'Middle.txt');
          Assign(f4, 'Low.txt');
          Rewrite(f2);
          Rewrite(f3);
          Rewrite(f4);
          CloseFile(f2);
          CloseFile(f3);
          CloseFile(f4);
          Assign(f5, 'Deleted.txt');
          Rewrite(f5);
          CloseFile(f5);
          SetLength(student, 0);
        end
    else
      writeln('Ошибка ввода!');
    end;
  end;
  Writeln;
  write('Для завершения нажмите <Enter>');

  Readln;
end.

