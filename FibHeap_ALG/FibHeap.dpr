program FibHeap;
{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  // Node
  pnode = ^node;
  node = record
    key, degree: integer;
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
  New(heap);
  head^.size := 0;
  head.min := nil;

end;

procedure heapInsert(var heap: pheap; node: pnode);
begin
  if(heapMin(heap) = nil) then
  begin
    //node^.
  end;

end;

function heapMin(heap: pheap): pnode;
begin
  Result := heap^.min;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
end.

