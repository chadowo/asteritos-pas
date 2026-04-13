{$mode ObjFPC}{H+}
unit MenuState;

interface
uses
  SysUtils,
  SDL2,
  Image, Font, State;

type
  TMenuState = class(TStateClass)
    constructor Create(Renderer: PSDL_Renderer);
    destructor Destroy; override;

    procedure Enter; override;
    procedure Leave; override;

    procedure Update(Dt: Single); override;
    procedure Draw; override;
  private
    { Game resources }
    FBackground: TImage;
    FFont: TFont;

    FRenderer: PSDL_Renderer
  end;

implementation

constructor TMenuState.Create(Renderer: PSDL_Renderer);
begin
  FBackground := TImage.Create('assets/sprites/bg.png', Renderer);
  FFont := TFont.Create('assets/fonts/nordine/nordine.ttf', 48);

  FRenderer := Renderer;
end;

destructor TMenuState.Destroy;
begin
  WriteLn('Menu state being destroyed ...');

  FreeAndNil(FFont);
  FreeAndNil(FBackground);

  // FRenderer isn't ours so we don't free it.
  FRenderer := nil;
end;

procedure TMenuState.Enter;
begin
  WriteLn('State entered: ', Self.ClassName);
end;

procedure TMenuState.Leave;
begin
  WriteLn('State leaved: ', Self.ClassName);
end;

procedure TMenuState.Update(Dt: Single);
begin end;

procedure TMenuState.Draw;
var
  TextWidth: Integer;
begin
  FBackground.Draw(FRenderer);

  // This is ... incredibly inefficient, creating two surfaces each frame to get some integer
  // and then to create a texture to draw, of the same text too! But it's still cool nonetheless.
  TextWidth := FFont.MeasureText('Asteritos');
  FFont.Draw((800 div 2) - (TextWidth div 2), 32, 'Asteritos', TFont.CColorWhite, FRenderer);end;
end.
