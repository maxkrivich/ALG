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
procedure makeFib(head: pheap);
begin
  head^.size := 0;
  head.min := Nil;

end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
end.
