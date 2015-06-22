program laba4_2;
{$APPTYPE CONSOLE}

const
  n1 = 5;

var
  a: array[0..n1] of integer;
  n: byte;

procedure load(var a: array of integer);
var
  i: integer;
begin
  for i := low(a) to n1 do
    readln(a[i]);
end;

procedure print(var a: array of integer; var n: byte);
var
  i: integer;
begin
  for i := low(a) to n do
    write(a[i], ' ');
end;

procedure laba42(var a: array of integer; var n: byte);
var
  i, j, k, p, q: byte;
  x: integer;
begin
  i := 0;
  while i <= n do
  begin
    k := 0;
    for j := i + 1 to n do
      if a[j] = a[i] then
        inc(k);
    if k = 1 then
    begin
      p := i;
      x := a[i];
      while p <= n do
        if a[p] = x then
        begin
          for q := p to n - 1 do
            a[q] := a[q + 1];
          dec(n);
        end
        else
          inc(p);
    end
    else
      inc(i);
  end;
end;

begin
  n := n1;
  load(a);
  laba42(a, n);
  print(a, n);
  readln;
end.

