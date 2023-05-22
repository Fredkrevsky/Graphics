unit uHuman;
interface
uses
  Winapi.Windows, System.Classes, Vcl.Graphics;
type
 TanimData = record
   duration:integer;
   sdstart:integer;
   sdlength:integer;
   sustart:integer;
   sulength:integer;
   startpoint:TPoint;
   endpoint:TPoint;
 end;
 Tanimdatas = array of TanimData;
 TGuitar = class
    gtype  :1..2;
    Body   :TArray<TPoint>;
    Body2  :TArray<TPoint>;
    bridge :TArray<TPoint>;
    Grif   :TArray<TPoint>;
    Head   :TArray<TPoint>;
    Hole   :TArray<TPoint>;
    Peg    :TArray<TPoint>;
    Line   :TArray<TPoint>;
    lineframe: Integer;
    cosa, sina:Double;
    source:TBitmap;
    const xc=100;
          yc=100;
  public
    constructor Create;
    procedure changetype(t:Integer);
    procedure draw(dest:TCanvas; x, y:Integer; newlineframe:integer);
    procedure rotate(angle:double);
    procedure changelineframe(frame:Integer);
  private
    procedure redraw();
    procedure newpoints();
  end;
Tredraw = procedure() of object;
Tlimb = (llarm, lrarm, llleg, lrleg);
THuman = class
    redraw:Tredraw;
    fbodyup:TPoint;
    fBodydown:TPoint;
    flimbs:array[TLimb] of TPoint;
    flclock:array[TLimb] of boolean;
    source:TBitmap;
    fguitar:TGuitar;
    gxc, gyc:integer;
    const headr = 20;
          arm1 = 60;
          arm2 = 50;
          leg1 = 35;
          leg2 = 45;
          xc=200;
          yc=200;
          linewidth = 4;
      constructor Create;
    public
      procedure setlimb(ltype: TLimb;centerpoint, newpoint: TPoint; const maxl: integer);
      procedure setbodyup(x, y:Integer);
      procedure draw(dest:TCanvas; x, y:Integer);
      function FindThirdPoint(var P0, P1:TPoint; a,b:double; clockwise:boolean; gravity:boolean):TPoint;
      procedure DrawWithGuitar(x, y:integer);
      procedure DrawWithoutGuitar();
      procedure setrarm(a:TPoint);
      procedure setlarm(a:TPoint);
      procedure setrleg(a:TPoint);
      procedure setlleg(a:TPoint);
      property rleg :TPoint read flimbs[lrleg] write setrleg;
      property lleg :TPoint read flimbs[llleg] write setlleg;
      property rarm :TPoint read flimbs[lrarm] write setrarm;
      property larm :TPoint read flimbs[llarm] write setlarm;
      property rlegdir :boolean write flclock[lrleg];
      property llegdir :boolean write flclock[llleg];
      property rarmdir :boolean write flclock[lrarm];
      property larmdir :boolean write flclock[llarm];
      property guitar :TGuitar read fguitar write fguitar;
    private
      procedure redrawwithoutg();
      procedure redrawwithg();

  end;

procedure rarmanim(t:integer; human:THuman; data:TanimData);
implementation




constructor THuman.Create;
begin
  inherited;
  fguitar:= TGuitar.create();
  fbodyup:=Point(0, -80);
  fbodydown:=Point(0,0);
  flimbs[lrarm]:=Point(10,-30);
  flimbs[llarm]:=Point(50,-90);
  flimbs[lrleg]:=Point(-30,90);
  flimbs[llleg]:=Point(+30,90);
  source:=TBitmap.Create(400, 400);
  source.Transparent:=true;
  redraw:= redrawwithoutg;
  redraw();
end;
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

procedure THuman.draw(dest: TCanvas; x, y: Integer);
begin
    dest.Draw(x-xc, y-yc, source);
    ///dest.CopyMode:=cmSrcAnd;
    ///dest.CopyRect(Rect(x-Trunc(xc*scale),y-Trunc(yc*scale),x+Trunc(xc*scale), y+Trunc(yc*scale)), source.canvas, Rect(0,0, source.width, source.height));
end;

procedure THuman.DrawWithGuitar;
begin
  redraw:=redrawwithg;
  gxc:= x;
  gyc:= y;
  redraw();
end;


procedure THuman.DrawWithoutGuitar;
begin
  redraw:=redrawwithoutg;
  redraw();
end;

procedure THuman.redrawwithg;
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
      ///тело
      PolyLine([center+fbodydown,
                center+fbodyup]);
      ///голова
      Ellipse(Rect(center+fBodyUp+Point(-headr, -headr*2), center+fBodyUp+Point(headr, 0)));
      ///правая нога
      PolyLine([center+fBodydown,
                center+FindThirdPoint(fBodydown, flimbs[lrleg], leg1, leg2, flclock[lrleg], false),
                center+flimbs[lrleg]]);
      ///левая нога
      PolyLine([center+fBodydown,
                center+FindThirdPoint(fBodydown, flimbs[llleg], leg1, leg2, flclock[llleg], false),
                center+flimbs[llleg]]);
      ///левая рука
      temp:=center+FindThirdPoint(fBodyup, flimbs[llarm], arm1, arm2, flclock[llarm], true);
      PolyLine([center+fBodyup,
                temp]);
      PolyLine([temp,
                center+flimbs[llarm]]);
      ///гитара
      Draw(gxc-100+xc,gyc-100+yc, guitar.source);
      ///левая рука поверх грифа
      PolyLine([center+flimbs[llarm],
                Point((temp.x+center.x+flimbs[llarm].x) div 2, (temp.y+center.y+flimbs[llarm].y) div 2)]);

      ///правая рука поверх гитары
      PolyLine([center+fBodyup,
                center+FindThirdPoint(fBodyup, flimbs[lrarm], arm1, arm2, flclock[lrarm], true),
                center+flimbs[lrarm]]);
    end;
end;

procedure THuman.redrawwithoutg;
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
      ///тело
      PolyLine([center+fbodydown, center+fbodyup]);
      ///голова
      Ellipse(Rect(center+fBodyUp+Point(-headr, -headr*2),center+fBodyUp+Point(headr, 0)));
      ///правая нога
      PolyLine([center+fBodydown, center+FindThirdPoint(fBodydown, flimbs[lrleg], leg1, leg2, flclock[lrleg], false),center+flimbs[lrleg]]);
      ///левая нога
      PolyLine([center+fBodydown, center+FindThirdPoint(fBodydown, flimbs[llleg], leg1, leg2, flclock[llleg], false),center+flimbs[llleg]]);
      ///левая рука
      PolyLine([center+fBodyup,
                center+FindThirdPoint(fBodyup, flimbs[llarm], arm1, arm2, flclock[llarm], true),
                center+flimbs[llarm]]);
      ///правая рука
      PolyLine([center+fBodyup,
                center+FindThirdPoint(fBodyup, flimbs[lrarm], arm1, arm2, flclock[lrarm], true),
                center+flimbs[lrarm]]);
    end;
end;

procedure THuman.setlimb;
var c:double;
    x, y:integer;
begin
  x:=newpoint.x;
  y:=newpoint.y;
  c:=sqrt((x-centerpoint.x)*(x-centerpoint.x)+(y-centerpoint.y)*(y-centerpoint.y));
  if c>maxl then
    begin
      x:=centerpoint.x+Round((x-centerpoint.x)*(maxl)/c);
      y:=centerpoint.y+Round((y-centerpoint.y)*(maxl)/c);
    end;
  flimbs[ltype].x:=x;
  flimbs[ltype].y:=y;
end;

procedure THuman.setbodyup(x, y: Integer);
begin
  fbodyup.x:=x;
  fbodyup.y:=y;
  redraw();
end;

procedure THuman.setlarm;
begin
  setlimb(llarm,fbodyup, a, arm1+arm2);
  redraw();
end;



procedure THuman.setlleg;
begin
  setlimb(llleg,fbodydown, a, leg1+leg2);
  redraw();
end;

procedure THuman.setrarm;
var c:double;
begin
  setlimb(lrarm,fbodyup, a, arm1+arm2);
  redraw();
end;

procedure THuman.setrleg;
var c:double;
begin
  setlimb(lrleg,fbodydown, a, leg1+leg2);
  redraw();
end;

procedure TGuitar.changetype(t: Integer);
begin
  if (t=1) or(t=2) then
  begin
    gtype:=t;
    newpoints();
    redraw();
  end;
end;

constructor TGuitar.Create;
begin
  inherited;
  gtype:=1;
  newpoints();
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
  if gtype=1 then
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
    end
  else
    with source do begin
    canvas.pen.color:=clwhite;
    canvas.brush.color:=clwhite;
    canvas.rectangle(0,0,200, 200);
    Canvas.Pen.Color := clBlack;
    Canvas.PolyBezier(add(body, 0, 0 ,false));
    Canvas.PolyBezier(add(body2, 0, 0 ,false));

    Canvas.Brush.Color :=Rgb(47, 27, 28);
    Canvas.Polygon(add(bridge, 0, 0 ,false));

    Canvas.Brush.Color :=Rgb(65, 65, 65);
    Canvas.Polygon(add(Grif, 0, 0 ,false));

    Canvas.Brush.Color :=Rgb(108, 31, 5);
    Canvas.Polygon(add(Head, 0, 0 ,false));

    //Canvas.Brush.Color :=Rgb(26, 19, 9);
    //Canvas.Ellipse(xc-8, yc-8, xc+8, yc+8);

    Canvas.Brush.Color :=clRed;
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




procedure TGuitar.newpoints;
begin
  if gtype =1 then
    begin
      Body:=   [Point(-40, -28),
                Point(-20, -30),Point(-8, -12),
                Point(8, -23),
                Point(28, -23), Point(28, 23),
                Point(8, 23),
                Point(-8, 12), Point(-20, 30),
                Point(-30, 28),
                Point(-56, 28), Point(-56, -28),
                Point(-40, -28)];
      Bridge:= [Point(-29, -14),Point(-26, -14),Point(-26, 14), Point(-29, 14)];
      Grif:=   [Point(3, -5), Point(74, -5), Point(74, 5), Point(3, 5)];
      Head:=   [Point(74, -6), Point(97, -6), Point(97, 6), Point(74, 6)];
      Peg:=    [Point(76, -9), Point(79, -9), Point(79, -7),Point(76, -7)];
      Line:=   [Point(-27, -3),Point(-14, -3), Point(-14, -3), Point(0, -3)];
    end
  else
    begin
      Body:=   [Point(-24, -28),
                Point(-10, -30),Point(-8, -12),
                Point(18, -23),
                Point(28, -23), Point(28, -23),
                Point(38, -20),
                Point(35, -5), Point(18, -25),
                Point(18, 0),
                Point(5, 10), Point(5, 20),
                Point(24, 20),
                Point(30, 20), Point(27, 25),
                Point(24, 25),
                Point(22, 26), Point(20, 26),
                Point(6, 27),
                Point(-20, 25), Point(-6, 20),
                Point(-33, 30),
                Point(-56, 38), Point(-56, -28),
                Point(-24, -28)];
      Body2:=   [Point(-8, -10),
                Point(-2, -8),Point(-8, -12),
                Point(16, -5){,
                Point(28, -23), Point(28, -23),
                Point(38, -20),
                Point(35, -5), Point(18, -25),
                Point(18, 0),
                Point(5, 10), Point(5, 20),
                Point(24, 20),
                Point(30, 20), Point(27, 25),
                Point(24, 25),
                Point(22, 26), Point(20, 26),
                Point(6, 27),
                Point(-20, 25), Point(-6, 20),
                Point(-33, 30),
                Point(-56, 38), Point(-56, -28),
                Point(-24, -28)}];
      Bridge:= [Point(-29, -14),Point(-26, -14),Point(-26, 14), Point(-29, 14)];
      Grif:=   [Point(3, -5), Point(74, -5), Point(74, 5), Point(3, 5)];
      Head:=   [Point(74, -6), Point(97, -6), Point(97, 6), Point(74, 6)];
      Peg:=    [Point(76, -9), Point(79, -9), Point(79, -7),Point(76, -7)];
      Line:=   [Point(-27, -3),Point(-14, -3), Point(-14, -3), Point(0, -3)];
    end
end;


procedure rarmanim(t:integer; human:THuman; data:TanimData);
var temp, temp2:TPoint;
    progress:double;
begin
  with data, human do
  if (sdstart<>-1) and (duration>0) then
    begin

      if t<sdstart then
        begin
          temp:=startpoint;
        end
      else
        if (t>=sdstart) and (t<=sdstart+sdlength) then
          begin
            progress:= (1-cos( PI * (t-sdstart)/sdlength))/2;
            temp:=Point(startpoint.x+Round((endpoint.x-startpoint.x)*progress),
                        startpoint.y+Round((endpoint.y-startpoint.y)*progress));
          end
      else
        if (t>sdstart+sdlength) and (t<sustart) then
          begin
            temp:=endpoint;
          end
      else
        if (t>=sustart) and (t<=sustart+sulength) then
          begin
            progress:= (1-cos( PI * (t-sustart)/sulength))/2;
            temp:=Point(endpoint.x+Round((startpoint.x-endpoint.x)*progress),
                        endpoint.y+Round((startpoint.y-endpoint.y)*progress));
          end
      else
        begin
          temp:=startpoint;
        end;
      temp2.X:=Round(temp.X*guitar.cosa-temp.Y*guitar.sina);
      temp2.Y:=Round(temp.X*guitar.sina+temp.Y*guitar.cosa);
      temp2:=temp2+Point(gxc, gyc);
      rarm:=temp2;
    end;
end;
end.
