unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.MPlayer;

type
  TForm4 = class(TForm)
    ImageScene: TImage;
    TimerColorChange: TTimer;
    TimerHand: TTimer;
    TimerFonMotion: TTimer;
    Pause: TTimer;
    Play: TTimer;
    MediaPlayer1: TMediaPlayer;
    Titres: TTimer;
    procedure TimerFonMotionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerColorChangeTimer(Sender: TObject);
    procedure TimerHandTimer(Sender: TObject);
    function DisplayNextLineVysotsky:string;
    procedure PauseTimer(Sender: TObject);
    procedure PlayTimer(Sender: TObject);
    procedure TitresTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  THuman = class
    headr: Integer;
    bodyup: TPoint;
    Bodydown: TPoint;
    rightarm: TPoint;
    leftarm: TPoint;
    rightleg: TPoint;
    leftleg: TPoint;
    source: TBitmap;

  const
    arm1 = 60;
    arm2 = 50;
    leg1 = 35;
    leg2 = 45;
    xc = 200;
    yc = 200;
    linewidth = 4;
    constructor Create;
  public
    procedure setrarm(x, y: Integer);
    procedure setlarm(x, y: Integer);
    procedure setrleg(x, y: Integer);
    procedure setlleg(x, y: Integer);
    procedure setbodyup(x, y: Integer);
    procedure draw(dest: TCanvas; x, y: Integer);
    function FindThirdPoint(var P0, P1: TPoint; a, b: double;
      clockwise: boolean; gravity: boolean): TPoint;
    procedure DrawWithGuitar(guitarsource: TBitmap; x, y: Integer);
  private
    procedure redraw();
  end;

  Tframe = 0 .. 100;

  TGuitar = class
    Body: TArray<TPoint>;
    bridge: TArray<TPoint>;
    Grif: TArray<TPoint>;
    Head: TArray<TPoint>;
    Hole: TArray<TPoint>;
    Peg: TArray<TPoint>;
    Line: TArray<TPoint>;
    lineframe: Tframe;
    cosa, sina: double;
    source: TBitmap;

  const
    xc = 100;
    yc = 100;
  public
    constructor Create;
    procedure draw(dest: TCanvas; x, y: Integer; newlineframe: Integer);
    procedure rotate(angle: double);
    procedure changelineframe(frame: Integer);

  private
    procedure redraw();
    procedure newpoints();
  end;

var
  point1, point2, point3: TPoint;
  t: Integer;
  h, h2: THuman;
  g: TGuitar;
  guitx, guity, CL: Integer;
  guitangle: double;
  Form4: TForm4;
  Bmp, Bmp1 : TBitMap;
  ii : Integer;
  Col: array[1..6] of TColor;
  UpRect, FonRect1, FonRect2, LRect, RRect : TRect;
  FVysotsky, FTitres: TextFile;
  Line: string;
  FL : Boolean;
  lhandpos: integer;

implementation

{$R *.dfm}

Procedure Circles(Xc, Yc : Integer; BmpX : TBitMap);
var
  i, Radius, N, X1, X2, Y1, Y2: Integer;
  alpha : double;
begin
  Radius := Random(4) + 26;
  N := Random(3) + 35;
  for i := 0 to N - 1 do
    begin
      alpha := i * 2 * Pi / N;

      X1 := Round(Xc - Radius * cos(alpha));
      Y1 := Round(Yc - Radius * sin(alpha));
      X2 := Round(Xc + Radius * cos(alpha));
      Y2 := Round(Yc + Radius * sin(alpha));

      BmpX.Canvas.MoveTo(X1, Y1);
      BmpX.Canvas.LineTo(X2, Y2);
    end;
end;

Procedure DoubtfulProcedure(ColorLocal : TColor; i, j : Integer);
begin
  Bmp.Canvas.Pen.Color := ColorLocal;
  Bmp.Canvas.MoveTo(i, 0);
  Bmp.Canvas.LineTo(j, 400);
end;


procedure TForm4.FormCreate(Sender: TObject);
begin
MediaPlayer1.FileName :=
    'C:\Users\User\Desktop\Лабы ОАиП\Лаба мультик\Songs\Vysotsky.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.Play;
Line:='';
AssignFile(FVysotsky,
    ExtractFilePath(Application.ExeName)+'Lyrics\Vysotsky.txt');
  Reset(FVysotsky);
FL := True;
Bmp := TBitmap.Create;
Bmp1 := TBitmap.Create;
Bmp1.Width := ImageScene.Width;
Bmp1.Height := ImageScene.Height;
Bmp1.Canvas.Pen.Color := clGray;
Bmp1.Canvas.Brush.Color := clGray;
Bmp1.Canvas.FillRect(Rect(0, 0, Bmp1.Width, Bmp1.Height));
Bmp1.Canvas.Pen.Color := clWhite;
Bmp1.Canvas.Brush.Color := $00460300;
Bmp1.Canvas.Ellipse(0, Screen.Height - 405, Screen.Width, Screen.Height - 155);
Bmp1.Canvas.Pen.Color := $00460300;
Bmp1.Canvas.Brush.Color := $00460300;
Bmp1.Canvas.Rectangle(0, Screen.Height - 460, Screen.Width, Screen.Height - 280);
Bmp1.Canvas.Pen.Color := clWhite;
Bmp1.Canvas.Brush.Color := $009FEE9B;
Bmp1.Canvas.Ellipse(0, Screen.Height - 490, Screen.Width, Screen.Height - 370);
Bmp1.Canvas.Pen.Color := $009FEE9B;         //$00A8D6E1
Bmp1.Canvas.Brush.Color := $009FEE9B;
Bmp1.Canvas.Rectangle(0, Screen.Height - 680, Screen.Width, Screen.Height - 430);
FonRect1 := Rect(0, Screen.Height - 680, Screen.Width, Screen.Height);

Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 50, 50, Screen.Height - 430);
LRect := Rect(0, 50, 50, Screen.Height - 430);        //Шторки

t := 0;
  guitangle := -0.4;
  guitx := 20;
  guity := -30;
  h := THuman.Create();
  g := TGuitar.Create();
  h2 := THuman.Create();
  g.rotate(guitangle);
  h.setbodyup(10, -70);
  h.setlleg(20, 100);
  h.setrleg(-20, 100);
  h.setlarm(guitx + Round(60 * cos(guitangle)),
    guity + Round(60 * sin(guitangle)));
  h.DrawWithGuitar(g.source, guitx, guity);


Bmp1.Canvas.Rectangle(Screen.Width - 60, 50, Screen.Width, Screen.Height - 430);
RRect := Rect(Screen.Width - 60, 50, Screen.Width, Screen.Height - 430);
Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 0, Screen.Width, 40);
UpRect := Rect(0, 0, Screen.Width, 40);
ii := 0;


end;

procedure TForm4.TimerHandTimer(Sender: TObject);
  var
  rhandframe, cosrh, swinglength: double;
  framelength, l: Integer;
begin
  Inc(t);

  framelength := 15;
  l := 6;

  swinglength := 0.5;
  rhandframe := (t mod framelength) / framelength;
  if rhandframe < swinglength then
    cosrh := cos(rhandframe * PI / (swinglength))
  else
    cosrh := -cos((rhandframe - swinglength) * PI / (1 - swinglength));
  h.setrarm(guitx + Round(8 * cos(guitangle)),
    guity + -1 + Round(8 * sin(guitangle)) - Round(l * cosrh));
  h.DrawWithGuitar(g.source, guitx, guity);
end;

procedure TForm4.TitresTimer(Sender: TObject);
begin
  Canvas.Textout(50, 50, Line);
end;

procedure TForm4.PauseTimer(Sender: TObject);
begin
  Pause.Enabled:=False;
  Play.Enabled:=True;
end;

function TForm4.DisplayNextLineVysotsky:string;
var TempLine: string;
begin
  if not Eof(FVysotsky) then
  begin
    lhandpos:=(random(2)+4)*14;
    h.setlarm(guitx+Round(lhandpos*cos(guitangle)),guity+Round(lhandpos*sin(guitangle)));
    h.DrawWithGuitar(g.source, guitx, guity);
    Readln(FVysotsky, TempLine);
    if TempLine<>'' then
    Result:= TempLine
    else
    Result:=Line;
  end
  else
  begin
    CloseFile(FVysotsky);
    Play.Enabled := False;
    TimerHand.Enabled:=False;
    Titres.Enabled:=True;
    ii:=0;
    Fl:= False;
    AssignFile(FTitres, ExtractFilePath(Application.ExeName)+'Lyrics\Vysotsky.txt');
  end;
end;

procedure TForm4.PlayTimer(Sender: TObject);
begin
  Line:=DisplayNextLineVysotsky;
end;

procedure TForm4.TimerColorChangeTimer(Sender: TObject);
var
  ind : Integer;
begin
  for ind := Low(Col) to High(Col) do
    Col[ind] := RGB(Random(255), Random(255), Random(255));
end;

procedure TForm4.TimerFonMotionTimer(Sender: TObject);
var
  i, j, Radius, Xc, Yc, N, X1, Y1, X2, Y2 : Integer;
  alpha : double;

begin
    if FL then
      CL := 872
    else
      CL := Trunc(Screen.Width / 2);
    Bmp.Width := ImageScene.Width;
    Bmp.Height := ImageScene.Height;
    Bmp.Canvas.Pen.Color := clGray;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Rectangle(0, 0, Bmp.Width, Bmp.Height);
    Bmp.Canvas.Font.Name := 'Arial';
    Bmp.Canvas.Font.Size := 13;
    i := 0;
    while i <= Screen.Width do
      begin
        if i <= Trunc(Screen.Width / 2) then
          begin
            DoubtfulProcedure(Col[1], i, Trunc(Screen.Width / 2) - i);
            DoubtfulProcedure(Col[2], Trunc(Screen.Width / 2) + i, Screen.Width - i);
          end;
        DoubtfulProcedure(Col[3], i + 10, Screen.Width - i - 10);
        DoubtfulProcedure(Col[4], i, Screen.Width - i);
        if i <= 400 then
          begin
            Bmp.Canvas.Pen.Color := Col[5];
            Bmp.Canvas.MoveTo(0, i);
            Bmp.Canvas.LineTo(Screen.Width, Screen.Height - 680 - i);
          end;
        Inc(i, 20);
      end;
    Bmp.Canvas.CopyRect(FonRect1, Bmp1.Canvas, FonRect1);

    Bmp.Canvas.Pen.Color := $003E3E31;         //$00A8D6E1
    Bmp.Canvas.Brush.Color := $003E3E31;
    i := Random(2);
    Bmp.Canvas.Ellipse(50 + i, Screen.Height - 810 + i, 100 + i, Screen.Height - 480  + i);    //
    Bmp.Canvas.Ellipse(150 + i, Screen.Height - 810 + i, 200 + i, Screen.Height - 480  + i);   //Левая колонка фон
    Bmp.Canvas.Rectangle(75 + i, Screen.Height - 810 + i, 175 + i, Screen.Height - 480 + i);  //
    i := Random(2);
    Bmp.Canvas.Ellipse(Screen.Width - 210 + i, 270 + i, Screen.Width - 160 + i,   Screen.Height - 480 + i);  //
    Bmp.Canvas.Ellipse(Screen.Width - 110 + i, 270 + i, Screen.Width - 60  + i,   Screen.Height - 480 + i);  //Правая колонка фон
    Bmp.Canvas.Rectangle(Screen.Width - 185 + i, 270 + i, Screen.Width - 85 + i,   Screen.Height - 480 + i);//


    Bmp.Canvas.Pen.Color := clBlack;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Pen.Width := 12 + Random(6);
    Bmp.Canvas.Ellipse(90, Screen.Height - 770, 160, Screen.Height - 700);
    Bmp.Canvas.Ellipse(90, Screen.Height - 620, 160, Screen.Height - 550);
    Bmp.Canvas.Ellipse(Screen.Width - 170, Screen.Height - 770,  Screen.Width - 100, Screen.Height - 700);   //Êðóãè êîëîíêè ñïðàâà (âåðõ)
    Bmp.Canvas.Ellipse(Screen.Width - 170, Screen.Height - 620,  Screen.Width - 100, Screen.Height - 550);

    Bmp.Canvas.Pen.Width := 1;
    Bmp.Canvas.Pen.Color := $003E3E31;
    Circles(125, Screen.Height - 735, Bmp);
    Circles(125, Screen.Height - 585, Bmp);
    Circles(Screen.Width - 135, Screen.Height - 735, Bmp);
    Circles(Screen.Width - 135, Screen.Height - 585, Bmp);
    h.draw(Bmp.canvas, Screen.Width div 2, Screen.Height div 2);

    if ii <= CL then
      begin
        inc(ii, 4);
        if Fl then
        begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 40, Trunc(Screen.Width / 2) - ii, Screen.Height - 430);   //Раздвигающиеся шторки
        Bmp.Canvas.Rectangle(Trunc(Screen.Width / 2) + ii, 40, Screen.Width, Screen.Height - 430);
        end
        else
        begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 40, ii, Screen.Height - 430);   //Раздвигающиеся шторки
        Bmp.Canvas.Rectangle(Screen.Width, 40, Screen.Width - ii, Screen.Height - 430);
        end;
        if ii > Trunc(Screen.Width / 2)  then
          TimerFonMotion.Enabled := False
      end
    else
      begin
        Bmp.Canvas.CopyRect(LRect, Bmp1.Canvas, LRect);
        Bmp.Canvas.CopyRect(RRect, Bmp1.Canvas, RRect);
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Ellipse(-50, -200, 100, 300);
        Bmp.Canvas.Ellipse(Screen.Width + 50, -200, Screen.Width - 100, 300);
      end;
  Bmp.Canvas.Font.Color:=clBlack;
  Bmp.Canvas.Brush.Color := clWhite;
  Bmp.Canvas.CopyRect(UpRect, Bmp1.Canvas, UpRect);
  if Line<>'' then
  Bmp.Canvas.Ellipse(ClientWidth div 2 - 80, 100, ClientWidth div 2 + 380, 230);
  Bmp.Canvas.TextOut(950, 140, Line);

  ImageScene.Picture.Bitmap.Assign(Bmp);

end;

{ THuman }

constructor THuman.Create;
begin
  inherited;
  headr := 20;
  bodyup := Point(0, -80);
  Bodydown := Point(0, 0);
  rightarm := Point(10, -30);
  leftarm := Point(50, -90);
  rightleg := Point(-30, 90);
  leftleg := Point(+30, 90);
  source := TBitmap.Create(400, 400);
  source.Transparent := true;
  source.Canvas.Pixels[0, 0]:=clWhite;
  redraw();
end;

function THuman.FindThirdPoint(var P0, P1: TPoint; a, b: double;
  clockwise: boolean; gravity: boolean): TPoint;
const
  sign: array [boolean] of Integer = (-1, 1);
var
  c, c1, cos1, cosc, sinc: double;
  x, y: double;
begin
  c1 := sqrt((P0.x - P1.x) * (P0.x - P1.x) + (P0.y - P1.y) * (P0.y - P1.y));
  if (c1 > a + b) or (b > a + c1 + 0.1) or (a > b + c1) then
  begin
    c := a + b;
  end
  else
    c := c1;
  cos1 := (a * a + c * c - b * b) / (2 * a * c);
  sinc := (P1.y - P0.y) / c1;
  cosc := (P1.x - P0.x) / c1;
  x := a * cos1;
  y := a * sqrt(1 - cos1 * cos1);
  if not gravity then
    y := y * sign[clockwise]
  else
    y := y * sign[cosc > 0];
  result.x := P0.x + Round(x * cosc - y * sinc);
  result.y := P0.y + Round(x * sinc + y * cosc);
end;

procedure THuman.draw(dest: TCanvas; x, y: Integer);
begin
  dest.draw(x - xc, y - yc, source);
end;

procedure THuman.DrawWithGuitar(guitarsource: TBitmap; x, y: Integer);
var
  center, temp: TPoint;

begin
  center.x := xc;
  center.y := yc;
  with source.canvas do
  begin
    brush.color := clWhite;
    pen.color := clWhite;
    pen.Width := linewidth;
    Rectangle(-1, -1, 400, 400);
    brush.color := RGB(255, 254, 255);
    pen.color := clBlack;
    PolyLine([center + Bodydown, center + bodyup]);
    Ellipse(Rect(center + bodyup + Point(-headr, -headr * 2),
      center + bodyup + Point(headr, 0)));
    PolyLine([center + Bodydown, center + FindThirdPoint(Bodydown, rightleg,
      leg1, leg2, true, false), center + rightleg]);
    PolyLine([center + Bodydown, center + FindThirdPoint(Bodydown, leftleg,
      leg1, leg2, false, false), center + leftleg]);
    temp := center + FindThirdPoint(bodyup, leftarm, arm1, arm2, false, true);
    PolyLine([center + bodyup, temp]);
    PolyLine([temp, center + leftarm]);
    draw(x - 100 + xc, y - 100 + yc, guitarsource);
    PolyLine([center + bodyup, center + FindThirdPoint(bodyup, rightarm, arm1,
      arm2, true, false), center + rightarm]);
    PolyLine([center + leftarm, Point((temp.x + center.x + leftarm.x) div 2,
      (temp.y + center.y + leftarm.y) div 2)]);

  end;
end;

procedure THuman.redraw();

var
  center: TPoint;
begin
  center.x := xc;
  center.y := yc;
  with source.canvas do
  begin
    brush.color := clWhite;
    pen.color := clWhite;
    pen.Width := linewidth;
    Rectangle(-1, -1, 300, 300);
    brush.color := RGB(255, 254, 255);
    pen.color := clBlack;
    PolyLine([center + Bodydown, center + bodyup]);
    Ellipse(Rect(center + bodyup + Point(-headr, -headr * 2),
      center + bodyup + Point(headr, 0)));
    PolyLine([center + bodyup, center + FindThirdPoint(bodyup, rightarm, arm1,
      arm2, true, false), center + rightarm]);
    PolyLine([center + bodyup, center + FindThirdPoint(bodyup, leftarm, arm1,
      arm2, false, false), center + leftarm]);
    PolyLine([center + Bodydown, center + FindThirdPoint(Bodydown, rightleg,
      leg1, leg2, true, false), center + rightleg]);
    PolyLine([center + Bodydown, center + FindThirdPoint(Bodydown, leftleg,
      leg1, leg2, false, false), center + leftleg]);
  end;
end;

procedure THuman.setbodyup(x, y: Integer);
begin
  bodyup.x := x;
  bodyup.y := y;
end;

procedure THuman.setlarm(x, y: Integer);
var
  c: double;
begin
  c := sqrt((x - bodyup.x) * (x - bodyup.x) + (y - bodyup.y) * (y - bodyup.y));
  if c > arm1 + arm2 then
  begin
    x := bodyup.x + Round((x - bodyup.x) * (arm1 + arm2) / c);
    y := bodyup.y + Round((y - bodyup.y) * (arm1 + arm2) / c);
  end;
  leftarm.x := x;
  leftarm.y := y;
  redraw();
end;

procedure THuman.setlleg(x, y: Integer);
var
  c: double;
begin
  c := sqrt((x - Bodydown.x) * (x - Bodydown.x) + (y - Bodydown.y) *
    (y - Bodydown.y));
  if c > leg1 + leg2 then
  begin
    x := Bodydown.x + Round((x - Bodydown.x) * (arm1 + arm2) / c);
    y := Bodydown.y + Round((y - Bodydown.y) * (arm1 + arm2) / c);
  end;
  leftleg.x := x;
  leftleg.y := y;
  redraw();
end;

procedure THuman.setrarm(x, y: Integer);
var
  c: double;
begin
  c := sqrt((x - bodyup.x) * (x - bodyup.x) + (y - bodyup.y) * (y - bodyup.y));
  if c > arm1 + arm2 then
  begin
    x := bodyup.x + Round((x - bodyup.x) * (arm1 + arm2) / c);
    y := bodyup.y + Round((y - bodyup.y) * (arm1 + arm2) / c);
  end;
  rightarm.x := x;
  rightarm.y := y;
  redraw();
end;

procedure THuman.setrleg(x, y: Integer);
var
  c: double;
begin
  c := sqrt((x - Bodydown.x) * (x - Bodydown.x) + (y - Bodydown.y) *
    (y - Bodydown.y));
  if c > leg1 + leg2 then
  begin
    x := Bodydown.x + Round((x - Bodydown.x) * (arm1 + arm2) / c);
    y := Bodydown.y + Round((y - Bodydown.y) * (arm1 + arm2) / c);
  end;
  rightleg.x := x;
  rightleg.y := y;
  redraw();
end;

constructor TGuitar.Create;
begin
  inherited;
  newpoints();
  lineframe := 0;
  sina := 0;
  cosa := 1;
  source := TBitmap.Create(200, 200);
  source.Transparent := true;
  redraw();
end;

procedure TGuitar.redraw();

  function add(const a: TArray<TPoint>; x1, y1: Integer; flip: boolean)
    : TArray<TPoint>;
  var
    j, x, y: Integer;
  begin
    Setlength(result, Length(a));
    for j := Low(a) to High(a) do
    begin
      result[j] := a[j] + Point(x1, y1 - 2 * (a[j].y + y1) * Ord(flip));
      x := Round(result[j].x * cosa - result[j].y * sina);
      y := Round(result[j].x * sina + result[j].y * cosa);
      result[j] := Point(x, y) + Point(xc, yc);
    end;
  end;

var
  i, k: Integer;
begin
  with source do
  begin
    canvas.pen.color := clWhite;
    canvas.brush.color := clWhite;
    canvas.Rectangle(0, 0, 200, 200);
    canvas.pen.color := clBlack;
    canvas.PolyBezier(add(Body, 0, 0, false));

    canvas.brush.color := RGB(47, 27, 28);
    canvas.Polygon(add(bridge, 0, 0, false));

    canvas.brush.color := RGB(65, 65, 65);
    canvas.Polygon(add(Grif, 0, 0, false));

    canvas.brush.color := RGB(108, 31, 5);
    canvas.Polygon(add(Head, 0, 0, false));

    canvas.brush.color := RGB(26, 19, 9);
    canvas.Ellipse(xc - 8, yc - 8, xc + 8, yc + 8);

    canvas.brush.color := RGB(225, 165, 105);
    canvas.FloodFill(xc - Round(12 * cosa), yc - Round(12 * sina), clBlack,
      fsBorder);

    canvas.brush.color := RGB(169, 169, 169);
    for i := 0 to 2 do
    begin
      canvas.Polygon(add(Peg, 7 * i, 0, false));
      canvas.Polygon(add(Peg, 7 * i, 0, true));
    end;
    canvas.pen.color := RGB(255, 254, 255);
    for i := 0 to 2 do
      for k := 0 to 3 do
        canvas.PolyBezier(add(Line, 27 * k, i * 3, false));
  end
end;

procedure TGuitar.rotate;
begin
  sina := sin(angle);
  cosa := cos(angle);
  redraw();
end;

procedure TGuitar.changelineframe;
begin
  if frame <> lineframe then
  begin
    lineframe := frame;
    if frame > 2 then
    begin
      Line[1].y := 3 * (frame mod 2) - 3;
      Line[2].y := -3 * (frame mod 2) - 3;
    end
    else
    begin
      Line[2].y := 3 * (frame mod 2) - 3;
      Line[1].y := -3 * (frame mod 2) - 3;
    end;
    redraw();
  end;
end;

procedure TGuitar.draw;
begin
  dest.draw(x - xc, y - yc, source);
end;

procedure TGuitar.newpoints;
begin
  Body := [Point(-40, -28), Point(-20, -30), Point(-8, -12), Point(8, -23),
    Point(28, -23), Point(28, 23), Point(8, 23), Point(-8, 12), Point(-20, 30),
    Point(-30, 28), Point(-56, 28), Point(-56, -28), Point(-40, -28)];
  bridge := [Point(-29, -14), Point(-26, -14), Point(-26, 14), Point(-29, 14)];
  Grif := [Point(3, -5), Point(74, -5), Point(74, 5), Point(3, 5)];
  Head := [Point(74, -6), Point(97, -6), Point(97, 6), Point(74, 6)];
  Peg := [Point(76, -9), Point(79, -9), Point(79, -7), Point(76, -7)];
  Line := [Point(-27, -3), Point(-14, -3), Point(-14, -3), Point(0, -3)];
end;



  end.
