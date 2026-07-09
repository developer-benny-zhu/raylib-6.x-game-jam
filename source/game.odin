package game

import "core:c"
import "vendor:raylib"

run: bool

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
WINDOW_TITLE :: "Hex Arena"
FPS :: 60
splash_screen: Splash_Screen


game_state: Game_State
init :: proc() {
	run = true
	raylib.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	raylib.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE)
	raylib.SetTargetFPS(FPS)

	game_state_init(&game_state)
}

update :: proc() {
	delta_time := raylib.GetFrameTime()
	splash_screen_update(&splash_screen, delta_time)
	splash_screen_draw(splash_screen, game_state.assets)
	free_all(context.temp_allocator)
}

parent_window_size_changed :: proc(width: int, height: int) {
	raylib.SetWindowSize(c.int(width), c.int(height))
}

shutdown :: proc() {
	raylib.CloseWindow()
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		if raylib.WindowShouldClose() {
			run = false
		}
	}

	return run
}
