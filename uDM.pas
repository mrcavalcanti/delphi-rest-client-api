unit uDM;

interface

uses
  SysUtils, Classes, RestClient, Person;

const
  CONTEXT_PATH = 'https://viacep.com.br/';
  XML_PATH = 'C:\temp\Arquivo.xml';

type
  // declara um registro para centralizar as configurações de conexão SMTP
  TInfoSMTP = record
      servidor: string;
      usuario: string;
      senha: string;
  end;

  TDM = class(TDataModule)
     RestClient: TRestClient;
    procedure DataModuleCreate(Sender: TObject);
  private
      { Private declarations }
      FInfoSMTP: TInfoSMTP;
  public
      { Public declarations }
      class function ObterCEP(ACEP: String): TAddress;
      class procedure EnviarEmail(ANome, AEmail: String);
  published
      property infoSMTP : TInfoSMTP read FInfoSMTP write FInfoSMTP;
  end;

var
  DM: TDM;

implementation

uses uMail;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

class function TDM.ObterCEP(ACEP: String): TAddress;
begin
    Result := TAddress(Dm.RestClient.Resource(CONTEXT_PATH +
        'ws/' + ACEP + '/json/').Get(TAddress));
end;

class procedure TDM.EnviarEmail(ANome, AEmail: String);
var
    vMail: TMailUserControl;
begin
    vMail := TMailUserControl.Create(nil);
    try
        with vMail, Dm.infoSMTP do
        begin
            ServidorSMTP := servidor;
            vMail.Usuario := usuario;
            vMail.Senha := senha;
            NomeRemetente := 'Robô Marcelo';
            EmailRemetente := 'naoresponda@swg2.com.br';
            AdicionaMensagem.Titulo := 'Cadastro Pessoa XML';
            AdicionaMensagem.Mensagem.Add(':nome');
            AdicionaMensagem.Mensagem.Add(':email');
            AdicionaMensagem.Mensagem.Add('Araketu');   // PODE INLUIR UM MEMORANDO PARA EDIÇÃO DO CONTEÚDO (TEXTO)
            EnviaEmailXML(ANome, AEmail);
        end;
    finally
        FreeAndNil(vMail);
    end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
    with Dm.infoSMTP do
    begin
        servidor := 'smtp.DOMINIO.com.br';
        usuario := 'NOME@DOMINIO.com.br';
        senha := 'senha';
    end;
end;

end.
