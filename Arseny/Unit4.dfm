object Form4: TForm4
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Form4'
  ClientHeight = 1080
  ClientWidth = 1920
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 1920
    Height = 1080
    Align = alClient
    ExplicitLeft = 64
    ExplicitTop = 120
    ExplicitWidth = 1782
    ExplicitHeight = 673
  end
  object TimerFonMotion: TTimer
    Interval = 1
    OnTimer = TimerFonMotionTimer
    Left = 432
    Top = 168
  end
end
