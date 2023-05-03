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
  object ImageScene: TImage
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
  object MediaPlayer1: TMediaPlayer
    Left = 816
    Top = 368
    Width = 253
    Height = 30
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object TimerColorChange: TTimer
    Interval = 500
    OnTimer = TimerColorChangeTimer
    Left = 992
    Top = 48
  end
  object TimerHand: TTimer
    Interval = 20
    OnTimer = TimerHandTimer
    Left = 912
    Top = 48
  end
  object TimerFonMotion: TTimer
    Interval = 1
    OnTimer = TimerFonMotionTimer
    Left = 832
    Top = 48
  end
  object Pause: TTimer
    Interval = 1725
    OnTimer = PauseTimer
    Left = 744
    Top = 48
  end
  object Play: TTimer
    Enabled = False
    Interval = 1725
    OnTimer = PlayTimer
    Left = 672
    Top = 48
  end
  object Titres: TTimer
    Enabled = False
    Interval = 20
    OnTimer = TitresTimer
    Left = 600
    Top = 48
  end
end
