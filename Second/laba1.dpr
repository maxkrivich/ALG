program laba21;
{$APPTYPE CONSOLE}
uses SysUtils, Windows;
type                          
  T2Dint = array of array of Integer;
  Tstr = array of string;
var
  cou: Tstr;
  med: T2Dint;
  n, ind: Integer;

procedure medal(var med: T2Dint; var ind: Integer; var cou: Tstr);
var
  p: string;
  i, y: Integer;
  l: Boolean;
begin
  Writeln;
  if ind <> -42 then
  begin
    write('Введите кол-во золотых медалей: ');
    Readln(med[ind, 0]);

    write('Введите кол-во серебряных медалей: ');
    Readln(med[ind, 1]);

    write('Введите кол-во бронзовых медалей: ');
    Readln(med[ind, 2]);
  end;

  if ind = -42 then
  begin
    l := False;
    write('Введите страну: ');
    Readln(p);
    for i := 0 to High(cou) do
      if AnsiLowerCase(cou[i]) = AnsiLowerCase(p) then
      begin
        l := True;
        ind := i;
        Break;
      end;
    if l = True then
    begin
      write('Введите кол-во золотых медалей: ');
      Readln(y);
      med[ind, 0] := med[ind, 0] + y;
      write('Введите кол-во серебряных медалей: ');
      Readln(y);
      med[ind, 1] := med[ind, 1] + y;

      write('Введите кол-во бронзовых медалей: ');
      Readln(y);
      med[ind, 2] := med[ind, 2] + y;
    end;
    if l = False then
    begin
      Write('Этой страны в списке нету! Добавить?(1-да,2-нет): ');
      readln(y);
      if y = 1 then
      begin
        SetLength(cou, Length(cou) + 1);
        cou[high(cou)] := p;
        ind := High(cou);
        setLength(med, length(med) + 1);
        setLength(med[High(med)], 3);
        medal(med, ind, cou);
      end;
    end;
  end;
end;

procedure AddCountry(var cou: Tstr; var ind: Integer; var med: T2Dint);
var
  i: Integer;
  l: Boolean;
  p: string;
begin
  Writeln;
  l := False;
  SetLength(cou, Length(cou) + 1);
  write('Введите страну: ');
  Readln(p);
  for i := 0 to High(cou) do
    if AnsiLowerCase(cou[i]) = AnsiLowerCase(p) then
    begin
      Writeln('Страна уже есть в списке!');
      l := True;
      ind := i;
      medal(med, ind, cou);
      Break;
    end;
  if l = False then
  begin
    cou[high(cou)] := p;
    ind := High(cou);
    setLength(med, length(med) + 1);
    setLength(med[High(med)], 3);
    medal(med, ind, cou);
  end;
end;

procedure PrintAll(med: T2Dint; cou: Tstr);
var
  i, j: Integer;
begin
  Writeln;
  Writeln(' место   страна   золото серебро бронза');
  for i := Low(cou) to High(cou) do
  begin
    write('   ', i + 1, '.     ', cou[i], '        ');
    for j := 0 to 2 do
      write(med[i, j], '       ');
    writeln;
  end;

end;

procedure PrintOne(med: T2Dint; cou: Tstr);
var
  i, j, ind: Integer;
  p: string;
begin
  Writeln;
  write('Введите страну: ');
  Readln(p);
  for i := 0 to High(cou) do
    if AnsiLowerCase(cou[i]) = AnsiLowerCase(p) then
      ind := i;
  Writeln(' место   страна   золото серебро бронза');
  write('   ', ind + 1, '.     ', cou[ind], '        ');
  for j := 0 to 2 do
    write(med[ind, j], '       ');
  writeln;
end;

procedure Swap(i: Integer; var med: T2Dint; var cou: Tstr); forward;

procedure Sort(var med: T2Dint; var cou: Tstr);
var
  i, j: integer;
begin
  for i := Low(med) to High(med) do
    for j := i + 1 to High(med) do
      if med[i, 0] < med[j, 0] then
        Swap(i, med, cou);
  for i := Low(med) to High(med) do
    for j := i + 1 to High(med) do
      if (med[i, 0] = med[j, 0]) and (med[i, 1] < med[j, 1]) then
        Swap(i, med, cou);
  for i := Low(med) to High(med) do
    for j := i + 1 to High(med) do
      if (med[i, 0] = med[j, 0]) and (med[i, 1] = med[j, 1]) and (med[i, 2] <med[j, 2]) then
        Swap(i, med, cou);
end;

procedure Swap(i: Integer; var med: T2Dint; var cou: Tstr);
var
  j, tm: integer;
  tc: string;
begin
  tc := cou[i];
  cou[i] := cou[i + 1];
  cou[i + 1] := tc;
  for j := 0 to 2 do
  begin
    tm := med[i, j];
    med[i, j] := med[i + 1, j];
    med[i + 1, j] := tm;
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  while (n <> 5) do
  begin
    Writeln;
    Writeln('1.Добавить страну-призера');
    Writeln('2.Добавить медали стране');
    Writeln('3.Вывести сводную таблицу');
    Writeln('4.Вывести данные по стране');
    Writeln('5.Выход из программы');
    writeln;
    write('Сделайте свой выбор: ');
    readln(n);
    case n of
      1:
        begin
          AddCountry(cou, ind, med);
          sort(med, cou);
        end;
      2:
        begin
          ind := -42;
          medal(med, ind, cou);
          sort(med, cou);
        end;
      3: PrintAll(med, cou);
      4: PrintOne(med, cou);
      5: Break;
    else
      Writeln('Ошибка ввода!');
    end;
  end;
  Writeln;
  write('Для завершения нажмите <Enter>');
  readln;
end.

