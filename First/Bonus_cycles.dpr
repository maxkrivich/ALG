program Bonus_cycles;
{$APPTYPE CONSOLE}
uses SysUtils;
 
var
  a, b, c, sq, n: integer;

begin
  write('Input "N": ');
  Readln(n);
  if n >= 5 then
    for a := 1 to n do
      for b := 1 to n do
      begin
        sq := sqr(a) + sqr(b);
        c := Trunc(Sqrt(sq));
        if (sqr(c) = sq) and (c <= n) then
          Writeln(' > ', 'sqr(', a, ') + sqr(', b, ') = sqr(', c, ')');
      end;
  Readln;
end.
