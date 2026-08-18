{$ifdef FPC}{$mode ObjFPC}{$H+}{$endif}
program TestRunner;
uses 
  ConsoleTestRunner, TestAsteritos;

type
  TAsteritosTestRunner = class(TTestRunner)
  protected
    // Override blah blah blah
  end;

var
  Application: TAsteritosTestRunner;
begin
  DefaultRunAllTests := true;
  DefaultFormat := fPlain;

  Application := TAsteritosTestRunner.Create(nil);
  Application.Initialize;
  Application.Title := 'FPCUnit Console Test Runner';
  Application.Run;
  Application.Free;
end.
