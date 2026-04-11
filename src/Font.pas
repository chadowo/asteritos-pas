{$mode ObjFPC}{$H+}
unit Font;

interface
uses
  SysUtils, SDL2, SDL2_TTF;

type
  TFont = class
  private

  protected
    FFont: PTTF_Font;
  public
    const CColorWhite: TSDL_Color = (R: 255; G: 255; B: 255; A: 255);
    const CColorBlack: TSDL_Color = (R: 0;   G: 0;   B: 0;   A: 255);
    const CColorRed:   TSDL_Color = (R: 255; G: 0;   B: 0;   A: 255);
    const CColorGreen: TSDL_Color = (R: 0;   G: 255; B: 0;   A: 255);
    const CColorBlue:  TSDL_Color = (R: 0;   G: 0;   B: 250; A: 255);

    constructor Create(Path: String; Size: Integer);
    destructor Destroy; override;

    procedure Draw(X, Y: Integer; Text: String; Color: TSDL_Color; Renderer: PSDL_Renderer);
  published

  end;

implementation

constructor TFont.Create(Path: String; Size: Integer);
begin
  FFont := TTF_OpenFont(PChar(Path), Size);
  if FFont = nil then
    raise Exception.Create('Couldn''t create font');
end;

destructor TFont.Destroy;
begin
  TTF_CloseFont(FFont);
end;

procedure TFont.Draw(X, Y: Integer; Text: String; Color: TSDL_Color; Renderer: PSDL_Renderer);
var
  LSurface: PSDL_Surface;
  LTexture: PSDL_Texture;

  R: TSDL_Rect;
begin
  LSurface := TTF_RenderUTF8_Blended(FFont, PChar(Text), Color);
  LTexture := SDL_CreateTextureFromSurface(Renderer, LSurface);

  SDL_FreeSurface(LSurface);
  LSurface := nil;

  R.X := X;
  R.Y := Y;
  SDL_QueryTexture(LTexture, nil, nil, @R.W, @R.H);

  SDL_RenderCopy(Renderer, LTexture, nil, @R);
  SDL_DestroyTexture(LTexture);
  LTexture := nil;
end;

end.
