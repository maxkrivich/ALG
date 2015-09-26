program HeapALG;
{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;
type
  node = Integer;
var
  lvl, size, i: Integer;
  heap: array of node;

procedure Swap(var a, b: node); assembler; register;
asm
mov ecx, [eax]
xchg ecx, [edx]
mov [eax], ecx
end;

procedure cls;
var
  cursor: COORD;
  r: cardinal;
begin
  r := 300;
  cursor.X := 0;
  cursor.Y := 0;
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 80 * r, cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cursor);
end;

function menu: byte;
var
  n: byte;
begin
  writeln('1.Add element');
  writeln('2.Delete element');
  writeln('3.Print heap');
  writeln('4.Exit');
  Writeln;
  write('  Make your choice: ');
  Readln(n);
  cls;
  result := n;
end;

function getParent(var n: Integer): Integer;
begin
  Result := (n - 1) div 2;
end;

function getRightChild(var n: Integer): Integer;
begin
  Result := 2 * n + 2;
end;

function getLeftChild(var n: Integer): Integer;
begin
  Result := 2 * n + 1;
end;

procedure makeHeap();
begin
  lvl := 1;
  size := 0;
  SetLength(heap, (1 shl lvl) + 1);
end;

procedure newLevel();
begin
  Inc(lvl);
  SetLength(heap, (1 shl lvl) + 1);
end;

procedure delLevel();
begin
  Dec(lvl);
  SetLength(heap, (1 shl lvl) - 1);
end;

procedure addNode(n: node);
var
  p: Integer;
begin
  if (size = Length(heap)) then
    newLevel();
  heap[size] := n;
  p := size;
  while (heap[p] < heap[getParent(p)]) do
  begin
    Swap(heap[p], heap[getParent(p)]);
    p := getParent(p);
  end;
  Inc(size);
end;

function deleteNode(): node;
var
  p, l, r: Integer;
begin
  if size = 0 then
  begin
    Result := Low(Integer);
    exit;
  end;
  p := Low(heap);
  l := getLeftChild(p);
  r := getRightChild(p);
  Result := heap[p];
  Dec(size);
  heap[p] := heap[size];
  heap[size] := High(Integer);
  while ((heap[p] > heap[l]) or (heap[p] > heap[r])) and not (p > size div 2) do
  begin
    if (heap[l] < heap[r]) then
    begin
      swap(heap[p], heap[l]);
      p := l;
    end
    else
    begin
      swap(heap[p], heap[r]);
      p := r;
    end;
    l := getLeftChild(p);
    r := getRightChild(p);
  end;
end;

procedure printHeap();
var
  i: Integer;
begin
  if size = 0 then
  begin
    Writeln('Heap is empty!');
    exit;
  end;
  for i := 0 to size - 1 do
    Write(heap[i], ' ');
  Writeln;
end;

begin
  makeHeap();
  repeat
    cls;
    case menu of
      1:
        begin
          write('Input number: ');
          readln(i);
          addNode(i);
        end;
      2:
        begin
          i := deleteNode();
          if (i = Low(Integer)) then
            writeln('Heap is empty!')
          else
            writeln('DELETED: ', i);
          Readln;
        end;
      3:
        begin
          printHeap();
          Readln;
        end;
      4: EXIT;
    end;
  until 1 = 0;
end.

