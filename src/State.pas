{$mode ObjFPC}{$H+}
unit State;

interface
type
  TStateClass = class
    procedure Enter; virtual; abstract;
    procedure Leave; virtual; abstract;

    procedure Update(Dt: Single); virtual; abstract;
    procedure Draw; virtual; abstract;
  end;

implementation

end.
