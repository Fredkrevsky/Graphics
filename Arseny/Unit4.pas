unit unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    TimerFonMotion: TTimer;
    TimerColorChange: TTimer;
    procedure TimerFonMotionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerColorChangeTimer(Sender: TObject);
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
Bmp1.Canvas.Ellipse(0, Screen.Height - 405, Screen.Width, Screen.Height - 155);
Bmp1.Canvas.Pen.Color := $00460300;
Bmp1.Canvas.Brush.Color := $00460300;
Bmp1.Canvas.Rectangle(0, Screen.Height - 460, Screen.Width, Screen.Height - 280);
Bmp1.Canvas.Pen.Color := clWhite;
Bmp1.Canvas.Brush.Color := $00280200;
Bmp1.Canvas.Ellipse(0, Screen.Height - 490, Screen.Width, Screen.Height - 370);
Bmp1.Canvas.Pen.Color := $00280200;         //$00A8D6E1
Bmp1.Canvas.Brush.Color := $00280200;
Bmp1.Canvas.Rectangle(0, Screen.Height - 680, Screen.Width, Screen.Height - 430);
FonRect1 := Rect(0, Screen.Height - 680, Screen.Width, Screen.Height);

Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 50, 50, Screen.Height - 430);
LRect := Rect(0, 50, 50, Screen.Height - 430);        //Шторки
Bmp1.Canvas.Rectangle(Screen.Width - 60, 50, Screen.Width, Screen.Height - 430);
RRect := Rect(Screen.Width - 60, 50, Screen.Width, Screen.Height - 430);
Bmp1.Canvas.Pen.Color := clBlack;
Bmp1.Canvas.Brush.Color := $00020062;
Bmp1.Canvas.Rectangle(0, 0, Screen.Width, 40);
UpRect := Rect(0, 0, Screen.Width, 40);
ii := 0;
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

    if ii <= 872 then
      begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 40, Trunc(Screen.Width / 2) - ii, Screen.Height - 430);   //Раздвигающиеся шторки
        Bmp.Canvas.Rectangle(Trunc(Screen.Width / 2) + ii, 40, Screen.Width, Screen.Height - 430);
        inc(ii, 4);
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
  Bmp.Canvas.CopyRect(UpRect, Bmp1.Canvas, UpRect);
  Image1.Picture.Bitmap.Assign(Bmp);
end;

end.
