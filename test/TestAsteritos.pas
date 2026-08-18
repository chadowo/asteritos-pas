{$ifdef FPC}{$mode ObjFPC}{$H+}{$endif}
unit TestAsteritos;

interface

uses
  SysUtils, FPCUnit, TestUtils, TestRegistry, Asteritos.Consts;

type
  TTestAsteritos = class(TTestCase)
  published
    procedure TestWindowDimensionsConstants;
  end;

implementation

procedure TTestAsteritos.TestWindowDimensionsConstants;
begin
  AssertEquals('Screen width is 800px', CWindowWidth, 800);
  AssertEquals('Screen height is 600px', CWindowHeight, 600);
end;

initialization
  RegisterTest(TTestAsteritos);
end.
