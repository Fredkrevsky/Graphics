unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.MPlayer;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Vysotsky: TButton;
    MediaPlayer1: TMediaPlayer;
    Escape: TButton;
    vstupTimer: TTimer;
    ExitButton: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VysotskyClick(Sender: TObject);
    procedure EscapeClick(Sender: TObject);
    procedure vstupTimerTimer(Sender: TObject);
    procedure DrawMan(X, Y:Integer);
    procedure DrawPeople(X1, X2, Y1, Y2:Integer);
    procedure ExitButtonClick(Sender: TObject);
  private
    FTextFile: TextFile;
    procedure DisplayNextLine(X, Y: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Line: string;

implementation

{$R *.dfm}

procedure TForm1.VysotskyClick(Sender: TObject);
begin
  Canvas.Font.Color := clBlack;
  Canvas.Font.Name := 'Arial';
  Canvas.Font.Size := 13;
  AssignFile(FTextFile,
    'C:\Users\User\Desktop\Лабы ОАиП\Лаба мультик\Lyrics\Vysotsky.txt');
  Reset(FTextFile);
  MediaPlayer1.FileName :=
    'C:\Users\User\Desktop\Лабы ОАиП\Лаба мультик\Songs\Vysotsky.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.Play;
  Timer1.Interval := 3450;
  Timer1.Enabled := True;
  Vysotsky.Visible := False;
  Escape.Visible := True;
  DrawPeople(200, ClientWidth-200, ClientHeight div 2, ClientHeight-200);
end;

procedure TForm1.DisplayNextLine(X, Y: Integer);
begin
  if not Eof(FTextFile) then
  begin
    Readln(FTextFile, Line);
    Canvas.TextOut(X, Y, Line);
  end
  else
  begin
    Timer1.Enabled := False;
    Canvas.Rectangle(0, 0, ClientWidth, ClientHeight);
    Vysotsky.Visible := True;
    Escape.Visible := False;
  end;
end;

procedure TForm1.EscapeClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  MediaPlayer1.Stop;
  Escape.Visible := False;
  Vysotsky.Visible := True;
end;

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseFile(FTextFile);
end;

procedure TForm1.vstupTimerTimer(Sender: TObject);
begin
  vstupTimer.Enabled := False;
  Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Canvas.Rectangle(0, 0, ClientWidth, ClientHeight mod 2);
  Canvas.Ellipse(ClientWidth div 2 - 80, 10, ClientWidth div 2 + 330, 140);
  DisplayNextLine(ClientWidth div 2, 50);
  DisplayNextLine(ClientWidth div 2, 75);
end;

procedure TForm1.DrawMan(X, Y:Integer);
begin
  // Нарисовать голову
  Canvas.Ellipse(X - 20, Y, X + 20, Y + 40);

  // Нарисовать тело
  Canvas.MoveTo(X, Y + 40);
  Canvas.LineTo(X, Y + 100);

  // Нарисовать левую руку
  Canvas.MoveTo(X, Y + 60);
  Canvas.LineTo(X - 20, Y + 80);

  // Нарисовать правую руку
  Canvas.MoveTo(X, Y + 60);
  Canvas.LineTo(X + 20, Y + 80);

  // Нарисовать левую ногу
  Canvas.MoveTo(X, Y + 100);
  Canvas.LineTo(X - 20, Y + 140);

  // Нарисовать правую ногу
  Canvas.MoveTo(X, Y + 100);
  Canvas.LineTo(X + 20, Y + 140);
end;

procedure TForm1.DrawPeople(X1, X2, Y1, Y2:Integer);
const
MasX:array[1..10] of integer = (2, -3, -6, -6, 6, 8, 7, -7, -9, 3);
MasY:array[1..10] of integer = (-1, -4, -8, 9, -8, 3, -1, -9, -7, -7);
var i, j, Number:Integer;
begin
  Number:=1;
  i:=X1;
  while (i<=X2) do
  begin
    j:=Y1;
    while j<Y2 do
    begin
      DrawMan(i, j);
      i:=i+MasX[Number];
      j:=j+MasY[Number]+50;
      Number:=Number mod 10 + 1;
    end;
    i:=i+MasX[Number]+50;
  end;
end;

end.
