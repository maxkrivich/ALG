program HuffCode;
{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  pnode = ^node;

  node = record
    freq: integer;
    letter: char;
    code: string;
    left, right: pnode;
  end;

  TArr = array of pnode;

var
  huff: TArr;
  i: integer;
  frequency: array[33..122] of integer;
  code: array[33..122] of string;

procedure Sort;
var
  tmp: pnode;    
  i, j: integer;
begin
  for i := 0 to high(huff) - 1 do
    for j := i + 1 to high(huff) do
      if huff[i].freq < huff[j].freq then
      begin
        New(tmp);
        tmp := huff[i];
        huff[i] := huff[j];
        huff[j] := tmp;
      end;
end;

function size: integer;
begin
  Result := 0;
  for i := Low(frequency) to High(frequency) do
    if frequency[i] <> 0 then
      Inc(Result);
end;

procedure Huffman;
var
  p: pnode;
  size: integer;
begin
  size := high(huff);
  while size <> 0 do
  begin
    Sort;
    New(p);
    p.left := huff[size - 1];
    p.right := huff[size];
    p.freq := huff[size - 1].freq + huff[size].freq;
    Dec(size);
    huff[size] := p;
  end;

end;

procedure freq;
var
  f: text;
  tmp: string;
  i, size: integer;
begin
  size := 0;
  Assign(f, 'lt.txt');
  Reset(f);
  while not (Eof(f)) do
  begin
    Readln(f, tmp);
    for i := 1 to Length(tmp) do
      if tmp[i] in ['a'..'z'] then
        Inc(frequency[Ord(tmp[i])]);
  end;
  CloseFile(f);
end;

procedure addLetter(var huff: TArr; lt: char; freq, pos: integer);
begin
  New(huff[pos]);
  huff[pos].letter := lt;
  huff[pos].freq := freq;
  huff[pos].left := nil;
  huff[pos].right := nil;
end;

procedure fillTable;
var
  i, pos: integer;
begin
  SetLength(huff, size);
  pos := Low(huff);
  for i := Low(frequency) to High(frequency) do
    if frequency[i] <> 0 then
    begin
      addLetter(huff, chr(i), frequency[i], pos);
      Inc(pos);
    end;

end;

procedure createCode(root: pnode; s: string);
begin
  if root = nil then
    Exit;
  createCode(root^.left, s + '0');
  if root^.letter <> '' then
  begin
    root^.code := s;
    code[Ord(root^.letter)] := root^.code;
    Writeln(root^.letter, ' ', root^.code, ' ', root^.freq);
  end;
  createCode(root^.right, s + '1');
end;

procedure massage;
var
  f1, f2: text;
  tmp, newStr: string;
  i: integer;
begin
  Assign(f1, 'lt.txt');
  Reset(f1);
  Assign(f2, 'ms.txt');
  Rewrite(f2);
  while not (Eof(f1)) do
  begin
    NewStr := '';
    Readln(f1, tmp);
    for i := 1 to Length(tmp) do
      NewStr := NewStr + code[Ord(tmp[i])];
    Writeln(f2, newStr);
  end;
  CloseFile(f1);
  CloseFile(f2);
end;

begin
  freq;
  fillTable;
  Huffman;
  createCode(huff[0], '');
  massage;
  Readln;
end.

