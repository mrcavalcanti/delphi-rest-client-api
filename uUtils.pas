unit uUtils;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, TypInfo, Person;

type
    TUtils = class
    public
        //class procedure Swap(var A, B: Integer);
        class function ChecaCEP(ACep, AEstado: string): Boolean;
        //Validar CPF
        class function VCPF(Dado: string): Boolean;
        //gravar arquivo xml com os dados da pessoa cadastrada
        class procedure GravarXML(ANameFile: String; APerson: TPerson);
    end;

implementation

{ TUtils }

class function TUtils.ChecaCEP(ACep, AEstado: string): Boolean;
var
    prefixo: Integer;
begin
    ACep := Copy(ACep, 1, 5) + Copy(ACep, 7, 3);
    prefixo := StrToInt(copy(ACep, 1, 3));
    if Length(trim(ACep)) > 0 then
    begin
        if (StrToInt(ACep) <= 1000000.0) then
        begin
            //MessageDlg('CEP tem que ser maior que [01000-000]', mtError, [mbOk], 0);
            Result := False
        end
        else
        begin
            if Length(Trim(Copy(ACep, 6, 3))) < 3 then
                Result := False
            else if (AEstado = '') then
                Result := True
            else if (AEstado = 'SP') and (prefixo >= 10) and (prefixo <= 199) then
                Result := True
            else if (AEstado = 'RJ') and (prefixo >= 200) and (prefixo <= 289) then
                Result := True
            else if (AEstado = 'ES') and (prefixo >= 290) and (prefixo <= 299) then
                Result := True
            else if (AEstado = 'MG') and (prefixo >= 300) and (prefixo <= 399) then
                Result := True
            else if (AEstado = 'BA') and (prefixo >= 400) and (prefixo <= 489) then
                Result := True
            else if (AEstado = 'SE') and (prefixo >= 490) and (prefixo <= 499) then
                Result := True
            else if (AEstado = 'PE') and (prefixo >= 500) and (prefixo <= 569) then
                Result := True
            else if (AEstado = 'AL') and (prefixo >= 570) and (prefixo <= 579) then
                Result := True
            else if (AEstado = 'PB') and (prefixo >= 580) and (prefixo <= 589) then
                Result := True
            else if (AEstado = 'RN') and (prefixo >= 590) and (prefixo <= 599) then
                Result := True
            else if (AEstado = 'CE') and (prefixo >= 600) and (prefixo <= 639) then
                Result := True
            else if (AEstado = 'PI') and (prefixo >= 640) and (prefixo <= 649) then
                Result := True
            else if (AEstado = 'MA') and (prefixo >= 650) and (prefixo <= 659) then
                Result := True
            else if (AEstado = 'PA') and (prefixo >= 660) and (prefixo <= 688) then
                Result := True
            else if (AEstado = 'AM') and ((prefixo >= 690) and (prefixo <= 692) or (prefixo >= 694) and (prefixo <= 698)) then
                Result := True
            else if (AEstado = 'AP') and (prefixo = 689) then
                Result := True
            else if (AEstado = 'RR') and (prefixo = 693) then
                Result := True
            else if (AEstado = 'AC') and (prefixo = 699) then
                Result := True
            else if ((AEstado = 'DF') or (AEstado = 'GO')) and (prefixo >= 000) and (prefixo <= 999) then
                Result := True
            else if (AEstado = 'TO') and (prefixo >= 770) and (prefixo <= 779) then
                Result := True
            else if (AEstado = 'MT') and (prefixo >= 780) and (prefixo <= 788) then
                Result := True
            else if (AEstado = 'MS') and (prefixo >= 790) and (prefixo <= 799) then
                Result := True
            else if (AEstado = 'RO') and (prefixo = 789) then
                Result := True
            else if (AEstado = 'PR') and (prefixo >= 800) and (prefixo <= 879) then
                Result := True
            else if (AEstado = 'SC') and (prefixo >= 880) and (prefixo <= 899) then
                Result := True
            else if (AEstado = 'RS') and (prefixo >= 900) and (prefixo <= 999) then
                Result := True
            else
                Result := False
        end;
    end
    else
    begin
        Result := True;
    end
end;

class function TUtils.VCPF(Dado: string): Boolean;
var
  D1: array[1..9] of Byte;
  I,
  DF1,
  DF2,
  DF3,
  DF4,
  DF5,
  DF6,
  Resto1,
  Resto2,
  PrimeiroDigito,
  SegundoDigito: Integer;
begin
  Result := True;
  if Length(Dado) = 11 then
  begin
    for I := 1 to 9 do
      if Dado[I] in ['0'..'9'] then
        D1[I] := StrToInt(Dado[I])
      else
        Result := False;
    if Result then
    begin
      DF1 := 10 * D1[1] + 9 * D1[2] + 8 * D1[3] + 7 * D1[4] + 6 * D1[5] + 5 * D1[6] +
        4 * D1[7] + 3 * D1[8] + 2 * D1[9];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;
      DF4 := 11 * D1[1] + 10 * D1[2] + 9 * D1[3] + 8 * D1[4] + 7 * D1[5] + 6 * D1[6] +
        5 * D1[7] + 4 * D1[8] + 3 * D1[9] + 2 * PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(Dado[10])) or
        (SegundoDigito <> StrToInt(Dado[11])) then
        Result := False;
    end;
  end
  else
    if Length(Dado) <> 0 then
      Result := False;
end;

class procedure TUtils.GravarXML(ANameFile: String; APerson: TPerson);
var
    XMLDoc: TXMLDocument;
    XMLNode: IXMLNode;
    _Component: TObject;

    procedure ProcessItem(AObject: TObject; AXMLNode: IXMLNode);
    var
      Count, Loop, LoopA: Integer;
      List: PPropList;
      _XMLNode: IXMLNode;
      Method: TMethod;
      Valor: String;
    begin
      if (not Assigned(AObject)) or (AObject = nil) then
        Exit;

      //tkAny = Propriedades + Métodos
      Count := GetPropList(AObject.ClassInfo, tkAny, nil);
      GetMem(List, Count * SizeOf(PPropInfo));
      try
        GetPropList(AObject.ClassInfo, tkAny, List);

        _XMLNode := AXMLNode.AddChild('item');
        _XMLNode.Attributes['class'] := AObject.ClassName;

        if (Count = 0) then
        begin
            if (AObject.ClassParent = TOwnedCollection) then
            begin
                for LoopA := 0 to TOwnedCollection(AObject).Count-1 do
                    ProcessItem(TOwnedCollection(AObject).Items[LoopA], _XMLNode);
            end;
        end;

        for Loop := 0 to Pred(Count) do
        begin
          case (List[Loop]^.PropType^.Kind) of
            tkUnknown: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkInteger: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkChar: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkEnumeration: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkFloat: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkString: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkSet: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkClass: ProcessItem(GetObjectProp(AObject, List[Loop]^.Name), _XMLNode);
            tkMethod: begin
                        Method := GetMethodProp(AObject, List[Loop]^.Name) ;
                        if Assigned(Method.Code) and Assigned(Method.Data) then
                        begin
                          Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
                        end
                        else
                          Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
                      end;
            tkWChar: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkLString: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkWString: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkVariant: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkArray: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkRecord: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkInterface: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkInt64: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
            tkDynArray: Valor := VarToStr(GetPropValue(AObject, List[Loop]^.Name));
          end;
          _XMLNode.Attributes[List[Loop]^.Name] := Valor;
        end;
      finally
        FreeMem(List, Count * SizeOf(PPropInfo))
      end;
    end;

begin
    if (APerson = nil) then
        Exit;

    XMLDoc := TXMLDocument.Create(nil);
    XMLDoc.Active := True;
    XmlDoc.Version := '1.0';
    XMLDoc.Encoding := 'utf-8';
    XMLNode := XMLDoc.AddChild('prova');
    XMLNode.Attributes['app'] := ParamStr(0);

    try
        _Component := TPerson(APerson);
        ProcessItem(_Component, XMLNode);
    except
    end;

    XMLDoc.SaveToFile(ANameFile);
end;

end.

