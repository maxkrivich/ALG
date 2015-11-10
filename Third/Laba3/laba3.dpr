program laba3;
{$APPTYPE CONSOLE}

uses
  SysUtils, Math, Windows;

const
  fName: string = 'num.txt';

procedure PrintFile;
var
  f: file of Double;
  a: Double;
begin
  Assign(f, fName);
  Reset(f);
  while (not Eof(f)) do
  begin
    read(f, a);
    write(a:0, ' ');
  end;
  Writeln;
  CloseFile(f);
end;
//XXX:WTF??
procedure MergeSort(const direction: string);
const
  f1Name: string = 'f1.txt';
  f2Name: string = 'f2.txt';
type
  TFile = file of Double;
var
  f, f1, f2: TFile;
  a, b: Double;
  cnt, c: Int64;
  i, j: Integer;
begin
  Assign(f, direction + fName);
  Reset(f);
  cnt := FileSize(f);
  CloseFile(f);
  c := 1;
  while (c < cnt) do
  begin
    Assign(f, direction + fName);
    Reset(f);
    Assign(f1, direction + f1Name);
    Rewrite(f1);
    Assign(f2, direction + f2Name);
    Rewrite(f2);
    if (not Eof(f)) then
      read(f, a);
    while (not Eof(f)) do
    begin
      i := 0;
      while ((i < c) and (not Eof(f))) do
      begin
        write(f1, a);
        read(f, a);
        Inc(i);
      end;
      i := 0;
      while ((i < c) and (not Eof(f))) do
      begin
        write(f2, a);
        read(f, a);
        Inc(i);
      end;
    end;
    CloseFile(f2);
    CloseFile(f1);
    CloseFile(f);

    Assign(f, direction + fName);
    Rewrite(f);
    Assign(f1, direction + f1Name);
    Reset(f1);
    Assign(f2, direction + f2Name);
    Reset(f2);
    if (not Eof(f1)) then
      read(f1, a);
    if (not Eof(f2)) then
      read(f2, b);
    while ((not Eof(f1)) and (not Eof(f2))) do
    begin
      i := 0;
      j := 0;
      while ((i < c) and (j < c) and (not Eof(f1)) and (not Eof(f2))) do
        if (a < b) then
        begin
          write(f, a);
          read(f1, a);
          Inc(i);
        end
        else
        begin
          write(f, b);
          read(f2, b);
          Inc(j);
        end;
      while ((i < c) and (not Eof(f1))) do
      begin
        write(f, a);
        read(f1, a);
        Inc(i);
      end;
      while ((j < c) and (not Eof(f2))) do
      begin
        write(f, b);
        read(f2, b);
        Inc(j);
      end;
    end;
    while not Eof(f1) do
    begin
      write(f, a);
      read(f1, a);
    end;
    while not Eof(f2) do
    begin
      write(f, b);
      read(f2, b);
    end;
    CloseFile(f2);
    CloseFile(f1);
    CloseFile(f);
    c := c * 2;
    PrintFile;
  end;
  { if DeleteFile(direction + f1Name) then
    Writeln('FILE 1 DELETED');
    if DeleteFile(direction + f2Name) then
    Writeln('FILE 2 DELETED');
  }
end;

procedure GenFile(cnt: Int64);
var
  f: file of Double;
  tmp: Double;
begin
  Assign(f, fName);
  Rewrite(f);
  Randomize;
  while (cnt > 0) do
  begin
    // tmp := RandG(1, 0.1);
    tmp := Random(100);
    write(f, tmp);
    Dec(cnt);
  end;
  CloseFile(f);
end;

function isSorted: Boolean;
var
  a, b: Double;
  f: file of Double;
begin
  Assign(f, fName);
  Reset(f);
  if FileSize(f) > 0 then
    Result := True
  else
    Result := False;
  while (not Eof(f) and Result) do
  begin
    read(f, a, b);
    if (a > b) then
      Result := False;
  end;
  CloseFile(f);
end;

var
  i: Integer;

begin
  repeat
    Readln(i);
    case i of
      1:
        MergeSort('D:\DelphiWorkspace\Win32\Debug\');
      2:
        GenFile(10);
      3:
        Writeln(isSorted);
      4:
        PrintFile;
    end;
  until 1 <> 1;

end.
