object Form4: TForm4
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Form4'
  ClientHeight = 809
  ClientWidth = 1858
  Color = clGray
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
    Width = 1858
    Height = 809
    Align = alClient
    ExplicitWidth = 1846
    ExplicitHeight = 793
  end
  object ImageCol1: TImage
    Left = 76
    Top = 216
    Width = 100
    Height = 330
  end
  object ImageCol2: TImage
    Left = 1388
    Top = 216
    Width = 100
    Height = 330
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 376
    Top = 24
  end
  object Timer: TTimer
    Interval = 1
    OnTimer = TimerTimer
    Left = 432
    Top = 168
  end
  object Timer2: TTimer
    Interval = 500
    OnTimer = Timer2Timer
    Left = 680
    Top = 176
  end
end
