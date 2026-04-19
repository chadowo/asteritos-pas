unit Button;

{$mode ObjFPC}{$H+}

interface
uses
  SysUtils,
  SDL2,
  Font;

type
  TButton = class
    constructor Create(Font: TFont; Text: String; ColorInactive, ColorActive: TSDL_Color);
    destructor Destroy; override;

    procedure Draw(X, Y: Integer; Renderer: PSDL_Renderer);

    procedure Hover;
    procedure StopHover;

    { Width is calculated by character of label multiplied font size. }
    function GetWidth: Integer;
  private
    FFont: TFont;
    FText: String;
    FCurrentColor, FColorInactive, FColorActive: TSDL_Color;
  end;

implementation

constructor TButton.Create(Font: TFont; Text: String; ColorInactive, ColorActive: TSDL_Color);
begin
  FFont := Font;
  FText := Text;
  FColorInactive := ColorInactive;
  FColorActive := ColorActive;
  FCurrentColor := FColorInactive;
end;

destructor TButton.Destroy;
begin end;

procedure TButton.Draw(X, Y: Integer; Renderer: PSDL_Renderer);
begin
  FFont.Draw(X, Y, FText, FCurrentColor, Renderer);
end;

procedure TButton.Hover;
begin
  FCurrentColor := FColorActive;
end;

procedure TButton.StopHover;
begin
  FCurrentColor := FColorInactive;
end;

function TButton.GetWidth: Integer;
begin
  WriteLn(FText.Length);
  Result := FText.Length * FFont.Size; // BUG: It's more than the correct amount, about two chars more
end;

end.
