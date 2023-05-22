unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.DateUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uHuman;

type
  TForm4 = class(TForm)
    Image1: TImage;
    TimerFonMotion: TTimer;
    Timercolors: TTimer;
    TimerForShtorki: TTimer;
    TimerforHuman: TTimer;
    procedure TimerFonMotionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure DrawFons(Size, XPL, YPL : Integer; BmpX : TBitmap);
    procedure BitmapCreate(var BmpX : TBitmap);
    procedure TimercolorsTimer(Sender: TObject);
    procedure TimerForShtorkiTimer(Sender: TObject);
    procedure TimerforHumanTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  Siz = 5;
var
  Form4: TForm4;
  Bmp, Bmp1, Bmp2 : TBitMap;
  FonRectStatic, UpRect, SmallFonRect : TRect;
  Col : array[1..6] of TColor;
  SH, SW : Real;
  ScaleShtorki : Real;
  STime : tdatetime;


  framestart:TDateTime;
  h:THuman;
  guitx, guity:integer;
  guitangle:double;
  anims:TanimDatas;
  currentanim:integer;
implementation

{$R *.dfm}
procedure Shtora(XPL, YPL : Integer; Scale : Real; var  BmpX : TBitMap);
begin
  BmpX.Canvas.Pen.Color := clBlack;
  BmpX.Canvas.Brush.Color := $00020062;
  BmpX.Canvas.Rectangle(XPL, YPL + Trunc(40 * SH), XPL + Trunc(((1920 / 2) * SW) * Scale), YPL + Trunc((1080 - 430) * SH));   //Раздвигающиеся шторки
  BmpX.Canvas.Rectangle(Trunc((1920 - (1920 / 2 * Scale)) * SW) + XPL, YPL + Trunc(40 * SH), XPL + Trunc(1920 * SW), YPL + Trunc((1080 - 430) * SH));
end;

Procedure Circles(Xc, Yc : Integer);
var
  i, Radius, N, X1, X2, Y1, Y2: Integer;
  alpha : double;
begin
  Radius := Trunc((Random(4) + 26) * SW);
  N := Random(3) + 35;
  for i := 0 to N - 1 do
    begin
      alpha := i * 2 * Pi / N;

      X1 := Round(Xc - Radius * cos(alpha));
      Y1 := Round(Yc - Radius * sin(alpha));
      X2 := Round(Xc + Radius * cos(alpha));
      Y2 := Round(Yc + Radius * sin(alpha));

      Bmp.Canvas.MoveTo(X1, Y1);
      Bmp.Canvas.LineTo(X2, Y2);
    end;
end;

procedure TForm4.BitmapCreate(var BmpX : TBitmap);
begin
  BmpX := TBitmap.Create;
  BmpX.Width := Image1.Width;
  BmpX.Height := Image1.Height;
  BmpX.Canvas.Pen.Color := clGray;
  BmpX.Canvas.Brush.Color := clGray;
  BmpX.Canvas.FillRect(Rect(0, 0, BmpX.Width, BmpX.Height));      //Фон
  BmpX.Canvas.Pen.Color := clWhite;
  BmpX.Canvas.Brush.Color := $00460300;
  BmpX.Canvas.Ellipse(0, Trunc((1080 - 405) * SH), Trunc(1920 * SW), Trunc((1080 - 155) * SH));
  BmpX.Canvas.Pen.Color := $00460300;
  BmpX.Canvas.Brush.Color := $00460300;
  BmpX.Canvas.Rectangle(0, Trunc((1080 - 460) * SH), Trunc(1920 * SW), Trunc((1080 - 280) * SH));
  BmpX.Canvas.Pen.Color := clWhite;
  BmpX.Canvas.Brush.Color := $00280200;
  BmpX.Canvas.Ellipse(0, Trunc((1080 - 490) * SH), Trunc(1920 * SW), Trunc((1080 - 370) * SH));
  BmpX.Canvas.Pen.Color := $00280200;
  BmpX.Canvas.Brush.Color := $00280200;
  BmpX.Canvas.Rectangle(0, Trunc((1080 - 680) * SH), Trunc(1920 * SW), Trunc((1080 - 430) * SH));
  BmpX.Canvas.Pen.Color := clBlack;
  BmpX.Canvas.Brush.Color := $00020062;
  BmpX.Canvas.Rectangle(0, Trunc(50 * SH), Trunc(50 * SW), Trunc((1080 - 430) * SH));      //Левая шторка
  BmpX.Canvas.Rectangle(Trunc((1920 - 50) * SW), Trunc(50 * SH), Trunc(1920 * SW), Trunc((1080 - 430) * SH));//Правая шторка
  BmpX.Canvas.Pen.Color := clBlack;
  BmpX.Canvas.Brush.Color := $00020062;
  BmpX.Canvas.Rectangle(0, 0, Trunc(1920 * SW), Trunc(40 * SH));
end;

Procedure DoubtfulProcedure(ColorLocal : TColor; i, j, XPL, YPL : Integer);
begin
  Bmp.Canvas.Pen.Color := ColorLocal;
  Bmp.Canvas.MoveTo(Trunc(i * SW) + XPL, Trunc(40 * SH) + YPL);
  Bmp.Canvas.LineTo(Trunc(j * SW) + XPL, Trunc((1080 - 680) * SH) + YPL);
end;




procedure Columns(X, Y, XPL, YPL : Integer);
var
  i : Integer;
begin         //$003E3E31
  i := Random(2);
  Bmp.Canvas.Pen.Color := $0036362C;         //$003E3E31
  Bmp.Canvas.Brush.Color := $0036362C;
  Bmp.Canvas.Ellipse(Trunc((X + i) * SW) + XPL, Trunc((Y + i) * SH) + YPL, Trunc((X + 50 + i) * SW) + XPL, Trunc((Y + 330 + i) * SH) + YPL);
  Bmp.Canvas.Ellipse(Trunc((X + 100 + i) * SW) + XPL, Trunc((Y + i) * SH) + YPL, Trunc((X + 150 + i) * SW) + XPL, Trunc((Y + 330 + i) * SH) + YPL);
  Bmp.Canvas.Pen.Color := $003E3E31;         //$0036362C
  Bmp.Canvas.Brush.Color := $003E3E31;
  Bmp.Canvas.Rectangle(Trunc((X + 25 + i) * SW) + XPL, Trunc((Y + i) * SH) + YPL, Trunc((X + 125 + i) * SW) + XPL, Trunc((Y + 330 + i) * SH) + YPL);

  Bmp.Canvas.Pen.Color := clBlack;
  Bmp.Canvas.Brush.Color := $00545443;
  Bmp.Canvas.Pen.Width := Trunc((12 + Random(6)) * SW);
  Bmp.Canvas.Ellipse(Trunc((X + 40) * SW) + XPL, Trunc((Y + 40) * SH) + YPL, Trunc((X + 110) * SW) + XPL, Trunc(((Y + 40) * SH) + 70 * SW) + YPL);
  Bmp.Canvas.Ellipse(Trunc((X + 40) * SW) + XPL, Trunc((Y + 190) * SH) + YPL, Trunc((X + 110) * SW) + XPL, Trunc(((Y + 190) * SH) + 70 * SW) + YPL);

  Bmp.Canvas.Pen.Width := 1;
  Bmp.Canvas.MoveTo(Trunc((X + 25 + i) * SW) + XPL, Trunc((Y + 1 + i) * SH) + YPL);
  Bmp.Canvas.LineTo(Trunc((X + 125 + i) * SW) + XPL, Trunc((Y + 1 + i) * SH) + YPL);
  Bmp.Canvas.MoveTo(Trunc((X + 25 + i) * SW) + XPL, Trunc((Y + 330 - 1 + i) * SH) + YPL);
  Bmp.Canvas.LineTo(Trunc((X + 125 + i) * SW) + XPL, Trunc((Y + 330 - 1 + i) * SH) + YPL);

  Bmp.Canvas.Pen.Color := $0022221C;
  Circles(Trunc((X + 75) * SW) + XPL, Trunc((Y + 40) * SH + 35 * SW) + YPL);
  Circles(Trunc((X + 75) * SW) + XPL, Trunc((Y + 190) * SH + 35 * SW) + YPL);
end;

procedure GradientLinesColor(XPL, YPL : Integer);
var
  i, k : Integer;
begin
    Bmp.Canvas.Pen.Color := clGray;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Font.Name := 'Matura MT Script Capitals';
    Bmp.Canvas.Font.Size := Trunc(44 * SW);
    Bmp.Canvas.Font.Color := Col[6];
    Bmp.Canvas.TextOut(Trunc(130 * SW) + XPL, Trunc(170 * SH) + YPL, 'ROCK');
    i := 0;
    while i <= 1920 do
      begin
        if i <= Trunc(1920 / 2) then
          begin
            DoubtfulProcedure(Col[1], i + 50, Trunc(1920 / 2) - i + 50, XPL, YPL);
            DoubtfulProcedure(Col[2], Trunc(1920 / 2) + i - 50, 1920 - i - 50, XPL, YPL);
          end;
        if (i + 60 > 1920  - i - 60) then
          k := -60
        else
          k := 60;
        DoubtfulProcedure(Col[3], i + k, 1920 - i - k, XPL, YPL);
        Inc(i, 20);
      end;
   i := 0;
   while i <= 1920 do
     begin
       if (i + 50 > 1920 - i - 50) then
         k := -50
       else
         k := 50;
       DoubtfulProcedure(Col[4], i + k, 1920 - i - k, XPL, YPL);
       if i <= 360 then
         begin
           Bmp.Canvas.Pen.Color := Col[5];
           Bmp.Canvas.MoveTo(Trunc(50 * SW) + XPL, Trunc((i + 40) * SH) + YPL);
           Bmp.Canvas.LineTo(Trunc((1920 - 50) * SW) + XPL, Trunc((1080 - 680 - i) * SH) + YPL);
         end;
       Inc(i, 20);
     end;
end;

Procedure TForm4.DrawFons(Size, XPL, YPL : Integer; BmpX : TBitmap);
var
  i : Integer;
  Point : TPoint;
begin
  XPL := Trunc(XPL * SW);
  YPL := Trunc(YPL * SH);

  SW := SW / Size;
  SH := SH / Size;

  UpRect := Rect(0, 0, Trunc(1920 * SW), Trunc(40 * SH));
  FonRectStatic := Rect(0, Trunc(40 * SH), Trunc(1920 * SW), Trunc(1080 * SH));
  Bmp.Canvas.CopyRect(Rect(XPL, YPL + Trunc(40 * SH), XPL + Trunc(1920 * SW), YPL + Trunc(1080 * SH)), BmpX.Canvas, FonRectStatic);

  GradientLinesColor(XPL, YPL);

  Bmp.Canvas.Pen.Color := clBlack;
  Bmp.Canvas.Brush.Color := $00020062;
  Bmp.Canvas.Ellipse(Trunc(-50 * SW) + XPL, Trunc(-200 * SH) + YPL, Trunc(100 * SW) + XPL, Trunc(300 * SH) + YPL);
  Bmp.Canvas.Ellipse(Trunc((1920 + 50) * SW) + XPL, Trunc(-200 * SH) + YPL, Trunc((1920 - 100) * SW) + XPL, Trunc(300 * SH) + YPL);

  Bmp.Canvas.CopyRect(Rect(XPL, YPL, Trunc(1920 * SW) + XPL, YPL + Trunc(40 * SH)), BmpX.Canvas, UpRect);
  /////////Колонки за шторками \/
  Columns(55, 1080 - 780, XPL, YPL);
  Columns(1920 - 205, 1080 - 780, XPL, YPL);
  /////////Колонки за шторками /\
  if size =1 then
    h.draw(bmp.canvas, ClientWidth div 2, ClientHeight div 2);

  /////////Шторки \/
  Shtora(XPL, YPL, ScaleShtorki, Bmp);
  /////////Шторки /\

  /////////Колонки перед шторками \/
  Columns(2, 1080 - 485, XPL, YPL);
  Columns(1920 - 152, 1080 - 485, XPL, YPL);
  /////////Колонки перед шторками /\

  /////////Телевизор \/
  if BmpX <> Bmp1 then
    begin
      Bmp.Canvas.Pen.Color := clWhite;
      Bmp.Canvas.Brush.Color := clWhite;
      Bmp.Canvas.Rectangle(XPL - Trunc(80 * Sw), YPL - Trunc(80 * SH), XPL + Trunc(2000 * SW), YPL);
      Bmp.Canvas.Rectangle(XPL - Trunc(80 * Sw), YPL - Trunc(80 * SH), XPL, YPL + Trunc(1160 * SH));
      Bmp.Canvas.Rectangle(XPL  + Trunc(1920 * SW), YPL - Trunc(80 * SH), XPL + Trunc(2000 * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Rectangle(XPL - Trunc(80 * Sw), YPL + Trunc(1080 * SH), XPL + Trunc(2000 * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Rectangle(XPL - Trunc(80 * Sw), YPL - Trunc(195 * SH), XPL + Trunc(2000 * SW), YPL - Trunc(80 * SH));
      Bmp.Canvas.MoveTo(XPL - Trunc(80 * Sw), YPL - Trunc(195 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc(2000 * SW), YPL - Trunc(195 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc(2000 * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Pen.Color := $00E2E2E2;
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 + 100) * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 + 550) * SW), YPL + Trunc(1860 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2) * SW), YPL + Trunc(1175 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 - 100) * SW), YPL + Trunc(1700 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 - 70) * SW), YPL + Trunc(1175 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 - 350) * SW), YPL + Trunc(1860 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 - 170) * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Pen.Color := clBlack;
      Bmp.Canvas.MoveTo(XPL - Trunc(80 * Sw), YPL - Trunc(195 * SH));
      Bmp.Canvas.LineTo(XPL - Trunc(80 * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 - 170) * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Pen.Color := $00E2E2E2;
      Bmp.Canvas.LineTo(XPL + Trunc((1920 / 2 + 550) * SW), YPL + Trunc(1160 * SH));
      Bmp.Canvas.Brush.Color := clBlack;
      Bmp.Canvas.FloodFill(XPL + Trunc((1920 / 2) * SW), YPL + Trunc(1165 * SH), $00E2E2E2, fsBorder);
    end;
  /////////Телевизор /\
  SW := SW * Size;
  SH := SH * Size;

  Image1.Picture.Bitmap.Assign(Bmp);
end;


procedure HInitialize;
const
  vis :TanimData = (duration:420; sdstart:0;sdlength:200;sustart:200; sulength:220; startpoint:(x:10;y:-8);endpoint:(x:5;y:10););
  animhalt:TanimData = (duration:400000; sdstart:-1);
var i:integer;
begin
  framestart:=now();
  currentanim:=0;
  guitangle:=-0.4;
  guitx:=20;
  guity:=-30;
  h:=thuman.create();
  h.setbodyup(10, -70);
  h.lleg:= Point(30, 100);
  h.llegdir:=true;
  h.rleg:= Point(-30, 100);
  h.rlegdir:=false;
  h.larmdir:= true;
  h.rarmdir:=true;
  h.DrawWithGuitar(guitx, guity);
  h.guitar.rotate(guitangle);
  h.larm:= Point(guitx+Round(60*cos(guitangle)),guity+Round(60*sin(guitangle)));
  SetLength(anims, 100);
  for i := 0 to 70 do
    begin
      anims[i]:=vis;
    end;
  anims[71]:=animhalt;

end;
procedure TForm4.FormCreate(Sender: TObject);
begin
   HInitialize();


  SH := Screen.Height / 1080 / Siz;
  SW := Screen.Width / 1920 / Siz;
  Bmp := TBitmap.Create;
  Bmp.Width := Image1.Width;
  Bmp.Height := Image1.Height;
  BitmapCreate(Bmp2);
  SmallFonRect := Rect(0, Trunc(40 * SH), Trunc(1920 * SW), Trunc(1080 * SH));
  SW := SW * Siz;
  SH := SH * Siz;
  BitmapCreate(Bmp1);
  ScaleShtorki := 1;
  Stime := Now();
end;


procedure TForm4.TimercolorsTimer(Sender: TObject);
var
  i : Integer;
begin
for i := Low(Col) to High(Col) do
  Col[i] := RGB(Random(255), Random(255), Random(255));
end;

procedure TForm4.TimerFonMotionTimer(Sender: TObject);
var
  CountForShtorki, i : Integer;
begin
  DrawFons(1, 0, 0, Bmp1);
  DrawFons(Siz, 1280, 600, Bmp2);
  DrawFons(Siz, 230, 600, Bmp2);
  Image1.Canvas.CopyRect(Rect(420-30, 709-30, 420+30, 709+30), Image1.Canvas, Rect(960-150, 540-150, 960+150, 540+150));
  Image1.Canvas.CopyRect(Rect(1470-30, 709-30, 1470+30, 709+30), Image1.Canvas, Rect(960-150, 540-150, 960+150, 540+150));
end;

procedure TForm4.TimerforHumanTimer(Sender: TObject);
var t:int64;
begin
  if currentanim<length(anims) then
    begin
      t:=MillisecondsBetween(Now(), framestart);
      if (t>anims[currentanim].duration) then
      begin
        framestart:=Now();
        t:=t-anims[currentanim].duration;
        Inc(currentanim);
      end;
      if currentanim<length(anims) then
        rarmanim(t, h, anims[currentanim]);
    end;
end;

procedure TForm4.TimerForShtorkiTimer(Sender: TObject);
const
  shtorkt = 3000;
  delay = 3000;
var
  st : int64;
begin
  st := MillisecondsBetween(Now(), Stime);
  if st < shtorkt then
    ScaleShtorki := 1 - st / shtorkt
  else
    if (st < delay + shtorkt) then
      ScaleShtorki := 0
    else
      if (st > delay + shtorkt) and (st < delay + 2 * shtorkt) then
        ScaleShtorki := (st - delay - shtorkt) / shtorkt
      else
        ScaleShtorki := 1;
end;

end.
