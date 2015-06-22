program laba26;
{$APPTYPE CONSOLE}
uses SysUtils, Windows;

procedure cls;
var
  cursor: COORD;
  r: cardinal;
begin
  r := 300;
  cursor.X := 0;
  cursor.Y := 0;
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 80 * r,
    cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cursor);
end;

function Sum1(n: integer): Integer;
var
  m: Integer;
begin
  write('Enter number: ');
  Readln(m);
  if m < 0 then
    Sum1 := n
  else
    Sum1 := Sum1(m) + n
end;

function Sum2(n: Integer): Integer;
begin
  if n mod 10 = 0 then
    Sum2 := n
  else
    Sum2 := n mod 10 + Sum2(n div 10);
end;

function SumMas(a: array of integer; x, y: Integer): Integer;
begin
  if x = y then
    Result := a[y]
  else
  begin
    summas := a[x] + Summas(a, x + 1, y);
  end;
end;

function f(x: Real): real;
begin
  f := 2 * x + 5;
end;

function FindRoot(a, b, e: real): real;
var
  c, x: Real;
begin
  c := (a + b) / 2;
  if abs(f(c)) < e then
    x := c
  else if f(a) * f(c) < 0 then
    x := FindRoot(a, c, e)
  else
    x := FindRoot(c, b, e);
  FindRoot := x;
end;

var
  mas: array of Integer;
  m, n, s, i: Integer;
  a, b, e: Real;
begin
  while n <> 4 do
  begin
    cls;
    Write('Select task: ');
    readln(n);
    case n of
      1:
        begin
          cls;
          writeln('Write [a,b] and (a<b) and (e>0)');
          write('Write a: ');
          readln(a);
          write('Write b: ');
          readln(b);
          write('Write e: ');
          readln(e);
          if f(a) * f(b) < 0 then
            a := FindRoot(a, b, e)
          else
          begin
            cls;
            Writeln(':(');
            readln;
            Continue;
          end;
          Writeln;
          writeln('Root: ', a: 0);
          readln;
        end;
      2:
        begin
          cls;
          m := 0;
          m := sum1(m);
          Writeln;
          Writeln('The sum of the numerical sequence: ', m);
          readln;
        end;
      3:
        begin
          s := 0;
          SetLength(mas,0);
          i := 0;
          cls;
          while i <> 5 do
          begin
            write('Enter number: ');
            Readln(m);
            repeat
              SetLength(mas, Length(mas) + 1);
              mas[High(mas)] := m mod 10;
              m := m div 10;
            until m = 0;
            Inc(i);
          end;
          m := Low(mas);
          n := High(mas);
          s := SumMas(mas, m, n);
          Writeln;
          Writeln('The sum of digits: ', s);
          n := 0;
          readln;
        end;
      4: Exit
    else
      begin
        cls;
        Writeln('Error!!1');
        Readln;
      end;
    end;
  end;
end.

