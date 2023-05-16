unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  uHandG;

type
  TForm4 = class(TForm)
    Image1: TImage;
    TimerFonMotion: TTimer;
    TimerHumanMotion: TTimer;
    procedure TimerFonMotionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure DrawFons(Size, XPL, YPL : Integer; BmpX : TBitmap);
    procedure BitmapCreate(var BmpX : TBitmap);
    Procedure CloseOpenShtorki(XPL, YPL : Integer; CL : Boolean);
    procedure TimerHumanMotionTimer(Sender: TObject);
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
  Col: array[1..6] of TColor;
  SH, SW : Real;
  ii : Integer;
  t:integer;
  h:THuman;
  g:TGuitar;
  guitx, guity:integer;
  guitangle:double;
implementation

{$R *.dfm}

Procedure TForm4.CloseOpenShtorki(XPL, YPL : Integer; CL : Boolean);
var
  CountForShtorki, k : Integer;
begin
  if not CL then
    k := 100
  else
    begin
      k := 0;
      if (TimerFonMotion.Tag > 860) and (ii = 0) then
        begin
          TimerFonMotion.Tag := 0;
          inc(ii);
        end;
    end;

  CountForShtorki := TimerFonMotion.Tag;
  if CountForShtorki <= Trunc(1920 / 2) - k then
    begin
      Bmp.Canvas.Pen.Color := clBlack;
      Bmp.Canvas.Brush.Color := $00020062;
      if not CL then
        begin
          Bmp.Canvas.Rectangle(XPL, YPL + Trunc(40 * SH), XPL + Trunc(((1920 / 2) - CountForShtorki) * SW), YPL + Trunc((1080 - 430) * SH));   //Раздвигающиеся шторки
          Bmp.Canvas.Rectangle(Trunc(((1920 / 2) + CountForShtorki) * SW) + XPL, YPL + Trunc(40 * SH), XPL + Trunc(1920 * SW), YPL + Trunc((1080 - 430) * SH));
        end
      else
        begin
          Bmp.Canvas.Rectangle(XPL, YPL + Trunc(40 * SH), XPL + Trunc(CountForShtorki * SW){ + Trunc(((1920 / 2) - CountForShtorki) * SW)}, YPL + Trunc((1080 - 430) * SH));   //Раздвигающиеся шторки
          Bmp.Canvas.Rectangle(XPL + Trunc(1920 * SW), YPL + Trunc(40 * SH), XPL + Trunc((1920 - CountForShtorki) * SW), YPL + Trunc((1080 - 430) * SH));
        end;
      inc(CountForShtorki, 4);

      if (CountForShtorki > Trunc(1920 / 2) - k) and (k = 0) and (ii = 1) then
        Close;

      TimerFonMotion.Tag := CountForShtorki;
    end
  else
    begin
      if (CountForShtorki > 10000) then
        CountForShtorki := 4001
      else
        inc(CountForShtorki);
      TimerFonMotion.Tag := CountForShtorki;
    end;
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

procedure TForm4.FormCreate(Sender: TObject);
begin
  t:=0;
  guitangle:=-0.4;
  guitx:=20;
  guity:=-30;
  h:=thuman.create();
  g:=TGuitar.Create();
  g.rotate(guitangle);
  h.setbodyup(10, -70);
  h.setlleg(20, 75, false);
  h.setrleg(-20, 75, true);
  h.setlarm(guitx+Round(60*cos(guitangle)),guity+Round(60*sin(guitangle)), true);

  SH := {766}Screen.Height / 1080 / Siz;
  SW := {1378}Screen.Width / 1920 / Siz;
  Bmp := TBitmap.Create;
  Bmp.Width := Image1.Width;
  Bmp.Height := Image1.Height;
  BitmapCreate(Bmp2);
  SmallFonRect := Rect(0, Trunc(40 * SH), Trunc(1920 * SW), Trunc(1080 * SH));
  SW := SW * Siz;
  SH := SH * Siz;
  BitmapCreate(Bmp1);
  TimerFonMotion.Tag := 0;
  ii := 0;
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
  if (TimerFonMotion.Tag mod 45 = 0) or (TimerFonMotion.Tag = Trunc(1920 / 2) - 96) then
    begin
      for i := Low(Col) to High(Col) do
        Col[i] := RGB(Random(255), Random(255), Random(255));
    end;
  Bmp.Canvas.CopyRect(Rect(XPL, YPL + Trunc(40 * SH), XPL + Trunc(1920 * SW), YPL + Trunc(1080 * SH)), BmpX.Canvas, FonRectStatic);

  GradientLinesColor(XPL, YPL);

  Bmp.Canvas.Pen.Color := clBlack;
  Bmp.Canvas.Brush.Color := $00020062;
  Bmp.Canvas.Ellipse(Trunc(-50 * SW) + XPL, Trunc(-200 * SH) + YPL, Trunc(100 * SW) + XPL, Trunc(300 * SH) + YPL);
  Bmp.Canvas.Ellipse(Trunc((1920 + 50) * SW) + XPL, Trunc(-200 * SH) + YPL, Trunc((1920 - 100) * SW) + XPL, Trunc(300 * SH) + YPL);

  Bmp.Canvas.CopyRect(Rect(XPL, YPL, Trunc(1920 * SW) + XPL, YPL + Trunc(40 * SH)), BmpX.Canvas, UpRect);

  Columns(55, 1080 - 780, XPL, YPL);
  Columns(1920 - 205, 1080 - 780, XPL, YPL);

  h.DrawWithGuitar(g.source, guitx, guity);
  h.draw(bmp.canvas, 960, 540);
  CloseOpenShtorki(XPL, YPL, False);
  Columns(2, 1080 - 485, XPL, YPL);
  Columns(1920 - 152, 1080 - 485, XPL, YPL);
  ////Телевизор
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
  ////
  SW := SW * Size;
  SH := SH * Size;

  Image1.Picture.Bitmap.Assign(Bmp);
end;


procedure TForm4.TimerFonMotionTimer(Sender: TObject);
var
  CountForShtorki, i : Integer;

begin
  DrawFons(1, 0, 0, Bmp1);
  DrawFons(Siz, 1280, 600, Bmp2);
  DrawFons(Siz, 230, 600, Bmp2);
  Image1.Canvas.CopyRect(Rect(420-30, 708-30, 420+30, 708+30), Image1.Canvas, Rect(960-150, 540-150, 960+150, 540+150));
  Image1.Canvas.CopyRect(Rect(1470-30, 708-30, 1470+30, 708+30), Image1.Canvas, Rect(960-150, 540-150, 960+150, 540+150));
  ///h.DrawWithGuitar(g.source, guitx, guity);
  ///h.draw(Image1.canvas, 200, 200);
end;

procedure TForm4.TimerHumanMotionTimer(Sender: TObject);
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
    guity + -1 + Round(8 * sin(guitangle)) - Round(l * cosrh), true);
end;

end.
