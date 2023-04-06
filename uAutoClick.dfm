object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RL Auto Clique'
  ClientHeight = 322
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Tag = 10
    Left = 271
    Top = 225
    Width = 268
    Height = 25
    Caption = 'Start (F6)'
    TabOrder = 7
    OnClick = btnStartClick
  end
  object grpOpcoesClique: TGroupBox
    Left = 0
    Top = 60
    Width = 265
    Height = 85
    Caption = 'Op'#231#245'es de Clique'
    TabOrder = 1
    object lbl1: TLabel
      Left = 20
      Top = 25
      Width = 81
      Height = 13
      Caption = 'Bot'#227'o do mouse:'
    end
    object lbl2: TLabel
      Left = 20
      Top = 50
      Width = 69
      Height = 13
      Caption = 'Tipo de clique:'
    end
    object cbbTypeClick: TComboBox
      Left = 120
      Top = 47
      Width = 95
      Height = 21
      ItemIndex = 1
      TabOrder = 1
      Text = 'Duplo'
      OnChange = cbbTypeClickChange
      Items.Strings = (
        'Simples'
        'Duplo')
    end
    object cbbMouseButton: TComboBox
      Left = 120
      Top = 20
      Width = 95
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'Esquerdo'
      OnChange = cbbMouseButtonChange
      Items.Strings = (
        'Esquerdo'
        'Direito'
        'Meio')
    end
  end
  object grpIntervaloClique: TGroupBox
    Left = 0
    Top = 0
    Width = 547
    Height = 57
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Intervalo de Clique'
    TabOrder = 0
    object lbl6: TLabel
      Left = 75
      Top = 24
      Width = 28
      Height = 13
      Caption = 'Horas'
    end
    object lbl7: TLabel
      Left = 195
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Minutos'
    end
    object lbl8: TLabel
      Left = 320
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Segundos'
    end
    object lbl9: TLabel
      Left = 445
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Milisegundos'
    end
    object edtHours: TEdit
      Left = 20
      Top = 20
      Width = 50
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
      Text = '0'
    end
    object edtMiliSec: TEdit
      Left = 390
      Top = 20
      Width = 50
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 3
      Text = '500'
    end
    object edtMin: TEdit
      Left = 140
      Top = 20
      Width = 50
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
      Text = '0'
    end
    object edtSec: TEdit
      Left = 265
      Top = 20
      Width = 50
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
      Text = '2'
    end
  end
  object grpRepetirClique: TGroupBox
    Left = 274
    Top = 60
    Width = 265
    Height = 85
    Caption = 'Repetir Clique'
    TabOrder = 2
    object lbl3: TLabel
      Left = 170
      Top = 25
      Width = 28
      Height = 13
      Caption = 'vezes'
    end
    object se1: TSpinEdit
      Left = 100
      Top = 20
      Width = 65
      Height = 22
      MaxValue = 99999999
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object rbRepeat: TRadioButton
      Left = 20
      Top = 25
      Width = 59
      Height = 17
      Caption = 'Repetir:'
      TabOrder = 0
    end
    object rbRepeat2: TRadioButton
      Left = 20
      Top = 50
      Width = 142
      Height = 17
      Caption = 'Repetir at'#233' mandar parar'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
  object grpPosiçãoCursor: TGroupBox
    Left = 0
    Top = 151
    Width = 539
    Height = 60
    Caption = 'Posi'#231#227'o do cursor'
    TabOrder = 3
    object lbl4: TLabel
      Left = 400
      Top = 25
      Width = 6
      Height = 13
      Caption = 'X'
      Enabled = False
    end
    object lbl5: TLabel
      Left = 470
      Top = 25
      Width = 6
      Height = 13
      Caption = 'Y'
      Enabled = False
    end
    object rbPos: TRadioButton
      Left = 20
      Top = 25
      Width = 119
      Height = 17
      Caption = 'Acompanhar posi'#231#227'o'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbPosClick
    end
    object rbSetPos: TRadioButton
      Left = 233
      Top = 25
      Width = 90
      Height = 17
      Caption = 'Definir posi'#231#227'o'
      TabOrder = 1
      OnClick = rbSetPosClick
    end
    object btnDefinirPos: TButton
      Left = 329
      Top = 20
      Width = 65
      Height = 25
      Caption = 'Definir'
      Enabled = False
      TabOrder = 2
      OnClick = btnDefinirPosClick
    end
    object edtX: TEdit
      Left = 410
      Top = 22
      Width = 50
      Height = 21
      Enabled = False
      TabOrder = 3
      Text = '0'
      OnChange = edtXChange
    end
    object edtY: TEdit
      Left = 482
      Top = 22
      Width = 45
      Height = 21
      Enabled = False
      TabOrder = 4
      Text = '0'
      OnChange = edtYChange
    end
  end
  object grpOpcoesAutoClique: TGroupBox
    Left = 0
    Top = 215
    Width = 265
    Height = 98
    Caption = 'Op'#231#245'es do Auto Clique'
    TabOrder = 4
    object chkFormStyle: TCheckBox
      Left = 32
      Top = 22
      Width = 94
      Height = 17
      Caption = 'Manter no topo'
      TabOrder = 0
      OnClick = chkFormStyleClick
    end
    object chkHideForm: TCheckBox
      Left = 32
      Top = 44
      Width = 141
      Height = 17
      Caption = 'Esconder janela ao iniciar'
      TabOrder = 1
      OnClick = chkHideFormClick
    end
  end
  object btnConfig: TButton
    Left = 271
    Top = 256
    Width = 268
    Height = 25
    Caption = 'Configurar'
    Enabled = False
    TabOrder = 5
  end
  object btnSobre: TButton
    Left = 271
    Top = 287
    Width = 268
    Height = 25
    Caption = 'Sobre'
    Enabled = False
    TabOrder = 6
  end
  object tmr1: TTimer
    Enabled = False
    OnTimer = tmr1Timer
    Left = 512
    Top = 32
  end
  object tmrKeyStatus: TTimer
    Interval = 1
    OnTimer = tmrKeyStatusTimer
    Left = 504
    Top = 96
  end
end
