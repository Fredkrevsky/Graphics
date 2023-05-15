unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    TimerFonMotion: TTimer;
    procedure TimerFonMotionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure StaticFonDraw;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  Bmp, Bmp1 : TBitMap;
  FonRectStatic, UpRect : TRect;
  Col: array[1..6] of TColor;
  SH, SW : Real;
implementation

{$R *.dfm}

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
Procedure TForm4.StaticFonDraw;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := Image1.Width;
  Bmp.Height := Image1.Height;
  Bmp1 := TBitmap.Create;
  Bmp1.Width := Image1.Width;
  Bmp1.Height := Image1.Height;
  Bmp1.Canvas.Pen.Color := clGray;
  Bmp1.Canvas.Brush.Color := clGray;
  Bmp1.Canvas.FillRect(Rect(0, 0, Bmp1.Width, Bmp1.Height));      //Фон
  Bmp1.Canvas.Pen.Color := clWhite;
  Bmp1.Canvas.Brush.Color := $00460300;
  Bmp1.Canvas.Ellipse(0, Trunc((Screen.Height - 405) * SH), Screen.Width, Trunc((Screen.Height - 155) * SH));
  Bmp1.Canvas.Pen.Color := $00460300;
  Bmp1.Canvas.Brush.Color := $00460300;
  Bmp1.Canvas.Rectangle(0, Trunc((Screen.Height - 460) * SH), Screen.Width, Trunc((Screen.Height - 280) * SH));
  Bmp1.Canvas.Pen.Color := clWhite;
  Bmp1.Canvas.Brush.Color := $00280200;
  Bmp1.Canvas.Ellipse(0, Trunc((Screen.Height - 490) * SH), Screen.Width, Trunc((Screen.Height - 370) * SH));
  Bmp1.Canvas.Pen.Color := $00280200;
  Bmp1.Canvas.Brush.Color := $00280200;
  Bmp1.Canvas.Rectangle(0, Trunc((Screen.Height - 680) * SH), Screen.Width, Trunc((Screen.Height - 430) * SH));
  Bmp1.Canvas.Pen.Color := clBlack;
  Bmp1.Canvas.Brush.Color := $00020062;
  Bmp1.Canvas.Rectangle(0, Trunc(50 * SH), Trunc(50 * SW), Trunc((Screen.Height - 430) * SH));      //Левая шторка
  Bmp1.Canvas.Rectangle(Trunc((Screen.Width - 50) * SW), Trunc(50 * SH), Screen.Width, Trunc((Screen.Height - 430) * SH));//Правая шторка
  Bmp1.Canvas.Pen.Color := clBlack;
  Bmp1.Canvas.Brush.Color := $00020062;
  Bmp1.Canvas.Rectangle(0, 0, Screen.Width, Trunc(40 * SH));
  UpRect := Rect(0, 0, Screen.Width, Trunc(40 * SH));
  FonRectStatic := Rect(0, Trunc(40 * SH), Screen.Width, Screen.Height);
end;
Procedure DoubtfulProcedure(ColorLocal : TColor; i, j : Integer);
begin
  Bmp.Canvas.Pen.Color := ColorLocal;
  Bmp.Canvas.MoveTo(Trunc(i * SW), Trunc(40 * SH));
  Bmp.Canvas.LineTo(Trunc(j * SW), Trunc((Screen.Height - 680) * SH));
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  SH := Screen.Height / 1080;
  SW := Screen.Width / 1920;
  StaticFonDraw;
  TimerFonMotion.Tag := 0;
end;

procedure Columns(X, Y : Integer);
var
  i : Integer;
begin         //$003E3E31
  i := Random(2);
  Bmp.Canvas.Pen.Color := $0036362C;         //$003E3E31
  Bmp.Canvas.Brush.Color := $0036362C;
  Bmp.Canvas.Ellipse(Trunc((X + i) * SW), Trunc((Y + i) * SH), Trunc((X + 50 + i) * SW), Trunc((Y + 330 + i) * SH));
  Bmp.Canvas.Ellipse(Trunc((X + 100 + i) * SW), Trunc((Y + i) * SH), Trunc((X + 150 + i) * SW), Trunc((Y + 330 + i) * SH));
  Bmp.Canvas.Pen.Color := $003E3E31;         //$0036362C
  Bmp.Canvas.Brush.Color := $003E3E31;
  Bmp.Canvas.Rectangle(Trunc((X + 25 + i) * SW), Trunc((Y + i) * SH), Trunc((X + 125 + i) * SW), Trunc((Y + 330 + i) * SH));

  Bmp.Canvas.Pen.Color := clBlack;
  Bmp.Canvas.Brush.Color := $00545443;
  Bmp.Canvas.Pen.Width := Trunc((12 + Random(6)) * SW);
  Bmp.Canvas.Ellipse(Trunc((X + 40) * SW), Trunc((Y + 40) * SH), Trunc((X + 110) * SW), Trunc(((Y + 40) * SH) + 70 * SW));
  Bmp.Canvas.Ellipse(Trunc((X + 40) * SW), Trunc((Y + 190) * SH), Trunc((X + 110) * SW), Trunc(((Y + 190) * SH) + 70 * SW));

  Bmp.Canvas.Pen.Width := 1;
  Bmp.Canvas.MoveTo(Trunc((X + 25 + i) * SW), Trunc((Y + 1 + i) * SH));
  Bmp.Canvas.LineTo(Trunc((X + 125 + i) * SW), Trunc((Y + 1 + i) * SH));
  Bmp.Canvas.MoveTo(Trunc((X + 25 + i) * SW), Trunc((Y + 330 - 1 + i) * SH));
  Bmp.Canvas.LineTo(Trunc((X + 125 + i) * SW), Trunc((Y + 330 - 1 + i) * SH));

  Bmp.Canvas.Pen.Color := $0022221C;
  Circles(Trunc((X + 75) * SW), Trunc((Y + 40) * SH + 35 * SW));
  Circles(Trunc((X + 75) * SW), Trunc((Y + 190) * SH + 35 * SW));
end;


procedure GradientLinesColor;
var
  i, k : Integer;
begin
    Bmp.Canvas.Pen.Color := clGray;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Font.Name := 'Matura MT Script Capitals';
    Bmp.Canvas.Font.Size := Trunc(44 * SW);
    Bmp.Canvas.Font.Color := Col[6];
    Bmp.Canvas.TextOut(Trunc(200 * SW), Trunc(100 * SH), 'ROCK');
    i := 0;
    while i <= Screen.Width do
      begin
        if i <= Trunc(Screen.Width / 2) then
          begin
            DoubtfulProcedure(Col[1], i + 50, Trunc(Screen.Width / 2) - i + 50);
            DoubtfulProcedure(Col[2], Trunc(Screen.Width / 2) + i - 50, Screen.Width - i - 50);
          end;
        if (i + 60 > Screen.Width - i - 60) then
          k := -60
        else
          k := 60;
        DoubtfulProcedure(Col[3], i + k, Screen.Width - i - k);
        Inc(i, 20);
      end;
   i := 0;
   while i <= Screen.Width do
     begin
       if (i + 50 > Screen.Width - i - 50) then
         k := -50
       else
         k := 50;
       DoubtfulProcedure(Col[4], i + k, Screen.Width - i - k);
       if i <= 360 then
         begin
           Bmp.Canvas.Pen.Color := Col[5];
           Bmp.Canvas.MoveTo(Trunc(50 * SW), Trunc((i + 40) * SH));
           Bmp.Canvas.LineTo(Trunc((Screen.Width - 50) * SW), Trunc((Screen.Height - 680 - i) * SH));
         end;
       Inc(i, 20);
     end;
end;

procedure TForm4.TimerFonMotionTimer(Sender: TObject);
var
  CountForShtorki, i : Integer;
begin
  if (TimerFonMotion.Tag mod 45 = 0) or (TimerFonMotion.Tag = Trunc(Screen.Width / 2) - 96) then
    begin
      for i := Low(Col) to High(Col) do
        Col[i] := RGB(Random(255), Random(255), Random(255));
    end;
  Bmp.Canvas.CopyRect(FonRectStatic, Bmp1.Canvas, FonRectStatic);

  GradientLinesColor;

  Bmp.Canvas.Pen.Color := clBlack;
  Bmp.Canvas.Brush.Color := $00020062;
  Bmp.Canvas.Ellipse(Trunc(-50 * SW), Trunc(-200 * SH), Trunc(100 * SW), Trunc(300 * SH));
  Bmp.Canvas.Ellipse(Trunc((Screen.Width + 50) * SW), Trunc(-200 * SH), Trunc((Screen.Width - 100) * SW), Trunc(300 * SH));
  Bmp.Canvas.CopyRect(UpRect, Bmp1.Canvas, UpRect);

  Columns(55, Screen.Height - 780);
  Columns(Screen.Width - 205, Screen.Height - 780);

  CountForShtorki := TimerFonMotion.Tag;
  if CountForShtorki <= Trunc(Screen.Width / 2) - 100 then
    begin
      Bmp.Canvas.Pen.Color := clBlack;
      Bmp.Canvas.Brush.Color := $00020062;
      Bmp.Canvas.Rectangle(0, Trunc(40 * SH), Trunc(((Screen.Width / 2) - CountForShtorki) * SW), Trunc((Screen.Height - 430) * SH));   //Раздвигающиеся шторки
      Bmp.Canvas.Rectangle(Trunc(((Screen.Width / 2) + CountForShtorki) * SW), Trunc(40 * SH), Screen.Width, Trunc((Screen.Height - 430) * SH));
      inc(CountForShtorki, 4);
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

  Columns(2, Screen.Height - 485);
  Columns(Screen.Width - 152, Screen.Height - 485);
  Image1.Picture.Bitmap.Assign(Bmp);
end;

end.
