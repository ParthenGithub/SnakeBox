program SnakeBox;
uses crt;

procedure GetKey(var code: integer);
var
    c: char;
begin
    c := ReadKey;
    
    if c = #0 then
    begin
        c := ReadKey;
        code := -ord(c)
    end
    else
    begin
        code := ord(c)
    end;
end;
procedure ShowPlayer(x, y: integer; msg: string);
begin
    GotoXY(x, y);
    TextColor(LightRed);
    write(msg);
    TextColor(White);
end;

procedure HidePlayer(x, y: integer; msg: string);
var 
    len, i: integer;
begin
    len := length(msg);
    GotoXY(x, y);
    for i := 1 to len do
        write(' ');
end;

procedure MovePlayer(var x, y : integer; msg: string; dx, dy: integer);
begin
    if (x + dx >= 2) and (x + dx <= ScreenWidth - 1) 
    and (y + dy >= 2) and (y + dy <= ScreenHeight - 2) then
    begin
        HidePlayer(x, y, msg);
        x := x + dx;
        y := y + dy;
        ShowPlayer(x, y, msg); 
        
    end;
end;

procedure DrawBorders;
var 
    x, y: integer;
begin
    {if not(ScreenWidth mod 2 = 0) then}
    TextColor(White);
        
    for y := 1 to ScreenHeight  do
        for x := 1 to ScreenWidth do
        begin
            if (y = 1) or (x = 1) or (x = ScreenWidth)
             or (y = ScreenHeight - 1) then
            begin
                if not(y = ScreenHeight) then
                begin    
                    GotoXY(x, y);
                    write('#');
                    GotoXY(x - 1, y);
                end;
            end;
        end;
end;

procedure DrawPanel(msg: string);
var 
    x: integer;
begin
    GotoXY(1, ScreenHeight);
    for x := 1 to ScreenWidth - 1 do
        write(' ');
    GotoXY(1, ScreenHeight);
    write(msg);
end;


var
    c: integer;
    CurX, CurY: integer;
    log: text;
const
    Character = '@';
    PanelWelcomePlayer = 'Use WASD/Arrows to move and Escape to leave';

begin
    clrscr;
    DrawBorders;
    DrawPanel(PanelWelcomePlayer);
    MovePlayer(CurX, CurY, Character,
    ScreenWidth div 2, ScreenHeight div 2);
    GotoXY(ScreenWidth, ScreenHeight);
 
    
    
    while True do
    begin
        
        if KeyPressed then
        begin
            GetKey(c);
            DrawPanel('You''re a red player');
        
            case c of
                -75:{Left}
                    MovePlayer(CurX, CurY, Character, -2, 0);
                -77:{Right}
                    MovePlayer(CurX, CurY, Character, 2, 0);
                -72:{Down}
                    MovePlayer(CurX, CurY, Character, 0, -1);
                -80:{Up}
                    MovePlayer(CurX, CurY, Character, 0, 1);
            
                97:{A}
                    MovePlayer(CurX, CurY, Character, -2, 0);
                100:{D}
                    MovePlayer(CurX, CurY, Character, 2, 0);
                119:{S}
                    MovePlayer(CurX, CurY, Character, 0, -1);
                115:{W}
                    MovePlayer(CurX, CurY, Character, 0, 1);
            
                27:{Escape}
                    break;
            end; 
        GotoXY(ScreenWidth, ScreenHeight);
        end;
    
    end;
    write(#27'[0m');
    clrscr;
end.

