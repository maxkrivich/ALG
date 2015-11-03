program FibHeap;
{$APPTYPE CONSOLE}

uses
  SysUtils, Math;

type
  // Node
  TKey = Integer;
  ppnode = ^pnode;
  pnode = ^node;
  node = record
    key: TKey;
    degree: Integer;
    parent, child, left, right: pnode;
    mark: Boolean;
  end;

  // Heap
  pheap = ^heap;
  heap = record
    size: Integer;
    min: pnode;
  end;
const
  DEFAULT_SIZE: Integer = 43;

procedure MakeFib(var head: pheap);
begin
  New(head);
  head^.size := 0;
  head^.min := nil;
end;

function cmp(n0, n1: pnode): Boolean;
begin
  if (n0^.key < n1^.key) then
    Result := True
  else
    Result := False;
end;

procedure Swap(var a, b: pnode);
var
  tmp: pnode;
begin
  tmp := a;
  a := b;
  b := tmp;
end;

function HeapMin(heap: pheap): pnode;
begin
  Result := heap.min;
end;

function NewNode(key: Integer): pnode;
begin
  New(Result);
  Result^.key := key;
  Result^.parent := nil;
  Result^.child := nil;
  Result^.left := Result;
  Result^.right := Result;
  Result^.degree := 0;
  Result^.mark := False;
end;

procedure Insert(var h: pheap; var x: pnode; var rb: ppnode); overload;
begin
  if (rb^ = nil) then
  begin
    rb^ := x;
    x^.left := x;
    x^.right := x;
  end
  else
  begin
    x^.right := rb^.right;
    x^.right^.left := x;
    x^.left := rb^;
    rb^.right := x;
  end;
  if (cmp(x, rb^)) then
    rb^ := x;
  if (rb^ = h^.min) then
  begin
    Inc(h^.size);
    x^.parent := nil;
  end;
end;

procedure Insert(var h: pheap; x: pnode; var rb: ppnode; var p: pnode); overload;
begin
  Insert(h, x, rb);
  if (p <> nil) then
  begin
    Inc(p^.degree);
    x^.parent := p;
  end;
end;

procedure Add(var h: pheap; key: Integer);
var
  tmp: ppnode;
  n: pnode;
begin
  tmp := @h^.min;
  n := NewNode(key);
  Insert(h, n, tmp);
end;

function HeapUnion(h0: pheap; var h1: pheap): pheap;
var
  pl, pr: pnode;
begin
  if (h1^.min = nil) then
    Exit;
  if (h0^.min = nil) then
  begin
    h0^.min := h1^.min;
    h0^.size := h1^.size;
  end
  else
  begin
    pl := h1^.min^.left;
    pr := h0^.min^.right;
    h0^.min^.right := h1^.min;
    h1^.min^.left := h0^.min;
    pl^.right := pr;
    pr^.left := pl;
    Inc(h0^.size, h1^.size);
  end;
  if ((h0^.min = nil) or ((h1^.min <> nil) and cmp(h1^.min, h0^.min))) then
    h0^.min := h1^.min;
  h1^.min := nil;
  h1^.size := 0;
  Result := h0;
end;

procedure LRPointers(var n: pnode);
begin
  if (n^.left <> n) then
  begin
    n^.right^.left := n^.left;
    n^.left^.right := n^.right;
  end;
end;

procedure Cut(var h: pheap; n: pnode);
var
  tmp: ppnode;
  tmpN:pnode;
begin
  Dec(n^.parent^.degree);
  if (n^.right = n) then
    n^.parent^.child := nil
  else
    n^.parent^.child := n^.right;
    if(n<>nil)then
  LRPointers(n);
  tmp := @h^.min;
  Insert(h, n, tmp);
  n^.mark := False;
end;

procedure CascadingCut(var h: pheap; var y: pnode);
var
  z: pnode;
begin
  z := y^.parent;
  if ((z <> nil) and (z^.degree > 0)) then
  begin
    if not (z^.mark) then
      z^.mark := True
    else
    begin
      Cut(h, y);
      CascadingCut(h, z);
    end;
  end;
end;

procedure DeleteRoot(var h: pheap; var n: pnode);
begin
  LRPointers(n);
  Dec(h^.size);
end;

procedure HeapLink(var h: pheap; var y, x: pnode);
var
  tmp: ppnode;
begin
  DeleteRoot(h, y);
  tmp := @x^.child;
  Insert(h, y, tmp, x);
  y^.mark := False;
end;

//TODO: Think about circle
procedure Consolidate(var h: pheap);
var
  A: array of pnode;
  x, y, w: pnode;
  i, d, HEAP_ROOTS, MAX_DEGREE: Integer;
  tmp: ppnode;
begin
  SetLength(A, DEFAULT_SIZE);
  MAX_DEGREE := 0;
  HEAP_ROOTS := h^.size;
  x := h^.min;
  for i := 1 to HEAP_ROOTS do
  begin
    w := x^.right;
    d := x^.degree;
    while (A[d] <> nil) do
    begin
      y := A[d];
      if (cmp(y, x)) then
        Swap(x, y);
      HeapLink(h, y, x);
      A[d] := nil;
      Inc(d);
    end;
    A[d] := x;
    MAX_DEGREE := Max(d, MAX_DEGREE);
    x := w;
  end;
  h^.min := nil;
  h^.size := 0;
  for i := 0 to MAX_DEGREE do
    if (A[i] <> nil) then
    begin
      tmp := @h^.min;
      Insert(h, A[i], tmp);
    end;
end;

function ExtractMin(var h: pheap): TKey;
var
  z: pnode;
begin
  z := h^.min;
  if (z <> nil) then
  begin
    while (z^.child <> nil) do
      Cut(h, z^.child);
    DeleteRoot(h, z);
    if (z^.right = z) then
      h^.min := nil
    else
    begin
      h^.min := h^.min^.right;
      Consolidate(h);
    end;
  end;
  if (z <> nil) then
  begin
    Result := z^.key;
    Dispose(z);
  end
  else
    Result := High(TKey);
end;

procedure DecreaseKey(var h: pheap; var x: pnode; k: Integer);
var
  y: pnode;
begin
  if (k > x^.key) then
    Exit;
  x^.key := k;
  y := x^.parent;
  if ((y <> nil) and cmp(x, y)) then
  begin
    Cut(h, x);
    CascadingCut(h, y);
  end
  else if (cmp(x, h^.min)) then
    h^.min := x;
end;

//TODO: Think about negative infinity (Low(Integer))

procedure HeapDelete(var h: pheap; var x: pnode);
begin
  DecreaseKey(h, x, Low(Integer));
  ExtractMin(h);
end;
var
  i: Integer;
  h: pheap;
  n: pnode;
begin
  { TODO -oUser -cConsole Main : Insert code here }
end.

