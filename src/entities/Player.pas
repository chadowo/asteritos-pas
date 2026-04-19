{$mode ObjFPC}{$H+}
unit Player;

interface
uses
  SysUtils,
  SDL2,
  Image;

type
  TPlayer = class
    constructor Create(Renderer: PSDL_Renderer);
    destructor Destroy; override;

    procedure Draw(Renderer: PSDL_Renderer);
  private
    FSprite: TImage;
  end;

implementation

constructor TPlayer.Create(Renderer: PSDL_Renderer);
begin
  FSprite := TImage.Create('assets/sprites/ship.png', Renderer);
end;

destructor TPlayer.Destroy;
begin
  FreeAndNil(FSprite);
end;

procedure TPlayer.Draw(Renderer: PSDL_Renderer);
begin
  FSprite.Draw(100, 100, Renderer);
end;

end.
