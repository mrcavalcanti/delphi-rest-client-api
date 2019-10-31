object Frm_PersonList: TFrm_PersonList
  Left = 518
  Top = 112
  Width = 713
  Height = 397
  Caption = 'Person List'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    697
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object pgcInfo: TPageControl
    Left = 12
    Top = 16
    Width = 673
    Height = 329
    ActivePage = tbsInfo
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tbsInfo: TTabSheet
      Caption = 'Informa'#231#245'es'
      DesignSize = (
        665
        301)
      object chkEnableCompression: TCheckBox
        Left = 363
        Top = 276
        Width = 128
        Height = 17
        Caption = 'Enable Compression'
        TabOrder = 0
        OnClick = chkEnableCompressionClick
      end
      object btnReset: TButton
        Left = 273
        Top = 272
        Width = 75
        Height = 25
        Caption = 'Reset'
        TabOrder = 1
        OnClick = btnResetClick
      end
      object btnRemove: TButton
        Left = 184
        Top = 272
        Width = 75
        Height = 25
        Caption = 'Remove'
        TabOrder = 2
        OnClick = btnRemoveClick
      end
      object btnUpdate: TButton
        Left = 96
        Top = 272
        Width = 75
        Height = 25
        Caption = 'Update'
        TabOrder = 3
        OnClick = btnUpdateClick
      end
      object btnAdd: TButton
        Left = 8
        Top = 272
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 4
        OnClick = btnAddClick
      end
      object ListView1: TListView
        Left = 8
        Top = 8
        Width = 649
        Height = 249
        Anchors = [akLeft, akTop, akRight]
        Columns = <
          item
            Caption = 'Id'
          end
          item
            Caption = 'Name'
            Width = 230
          end
          item
            Caption = 'Email'
            Width = 203
          end
          item
            Caption = 'Create Date'
            Width = 120
          end>
        RowSelect = True
        TabOrder = 5
        ViewStyle = vsReport
      end
    end
    object tbsConfig: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 1
      object gbxInfo: TGroupBox
        Left = 4
        Top = 12
        Width = 649
        Height = 261
        Caption = 'Autentica'#231#227'o Servidor de Email '
        TabOrder = 0
        DesignSize = (
          649
          261)
        object lblServidor: TLabel
          Left = 22
          Top = 55
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Servidor'
        end
        object lblUsuario: TLabel
          Left = 25
          Top = 83
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio'
        end
        object lblSenha: TLabel
          Left = 30
          Top = 115
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha'
        end
        object edtServidor: TEdit
          Left = 65
          Top = 48
          Width = 561
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object edtUsuario: TEdit
          Left = 65
          Top = 76
          Width = 561
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object edtSenha: TEdit
          Left = 65
          Top = 108
          Width = 561
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          PasswordChar = '*'
          TabOrder = 2
        end
        object btnConfirmarInfo: TButton
          Left = 468
          Top = 136
          Width = 155
          Height = 25
          Caption = 'Confirmar'
          TabOrder = 3
          OnClick = btnConfirmarInfoClick
        end
      end
    end
  end
end
