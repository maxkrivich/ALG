program laba4;
{$APPTYPE CONSOLE}

uses
  SysUtils, Math;

const
  MAX_VERTEX: Integer = 100;
  INF: Integer = High(Integer);

type
  rec = record
    vertexAmount, startVertex: Integer;
  end;

  pnode = ^node;

  node = record
    v, w: Integer;
    next: pnode;
  end;

var
  g: array of pnode;
  d, p: array of Integer;
  u: array of Boolean;

procedure Init;
var
  i: Integer;
begin
  SetLength(g, MAX_VERTEX);
  SetLength(d, MAX_VERTEX);
  for i := Low(d) to High(d) do
    d[i] := INF;
  SetLength(p, MAX_VERTEX);
  SetLength(u, MAX_VERTEX);
end;

procedure AddEdge(const s, f, w: Integer);
var
  tmp: pnode;
begin
  New(tmp);
  tmp^.v := f;
  tmp^.w := w;
  tmp^.next := g[s];
  g[s] := tmp;
end;

function SizeAt(head: pnode): Integer;
var
  pt: pnode;
begin
  Result := 0;
  pt := head;
  while (pt <> nil) do
  begin
    Inc(Result);
    pt := pt^.next;
  end;
end;

function GetAtIndex(head: pnode; index: Integer): pnode;
var
  i: Integer;
begin
  Result := head;
  i := 0;
  while ((i <> index) and (Result <> nil)) do
  begin
    Inc(i);
    Result := Result^.next;
  end;
end;

function InputFile: rec;
var
  s, f, w: Integer;
begin
  Assign(Input, 'input.txt');
  Reset(Input);
  read(Result.vertexAmount);
  while (True) do
  begin
    read(s, f, w);
    if ((s = f) and (f = w) and (w = 0)) then
      Break;
    AddEdge(s - 1, f - 1, w);
  end;
  read(Result.startVertex);
  Close(Input);
end;

procedure OutputFile;
var
  i: Integer;
begin
  Assign(Output, 'output.txt');
  Rewrite(Output);
{$N+,E-};
  i := Low(d);
  while ((d[i] <> INF) and (i < Length(d))) do
  begin
    Writeln((i + 1), ' ', d[i]);
    Inc(i);
  end;
  Readln;
  Close(Output);
end;

procedure Dijkstra(const s, n: Integer);
var
  i, j, v: Integer;
  tmp: pnode;
begin
  d[s] := 0;
  for i := 0 to n - 1 do
  begin
    v := -1;
    for j := 0 to n - 1 do
      if (not u[j] and ((v = -1) or (d[j] < d[v]))) then
        v := j;
    if (d[v] = INF) then
      Break;
    u[v] := True;
    for j := 0 to SizeAt(g[v]) - 1 do
    begin
      tmp := GetAtIndex(g[v], j);
      if (d[v] + tmp^.w < d[tmp^.v]) then
      begin
        d[tmp^.v] := d[v] + tmp^.w;
        p[tmp^.v] := v;
      end;
    end;
  end;
end;

procedure Way(const s, t: Integer);
type
  pnote = ^note;

  note = record
    v: Integer;
    next: pnote;
  end;
var
  head: pnote;
  v, pr: Integer;
  procedure PushBack(v: Integer);
  var
    pt, tmp: pnote;
  begin
    pt := head;
    if (pt <> nil) then
    begin
      while (pt^.next <> nil) do
        pt := pt^.next;
      New(tmp);
      tmp^.v := v;
      tmp^.next := pt^.next;
      pt^.next := tmp;
    end
    else
    begin
      New(tmp);
      tmp^.v := v;
      tmp^.next := head;
      head := tmp;
    end;
  end;

  procedure PrintWay(root: pnote);
  begin
    if (root = nil) then
      Exit;
    PrintWay(root^.next);
    if (root^.v <> pr) then
      Write(root^.v + 1, '->')
    else
      Write('END WAY');
  end;

begin
  head := nil;
  v := t;
  pr := Low(Integer);
  PushBack(pr);
  while (v <> s) do
  begin
    PushBack(v);
    v := p[v];
  end;
  PushBack(s);
  PrintWay(head);
  Writeln;
end;

procedure WaysFile(const cnt, s: Integer);
var
  i: Integer;
begin
  Assign(Output, 'ways.txt');
  Rewrite(Output);
  for i := Low(d) to cnt - 1 do
    Way(s, i);
  Close(Output);
end;

var
  tmp: rec;
  i: Integer;

begin
  Init;
  tmp := InputFile;
  Dijkstra(tmp.startVertex - 1, tmp.vertexAmount);
  OutputFile;
  WaysFile(tmp.vertexAmount, tmp.startVertex - 1);

end.
