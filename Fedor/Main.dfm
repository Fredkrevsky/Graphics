object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 409
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Vysotsky: TButton
    Left = 32
    Top = 24
    Width = 250
    Height = 50
    Caption = #1042#1083#1072#1076#1080#1084#1080#1088' '#1042#1099#1089#1086#1094#1082#1080#1081' "'#1052#1086#1089#1082#1074#1072' - '#1054#1076#1077#1089#1089#1072'"'
    TabOrder = 0
    OnClick = VysotskyClick
  end
  object MediaPlayer1: TMediaPlayer
    Left = 232
    Top = 68
    Width = 253
    Height = 30
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object Escape: TButton
    Left = 336
    Top = 28
    Width = 105
    Height = 42
    Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1087#1077#1089#1085#1102
    TabOrder = 2
    Visible = False
    OnClick = EscapeClick
  end
  object ExitButton: TButton
    Left = 152
    Top = 176
    Width = 75
    Height = 25
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 3
    OnClick = ExitButtonClick
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 624
    Top = 224
  end
  object vstupTimer: TTimer
    Enabled = False
    OnTimer = vstupTimerTimer
    Left = 656
    Top = 344
  end
end
