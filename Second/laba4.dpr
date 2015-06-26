program laba24;              
{$APPTYPE CONSOLE}
uses SysUtils, Windows;
type
  person = record
    lastname: string;
    firstname: string;
    d: Integer;
    m: Integer;
    y: Integer;
    point: Integer;
  end;
  pnote = ^note;
  note = record
    per: person;
    next: pnote;
  end;

procedure Cls;
var
  hStdOut: HWND;
  ScreenBufInfo: TConsoleScreenBufferInfo;
  Coord1: TCoord;
  z: Integer;
begin
  hStdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  GetConsoleScreenBufferInfo(hStdOut, ScreenBufInfo);
  for z := 1 to ScreenBufInfo.dwSize.Y do
    WriteLn;
  Coord1.X := 0;
  Coord1.Y := 0;
  SetConsoleCursorPosition(hStdOut, Coord1);
end;

procedure PushFront(var head: pnote; per: person); forward;
procedure PushBack(var head: pnote; per: person);
var
  tmp, pt: pnote;
begin
  if head = nil then
    PushFront(head, per)
  else
  begin
    pt := head;
    while pt^.next <> nil do
      pt := pt^.next;
    New(tmp);
    tmp^.per := per;
    tmp^.next := pt^.next;
    pt^.next := tmp;
  end;
end;

procedure PushFront(var head: pnote; per: person);
var
  tmp: pnote;
begin
  New(tmp);
  tmp^.per := per;
  tmp^.next := head;
  head := tmp;
end;

procedure PushAfter(var head: pnote; per: person);
var
  pf, pe: pnote;
  s: string;
begin
  New(pe);
  pe^.per := per;
  pe^.next := nil;
  pf := head;
  Write('Введите фамилию студента после которого вставить: ');
  Readln(s);
  while pf <> nil do
  begin
    if AnsiLowerCase(pf.per.lastname) = AnsiLowerCase(s) then
    begin
      pe^.next := pf^.next;
      pf^.next := pe;
      Break;
    end
    else
      pf := pf^.next;
  end;
end;

procedure PrintList(head: pnote);
var
  pt: pnote;
  i: Integer;
begin
  Cls;
  if head = nil then
    writeLn('Список пуст!!!1');
  i := 1;
  pt := head;
  while pt <> nil do
  begin
    Writeln(i, '. ', pt^.per.lastname, ' ', pt^.per.firstname, ' ', pt^.per.d,
      '.', pt^.per.m, '.', pt^.per.y, ' ', pt^.per.point);
    Inc(i);
    pt := pt^.next;
  end;
  readln;
  cls;
end;

procedure FindStudent(head: pnote);
var
  i: Integer;
  pt: pnote;
  tmps: string;
  b: Boolean;
begin
  Cls;
  if head = nil then
  begin
    writeLn('Список пуст!!!1');
    Readln;
    Cls;
    Exit;
  end;
  b := False;
  i := 1;
  pt := head;
  Write('Введите фамилию студента: ');
  Readln(tmps);
  Writeln;
  while pt <> nil do
  begin
    if AnsiLowerCase(tmps) = AnsiLowerCase(pt^.per.lastname) then
    begin
      b := True;
      Writeln(i, '. ', pt^.per.lastname, ' ', pt^.per.firstname, ' ', pt^.per.d,
        '.', pt^.per.m, '.', pt^.per.y, ' ', pt^.per.point);
      Inc(i);
    end;
    pt := pt^.next;
  end;
  if b = False then
    Writeln('Такого студента в списке нету!');
  Readln;
  Cls;
end;

procedure DeleteStudent(var head: pnote; s: string; f: boolean);
var
  pf, pd, pp: pnote;
  i: Integer;
begin
  i := 0;
  pp := nil;
  pf := head;
  while pf <> nil do
  begin
    if AnsiLowerCase(pf.per.lastname) = AnsiLowerCase(s) then
    begin
      if (i = 1) and (f = False) then
        Exit;
      if pf = head then
        head := pf^.next
      else
        pp^.next := pf^.next;
      if pf^.next = nil then
        pf^.next := pp;
      pd := pf;
      pf := pf^.next;
      Dispose(pd);
      Inc(i);
    end
    else
    begin
      pp := pf;
      pf := pf^.next;
    end;
  end;
  if (i > 0) and (f = true) then
    Writeln('Кол-во удаленных студентов: ', i)
  else if (f = True) then
    Writeln('Такого студента в списке нету!');

end;

procedure EasySort(var head: pnote);
var
  max: person;
  head1, tmp, pt: pnote;
  f: Boolean;
begin
  f := False;
  head1 := nil;
  pt := head;
  repeat
    max := head^.per;
    while pt <> nil do
    begin
      if max.lastname < pt^.per.lastname then
        max := pt^.per;
      pt := pt^.next;
    end;
    New(tmp);
    DeleteStudent(head, max.lastname, f);
    tmp^.per := max;
    tmp^.next := head1;
    head1 := tmp;
  until head = nil;
  head := head1;
end;

function Input: person;
var
  n: person;
  s: string;
begin
  Cls;
  write('Введите фамилию студента: ');
  Readln(n.lastname);
  write('Введите имя студента: ');
  Readln(n.firstname);
  write('Ведите дату в формате (дд.мм.гггг): ');
  readln(s);
  n.d := StrToInt(Copy(s, 1, 2));
  n.m := StrToInt(Copy(s, 4, 2));
  n.y := StrToInt(Copy(s, 7, 4));
  write('Введите средний балл: ');
  Readln(n.point);
  Readln;
  Cls;
  Result := n;
end;

var
  n: Byte;
  head: pnote;
  per: person;
  s: string;
  f: Boolean;

begin
  head := nil;
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);
  while n <> 42 do
  begin
    Cls;
    Writeln('1.Просмотр всей группы');
    Writeln('2.Добавление нового студента');
    Writeln('3.Поиск по фамилии');
    Writeln('4.Удаление студента с заданной фамилией');
    Writeln('5.Выход из программы');
    writeln;
    write('  Сделайте свой выбор: ');
    Readln(n);
    case n of
      1: PrintList(head);
      2:
        begin
          Cls;
          writeln('1.В начало списка');
          writeln('2.В конец списка');
          writeln('3.После указанного студента');
          writeln;
          write('  Сделайте свой выбор: ');
          readln(n);
          case n of
            1:
              begin
                per := Input;
                PushFront(head, per);
              end;
            2:
              begin
                per := Input;
                PushBack(head, per);
              end;
            3:
              begin
                if head = nil then
                  Continue;
                per := Input;
                PushAfter(head, per);
              end;
          end;
        end;
      3: FindStudent(head);
      4:
        begin
          Cls;
          if head = nil then
          begin
            writeLn('Список пуст!!!1');
            Readln;
            Cls;
            Continue;
          end;
          f := True;
          Write('Введите фамилию студента: ');
          Readln(s);
          DeleteStudent(head, s, f);
          readln;
          Cls;
        end;
      5: Exit;
      6: if head <> nil then
          EasySort(head);
    end;
  end;
end.

