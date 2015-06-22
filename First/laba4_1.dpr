program laba4_1;
{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  n = 5;

var
  x: array[0..n] of integer;
  i, s, j: integer;
begin
  s := 0;
  j := 0;
  for i := 0 to n do
    readln(x[i]);
  for i := 0 to n do
  begin
    if x[i] > 0 then
    begin
      j := i;
      break;
    end;
  end;
  for i := j to n do
  begin
    s := s + x[i];
  end;
  writeln(s);
  readln;
end.

