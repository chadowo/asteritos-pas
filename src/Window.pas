unit Window;

{$mode ObjFPC}{$H+}

interface
uses
  SysUtils, Generics.Collections,
  SDL2,
  Image, Font, State, GameState, MenuState;

type
  { A stack (last in, first out) of objects. In this case, a stack of
    states. }
  TStateStack = specialize TObjectStack<TStateClass>;

  TAsteritosWindow = class
  private
    FWindow: PSDL_Window;
    FRenderer: PSDL_Renderer;
    FEvent: TSDL_Event;

    FShouldQuit: Boolean;
    FTick: Integer;

    FStates: TStateStack;

    FMouseX, FMouseY: Integer;
  protected

  public
    constructor Create(Title: String; Width, Height: Integer);
    destructor Destroy; override;

    procedure Update(DeltaT: Single);
    procedure Draw;

    { Starts the game loop, calling the update and draw methods.
      The game ends when this method ends. }
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
  FStates := TStateStack.Create;
  FStates.Push(TGameState.Create(FRenderer));
end;

destructor TAsteritosWindow.Destroy;
var
  LState: TStateClass;
begin
  LState := FStates.Pop;
  FreeAndNil(LState);
  FreeAndNil(FStates);

  SDL_DestroyRenderer(FRenderer);
  SDL_DestroyWindow(FWindow);
end;

procedure TAsteritosWindow.Update(DeltaT: Single);
var
  CurrentState: TStateClass;
begin
  CurrentState := FStates.Peek;
  CurrentState.Update(DeltaT);
end;

procedure TAsteritosWindow.Draw;
var
  CurrentState: TStateClass;
begin
  Inc(FTick);

  CurrentState := FStates.Peek;
  CurrentState.Draw;
end;

procedure TAsteritosWindow.GameLoop;
{ We use variable step game logic for this }
var
  MinimumFPSDeltaTime, LastGameStep, Now, DeltaTime: Single;
begin
  MinimumFPSDeltaTime := 1000 div 6; // Minimum 6 FPS
  LastGameStep := SDL_GetTicks;

  while not FShouldQuit do
  begin
    // TODO: Events should be handled first and foremost, right?
    while (SDL_PollEvent(@FEvent) <> 0) do
      if FEvent.type_ = SDL_QUITEV then
        FShouldQuit := true;
    SDL_GetMouseState(@FMouseX, @FMouseY);

    Now := SDL_GetTicks;
    if LastGameStep < Now then
    begin
      DeltaTime := Now - LastGameStep;
      if DeltaTime > MinimumFPSDeltaTime then
        DeltaTime := MinimumFPSDeltaTime; // We're going too fast for this 'ol computer

      Update(DeltaTime);

      LastGameStep := Now;

      SDL_RenderClear(FRenderer);
      Draw;
      SDL_RenderPresent(FRenderer);
    end
    else
      SDL_Delay(1);

    // Update;
    //
    // SDL_RenderClear(FRenderer);
    // Draw;
    // SDL_RenderPresent(FRenderer);
    //
    // SDL_Delay(2); // Don't eat the CPU
  end;
end;

end.
