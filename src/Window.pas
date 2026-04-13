{$mode ObjFPC}{$H+}
unit Window;

interface
uses
  SysUtils, Contnrs,
  SDL2,
  Image, Font, State, MenuState;

type
  TAsteritosWindow = class
  private
    FWindow: PSDL_Window;
    FRenderer: PSDL_Renderer;
    FEvent: TSDL_Event;

    FShouldQuit: Boolean;
    FTick: Integer;

    FStates: TObjectStack;
  protected

  public
    constructor Create(Title: String; Width, Height: Integer);
    destructor Destroy; override;

    procedure Update;
    procedure Draw;

    { Starts the game loop, calling the update and draw methods }
    procedure GameLoop;
  published

  end;

implementation

constructor TAsteritosWindow.Create(Title: String; Width, Height: Integer);
begin
  FWindow := SDL_CreateWindow(PChar(Title), SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
    Width, Height, SDL_WINDOW_SHOWN);
  if FWindow = nil then
    raise Exception.Create('SDL2 window couldn''t be created');

  FRenderer := SDL_CreateRenderer(FWindow, -1, (SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC));
  if FRenderer = nil then
    raise Exception.Create('SDL2 renderer couldn''t be created');

  // I prefer white for me to know stuff's not broken
  SDL_SetRenderDrawColor(FRenderer, $FF, $FF, $FF, $FF);

  FShouldQuit := false;
  FStates := TObjectStack.Create;
  FStates.Push(TMenuState.Create(FRenderer));
end;

destructor TAsteritosWindow.Destroy;
var
  LState: TStateClass;
begin
  LState := TStateClass(FStates.Pop);
  FreeAndNil(LState);
  FreeAndNil(FStates);

  SDL_DestroyRenderer(FRenderer);
  SDL_DestroyWindow(FWindow);
end;

procedure TAsteritosWindow.Update;
var
  CurrentState: TStateClass;
begin
  // TODO: Why do we need to cast to TStateClass? I'm sure there is a more correct way to do this.
  CurrentState := TStateClass(FStates.Peek);
  CurrentState.Update(0);
end;

procedure TAsteritosWindow.Draw;
var
  CurrentState: TStateClass;
begin
  Inc(FTick);

  CurrentState := TStateClass(FStates.Peek);
  CurrentState.Draw;
end;

procedure TAsteritosWindow.GameLoop;
begin
  while not FShouldQuit do
  begin
    while (SDL_PollEvent(@FEvent) <> 0) do
      if FEvent.type_ = SDL_QUITEV then
        FShouldQuit := true;

    Update;

    SDL_RenderClear(FRenderer);
    Draw;
    SDL_RenderPresent(FRenderer);

    SDL_Delay(2); // Don't eat the CPU
  end;
end;

end.
