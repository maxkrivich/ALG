program laba5;
{$APPTYPE CONSOLE}

uses
  SysUtils, DateUtils;

type
  TArr = array of Integer;

var
  d: TArr;
  N, CNT: Integer;

procedure Init();
begin
  SetLength(d, N);
  CNT := 0;
end;

function isPosition(x, y: Integer): Boolean;
var
  i: Integer;
begin
  i := 0;
{$N+,E-};
  while ((i < x) and (y <> d[i]) and (Abs(x - i) <> Abs(y - d[i]))) do
    Inc(i);
  Result := (i = x);
end;

procedure Backtracking(x: Integer);
var
  i, y: Integer;
begin
  for y := 0 to N - 1 do
  begin
    if (isPosition(x, y)) then
    begin
      d[x] := y;
      if (x = N - 1) then
      begin
        for i := 0 to N - 1 do
          Write(chr(ord('A') + i), ':', d[i] + 1, ' ');
        Writeln;
        Inc(CNT);
      end;
      Backtracking(x + 1);
    end;
  end;
end;

var
  t1, t2: TDateTime;

begin
  // Write('Input N: ');
  Assign(Input, 'input.txt');
  Reset(Input);
  Assign(Output, 'output.txt');
  Rewrite(Output);
  Readln(N);
  Close(Input);
  Init();
  t1 := Time();
  Backtracking(0);
  t2 := Time();
  Writeln('COUNTS: ', CNT);
  Writeln('TIME: ', MilliSecondsBetween(t2, t1));
  Close(Output);
end.