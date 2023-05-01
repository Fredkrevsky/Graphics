unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Timer: TTimer;
    Timer2: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  Bmp, Bmp1 : TBitMap;
  ii : Integer;
  Col: array[1..6] of TColor;
  UpRect, FonRect1, FonRect2, LRect, RRect : TRect;
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
Bmp := TBitmap.Create;
Bmp1 := TBitmap.Create;
Bmp1.Width := Image1.Width;
Bmp1.Height := Image1.Height;
Bmp1.Canvas.Pen.Color := clGray;
Bmp1.Canvas.Brush.Color := clGray;
Bmp1.Canvas.FillRect(Rect(0, 0, Bmp1.Width, Bmp1.Height));
Bmp1.Canvas.Pen.Color := clWhite;
Bmp1.Canvas.Brush.Color := $00460300;
Bmp1.Canvas.Ellipse(0, 675, 1940, 925);
Bmp1.Canvas.Pen.Color := $00460300;
Bmp1.Canvas.Brush.Color := $00460300;
Bmp1.Canvas.Rectangle(0, 620, 1940, 800);
Bmp1.Canvas.Pen.Color := clWhite;
Bmp1.Canvas.Brush.Color := $00280200;
Bmp1.Canvas.Ellipse(0, 590, 1940, 710);
Bmp1.Canvas.Pen.Color := $00280200;         //$00A8D6E1
Bmp1.Canvas.Brush.Color := $00280200;
Bmp1.Canvas.Rectangle(0, 400, 1940, 650);
FonRect1 := Rect(0, 400, 1940, 1020);

Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 50, 50, 650);
LRect := Rect(0, 50, 50, 650);        //Шторки
Bmp1.Canvas.Rectangle(1860, 50, 1920, 650);
RRect := Rect(1860, 50, 1920, 650);
{Bmp1.Canvas.Ellipse(-50, -200, 100, 300);
ShRect1 := Rect(0, 0, 100, 300);
Bmp1.Canvas.Ellipse(1990, -200, 1820, 300);
ShRect2 := Rect(1820, 0, 1920, 300); }
Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 0, 1940, 40);
UpRect := Rect(0, 0, 1940, 40);
//Image1.Picture.Bitmap.Assign(Bmp1);
ii := 0;
end;

procedure TForm4.Timer2Timer(Sender: TObject);
var
  ind : Integer;
begin
  for ind := Low(Col) to High(Col) do
    Col[ind] := RGB(Random(255), Random(255), Random(255));
end;

procedure TForm4.TimerTimer(Sender: TObject);
var
  i, j, Radius, Xc, Yc, N, X1, Y1, X2, Y2 : Integer;
  alpha : double;

begin
    Bmp.Width := Image1.Width;
    Bmp.Height := Image1.Height;
    Bmp.Canvas.Pen.Color := clGray;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Rectangle(0, 0, Bmp.Width, Bmp.Height);
    Bmp.Canvas.Font.Name := 'Matura MT Script Capitals';
    Bmp.Canvas.Font.Size := 36;
    Bmp.Canvas.Font.Color := Col[6];
    Bmp.Canvas.TextOut(200, 100, 'ROCK');
    i := 0;
    while i <= 1940 do
      begin
        if i <= 970 then
          begin
            DoubtfulProcedure(Col[1], i, 970 - i);
            DoubtfulProcedure(Col[2], 970 + i, 1940 - i);
            DoubtfulProcedure(Col[3], 970 + i, 970 - i);
            DoubtfulProcedure(Col[3], 970 - i, 970 + i);
          end;
        DoubtfulProcedure(Col[4], i, 1940 - i);
        if i <= 400 then
          begin
            Bmp.Canvas.Pen.Color := Col[5];
            Bmp.Canvas.MoveTo(0, i);
            Bmp.Canvas.LineTo(1940, 400 - i);
          end;
        Inc(i, 20);
      end;
    Bmp.Canvas.CopyRect(FonRect1, Bmp1.Canvas, FonRect1);
   { Bmp.Canvas.Pen.Color := $00280200;         //$00A8D6E1
    Bmp.Canvas.Brush.Color := $00280200;
    Bmp.Canvas.Rectangle(0, 400, 1940, 650);    //Ôîí       $003E3E31
    Bmp.Canvas.Ellipse(0, 590, 1940, 710);  }

    Bmp.Canvas.Pen.Color := $003E3E31;         //$00A8D6E1
    Bmp.Canvas.Brush.Color := $003E3E31;
    i := Random(2);
    Bmp.Canvas.Ellipse(50 + i, 270 + i, 100 + i, 600 + i);    //
    Bmp.Canvas.Ellipse(150 + i, 270 + i, 200 + i, 600 + i);   //Левая колонка фон
    Bmp.Canvas.Rectangle(75, 270, 175, 600);  //
    i := Random(2);
    Bmp.Canvas.Ellipse(1710 + i, 270 + i, 1760 + i, 600 + i);  //
    Bmp.Canvas.Ellipse(1810 + i, 270 + i, 1860 + i, 600 + i);  //Правая колонка фон
    Bmp.Canvas.Rectangle(1735 + i, 270 + i, 1835 + i, 600 + i);//


    Bmp.Canvas.Pen.Color := clBlack;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Pen.Width := 12 + Random(6);
    Bmp.Canvas.Ellipse(90, 310, 160, 380);   //Êðóã êîëîíêè ñëåâà (âåðõ)
    Bmp.Canvas.Ellipse(90, 460, 160, 530);   //Êðóã êîëîíêè ñëåâà (íèç)
    Bmp.Canvas.Ellipse(1750, 310, 1820, 380);   //Êðóãè êîëîíêè ñïðàâà (âåðõ)
    Bmp.Canvas.Ellipse(1750, 460, 1820, 530);

    Bmp.Canvas.Pen.Width := 1;
    Bmp.Canvas.Pen.Color := $003E3E31;
    Circles(125, 345, Bmp);
    Circles(125, 495, Bmp);
    Circles(1785, 345, Bmp);
    Circles(1785, 495, Bmp);

    if ii <= 872 then
      begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 40, 960 - ii, 650);   //Раздвигающиеся шторки
        Bmp.Canvas.Rectangle(960 + ii, 40, 1925, 650);
        inc(ii, 4);
      end
    else
      begin
        Bmp.Canvas.CopyRect(LRect, Bmp1.Canvas, LRect);
        Bmp.Canvas.CopyRect(RRect, Bmp1.Canvas, RRect);
      {  for i := 0 to 100 do
          for j := 0 to 300 do
            if ($00020062 <> Bmp1.Canvas.Pixels[i, j]) and (clBlack <> Bmp1.Canvas.Pixels[i, j]) then
              Bmp1.Canvas.Pixels[i, j] := Bmp.Canvas.Pixels[i, j];
        Bmp.Canvas.CopyRect(ShRect1, Bmp1.Canvas, ShRect1);
        for i := 1820 to 1920 do
          for j := 0 to 300 do
            if ($00020062 <> Bmp1.Canvas.Pixels[i, j]) and (clBlack <> Bmp1.Canvas.Pixels[i, j]) then
              Bmp1.Canvas.Pixels[i, j] := Bmp.Canvas.Pixels[i, j];
        Bmp.Canvas.CopyRect(ShRect2, Bmp1.Canvas, ShRect2);  }
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Ellipse(-50, -200, 100, 300);
        Bmp.Canvas.Ellipse(1970, -200, 1820, 300);
      end;
  Bmp.Canvas.CopyRect(UpRect, Bmp1.Canvas, UpRect);
  Image1.Picture.Bitmap.Assign(Bmp);
end;

end.
