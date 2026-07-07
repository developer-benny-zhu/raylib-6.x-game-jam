package game

import "core:c"
import "vendor:raylib"

run: bool

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
WINDOW_TITLE :: "Hex Arena"
FPS :: 60

init :: proc() {
	run = true
	raylib.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	raylib.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE)
	raylib.SetTargetFPS(FPS)
}

update :: proc() {
	raylib.BeginDrawing()
	raylib.ClearBackground(raylib.RAYWHITE)

	// TODO: Add your game drawing/update logic here

	raylib.EndDrawing()
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
