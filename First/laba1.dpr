program laba1;
{$APPTYPE CONSOLE}
uses SysUtils;

var
  c, i, p, n: Integer;
  x, y: Real;
begin
  writeln('Laba 1  by Max Krivich');
  write('Select task: ');
  p := 0;
  n := 0;
  Readln(c);
  case c of
    1:
      begin
        Writeln;
        for i := 1 to 4 do
        begin
          write('Input number: ');
          Readln(c);
          if c > 0 then
            Inc(p)
          else
            Inc(n);
        end;
        writeln('pos: ', p, ' neg: ', n);
        Writeln;
      end;
    2:
      begin
        Writeln;
        write('Input X: ');
        Readln(x);
        write('Input Y: ');
        Readln(y);
        if x >= 9 then
          Writeln('Answer: ', (11 * y) / (3 * x + 3 * sqrt(x - 9)))
        else
          Writeln('Input error');
        Writeln;
      end;
    3:
      begin
        Writeln;
        writeln('M(x,y)');
        write('Input X: ');
        Readln(x);
        write('Input Y: ');
        Readln(y);
        if (x >= 0) and (y >= 0) and (sqr(x - 2) + sqr(y - 2) >= Sqr(1)) then
          Writeln(1 = 1)
        else
          Writeln(1 <> 1);
      end;
  end;
  Readln;
end.
