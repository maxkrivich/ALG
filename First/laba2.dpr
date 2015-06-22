program laba2;
{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n, j, x, i: integer;
  r, k: real;

begin
  writeln('Laba 2  by Max Krivich');
  write('Select task: ');
  readln(n);
  case n of
    1:
      begin
        writeln;
        write('Write number: ');
        readln(n);
        if n > 0 then
        begin
          repeat
            write(n mod 10);
            n := n div 10;
          until n = 0;
        end
        else
          writeln('N<=0');
        readln;
      end;
    2:
      begin
        writeln;
        j := 0;
        write('Write "N": ');
        readln(n);
        if n > 0 then
        begin
          x := sqr(n);
          repeat
            j := j + 1;
            x := x + sqr(n - j);
          until n - j = 0;
          writeln('Result: ', x);
        end
        else
          writeln('N=0 or N<0');
        readln;
      end;
    3:
      begin
        writeln;
        r := 0;
        write('The numbers of elements: ');
        readln(n);
        writeln('Write ', n, ' numbers:');
        for i := 1 to n do
        begin
          readln(k);
          if k > 0 then
            r := r + k
          else
            n := n - 1;
        end;
        if n <> 0 then
        begin
          r := r / n;
          writeln('Arithmetic mean positive numbers: ', r: 0);
        end
        else if n = 0 then
          writeln('You write all negetive numbers!');
        readln;
      end
  else
    begin
      writeln;
      writeln('Error!');
    end;
  end;
  readln;
end.

