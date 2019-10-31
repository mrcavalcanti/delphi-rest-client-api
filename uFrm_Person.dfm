object Frm_Person: TFrm_Person
  Left = 665
  Top = 142
  Width = 504
  Height = 603
  Caption = 'Person'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    488
    564)
  PixelsPerInch = 96
  TextHeight = 13
  object lblId: TLabel
    Left = 58
    Top = 15
    Width = 9
    Height = 13
    Alignment = taRightJustify
    Caption = 'Id'
  end
  object lblNome: TLabel
    Left = 39
    Top = 55
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 10
    Top = 506
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = 'Create Date'
  end
  object lblEmail: TLabel
    Left = 39
    Top = 193
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'E-mail'
  end
  object lblIdentidade: TLabel
    Left = 17
    Top = 83
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'Identidade'
  end
  object lblCPF: TLabel
    Left = 47
    Top = 138
    Width = 20
    Height = 13
    Alignment = taRightJustify
    Caption = 'CPF'
  end
  object lblTelefone: TLabel
    Left = 25
    Top = 166
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Telefone'
  end
  object lblEndereco: TLabel
    Left = 21
    Top = 221
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Endere'#231'o'
  end
  object lblComplemento: TLabel
    Left = 3
    Top = 357
    Width = 64
    Height = 13
    Alignment = taRightJustify
    Caption = 'Complemento'
  end
  object lblNumero: TLabel
    Left = 30
    Top = 329
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'N'#250'mero'
  end
  object lblLogradouro: TLabel
    Left = 13
    Top = 302
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = 'Logradouro'
  end
  object lblCEP: TLabel
    Left = 46
    Top = 274
    Width = 21
    Height = 13
    Alignment = taRightJustify
    Caption = 'CEP'
  end
  object lblPais: TLabel
    Left = 45
    Top = 469
    Width = 22
    Height = 13
    Alignment = taRightJustify
    Caption = 'Pa'#237's'
  end
  object lblEstado: TLabel
    Left = 34
    Top = 441
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Estado'
  end
  object lblCidade: TLabel
    Left = 34
    Top = 414
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Cidade'
  end
  object lblBairro: TLabel
    Left = 40
    Top = 386
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Bairro'
  end
  object Label1: TLabel
    Left = 76
    Top = 112
    Width = 223
    Height = 13
    Caption = 'Permitido CPF como: 11111111111 (para teste)'
  end
  object Label2: TLabel
    Left = 72
    Top = 248
    Width = 213
    Height = 13
    Caption = 'Exemplo de formato para o CEP: 029060-130'
  end
  object edtId: TEdit
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    TabStop = False
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object edtNome: TEdit
    Left = 72
    Top = 48
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 72
    Top = 531
    Width = 75
    Height = 25
    Caption = 'Confirm'
    ModalResult = 1
    TabOrder = 16
  end
  object btnCancel: TButton
    Left = 176
    Top = 531
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 17
  end
  object edtEmail: TEdit
    Left = 72
    Top = 186
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
  end
  object edtCreateDate: TEdit
    Left = 72
    Top = 499
    Width = 121
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 15
  end
  object edtIdentidade: TEdit
    Left = 72
    Top = 76
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object edtCPF: TEdit
    Left = 72
    Top = 131
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 11
    TabOrder = 3
    OnExit = edtCPFExit
  end
  object edtTelefone: TEdit
    Left = 72
    Top = 159
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object edtEndereco: TEdit
    Left = 72
    Top = 214
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
  end
  object edtComplemento: TEdit
    Left = 72
    Top = 350
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 10
  end
  object edtNumero: TEdit
    Left = 72
    Top = 322
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 9
  end
  object edtLogradouro: TEdit
    Left = 72
    Top = 295
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 8
  end
  object edtCEP: TEdit
    Left = 72
    Top = 267
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
    OnChange = edtCEPChange
  end
  object edtPais: TEdit
    Left = 72
    Top = 462
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 14
  end
  object edtEstado: TEdit
    Left = 72
    Top = 434
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 13
  end
  object edtCidade: TEdit
    Left = 72
    Top = 407
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 12
  end
  object edtBairro: TEdit
    Left = 72
    Top = 379
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 11
  end
end
