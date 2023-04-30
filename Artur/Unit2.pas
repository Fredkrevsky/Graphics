unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 THuman = class
    headr :Integer;
    bodyup:TPoint;
    Bodydown:TPoint;
    rightarm:TPoint;
    leftarm:TPoint;
    rightleg:TPoint;
    leftleg:TPoint;
    source:TBitmap;
    const arm1 = 60;
          arm2 = 50;
          leg1 = 45;
          leg2 = 55;
          xc=200;
          yc=200;
          linewidth = 4;
      constructor Create;
    public
      procedure setrarm(x, y:Integer);
      procedure setlarm(x, y:Integer);
      procedure setrleg(x, y:Integer);
      procedure setlleg(x, y:Integer);
      procedure setbodyup(x, y:Integer);
      procedure draw(dest:TCanvas; x, y:Integer);
      function FindThirdPoint(var P0, P1:TPoint; a,b:double; clockwise:boolean; gravity:boolean):TPoint;
      procedure DrawWithGuitar(guitarsource:TBitmap; x, y:integer);
    private
      procedure redraw();
  end;

  Tframe = 0..100;
  TGuitar = class
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
    const xc=100;
          yc=100;
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
  point1, point2, point3:TPoint;
  t:integer;
  h:THuman;
  g:TGuitar;
  guitx, guity:integer;
  guitangle:double;
implementation



{$R *.dfm}



function  THuman.FindThirdPoint(var P0, P1:TPoint; a,b:double; clockwise:boolean; gravity:boolean):TPoint;
const sign : array [boolean] of integer = (-1, 1);
var c, c1, cos1, cosc, sinc:double;
    x, y:double;
begin
  c1:=sqrt((P0.x-P1.x)*(P0.x-P1.x)+(P0.y-P1.y)*(P0.y-P1.y));
  if (c1>a+b) or (b>a+c1+0.1) or (a>b+c1) then
    begin
    c:=a+b;
    end
  else
    c:=c1;
  cos1:=(a*a+c*c-b*b)/(2*a*c);
  sinc:=(P1.y-P0.y)/c1;
  cosc:=(P1.x-P0.x)/c1;
  x:=a*cos1;
  y:=a*sqrt(1-cos1*cos1);
  if not gravity then
    y:=y*sign[clockwise]
  else
    y:=y*sign[cosc>0];
  result.x:=P0.x+Round(x*cosc-y*sinc);
  result.y:=P0.y+Round(x*sinc+y*cosc);
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  t:=0;
  guitangle:=-0.5;
  guitx:=30;
  guity:=-30;
  point1:=Point(50, 50);
  point2:=Point(50+Round(40*cos(t)), 50+Round(40*sin(t)));
  h:=thuman.create();
  g:=TGuitar.Create();

  g.rotate(guitangle);
  h.setbodyup(10, -80);

  h.setlarm(guitx+Round(60*cos(guitangle)),guity+Round(60*sin(guitangle)));
  ///h.draw(Paintbox1.canvas, 300, 300);
  h.DrawWithGuitar(g.source, guitx, guity);
  h.draw(Image1.canvas, 200, 200);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(t);
  {point2:=Point(80+Round(20*cos(t*0.04)), 80+Round(20*sin(t*0.04)));
  point3:=h.FindThirdPoint(point1, point2, 40, 40, false, true);
  PaintBox1.canvas.Rectangle(0,0, 200, 200);
  PaintBox1.canvas.Polyline([point1, point3, point2]);  }
  //if sin(t*0.3)<0 then
  //g.changelineframe(t mod 5);
  h.setrarm(guitx, guity+Round(5*cos(t*0.3)));
  Image1.canvas.Rectangle(0,0, 500, 500);
  h.DrawWithGuitar(g.source, guitx, guity);
  h.draw(Image1.canvas, 200, 200);
end;

{ THuman }

constructor THuman.Create;
begin
  inherited;
  headr:=20;
  bodyup:=Point(0, -90);
  bodydown:=Point(0,0);
  rightarm:=Point(10,-30);
  leftarm:=Point(50,-90);
  rightleg:=Point(-30,90);
  leftleg:=Point(+30,90);
  source:=TBitmap.Create(400, 400);
  source.Transparent:=true;

  redraw();
end;

procedure THuman.draw(dest: TCanvas; x, y: Integer);
begin
    dest.Draw(x-xc, y-yc, source);
end;

procedure THuman.DrawWithGuitar(guitarsource: TBitmap; x, y:integer);
var center, temp : TPoint;

begin
  center.x:=xc;
  center.y:=yc;
  with source.canvas do
    begin
      brush.color:=clWhite;
      pen.Color:=clWhite;
      Pen.Width:= linewidth;
      Rectangle(-1,-1,400,400);
      brush.color:=RGB(255,254,255);
      pen.Color:=clBlack;
      PolyLine([center+bodydown, center+bodyup]);
      Ellipse(Rect(center+BodyUp+Point(-headr, -headr*2),center+BodyUp+Point(headr, 0)));
      PolyLine([center+Bodydown, center+FindThirdPoint(Bodydown, rightleg, leg1, leg2, true, false),center+rightleg]);
      PolyLine([center+Bodydown, center+FindThirdPoint(Bodydown, leftleg, leg1, leg2, false, false),center+leftleg]);
      temp:=center+FindThirdPoint(Bodyup, leftarm, arm1, arm2, false, true);
      PolyLine([center+Bodyup, temp]);
      PolyLine([temp,center+leftarm]);
      Draw(x-100+xc,y-100+yc, guitarsource);
      PolyLine([center+Bodyup, center+FindThirdPoint(Bodyup, rightarm, arm1, arm2, true, false),center+rightarm]);

    end;
end;


procedure THuman.redraw();

var center : TPoint;
begin
  center.x:=xc;
  center.y:=yc;
  with source.canvas do
    begin
      brush.color:=clWhite;
      pen.Color:=clWhite;
      Pen.Width:= linewidth;
      Rectangle(-1,-1,300,300);
      brush.color:=RGB(255,254,255);
      pen.Color:=clBlack;
      PolyLine([center+bodydown, center+bodyup]);
      Ellipse(Rect(center+BodyUp+Point(-headr, -headr*2),center+BodyUp+Point(headr, 0)));
      PolyLine([center+Bodyup, center+FindThirdPoint(Bodyup, rightarm, arm1, arm2, true, false),center+rightarm]);
      PolyLine([center+Bodyup, center+FindThirdPoint(Bodyup, leftarm, arm1, arm2, false, false),center+leftarm]);
      PolyLine([center+Bodydown, center+FindThirdPoint(Bodydown, rightleg, leg1, leg2, true, false),center+rightleg]);
      PolyLine([center+Bodydown, center+FindThirdPoint(Bodydown, leftleg, leg1, leg2, false, false),center+leftleg]);
    end;
end;


procedure THuman.setbodyup(x, y: Integer);
begin
  bodyup.x:=x;
  bodyup.y:=y;
end;

procedure THuman.setlarm(x, y: Integer);
var c:double;
begin
  c:=sqrt((x-bodyup.x)*(x-bodyup.x)+(y-bodyup.y)*(y-bodyup.y));
  if c>arm1+arm2 then
    begin
      x:=bodyup.x+Round((x-bodyup.x)*(arm1+arm2)/c);
      y:=bodyup.y+Round((y-bodyup.y)*(arm1+arm2)/c);
    end;
  leftarm.x:=x;
  leftarm.y:=y;
  redraw();
end;

procedure THuman.setlleg(x, y: Integer);
var c:double;
begin
  c:=sqrt((x-bodydown.x)*(x-bodydown.x)+(y-bodydown.y)*(y-bodydown.y));
  if c>leg1+leg2 then
    begin
      x:=bodydown.x+Round((x-bodydown.x)*(arm1+arm2)/c);
      y:=bodydown.y+Round((y-bodydown.y)*(arm1+arm2)/c);
    end;
  leftleg.x:=x;
  leftleg.y:=y;
  redraw();
end;

procedure THuman.setrarm(x, y: Integer);
var c:double;
begin
  c:=sqrt((x-bodyup.x)*(x-bodyup.x)+(y-bodyup.y)*(y-bodyup.y));
  if c>arm1+arm2 then
    begin
      x:=bodyup.x+Round((x-bodyup.x)*(arm1+arm2)/c);
      y:=bodyup.y+Round((y-bodyup.y)*(arm1+arm2)/c);
    end;
  rightarm.x:=x;
  rightarm.y:=y;
  redraw();
end;

procedure THuman.setrleg(x, y: Integer);
var c:double;
begin
  c:=sqrt((x-bodydown.x)*(x-bodydown.x)+(y-bodydown.y)*(y-bodydown.y));
  if c>leg1+leg2 then
    begin
      x:=bodydown.x+Round((x-bodydown.x)*(arm1+arm2)/c);
      y:=bodydown.y+Round((y-bodydown.y)*(arm1+arm2)/c);
    end;
  rightleg.x:=x;
  rightleg.y:=y;
  redraw();
end;

constructor TGuitar.Create;
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

procedure TGuitar.redraw();

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

procedure TGuitar.rotate;
begin
  sina:=sin(angle);
  cosa:=cos(angle);
  redraw();
end;

procedure TGuitar.changelineframe;
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

procedure TGuitar.draw;
begin
  ///dest.CopyRect(TRect.Create(x-100, y-100, x+100, y+100), source.Canvas, TRect.Create(0, 0, 200, 200));
  dest.Draw(x-xc, y-yc, source);
end;




end.
