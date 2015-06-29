program Game;
{$APPTYPE CONSOLE}
uses
  SysUtils;
const
  n = 4;
type
  TArr = array[1..n] of Integer;
 
procedure RandArr(var arr: TArr);
var
  m, i, j, x: integer;
  f: Boolean;
begin
  m := 3;
  arr[1] := Random(8) + 1;
  Randomize;
  for i := Low(arr)+1 to High(arr) do
  begin
    repeat
      f := false;
      x := Random(9);
      for j := 1 to m do
        if arr[j] = x then
          f := true;
    until not (f);
    arr[i] := x;
    m := m + 1;
  end;
end;

procedure InputArr(var arr: TArr; tmp: Integer);
var
  st: string;
  i: Integer;
begin
  st := IntToStr(tmp);
  for i := Low(arr) to High(arr) do
    arr[i] := StrToInt(st[i]);
end;

function getResult(arr1, arr2: TArr): Boolean;
var
  b, c, i, j: Integer;
begin
  b := 0;
  c := 0;
  for i := Low(arr1) to High(arr1) do
    for j := Low(arr1) to High(arr1) do
      if arr1[i] = arr2[j] then
        if i = j then
          Inc(b)
        else
          Inc(c);
  Writeln('Bulls: ', b, ' Cows: ', c);
  if b = n then
    Result := true
  else
    Result := false;
end;

function checkError(tmp: integer): Boolean;
var
  i, j: Integer;
  ss: string;
begin
  Result := true;
  if ((tmp < 1000) or (tmp > 9999)) or (tmp <= 0) then
    Result := False;
  ss := IntToStr(tmp);
  for i := 1 to Length(ss) do
    for j := 1 to i - 1 do
      if ss[i] = ss[j] then
        Result := False;
end;

var
  compnum, usnum: TArr;
  f, t: Boolean;
  i, tmp: Integer;
begin
  Randomize;
  i := 1;
  RandArr(compnum);
  f := False;
  while not (f) do
  begin
    Writeln;
    write('Step ', i, ' > ');
    Readln(tmp);
    if checkError(tmp) = true then
    begin
      InputArr(usnum, tmp);
      f := getResult(compnum, usnum);
      Inc(i);
    end
    else
    begin
      Writeln;
      Writeln('Input error');
      Continue;
    end;
  end;
  Writeln;
  Writeln('You win!');
  Readln;
end.
