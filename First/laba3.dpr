program laba3;
{$APPTYPE CONSOLE}
uses
  SysUtils, Math;

var
  n, k, j, i, q, w, e, r: integer;
  s, f: double;

begin
  writeln('Laba 3 by Max Krivich');
  write('Select task: ');
  readln(n);
  case n of
    1:
      begin
        writeln;
        write('Write "N": ');
        readln(n);
        f := 1;
        s := 0;
        for k := 1 to n do
        begin
          f := f * k;
          s := s + (power(-1, k) * (k + 1)) / f;
        end;
        writeln('Result: ', s: 0);
        writeln;
      end;
    2:
      begin
        writeln;
        for i := 1 to 5 do
        begin
          for k := 1 to i do
            write('  ');
          for n := i to 5 do
            write(n, ' ');
          for j := 4 downto i do
            write(j, ' ');
          writeln;
        end;
      end;
    3:
      begin
        writeln;
        e := 0;
        r := 0;
        writeln('Write "N": ');
        read(n);
        readln(q);
        for i := 1 to (n - 1) do
        begin
          readln(w);
          if w > q then
            e := e + 1;
          if q > w then
            r := r + 1;
        end;
        n := n - 1;
        if e = n then
          writeln('Up');
        if r = n then
          writeln('Down');
        writeln;
      end
  else
    begin
      writeln;
      writeln('Error!');
    end;
  end;
  readln;
end.

