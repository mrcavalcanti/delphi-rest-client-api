unit uFrm_Person;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, RestUtils, Person;

type
    TFrm_Person = class(TForm)
    lblId: TLabel;
    lblNome: TLabel;
    Label3: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    lblEmail: TLabel;
    edtEmail: TEdit;
    edtCreateDate: TEdit;
    lblIdentidade: TLabel;
    edtIdentidade: TEdit;
    lblCPF: TLabel;
    edtCPF: TEdit;
    lblTelefone: TLabel;
    edtTelefone: TEdit;
    edtEndereco: TEdit;
    lblEndereco: TLabel;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    lblCEP: TLabel;
    edtCEP: TEdit;
    lblPais: TLabel;
    edtPais: TEdit;
    lblEstado: TLabel;
    edtEstado: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edtCEPChange(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
    private
        FIsNew: Boolean;
        procedure Fill(APerson: TPerson);
        procedure ReadFromForm(APerson: TPerson);
    public
        class function Modify(var APerson: TPerson): Boolean;
    end;

implementation

uses uDM, uUtils, uMail;

{$R *.dfm}

{ TFrm_Person }

procedure TFrm_Person.Fill(APerson: TPerson);
var
    vOnChange: TNotifyEvent;
begin
    FIsNew := (APerson = nil);
    edtCreateDate.Visible := not FIsNew;
    if not FIsNew then
    begin
        edtId.Text := IntToStr(APerson.id);
        edtNome.Text := APerson.name;
        edtEmail.Text := APerson.email;
        edtIdentidade.Text := APerson.ident;
        edtCPF.Text := APerson.cpf;
        edtTelefone.Text := APerson.tel;
        edtLogradouro.Text := APerson.address.logradouro;
        edtComplemento.Text := APerson.address.complemento;
        edtBairro.Text := APerson.address.bairro;
        edtCidade.Text := APerson.address.localidade;
        edtEstado.Text := APerson.address.uf;
        edtEndereco.Text := APerson.address.Endereco;
        edtCreateDate.Text := DateTimeToStr(APerson.createDate);
        // desabilita o evento de alteração do CEP para não executar o RESTFULL novamente, no final retorna o evento
        vOnChange := edtCEP.OnChange;
        edtCEP.OnChange := nil;
        edtCEP.Text := APerson.address.cep;
        edtCEP.OnChange := vOnChange;
    end;
end;

class function TFrm_Person.Modify(var APerson: TPerson): Boolean;
var
    vForm: TFrm_Person;
begin
    vForm := TFrm_Person.Create(nil);
    try
        vForm.Fill(APerson);
        Result := vForm.ShowModal = mrOk;
        if Result then
        begin
            if vForm.FIsNew then
                APerson := TPerson.Create;
            vForm.ReadFromForm(APerson);
        end;
    finally
        vForm.Free;
    end;
end;

procedure TFrm_Person.ReadFromForm(APerson: TPerson);
begin
    APerson.id := StrToIntDef(edtId.Text, 0);
    APerson.name := edtNome.Text;
    APerson.email := edtEmail.Text;
    APerson.ident := edtIdentidade.Text;
    APerson.cpf := edtCPF.Text;
    APerson.tel := edtTelefone.Text;

    APerson.address := TAddress.NewFrom(
        edtCEP.Text,
        edtLogradouro.Text,
        edtComplemento.Text,
        edtBairro.Text,
        edtCidade.Text,
        edtEstado.Text,
        EmptyStr, EmptyStr, EmptyStr);
    APerson.createDate := Now;
end;

procedure TFrm_Person.edtCEPChange(Sender: TObject);
var
    vAddress: TAddress;
    vCEP: String;
begin
    vCEP := edtCEP.Text;
    if (TUtils.ChecaCEP(vCEP, '')) then
    begin
        vAddress := nil;
        try
            vAddress := DM.ObterCEP(vCEP);
        finally
            edtLogradouro.Text := vAddress.logradouro;
            edtComplemento.Text := vAddress.complemento;
            edtBairro.Text := vAddress.bairro;
            edtCidade.Text := vAddress.localidade;
            edtEstado.Text := vAddress.uf;
            edtEndereco.Text := vAddress.Endereco;

            FreeAndnil(vAddress);
        end;
    end;
end;

procedure TFrm_Person.edtCPFExit(Sender: TObject);
begin
    if not TUtils.VCPF(edtCPF.Text) then
    begin
        ShowMessage('Erro de validação de CPF');
        edtCPF.Text := EmptyStr;
        edtCPF.SetFocus;
    end;
end;

end.

