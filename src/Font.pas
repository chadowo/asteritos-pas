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
