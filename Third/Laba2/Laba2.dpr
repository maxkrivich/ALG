program Laba2;
{$APPTYPE CONSOLE}

uses
  SysUtils, Windows, DateUtils, Math;

const
  dir: string = 'num.txt';
  range: Integer = 1000;

type
  Data = Integer;
  FData = file of Data;
  TArr = array of Data;

  Ttype = record
    time: Int64;
    sorted: Boolean;
  end;

var
  buff: TArr;
  t1, t2: TDateTime;
  rec: Ttype;

  // -- Helpers --
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

procedure SetColor(AColor: Integer);
begin
  SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), AColor and $0F);
end;

// -- end --
function menu: Byte;
var
  a: Byte;
begin
  SetColor(15);
  cls;
  Writeln('1. Generate a file N values');
  Writeln('2. Quick Sort');
  Writeln('3. Insertion Sort');
  Writeln('4. Selection Sort');
  Writeln('5. Bubble Sort');
  Writeln('6. Exit');
  Readln(a);
  cls;
  Result := a;
end;

function subMenu(color: Integer): Byte;
var
  a: Byte;
begin
  SetColor(color);
  cls;
  Writeln('1. Print array');
  Writeln('2. Sort array');
  Writeln('3. Show sort time');
  Writeln('4. Back');
  Readln(a);
  cls;
  Result := a;
end;

procedure Swap(var a, b: Data); assembler; register;
asm
  mov ecx, [eax]
  xchg ecx, [edx]
  mov [eax], ecx
end;

procedure createFile;
var
  n: Integer;
  f: FData;
  tmp: Data;
begin
  Write('Input N: ');
  Readln(n);
  while ((n < 10) xor (n > 1E5)) do
  begin
    Writeln('Input error!');
    Readln(n);
  end;
  Assign(f, dir);
  Rewrite(f);
  Randomize;
  while (n > 0) do
  begin
    tmp := Random(range);
    write(f, tmp);
    Dec(n);
  end;
  Close(f);
end;

procedure loadArray(var buff: TArr);
var
  f: FData;
  i: Integer;
begin
  Assign(f, dir);
  Reset(f);
  if (Length(buff) < FileSize(f)) then
    SetLength(buff, FileSize(f));
  i := 0;
  while (not(EOF(f))) do
  begin
    read(f, buff[i]);
    Inc(i);
  end;
  Close(f);
end;

procedure printArray(arr: TArr);
var
  i: Integer;
begin
  for i := Low(arr) to High(arr) do
    write(arr[i], ' ');
  Writeln;
  Readln;
  cls;
end;

function isSorted(arr: TArr; i, j: Integer): Boolean;
begin
  Result := True;
  Inc(i);
  while (Result and (i <= j)) do
  begin
    if not(arr[i] >= arr[i - 1]) then
      Result := False;
    Inc(i);
  end;
end;

// TODO
procedure quickSort(var arr: TArr; i, j: Integer);
var
  r, l, m: Integer;
begin
  l := i;
  r := j;
  m := Max(arr[i], arr[i + 1]);
  repeat
    while (arr[l] < m) do
      Inc(l);
    while (arr[r] > m) do
      Dec(r);
    if l <= r then
    begin
      Swap(arr[l], arr[r]);
      Inc(l);
      Dec(r);
    end;
  until l > r;
  if (i < r) then
    quickSort(arr, i, r);
  if (l < j) then
    quickSort(arr, l, j);

end;

function selectionSort(var arr: TArr; l, h: Integer): Ttype;
var
  i, j, k: Integer;
  t1, t2: TDateTime;
begin
  t1 := time();
  for i := l to h - 1 do
  begin
    k := i;
    for j := i + 1 to h do
      if (arr[j] < arr[k]) then
        k := j;
    Swap(arr[i], arr[k]);
  end;
  t2 := time();
  Result.time := MilliSecondsBetween(t2, t1);
  Result.sorted := isSorted(arr, l, h);
end;

// TODO: Insert sort dosn't works
function insertionSort(var arr: TArr; l, h: Integer): Ttype;
var
  i, j, del: Integer;
  t1, t2: TDateTime;
begin
  t1 := time();
  for i := l to h do
  begin
    del := arr[i];
    j := i - 1;
    while ((j >= 0) and (del <= arr[j])) do
    begin
      arr[j + 1] := arr[j];
      Dec(j);
    end;
    arr[j + 1] := del;
  end;
  t2 := time();
  Result.time := MilliSecondsBetween(t2, t1);
  Result.sorted := isSorted(arr, l, h);
end;

function bubbleSort(var arr: TArr; l, h: Integer): Ttype;
var
  i, j: Integer;
  t1, t2: TDateTime;
begin
  t1 := time();
  for i := l to h do
    for j := h downto i + 1 do
      if (arr[j] > arr[j - 1]) then
        Swap(arr[j], arr[j - 1]);
  t2 := time();
  Result.time := MilliSecondsBetween(t2, t1);
  Result.sorted := isSorted(arr, l, h);
end;

procedure Ex51(var arr: TArr);
var
  i, j, t: Integer;
  f: Text;
begin
  i := 0;
  j := 9;
  for t := 1 to 10000 do
  begin
    quickSort(arr, i, j);
    Writeln(t, ' ', isSorted(arr, i, j));
    i := j + 1;
    j := j + 10;
  end;
  Assign(f, 'Sorted.txt');
  Rewrite(f);
  j := 9;
  for t := Low(arr) to High(arr) do
  begin
    write(f, arr[t], ' ');
    if (t = j) then
    begin
      write(f, '| ');
      j := j + 10;
    end;
  end;
  Writeln(f, '');
  Close(f);
  Readln;
end;

begin
  while (True) do
  begin
    rec.time := 0;
    rec.sorted := False;
    case menu of
      1:
        createFile;
      2:
        begin
          loadArray(buff);
          while (True) do
          begin
            case subMenu(14) of
              1:
                printArray(buff);
              2:
                begin
                  cls;
                  Writeln('Sorting...');
                  t1 := time();
                  quickSort(buff, Low(buff), High(buff));
                  t2 := time();
                end;
              3:
                begin
                  Writeln('TIME: ', MilliSecondsBetween(t2, t1));
                  Readln;
                end;
              4:
                Break;
              5:
                begin
                  Writeln(isSorted(buff, Low(buff), High(buff)));
                  Readln;
                end;
            end;
          end;
        end;
      3:
        begin
          loadArray(buff);
          // Ex51(buff);
          while (True) do
          begin
            case subMenu(6) of
              1:
                printArray(buff);
              2:
                begin
                  cls;
                  Writeln('Sorting...');
                  rec := insertionSort(buff, Low(buff), High(buff));
                end;
              3:
                begin
                  Writeln('TIME: ', rec.time);
                  Readln;
                end;
              4:
                Break;
              5:
                begin
                  Writeln(rec.sorted);
                  Readln;
                end;
            end;
          end;
        end;
      4:
        begin
          loadArray(buff);
          while (True) do
          begin
            case subMenu(10) of
              1:
                printArray(buff);
              2:
                begin
                  cls;
                  Writeln('Sorting...');
                  rec := selectionSort(buff, Low(buff), High(buff));
                end;
              3:
                begin
                  Writeln('TIME: ', rec.time);
                  Readln;
                end;
              4:
                Break;
              5:
                begin
                  Writeln(rec.sorted);
                  Readln;
                end;
            end;
          end;
        end;
      5:
        begin
          loadArray(buff);
          while (True) do
          begin
            case subMenu(11) of
              1:
                printArray(buff);
              2:
                begin
                  cls;
                  Writeln('Sorting...');
                  rec := bubbleSort(buff, Low(buff), High(buff));
                end;
              3:
                begin
                  Writeln('TIME: ', rec.time);
                  Readln;
                end;
              4:
                Break;
              5:
                begin
                  Writeln(rec.sorted);
                  Readln;
                end;
            end;
          end;
        end;
      6:
        Exit;

      7:
        begin
        //Writeln('Sorting...');
          loadArray(buff);
          bubbleSort(buff, Low(buff), High(buff));
          //cls;
          Writeln('Sorting...');
          t1 := time();
          quickSort(buff, Low(buff), High(buff));
          t2 := time();
          cls;
          Writeln('TIME: ', MilliSecondsBetween(t2, t1));
          Writeln('STATUS: ', isSorted(buff, Low(buff), High(buff)));
          Readln;
        end;
    end;
  end;
  Readln;

end.
