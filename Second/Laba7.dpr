program Laba27;
{$APPTYPE CONSOLE}
uses SysUtils, Windows;
type
  pers = record
    lname, fname: string;
    labs: byte;
  end;
  pnode = ^node;
  node = record
    per: pers;
    left, right: pnode;
  end;

procedure cls;
var
  cursor: COORD;
  r: cardinal;
begin
  r := 300;
  cursor.X := 0;
  cursor.Y := 0;
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 80 * r,
    cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cursor);
end;

function input: pers;
var
  n: pers;
begin
  Cls;
  write('Введите фамилию студента: ');
  Readln(n.lname);
  write('Введите имя студента: ');
  Readln(n.fname);
  write('Введите кол-во сделанных лаботаторных работ: ');
  Readln(n.labs);
  Readln;
  Cls;
  Result := n;
end;

function menu: byte;
var
  n: byte;
begin
  Writeln('1.Добавить нового студента');
  Writeln('2.Найти студента по фамилии');
  Writeln('3.Удалить студента по фамилии');
  Writeln('4.Вывести студентов по алфамиту расположенных после данного');
  Writeln('5.Распечатать всех студентов по алфавиту');
  Writeln('6.Выход из программы');
  Writeln;
  write('  Сделайте свой выбор: ');
  Readln(n);
  cls;
  result := n;
end;

procedure AddNode(var root: pnode; val: pers);
begin
  if root = nil then
  begin
    New(root);
    root^.per := val;
    root^.left := nil;
    root^.right := nil;
  end
  else
  begin
    if root^.per.lname < val.lname then
      AddNode(root^.right, val)
    else
      AddNode(root^.left, val);
  end;
end;

procedure PrintTree1(root: pnode);
begin
  if root = nil then
    exit;
  PrintTree1(root^.left);
  Writeln(root^.per.lname, ' ', root^.per.fname, ' ', root^.per.labs);
  PrintTree1(root^.right);
end;

function FindeNode(root: pnode; val: string): pnode;
begin
  if root = nil then
  begin
    Result := nil;
    Exit;
  end;
  if val < root^.per.lname then
    Result := FindeNode(root^.left, val)
  else if val > root^.per.lname then
    Result := FindeNode(root^.right, val)
  else
    Result := root;
end;

procedure PrintTree2(root: pnode; val: string);
begin
  if root = nil then
    exit;
  if val > root^.per.lname then
    PrintTree2(root^.right, val)
  else if val <= root^.per.lname then
  begin
    PrintTree2(root^.left, val);
    Writeln(root^.per.lname, ' ', root^.per.fname, ' ', root^.per.labs);
    PrintTree2(root^.right, val);
  end;
end;

function Delete(var root: pnode): pers;
var
  tmp: pnode;
begin
  if root^.left = nil then
  begin
    Delete := root.per;
    tmp := root;
    root := root^.right;
    dispose(tmp);
  end
  else
    Delete(root^.left);
end;

procedure DeleteNode(var root: pnode; val: string);
var
  tmp: pnode;
begin
  if root = nil then
    exit;
  if val < root^.per.lname then
    DeleteNode(root^.left, val)
  else if val > root^.per.lname then
    DeleteNode(root^.right, val)

  else if (root^.left = nil) and (root^.right = nil) then
  begin
    dispose(root);
    root := nil;
  end

  else if (root^.left <> nil) and (root^.right = nil) then
  begin
    tmp := root^.left;
    dispose(root);
    root := tmp;
  end

  else if (root^.left = nil) and (root^.right <> nil) then
  begin
    tmp := root^.right;
    dispose(root);
    root := tmp;
  end
  else
    root.per := Delete(root^.right);

end;

var
  root, f: pnode;
  p: Integer;
  v: string;
begin
  root := nil;
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  repeat
    cls;
    case menu of
      1: AddNode(root, input);
      2:
        begin
          write('Введите фамилию студента: ');
          Readln(v);
          Writeln;
          f := FindeNode(root, v);
          if f = nil then
            Writeln('Такого студента в дереве нету! ={')
          else
            Writeln(f^.per.lname, ' ', f^.per.fname, ' ', f^.per.labs);
          Readln;
        end;
      3:
        begin
          write('Введите фамилию студента: ');
          Readln(v);
          DeleteNode(root, v);
        end;
      4:
        begin
          write('Введите фамилию студента: ');
          Readln(v);
          PrintTree2(root, v);
        end;
      5:
        begin
          if root = nil then
            Writeln('Пустое дерево');
          PrintTree1(root);
          readln;
        end;
      6: Exit;
    end;
  until 1 = 0;
end.

