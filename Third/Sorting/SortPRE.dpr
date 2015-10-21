program Project3;

{$APPTYPE CONSOLE}

uses
  SysUtils, DateUtils, Math;

type
  TArr = array of Integer;

const
  range: Integer = 100;
  DEF_SIZE: Integer = 10;

procedure Swap(var a, b: Integer); assembler; register;
asm
  mov ecx, [eax]
  xchg ecx, [edx]
  mov [eax], ecx
end;

function isSorted(arr: TArr): Boolean;
var
  i: Integer;
begin
  Result := True;
  i := 1;
  while (Result and (i < Length(arr))) do
  begin
    if not (arr[i] >= arr[i - 1]) then
      Result := False;
    Inc(i);
  end;
end;

function getRightChild(var n: Integer): Integer;
begin
  Result := 2 * n + 2;
end;

function getLeftChild(var n: Integer): Integer;
begin
  Result := 2 * n + 1;
end;

procedure gen(var arr: TArr);
var
  i: Integer;
begin
  Randomize;
  for i := Low(arr) to High(arr) do
    arr[i] := Random(range + 100); //- range div 2;
end;

procedure print(arr: TArr);
var
  i: Integer;
begin
  for i := Low(arr) to High(arr) do
    write(arr[i], ' ');
  writeln;
end;

procedure makeHeap(var arr: TArr; iSt, iEn: Integer);
var
  mCh: Integer;
begin
  mCh := getLeftChild(iSt);
  while (mCh < iEn) and (getRightChild(iSt) < iEn) do
  begin
    if (arr[mCh] < arr[getRightChild(iSt)]) then
      Inc(mCh);
    if (arr[iSt] < arr[mCh]) then
      Swap(arr[iSt], arr[mCh]);
    iSt := mCh;
    mCh := getLeftChild(iSt);
  end;
  //print(arr);
end;

procedure heapSort(var arr: TArr);
var
  i: Integer;
begin
  i := (Length(arr) div 2) - 1;
  while (i > -1) do
  begin
    makeHeap(arr, i, Length(arr));
    Dec(i);
  end;
  i := High(arr);
  while (i > -1) do
  begin
    Swap(arr[0], arr[i]);
    makeHeap(arr, 0, i);
    Dec(i);
  end;
end;

procedure MergeSort(var arr: TArr; iSt, iEn: Integer);
var
  iMid, r, l, i: Integer;
  arrTmp: TArr;
begin
  if (iSt < iEn) then
  begin
    SetLength(arrTmp, Length(arr));
    iMid := (iSt + iEn) div 2;
    MergeSort(arr, iSt, iMid);
    MergeSort(arr, iMid + 1, iEn);
    l := iSt;
    r := iMid + 1;
    i := iSt;
    while (i <= iEn) do
    begin
      if (l < iMid + 1) and ((r > iEn) or (arr[l] < arr[r])) then
      begin
        arrTmp[i] := arr[l];
        inc(l);
      end
      else
      begin
        arrTmp[i] := arr[r];
        inc(r);
      end;
      inc(i);
    end;
    for i := iSt to iEn do
      arr[i] := arrTmp[i];
  end;
end;

procedure CountingSort(var arr: TArr);
var
  tmp: TArr;
  i, j, cnt, max, min: Integer;
begin
  max := MaxIntValue(arr);
  min := MInIntValue(arr);
  SetLength(tmp, max - min + 1);
  for i := Low(arr) to High(arr) do
    Inc(tmp[arr[i] - min]);
  j := Low(arr);
  i := min;
  while (i <= max) do
  begin
    while tmp[i - min] > 0 do
    begin
      arr[j] := i;
      Inc(j);
      Dec(tmp[i - min])
    end;
    Inc(i);
  end;
end;

procedure RadixSort(var arr: TArr);
var
  i, j, ex, max, buf: Integer;
begin
  ex := 10;
  max := MaxIntValue(arr);
  while (max / ex > 0) do
  begin
    for i := Low(arr) + 1 to High(arr) do
    begin
      buf := arr[i];
      j := i - 1;
      while (j >= 0) and ((arr[j] mod ex) > (buf mod ex)) do
      begin
        arr[j + 1] := arr[j];
        Dec(j);
      end;
      arr[j + 1] := buf;
    end;
    ex := ex * 10;
  end;

end;

var
  arr: TArr;
  i: Integer;
  t1, t2: TDateTime;

begin
  SetLength(arr, DEF_SIZE);
  gen(arr);
  print(arr);
  t1 := Time();
  RadixSort(arr);
  t2 := Time();
  print(arr);
  Writeln('TOTAL TIME: ', millisecondsbetween(t2, t1));
  Readln;
end.
