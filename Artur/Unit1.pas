unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, System.Types,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    Image1: TImage;
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
  Tframe = 0..100;
  Guitar = class
    Body   :TArray<TPoint>;
    bridge :TArray<TPoint>;
    Grif   :TArray<TPoint>;
    Head   :TArray<TPoint>;
    Hole   :TArray<TPoint>;
    Peg    :TArray<TPoint>;
    Line   :TArray<TPoint>;
    lineframe: Tframe;
    cosa, sina:Double;
    source:TBitmap;
  public
    constructor Create;
    procedure draw(dest:TCanvas; x, y:Integer; newlineframe:integer);
    procedure rotate(angle:double);
    procedure changelineframe(frame:Integer);
  private
    procedure redraw();
  end;
var
  Form1: TForm1;
  guit:Guitar;
  t:integer;
implementation

{$R *.dfm}
constructor Guitar.Create;
begin
  inherited;
  Body:=   [Point(-30, -28),
            Point(-20, -30),Point(-8, -12),
            Point(8, -23),
            Point(28, -23), Point(28, 23),
            Point(8, 23),
            Point(-8, 12), Point(-20, 30),
            Point(-30, 28),
            Point(-56, 28), Point(-56, -28),
            Point(-30, -28)];
  Bridge:= [Point(-29, -14),Point(-26, -14),Point(-26, 14), Point(-29, 14)];
  Grif:=   [Point(3, -5), Point(74, -5), Point(74, 5), Point(3, 5)];
  Head:=   [Point(74, -6), Point(97, -6), Point(97, 6), Point(74, 6)];
  Peg:=    [Point(76, -9), Point(79, -9), Point(79, -7),Point(76, -7)];
  Line:=   [Point(-27, -3),Point(-14, -3), Point(-14, -3), Point(0, -3)];
  lineframe:=0;
  sina:=0;
  cosa:=1;
  source:=TBitmap.Create(200, 200);
  source.Transparent:=true;
  redraw();
end;

procedure Guitar.redraw();
const xc=100; yc=100;
function add(const A:TArray<TPoint>; x1, y1:integer; flip:boolean):TArray<TPoint>;
var j,X, Y:integer;
begin
  Setlength(Result, Length(A));
  for j := Low(A) to High(A) do
    begin
      Result[j]:=A[j]+ Point(x1, y1-2*(A[j].Y+y1)*Ord(flip));
      X:=Round(Result[j].X*cosa-Result[j].Y*sina);
      Y:=Round(Result[j].X*sina+Result[j].Y*cosa);
      Result[j]:=Point(X,Y)+Point(xc, yc);
    end;
end;
var i, k:integer;
begin
  with source do begin
  canvas.pen.color:=clwhite;
  canvas.brush.color:=clwhite;
  canvas.rectangle(0,0,200, 200);
  Canvas.Pen.Color := clBlack;
  Canvas.PolyBezier(add(body, 0, 0 ,false));

  Canvas.Brush.Color :=Rgb(47, 27, 28);
  Canvas.Polygon(add(bridge, 0, 0 ,false));

  Canvas.Brush.Color :=Rgb(65, 65, 65);
  Canvas.Polygon(add(Grif, 0, 0 ,false));

  Canvas.Brush.Color :=Rgb(108, 31, 5);
  Canvas.Polygon(add(Head, 0, 0 ,false));

  Canvas.Brush.Color :=Rgb(26, 19, 9);
  Canvas.Ellipse(xc-8, yc-8, xc+8, yc+8);

  Canvas.Brush.Color :=Rgb(225, 165, 105);
  Canvas.FloodFill(xc-Round(12*cosa), yc-Round(12*sina), clBlack, fsBorder);

  Canvas.Brush.Color :=Rgb(169, 169, 169);
  for i := 0 to 2 do
    begin
      Canvas.Polygon(add(Peg, 7*i, 0, false));
      Canvas.Polygon(add(Peg, 7*i, 0, true));
    end;
  Canvas.Pen.Color := RGB(255, 254, 255);
  for i := 0 to 2 do
    for k := 0 to 3 do
      Canvas.PolyBezier(add(Line, 27*k, i*3 ,false));
  end;

end;

procedure Guitar.rotate;
begin
  sina:=sin(angle);
  cosa:=cos(angle);
  redraw();
end;

procedure Guitar.changelineframe;
var y1, y2:integer;
begin
  if frame<>lineframe then
    begin
      lineframe:=frame;
      if frame > 2 then
      begin
        Line[1].Y:=3*(frame mod 2)-3;
        Line[2].Y:=-3*(frame mod 2)-3;
      end
      else
      begin
        Line[2].Y:=3*(frame mod 2)-3;
        Line[1].Y:=-3*(frame mod 2)-3;
      end;
      redraw();
    end;
end;

procedure Guitar.draw;

begin
  ///dest.CopyRect(TRect.Create(x-100, y-100, x+100, y+100), source.Canvas, TRect.Create(0, 0, 200, 200));
  dest.Draw(x-100, y-100, source);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  //основание
  {(*Image2.Canvas.arc(1, 3, 40, 59, 22, 3, 22, 59);     *)
  Image2.Canvas.PolyBezier([Point(21,3), Point(31,1), Point(43, 19),
  Point(59, 8), Point(79, 8), Point(79,54), Point(59,54), Point(43,43),
  Point(31, 61), Point(21, 59),Point(-5, 59), Point(-5, 3), Point(21,3)]);
  (*Image2.Canvas.arc(44, 8, 75, 54, 59, 54, 59, 8);
  Image2.Canvas.PolyBezier([Point(59,54), Point(43,43), Point(31, 61), Point(21, 59)]);*)
  //палка
  Image2.Canvas.Brush.Color :=Rgb(47, 27, 28);
  Image2.Canvas.Rectangle(22, 17, 26, 45);
  //длинная палка или как там
  Image2.Canvas.Brush.Color :=Rgb(65, 65, 65);
  Image2.Canvas.Rectangle(54, 26, 125, 37);
  //гриф
  Image2.Canvas.Brush.Color :=Rgb(108, 31, 5);
  Image2.Canvas.Rectangle(125, 25, 148, 38);
  //дырка
  Image2.Canvas.Brush.Color :=Rgb(26, 19, 9);
  Image2.Canvas.Ellipse(51-7, 31-7, 51+7, 31+7);
  //цвет
  Image2.Canvas.Brush.Color :=Rgb(225, 165, 105);
  Image2.Canvas.FloodFill(22, 49, clBlack, fsBorder);
  ///крутилки
  Image2.Canvas.Brush.Color :=Rgb(169, 169, 169);
  for i := 0 to 2 do
    begin
      Image2.Canvas.Rectangle(126+i*7, 22, 130+i*7, 25);
      Image2.Canvas.Rectangle(126+i*7, 41, 130+i*7, 38);
    end;
  ///струны
  Image2.Canvas.Pen.Color := clWhite;
  for i := 0 to 2 do
    begin
      Image2.Canvas.MoveTo(24, 28+i*3);
      Image2.Canvas.LineTo(130, 28+i*3);
    end; }


  guit := Guitar.Create;
  guit.rotate(-1);
  guit.draw(Image1.Canvas, 100, 100,0);
  t:=0
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var t2:integer;
begin

  if t div 5 mod 10 = 0 then
    guit.changelineframe(t mod 5);

  Image1.Canvas.Rectangle(-1,-1, 201, 201);
  guit.draw(Image1.Canvas, 100, 100,0 );
  inc(t);
end;

end.
