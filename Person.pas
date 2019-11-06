unit Person;

{$I DelphiRest.inc}

{$IFDEF DELPHI_7}
{$M+}
{$ENDIF}

interface

uses SysUtils, StrUtils;

type
    TAddress = class;
    
    TPerson = class(TObject)
    private
        FId: Integer;
        FEmail: string;
        FName: string;
        FIdent: string;
        FCPF: string;
        FTel: string;
        FAddress: TAddress;
        FCreateDate: TDateTime;
    published
        property id: Integer read FId write FId;
        property name: string read FName write FName;
        property email: string read FEmail write FEmail;
        property ident: string read FIdent write FIdent;
        property cpf: string read FCPF write FCPF;
        property tel: string read FTel write FTel;
        property address: TAddress read FAddress write FAddress;
        property createDate: TDateTime read FCreateDate write FCreateDate;
    end;


    TAddress = class(TObject)
    private
        FCEP: string;
        FLogradouro: string;
        FComplemento: string;
        FBairro: string;
        FLocalidade: string;
        FUF: string;
        FUnidade: string;
        FIBGE: string;
        FGIA: string;
    published
        property cep: string read FCEP write FCEP;
        property logradouro: string read FLogradouro write FLogradouro;
        property complemento: string read FComplemento write FComplemento;
        property bairro: string read FBairro write FBairro;
        property localidade: string read FLocalidade write FLocalidade;
        property uf: string read FUF write FUF;
        property unidade: string read FUnidade write FUnidade;
        property ibge: string read FIBGE write FIBGE;
        property gia: string read FGIA write FGIA;

        function Endereco: string;
        function ComplementoValido: string;
        class function NewFrom(CEP, Logradouro, Complemento, Bairro, Localidade,
            UF, Unidade, IBGE, GIA: string): TAddress;
    end;

implementation


{ TAddress }
class function TAddress.NewFrom(CEP, Logradouro, Complemento, Bairro,
    Localidade, UF, Unidade, IBGE, GIA: string): TAddress;
begin
    Result := TAddress.Create;
    Result.cep := CEP;
    Result.logradouro := Logradouro;
    Result.complemento := Complemento;
    Result.bairro := Bairro;
    Result.localidade := Localidade;
    Result.uf := UF;
    Result.unidade := Unidade;
    Result.ibge := IBGE;
    Result.gia := GIA;
end;

function TAddress.ComplementoValido: string;
begin
    Result := IfThen(Self.complemento = EmptyStr, EmptyStr, ', ' +
        Self.complemento);
end;

function TAddress.Endereco: string;
begin
    Result := Self.logradouro + Self.ComplementoValido() + ' - ' + Self.bairro +
        ' - ' + Self.cep + ' - ' + Self.localidade + ' - ' + Self.uf;
end;
end.


