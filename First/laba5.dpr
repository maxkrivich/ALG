program laba5;
{$APPTYPE CONSOLE}

uses                      
  SysUtils;

const
  n = 2;

var
  x1: array[0..n, 0..n] of integer;
  x2: array[0..n, 0..n] of integer;
  x3: array[0..n] of integer;
  i, j, b: integer;
begin
  randomize;
  write('Matrix N1:');
  for i := low(x1) to high(x1) do
  begin
    ;
    writeln;
    for j := low(x1) to high(x1) do
    begin
      x1[i, j] := random(10);
      write(x1[i, j], ' ');
    end;
  end;
  writeln;
  writeln;
  write('Matrix N2:');
  for i := low(x1) to high(x1) do
  begin
    writeln;
    for j := low(x1) to high(x1) do
    begin
      x2[i, j] := random(10);
      write(x2[i, j], ' ');
    end;
  end;
  for i := low(x2) to high(x2) do
  begin
    b := 0;
    for j := low(x2) to high(x2) do
    begin
      if x1[i, j] > x2[i, j] then
        inc(b);
      if b = n + 1 then
        x3[i] := 1
      else
        x3[i] := 0;
    end;
  end;
  writeln;
  writeln;
  writeln('Vector "b": ');
  for i := low(x1) to high(x1) do
    write(x3[i], ' ');
  readln;
end.

