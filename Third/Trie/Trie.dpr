program Trie;
{$APPTYPE CONSOLE}
uses
  SysUtils;

type
  pnode = ^node;
  node = record
    letter: Char;
    nBro, fCh: pnode;
  end;

procedure createTrie(var root: pnode);
begin
  New(root);
  root^.fCh := nil;
  root^.nBro := nil;
end;

function isLetter(c: char): boolean;
begin
  if (c in ['A'..'Z']) or (c in ['a'..'z']) or (c = '-') or (c = Chr(39)) then
    Result := True
  else
    Result := False;
end;

function find(head: pnode; c: char): pnode;
var
  pt: pnode;
begin
  pt := head;
  while (pt <> nil) do
  begin
    if (pt^.letter = c) then
    begin
      //  Writeln(c, ' Find!');
      Break;
    end;
    pt := pt^.nBro;
  end;
  Result := pt;
end;

function isCorrect(root: pnode; s: string): boolean;
var
  f, n: pnode;
  t: boolean;
  i: Integer;
begin
  s := s + '$';
  t := true;
  n := root;
  i := 1;
  while (t) do
  begin
    f := find(n^.fCh, s[i]);
    if (f = nil) then
    begin
      t := false;
      break;
    end;
    if (f^.letter = '$') then
      break
    else
    begin
      inc(i);
      n := f;
    end;
  end;
  Result := t;
end;

procedure pushFront(var head: pnode; c: char);
var
  p: pnode;
begin
  New(p);
  p^.letter := c;
  p^.fCh := nil;
  p^.nBro := head;
  head := p;
end;

procedure insert(root: pnode; s: string);
var
  i: Integer;
  n, f: pnode;
  t: Boolean;
begin
  n := root;
  if isCorrect(root, s) then
    Exit;
  for i := 1 to Length(s) do
  begin
    f := find(n^.fCh, s[i]);
    if (f = nil) then
    begin
      pushFront(n^.fCh, s[i]);
      f := n^.fCh;
    end;
    n := f;
  end;
  pushFront(n^.fCh, '$');
end;

procedure inputTrie(root: pnode; const d: string);
var
  f: text;
  s: string;
  c: Char;
  i, j: integer;
begin
  Assign(f, d);
  Reset(f);
  s := '';
  while not Eof(f) do
  begin
    while (True) do
    begin
      read(f, c);
      if (isLetter(c)) then
        s := s + c
      else
      begin
        insert(root, s);
        Break;
      end;
    end;
    s := '';
  end;
  Close(f);
end;

procedure printTrie(root: pnode; s: string);
begin
  if (root <> nil) then
  begin
    if (root^.letter = '$') then
      Writeln(s);
    if (root^.nBro <> nil) then
      printTrie(root^.nBro, s);
    if (root^.fCh <> nil) then
      printTrie(root^.fCh, s + root^.letter);
  end;

end;

procedure checkFile(root: pnode; const d: string);
var
  f: text;
  s: string;
  c: Char;
begin
  Assign(f, d);
  Reset(f);
  while not Eof(f) do
  begin
    while (True) do
    begin
      read(f, c);
      if (isLetter(c)) then
        s := s + c
      else
      begin
        if not (isCorrect(root, s)) then
          Writeln(s);
        s := '';
        Break;
      end
    end;
  end;
  close(f);
end;

var
  head: pnode;

begin
  createTrie(head);
  inputTrie(head, 's.txt');
  Writeln(AnsiUpperCase('----- vocabulary -----'));
  printTrie(head, '');
  Writeln(AnsiUpperCase('----- mistake -----'));
  checkFile(head, 'ss.txt');
  readln;
end.

