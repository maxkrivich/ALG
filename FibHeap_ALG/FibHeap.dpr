program FibHeap;
{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  // Node
  pnode = ^node;
  node = record
    key, degree: Integer;
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
  SIZE: Integer = 32;
  // -------(Make_Fib_Heap)    O(1)   --------

procedure makeFib(var head: pheap);
begin
  New(head);
  head^.size := 0;
  head.min := nil;

end;
// -------(Min_Heap)    O(1)   --------

function heapMin(heap: pheap): pnode;
begin
  Result := heap.min;
end;
// -------(Insert_Heap)    O(1)   --------

procedure insert(var heap: pheap; node: pnode);
begin
  node^.degree := 0;
  node^.parent := nil;
  node^.child := nil;
  node^.left := node;
  node^.right := node;
  node^.mark := False;
  if (heapMin(heap) <> nil) then
  begin
    node^.right := heapMin(heap);
    node^.left := heapMin(heap)^.left;
    heap^.min^.left := node;
    node^.left^.right := node;
    if (node^.key < heapMin(heap)^.key) then
      heap^.min := node;
  end
  else
    heap^.min := node;
  Inc(heap.size);
end;

// --- --

function heapUnion(h1, h2: pheap): pheap;
var
  h: pheap;
begin
  makeFib(h);
  if ((h1 <> nil) and (h2 <> nil)) then
  begin
    h^.min := h1^.min;
    if (h^.min <> nil) then
    begin
      if (h2^.min <> nil) then
      begin
        h^.min^.right^.left := h2^.min^.left;
        h2^.min^.left^.right := h^.min^.right;
        h^.min^.right := h2^.min;
        h2^.min^.left := h^.min;
        if (h2^.min^.key < h1^.min^.key) then
          h^.min := h2^.min;
      end;
    end
    else
      h^.min := h2^.min;
    h^.size := h1^.size + h2^.size;
  end;
  Result := h;
end;
//TODO:write

procedure heap_link(var h: pheap; y, x: pnode);
begin
  Inc(x^.degree);
  y^.mark := False;
end;

//TODO:finish writing

procedure consolidate(var h: pheap);
var
  A: array of pnode;
  d, i: Integer;
  x, y, w: pnode;
begin
  SetLength(A, SIZE);
  x := heapMin(h);
  while (x <> heapMin(h)) do
  begin
    w := x;
    d := x^.degree;
    while (A[d] <> nil) do
    begin
      y := A[d];
      if (x^.key > y^.key) then
      begin
        x := @x xor @y;
        y := @x xor @y;
        x := @x xor @y;
      end;
      heap_link(h, y, x);
      A[d] := nil;
      Inc(d);
    end;
    A[d] := x;
  end;
end;

function extractMin(var heap: pheap): pnode;
var
  z, x: pnode;
begin
  z := heap^.min;
  if (z <> nil) then
  begin
    z^.child^.parent := nil;
    x := z^.child^.right;
    while (x <> z^.child) do
    begin
      x^.parent := nil;
      x := x^.right;
    end;
    //TODO: 6 from book

    z^.left^.right = z^.right;
    z^.right^.left = z^.left;
    if (z = z^.right) then
      heap^.min := nil
    else
    begin
      heap^.min := z^.right;
      // consolidate(h);     //TODO: write  consolidate
    end;
    Dec(heap^.size);
  end;
  Result := z;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
end.

