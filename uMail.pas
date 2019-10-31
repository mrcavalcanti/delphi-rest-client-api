unit uMail;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, DBClient, 
  IdMessage, IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdSSLOpenSSL, IdAttachmentFile, dialogs;

type
  TMailMessage = class(TPersistent)
  private
    FTitulo: String;
    FLines: TStrings;
    procedure SetLines(const Value: TStrings);
  protected
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy;override;
    procedure Assign(Source : TPersistent);override;
  published
    property Titulo : String read FTitulo write FTitulo;
    property Mensagem : TStrings read FLines write SetLines;
  end;

type
  TMailUserControl = class(TComponent)
  private
    FEmailRemetente: String;
    FUsuario: String;
    FNomeRemetente: String;
    FSenha: String;
    FSMTPServer: String;
    FAdicionaMensagem: TMailMessage;
    FIdAntiFreeze : TIdAntiFreeze;
    function ParseMailMSG( Nome, Email, txt : String) : String;
  protected
    procedure EnviaEmail(Nome, Email: String; UCMSG: TMailMessage);
  public
    constructor Create(AOwner : TComponent); override;
    procedure EnviaEmailXML(NomeDestinatario, EmailDestinatario: String);
  published
    property ServidorSMTP: String read FSMTPServer write FSMTPServer;
    property Usuario: String read FUsuario write FUsuario;
    property Senha: String read FSenha write FSenha;
    property NomeRemetente: String read FNomeRemetente write FNomeRemetente;
    property EmailRemetente: String read FEmailRemetente write FEmailRemetente;
    property AdicionaMensagem: TMailMessage read FAdicionaMensagem write FAdicionaMensagem;
  end;

implementation

uses uDm;

{ TMailAdicUsuario }

procedure TMailMessage.Assign(Source: TPersistent);
begin
    if Source is TMailMessage then
    begin
        Self.Titulo := TMailMessage(Source).Titulo;
        Self.Mensagem.Assign(TMailMessage(Source).Mensagem);
    end
    else
        inherited;
end;

constructor TMailMessage.Create(AOwner: TComponent);
begin
    FLines := TStringList.Create;
end;

destructor TMailMessage.Destroy;
begin
    inherited;
end;

procedure TMailMessage.SetLines(const Value: TStrings);
begin
    FLines.Assign(Value);
end;

{ TMailUserControl }

constructor TMailUserControl.Create(AOwner: TComponent);
begin
    inherited;
    AdicionaMensagem :=  TMailMessage.Create(self);
    FIdAntiFreeze := TIdAntiFreeze.Create(Self);
    FIdAntiFreeze.Active := True;
end;

procedure TMailUserControl.EnviaEmailXML(NomeDestinatario, EmailDestinatario: String);
begin
    EnviaEmail(NomeDestinatario, EmailDestinatario, AdicionaMensagem);
end;

function TMailUserControl.ParseMailMSG( Nome, Email, txt : String) : String;
begin
    Txt := StringReplace(txt, ':nome', Nome, [rfReplaceAll]);
    Txt := StringReplace(txt, ':email', Email, [rfReplaceAll]);
    Result := Txt;
end;


procedure TMailUserControl.EnviaEmail(Nome, Email: String; UCMSG: TMailMessage);
var
    MailSSL: TIdSSLIOHandlerSocketOpenSSL;
    MailMSG: TIdMessage;
    MailSMTP: TIdSMTP;
begin
    MailSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
    MailSMTP := TIdSMTP.Create(Self);
    MailMSG := TIdMessage.Create(Self);

    try
        // Configuração do SSL
        MailSSL.SSLOptions.Method := sslvSSLv23;
        MailSSL.SSLOptions.Mode := sslmClient;

        // Configuração do SMTP
        MailSMTP.IOHandler := MailSSL;
        MailSMTP.Host := ServidorSMTP;
        MailSMTP.Port := 587;
{$IFDEF VER140}
        MailSMTP.UserID := Usuario;
{$ENDIF}
{$IFDEF VER150}
        MailSMTP.Username := Usuario;
{$ENDIF}
        if (Senha <> EmptyStr) then
        begin
            MailSMTP.Password := Senha;
        end;

        // Tentativa de conexão e autenticação
        try
            MailSMTP.Connect;
            MailSMTP.Authenticate;
        except
            on E:Exception do
            begin
                MessageDlg('Erro na conexão e/ou autenticação: ' +
                        E.Message, mtWarning, [mbOK], 0);
                Exit;
            end;
        end;

        // Configuração da mensagem
        MailMSG.From.Address := EmailRemetente;
        MailMSG.From.Name := NomeRemetente;
        MailMSG.From.Text := NomeRemetente + ' <' + EmailRemetente + '>';
        with MailMSG.Recipients.Add do
        begin
            Address := Email;
            Name := Nome;
            Text := Nome + ' <' + Email + '>';
        end;
        MailMSG.Subject := UCMSG.Titulo;
        MailMSG.Body.Text := ParseMailMSG(Nome, Email, UCMSG.Mensagem.Text);

        // Anexo da mensagem (opcional)
        if FileExists(XML_PATH) then
            TIdAttachmentFile.Create(MailMSG.MessageParts, XML_PATH);

        // Envio da mensagem
        try
            MailSMTP.Send(MailMSG);
            MessageDlg('Mensagem enviada com sucesso.', mtInformation, [mbOK], 0);
        except
            On E:Exception do
              MessageDlg('Erro ao enviar a mensagem: ' +
                        E.Message, mtWarning, [mbOK], 0);
        end;
    finally
        // desfazer a conexão
        if (MailSMTP.Connected) then
            MailSMTP.Disconnect;

        // liberação dos objetos da memória
        FreeAndNil(MailMSG);
        FreeAndNil(MailSSL);
        FreeAndNil(MailSMTP);
    end;
end;

end.
