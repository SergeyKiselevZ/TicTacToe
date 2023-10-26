program TicTacToe;
uses crt;
type
	PlayingField = array [1..3] of array [1..3] of char;

procedure drawField(field: PlayingField);
var
	i, j: integer;
	saveStyle: integer;
begin
	saveStyle := TextAttr;
	writeln('____________');
	for i := 1 to 3 do
	begin
		write('|');
		for j := 1 to 3 do
		begin
			if (field[i][j] = 'X') or (field[i][j] = 'O') then
				TextColor(2);
			write(' ', field[i][j]);
			TextAttr := saveStyle;
			write(' |')
		end;
		writeln
	end;
	writeln('____________')
end;

function win(field: PlayingField): boolean;
var
		{Линии победы, в виде координат каждой клетки}
	victories: array[1..8] of array [1..3] of integer = ((11, 12, 13),
													    (21, 22, 23),
														(31, 32, 33),
														(11, 21, 31),
														(12, 22, 32),
														(13, 23, 33),
														(11, 22, 33),
														(31, 22, 13));
	i: integer;
begin
	win := false;
	for i := 1 to 8 do
	begin
		if (field[victories[i][1] div 10][victories[i][1] mod 10] = 'X') and 
			(field[victories[i][2] div 10][victories[i][2] mod 10] = 'X') and 
			(field[victories[i][3] div 10][victories[i][3] mod 10] = 'X') then
			win := true;
		if (field[victories[i][1] div 10][victories[i][1] mod 10] = 'O') and
			(field[victories[i][2] div 10][victories[i][2] mod 10] = 'O') and 
			(field[victories[i][3] div 10][victories[i][3] mod 10] = 'O') then
			win := true
	end
end;

procedure changeCell(var field: PlayingField; x, y: integer; s: char; var status: boolean);
begin
	{Проверка на занятость поля}
	if (field[x][y] = 'O') or (field[x][y] = 'X') then
	begin
		writeln('Sorry, cell is busy');
		status := false
	end
	else
		field[x][y] := s
end;

procedure changeField(var field: PlayingField; num: integer; s: char; var status: boolean);
begin
	case num of
		1..3: begin
			changeCell(field, 1, num, s, status);
		end;
		4..6: begin 
			changeCell(field, 2, num-3, s, status);
		end;
		7..9: begin
			changeCell(field, 3, num-6, s, status);
		end;
	end
end;
{Главная часть}
var
	field: PlayingField = (('1', '2', '3'), ('4', '5', '6'), ('7', '8', '9'));
	num: integer;
	sprites: array [1..2] of char = ('X', 'O');
	sprite: integer = 1;
	c: integer;
	status: boolean = true;
begin
	clrscr;
	while true do
	begin
		status := true;
		drawField(field);
		writeln('(Type ''10'' for exit)');
		writeln('(', sprites[sprite], ' move)');
		read(num);
		if num = 10 then
			break;
		changeField(field, num, sprites[sprite], status);
		if win(field) then
		begin
			writeln(sprites[sprite], ' win');
			break
		end;
		if not status then
			continue;
		if sprite = 1 then
			sprite := 2
		else
			sprite := 1;
		clrscr
	end
end.
