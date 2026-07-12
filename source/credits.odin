package game

import "vendor:raylib"

import "core:math/linalg"

credits_update :: proc(game_state: ^Game_State) {
	raylib.BeginDrawing()
	if raylib.IsKeyPressed(raylib.KeyboardKey.ESCAPE) {
		game_state.scene = .Main_Menu
		main_menu_init(&game_state.main_menu, game_state)
	}
	raylib.ClearBackground(raylib.BLACK)
	window_w := f32(raylib.GetScreenWidth())
	window_h := f32(raylib.GetScreenHeight())
	screen_center := linalg.Vector2f32{window_w / 2, window_h / 2}
	scale := window_h / f32(VIRTUAL_SCREEN_HEIGHT)

    draw_text("Press escape to go back to main menu", {screen_center.x, screen_center.y - 100}, raylib.GetFontDefault(), 32, .Center)

	draw_text(
		"Big thanks to Kenney assets for the majority of the sprites used in this game.",
		screen_center,
		raylib.GetFontDefault(),
		32,
		.Center,
	)
	raylib.EndDrawing()
}
