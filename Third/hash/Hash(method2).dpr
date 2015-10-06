program hashTable;
{$APPTYPE CONSOLE}
uses
  SysUtils;
// TODO: works, but raw for working 
type rec = record
      key:int64;
      info:string[15];
     end;
   pnode = ^node;
   node = record
    val:rec;
    next:pnode;
    end;

var arr:array of pnode;
    head, p:pnode;
    f: file of rec;
    t:rec;
    i:integer;

function getHashCode(key:int64; size:integer):int64;
begin
  Result:= key mod size;
end;

function getKey(const s:string):int64;
var i, j:integer;
    res: int64;
begin
 j:=length(s) - 1;
 res:=0;
for i:= 1 to length(s) do
 begin
 res:= res + ( (1 shl (j * 8)) * ord(s[i]) );
 Dec(j);
 end;
 Result:=res;
end;

procedure pushFront(var head: pnode; n: rec);
var
  p: pnode;
begin
  New(p);
  p^.val := n;
  p^.next := head;
  head := p;
end;

procedure addNode(const s:rec);
begin
  pushFront(arr[getHashCode(s.key, length(arr))], s);
end;

procedure print(s:pnode);
begin
while (s<>nil) do
begin
 writeln(s^.val.info, ' ',s^.val.key) ;
 s:= s^.next;
 end;
end;

begin
  SetLength(arr, 2);
  {t.info := 'mamka';
  t.key:= getKey(t.info);
  Assign( f,'D:\ff.txt');
  Rewrite(f);
  Write(f,t);
  t.info := 'dsfsd';
  t.key:= getKey(t.info);
  Write(f, t);
  t.info := 'mamka';
  t.key:= getKey(t.info);
  Write(f, t);
  Close(f); }
  Assign( f,'D:\ff.txt');
  Reset(f);
  while not(EOF(f)) do
   begin
   read(f,t);
   addNode(t);
   end;
   close(f);
   for i:= low (arr) to high(arr) do
     print(arr[i]);
     readln;
  Writeln(getKey('mamka'));
  Writeln(getHashCode(getKey('mamka'),20));
  readln;
end.
