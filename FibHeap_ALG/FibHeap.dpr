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
  if (heapMin(heap) <> nil) then
  begin
    node^.degree := 0;
    node^.parent := nil;
    node^.child := nil;
    node^.left := node;
    node^.right := node;
    node^.mark := False;
    if (node.key < heapMin(heap).key) then
      heap^.min := node;
  end
  else
    heap^.min := node;
  Inc(heap.size);
end;

// --- --

function heapUnion(h1, h2: pheap):pheap;
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

begin
  { TODO -oUser -cConsole Main : Insert code here }
end.

