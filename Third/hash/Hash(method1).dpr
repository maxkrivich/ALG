program hashTable;
{$APPTYPE CONSOLE}
uses SysUtils;
//TODO: only sample

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

function getHashCode(i:int64; size:integer):int64;
begin
  Result:= trunc(frac(i*((sqrt(5) - 1) / 2))*size);
end;
begin
  Writeln(getKey('mama'));
   Writeln(getHashCode(get('mama'),20));
  readln;
end.
