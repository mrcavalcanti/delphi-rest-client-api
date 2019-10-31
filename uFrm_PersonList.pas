unit uFrm_PersonList;
interface
uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, RestUtils, Contnrs, Person;
type
    TFrm_PersonList = class(TForm)
    pgcInfo: TPageControl;
    tbsInfo: TTabSheet;
    tbsConfig: TTabSheet;
    chkEnableCompression: TCheckBox;
    btnReset: TButton;
    btnRemove: TButton;
    btnUpdate: TButton;
    btnAdd: TButton;
    ListView1: TListView;
    gbxInfo: TGroupBox;
    lblServidor: TLabel;
    edtServidor: TEdit;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    btnConfirmarInfo: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure chkEnableCompressionClick(Sender: TObject);
    procedure btnConfirmarInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
    procedure ClearList;
    procedure RefreshList;
    procedure AddItemList(APerson: TPerson; AItem: TListItem);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    end;

var
    Frm_PersonList: TFrm_PersonList;

implementation

uses uFrm_Person, uDM, uUtils;
{$R *.dfm}

procedure TFrm_PersonList.btnAddClick(Sender: TObject);
var
    vPerson: TPerson;
begin
    vPerson := nil;
    if TFrm_Person.Modify(vPerson) then
    begin
        AddItemList(vPerson, nil);
    end;
end;

procedure TFrm_PersonList.btnRemoveClick(Sender: TObject);
var
    vPerson: TPerson;
begin
    if ListView1.ItemIndex >= 0 then
    begin
        vPerson := TPerson(ListView1.Items[ListView1.ItemIndex].Data);
        TObject(vPerson).Free;
        ListView1.Items.Delete(ListView1.ItemIndex);
    end;
end;

procedure TFrm_PersonList.btnResetClick(Sender: TObject);
begin
    RefreshList;
end;

procedure TFrm_PersonList.btnUpdateClick(Sender: TObject);
var
    vPerson: TPerson;
    vItem: TListItem;
begin
    if ListView1.ItemIndex >= 0 then
    begin
        vItem := ListView1.Items[ListView1.ItemIndex];
        vPerson := TPerson(vItem.Data);
        if TFrm_Person.Modify(vPerson) then
        begin
            AddItemList(vPerson, vItem);
        end;
    end;
end;

procedure TFrm_PersonList.chkEnableCompressionClick(Sender: TObject);
begin
    DM.RestClient.EnabledCompression := chkEnableCompression.Checked;
end;

procedure TFrm_PersonList.ClearList;
var
    i: Integer;
begin
    for i := ListView1.Items.Count - 1 downto 0 do
    begin
        TObject(ListView1.Items[i].Data).Free;
    end;
    ListView1.Items.Clear;
end;

constructor TFrm_PersonList.Create(AOwner: TComponent);
begin
    inherited;
    chkEnableCompression.Checked := DM.RestClient.EnabledCompression;
end;

destructor TFrm_PersonList.Destroy;
begin
    ClearList;
    inherited;
end;

procedure TFrm_PersonList.RefreshList;
begin
    ClearList;
end;

procedure TFrm_PersonList.btnConfirmarInfoClick(Sender: TObject);
begin
    with Dm.infoSMTP do
    begin
        servidor := edtServidor.Text;
        usuario := edtUsuario.Text;
        senha := edtSenha.Text;
    end;
    MessageDlg('Configuração realizada com sucesso.', mtInformation, [mbOK], 0);
end;

procedure TFrm_PersonList.FormCreate(Sender: TObject);
begin
    pgcInfo.TabIndex := 0;
    edtServidor.Text := Dm.infoSMTP.servidor;
    edtUsuario.Text := Dm.infoSMTP.usuario;
    edtSenha.Text := Dm.infoSMTP.senha;
end;

procedure TFrm_PersonList.AddItemList(APerson: TPerson; AItem: TListItem);
var
    vPerson: TPerson;
begin
    vPerson := APerson;
    if Assigned(vPerson) then
    begin
        if Assigned(AItem) then
        begin
            try
                ListView1.Items.BeginUpdate;
                with AItem do
                begin
                    Caption := vPerson.name;
                    Data := vPerson;
                    SubItems.Add(vPerson.name);
                    SubItems.Add(vPerson.email);
                    SubItems.Add(vPerson.address.cep);
                    Update;
                end;
            finally
                ListView1.Items.EndUpdate;
                ListView1.Refresh;
            end;
        end
        else
        begin
            with ListView1.Items.Add do
            begin
                Caption := vPerson.name;
                Data := vPerson;
                SubItems.Add(vPerson.name);
                SubItems.Add(vPerson.email);
                SubItems.Add(vPerson.address.cep);
            end;
        end;

        // gera o arquivo no diretório temp do usuário, poderia ter utilizado o memorystream como outra opção...
        TUtils.GravarXML(XML_PATH, vPerson);

        if (MessageDlg('Deseja enviar um e-mail com os dados de cadastro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        begin
            Dm.EnviarEmail(vPerson.name, vPerson.email);
        end;
    end;
end;

end.
