{$mode ObjFPC}{$H+}
program Asteritos;
uses
  SysUtils, SDL2, SDL2_Image, Window;

procedure InitSDL2;
begin
  if SDL_Init(SDL_INIT_VIDEO) < 0 then
  begin
    WriteLn('Couldn''t initialize SDL2. Error: ', SDL_GetError);
    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, 'SDL2 initializing error', SDL_GetError, nil);
    Halt(1);
  end;
end;

procedure InitSDL2Image;
begin
  if not ((IMG_Init(IMG_INIT_PNG) and IMG_INIT_PNG) = IMG_INIT_PNG) then
  begin
    WriteLn('Couldn''t initialize SDL2-Image. Error: ', SDL_GetError);
    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, 'SDL2-Image initializing error', IMG_GetError, nil);
    Halt(1);
  end;
end;

const
  CWindowWidth = 800;
  CWindowHeight = 600;
var
  MyWindow: TAsteritosWindow;
begin
  InitSDL2;
  InitSDL2Image;

  MyWindow := TAsteritosWindow.Create('Asteritos', CWindowWidth, CWindowHeight);

  MyWindow.GameLoop;

  FreeAndNil(MyWindow);
  SDL_Quit;
end.
