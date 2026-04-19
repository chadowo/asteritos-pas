{$mode ObjFPC}{$H+}
unit GameState;

interface
uses
  SysUtils,
  SDL2,
  State, Image, Font, Player;

type
  TGameState = class(TStateClass)
    constructor Create(Renderer: PSDL_Renderer);
    destructor Destroy; override;

    procedure Enter; override;
    procedure Leave; override;

    procedure Update(Dt: Single); override;
    procedure Draw; override;
  private
  	FRenderer: PSDL_Renderer;

  	FBackground: TImage;
  	FFont: TFont;

    FPlayer: TPlayer;
  end;

implementation

constructor TGameState.Create(Renderer: PSDL_Renderer);
begin
  FRenderer := Renderer;

  FBackground := TImage.Create('assets/sprites/bg.png', FRenderer);
  FFont := TFont.Create('assets/fonts/nordine/nordine.ttf', 28);

  FPlayer := TPlayer.Create(FRenderer);
end;

destructor TGameState.Destroy;
begin
  FreeAndNil(FPlayer);
  FreeAndNil(FFont);
  FreeAndNil(FBackground);

  FRenderer := nil;
end;

procedure TGameState.Enter;
begin
  WriteLn('State entered: ', Self.ClassName);
end;

procedure TGameState.Leave;
begin
  WriteLn('State leaved: ', Self.ClassName);
end;

procedure TGameState.Update(DT: Single);
begin end;

procedure TGameState.Draw;
begin
  FBackground.Draw(0, 0, FRenderer);
  FFont.Draw(15, 15, 'SCORE: ', TFont.CColorWhite, FRenderer);

  FPlayer.Draw(FRenderer);
end;

end.
