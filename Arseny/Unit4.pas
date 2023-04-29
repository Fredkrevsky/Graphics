unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    ImageCol1: TImage;
    ImageCol2: TImage;
    Timer: TTimer;
    Timer2: TTimer;

   // procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  Bmp, Bmp1, Bmp2, BmpSh1, BmpSh2 : TBitMap;
  ii : Integer;
  Col: array[1..6] of TColor;
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




procedure TForm4.FormCreate(Sender: TObject);
begin
ii := 0;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
var
  i, Radius, Xc, Yc, N, X1, Y1, X2, Y2 : Integer;
  alpha : double;
begin
if ii >= 900 then
begin
Bmp1 := TBitmap.Create;
Bmp2 := TBitmap.Create;
try
  Bmp1.Width := 100;
  Bmp1.Height := 330;

  Bmp2.Width := 100;
  Bmp2.Height := 330;

  Bmp1.Canvas.Pen.Color := $003E3E31;         //$00A8D6E1
  Bmp1.Canvas.Brush.Color := $003E3E31;

  Bmp2.Canvas.Pen.Color := $003E3E31;         //$00A8D6E1
  Bmp2.Canvas.Brush.Color := $003E3E31;

  Bmp1.Canvas.Rectangle(0, 0, 100, 330);
  Bmp2.Canvas.Rectangle(0, 0, 100, 330);

  Bmp1.Canvas.Pen.Color := clBlack;
  Bmp1.Canvas.Brush.Color := clGray;
  Bmp1.Canvas.Pen.Width := 12 + Random(5);

  Bmp2.Canvas.Pen.Color := clBlack;
  Bmp2.Canvas.Brush.Color := clGray;
  Bmp2.Canvas.Pen.Width := 12 + Random(5);

  Bmp1.Canvas.Ellipse(15, 40, 85, 110);   //Круг колонки слева (верх)
  Bmp1.Canvas.Ellipse(15, 190, 85, 260);   //Круг колонки слева (низ)

  Bmp2.Canvas.Ellipse(15, 40, 85, 110);   //Круги колонки справа (верх)
  Bmp2.Canvas.Ellipse(15, 190, 85, 260);

  Bmp1.Canvas.Pen.Color := clBlack;
  Bmp1.Canvas.Brush.Color := clGray;

  Bmp2.Canvas.Pen.Color := clBlack;
  Bmp2.Canvas.Brush.Color := clGray;

  Bmp1.Canvas.Pen.Width := 1;
  Bmp1.Canvas.Pen.Color := $003E3E31;
  Bmp2.Canvas.Pen.Width := 1;
  Bmp2.Canvas.Pen.Color := $003E3E31;
  Circles(50, 75, Bmp2);
  Circles(50, 225, Bmp1);
  Circles(50, 225, Bmp2);
  Circles(50, 75, Bmp1);

  ImageCol1.Picture.Bitmap.Assign(Bmp1);
  ImageCol2.Picture.Bitmap.Assign(Bmp2);
finally
  Bmp1.Free;
  Bmp2.Free;
end;
end;

end;



procedure TForm4.Timer2Timer(Sender: TObject);
begin
  Col[1] := RGB(Random(255), Random(255), Random(255));
  Col[2] := RGB(Random(255), Random(255), Random(255));
  Col[3] := RGB(Random(255), Random(255), Random(255));
  Col[4] := RGB(Random(255), Random(255), Random(255));
  Col[5] := RGB(Random(255), Random(255), Random(255));
  Col[6] := RGB(Random(255), Random(255), Random(255));
end;

procedure TForm4.TimerTimer(Sender: TObject);
var
  i, Radius, Xc, Yc, N, X1, Y1, X2, Y2 : Integer;
  alpha : double;

begin
  Bmp := TBitmap.Create;
  try
    Bmp := TBitmap.Create;
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
            Bmp.Canvas.Pen.Color := Col[1];
            Bmp.Canvas.MoveTo(i, 0);
            Bmp.Canvas.LineTo(970 - i, 400);
            Bmp.Canvas.Pen.Color := Col[2];
            Bmp.Canvas.MoveTo(970 + i, 0);
            Bmp.Canvas.LineTo(1940 - i, 400);
            Bmp.Canvas.Pen.Color := Col[3];
            Bmp.Canvas.MoveTo(970 + i, 0);
            Bmp.Canvas.LineTo(970 - i, 400);
            Bmp.Canvas.Pen.Color := Col[3];
            Bmp.Canvas.MoveTo(970 - i, 0);
            Bmp.Canvas.LineTo(970 + i, 400);
          end;
        Bmp.Canvas.Pen.Color := Col[4];
        Bmp.Canvas.MoveTo(i, 0);
        Bmp.Canvas.LineTo(1940 - i, 400);
        Bmp.Canvas.Pen.Color := Col[5];
        if i <= 400 then
          begin
            Bmp.Canvas.MoveTo(0, i);
            Bmp.Canvas.LineTo(1940, 400 - i);
          end;
        Inc(i, 20);
      end;

  {  i := -5;
  while i <= 1940  do
    begin
      Bmp.Canvas.Pen.Color := $00020062;
      Bmp.Canvas.Brush.Color := $00020062;
      Bmp.Canvas.Ellipse(i, 0, i + 20, 95);
      Bmp.Canvas.Pen.Color := clBlue;
      Bmp.Canvas.Brush.Color := clBlue;
      Bmp.Canvas.Ellipse(i + 18, 0, i + 38, 95);
      Bmp.Canvas.Pen.Color := clGreen;
      Bmp.Canvas.Brush.Color := clGreen;
      Bmp.Canvas.Ellipse(i + 36, 0, i + 56, 95);
      Bmp.Canvas.Pen.Color := clYellow;
      Bmp.Canvas.Brush.Color := clYellow;
      Bmp.Canvas.Ellipse(i + 14, 0, i + 24, 95);
      Bmp.Canvas.Pen.Color := $004080FF;
      Bmp.Canvas.Brush.Color := $004080FF;
      Bmp.Canvas.Ellipse(i + 35, 0, i + 45, 95);
      inc(i, 50);
    end; }


    Bmp.Canvas.Pen.Color := $00280200;         //$00A8D6E1
    Bmp.Canvas.Brush.Color := $00280200;
    Bmp.Canvas.Rectangle(0, 400, 1940, 650);    //Фон       $003E3E31
    Bmp.Canvas.Ellipse(0, 590, 1940, 710);

    Bmp.Canvas.Pen.Color := $003E3E31;         //$00A8D6E1
    Bmp.Canvas.Brush.Color := $003E3E31;
    Bmp.Canvas.Ellipse(70, 270, 120, 600);    //
    Bmp.Canvas.Ellipse(170, 270, 220, 600);   //Левая Колонка
    Bmp.Canvas.Rectangle(95, 270, 195, 600);                                          //

    Bmp.Canvas.Ellipse(1710, 270, 1760, 600);  //
    Bmp.Canvas.Ellipse(1810, 270, 1860, 600);  //Правая Колонка
    Bmp.Canvas.Rectangle(1735, 270, 1835, 600);//


    Bmp.Canvas.Pen.Color := clBlack;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Pen.Width := 15;
    Bmp.Canvas.Ellipse(110, 310, 180, 380);   //Круг колонки слева (верх)
    Bmp.Canvas.Ellipse(110, 460, 180, 530);   //Круг колонки слева (низ)
    Bmp.Canvas.Pen.Color := clBlack;
    Bmp.Canvas.Brush.Color := clGray;
    Bmp.Canvas.Ellipse(1750, 310, 1820, 380);   //Круги колонки справа (верх)
    Bmp.Canvas.Ellipse(1750, 460, 1820, 530);

    Bmp.Canvas.Pen.Width := 1;
    Bmp.Canvas.Pen.Color := $003E3E31;
    Circles(145, 345, Bmp);
    Circles(145, 495, Bmp);
    Circles(1785, 345, Bmp);
    Circles(1785, 495, Bmp);
    if ii <= 872 then
      begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 40, 960 - ii, 650);
        Bmp.Canvas.Rectangle(960 + ii, 40, 1925, 650);
        inc(ii, 4);
      end
    else
      begin
        Bmp.Canvas.Pen.Color := clBlack;
        Bmp.Canvas.Brush.Color := $00020062;
        Bmp.Canvas.Rectangle(0, 50, 50, 650);
        Bmp.Canvas.Rectangle(1880, 50, 1940, 650);
        Bmp.Canvas.Ellipse(-50, -200, 100, 300);       //Завязанная Левая шторка
        Bmp.Canvas.Ellipse(1990, -200, 1830, 300);     //Правая шторка
      end;
    Bmp.Canvas.Pen.Color := clBlack;
    Bmp.Canvas.Brush.Color := $00020062;
    Bmp.Canvas.Rectangle(0, 0, 1940, 40);
    Image1.Picture.Bitmap.Assign(Bmp);
  finally
    Bmp.Free;
  end;

end;
end.
