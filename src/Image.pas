{$mode ObjFPC}{$H+}
unit Image;

interface
uses
  SysUtils, SDL2, SDL2_Image;

type
  TImage = class
  private
    FSDLTexture: PSDL_Texture;
  protected

  public
    constructor Create(Path: String; Renderer: PSDL_Renderer);
    destructor Destroy; override;

    procedure Draw(Renderer: PSDL_Renderer);
  published

  end;

implementation

constructor TImage.Create(Path: String; Renderer: PSDL_Renderer);
var
  LSurface: PSDL_Surface;
begin
  LSurface := IMG_Load(PChar(Path));
  if LSurface = nil then
  begin
    WriteLn('Unable to load image at path ', Path, 'SDL2_Image error: ', IMG_GetError);
    raise Exception.Create('Couldn''t create surface');
  end;

  FSDLTexture := SDL_CreateTextureFromSurface(Renderer, LSurface);
  if FSDLTexture = nil then
  begin
    WriteLn('Unable create texture from ', Path, 'SDL2 error: ', SDL_GetError);
    raise Exception.Create('Couldn''t create texture');
  end;

  SDL_FreeSurface(LSurface);
end;

destructor TImage.Destroy;
begin
  SDL_DestroyTexture(FSDLTexture);
end;

procedure TImage.Draw(Renderer: PSDL_Renderer);
begin
  SDL_RenderCopy(Renderer, FSDLTexture, nil, nil);
end;

end.
