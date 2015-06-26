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
    write('Ââåäèòå êîë-âî çîëîòûõ ìåäàëåé: ');
    Readln(med[ind, 0]);

    write('Ââåäèòå êîë-âî ñåðåáðÿíûõ ìåäàëåé: ');
    Readln(med[ind, 1]);

    write('Ââåäèòå êîë-âî áðîíçîâûõ ìåäàëåé: ');
    Readln(med[ind, 2]);
  end;

  if ind = -42 then
  begin
    l := False;
    write('Ââåäèòå ñòðàíó: ');
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
      write('Ââåäèòå êîë-âî çîëîòûõ ìåäàëåé: ');
      Readln(y);
      med[ind, 0] := med[ind, 0] + y;
      write('Ââåäèòå êîë-âî ñåðåáðÿíûõ ìåäàëåé: ');
      Readln(y);
      med[ind, 1] := med[ind, 1] + y;

      write('Ââåäèòå êîë-âî áðîíçîâûõ ìåäàëåé: ');
      Readln(y);
      med[ind, 2] := med[ind, 2] + y;
    end;
    if l = False then
    begin
      Write('Ýòîé ñòðàíû â ñïèñêå íåòó! Äîáàâèòü?(1-äà,2-íåò): ');
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
  write('Ââåäèòå ñòðàíó: ');
  Readln(p);
  for i := 0 to High(cou) do
    if AnsiLowerCase(cou[i]) = AnsiLowerCase(p) then
    begin
      Writeln('Ñòðàíà óæå åñòü â ñïèñêå!');
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
  Writeln(' ìåñòî   ñòðàíà   çîëîòî ñåðåáðî áðîíçà');
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
  write('Ââåäèòå ñòðàíó: ');
  Readln(p);
  for i := 0 to High(cou) do
    if AnsiLowerCase(cou[i]) = AnsiLowerCase(p) then
      ind := i;
  Writeln(' ìåñòî   ñòðàíà   çîëîòî ñåðåáðî áðîíçà');
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
    Writeln('1.Äîáàâèòü ñòðàíó-ïðèçåðà');
    Writeln('2.Äîáàâèòü ìåäàëè ñòðàíå');
    Writeln('3.Âûâåñòè ñâîäíóþ òàáëèöó');
    Writeln('4.Âûâåñòè äàííûå ïî ñòðàíå');
    Writeln('5.Âûõîä èç ïðîãðàììû');
    writeln;
    write('Ñäåëàéòå ñâîé âûáîð: ');
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
      Writeln('Îøèáêà ââîäà!');
    end;
  end;
  Writeln;
  write('Äëÿ çàâåðøåíèÿ íàæìèòå <Enter>');
  readln;
end.

