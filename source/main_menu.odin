package game

import "core:math"
import "core:math/linalg"
import "vendor:raylib"

Main_Menu :: struct {
	play_button:    Texture_Button,
	credits_button: Texture_Button,
}

main_menu_init :: proc(menu: ^Main_Menu, game_state: ^Game_State) {
	raylib.PlayMusicStream(game_state.assets.menu_music)
	menu.play_button = Texture_Button{}
}

main_menu_update :: proc(menu: ^Main_Menu, game_state: ^Game_State) {
	raylib.UpdateMusicStream(game_state.assets.menu_music)
	raylib.BeginDrawing()
	raylib.ClearBackground(raylib.BLACK)

	window_w := f32(raylib.GetScreenWidth())
	window_h := f32(raylib.GetScreenHeight())
	screen_center := linalg.Vector2f32{window_w / 2, window_h / 2}
	scale := window_h / f32(VIRTUAL_SCREEN_HEIGHT)

	title_size := f32(math.round(60 * scale))
	title_pos := linalg.Vector2f32{screen_center.x, screen_center.y - (100 * scale)}
	draw_text(
		"War of Hex",
		title_pos,
		raylib.GetFontDefault(),
		title_size,
		.Center,
		tint = raylib.WHITE,
	)

	button_width := f32(game_state.assets.button_tile.width) * 9.0 * scale
	button_height := f32(game_state.assets.button_tile.height) * 3.0 * scale

	menu.play_button.bounds = raylib.Rectangle {
		x      = screen_center.x - (button_width / 2),
		y      = screen_center.y + (40 * scale),
		width  = button_width,
		height = button_height,
	}

	menu.credits_button.bounds = raylib.Rectangle {
		x      = screen_center.x - (button_width / 2),
		y      = screen_center.y + (200 * scale),
		width  = button_width,
		height = button_height,
	}
	source := raylib.Rectangle {
		0,
		0,
		f32(game_state.assets.button_tile.width),
		f32(game_state.assets.button_tile.height),
	}

	if texture_button_update(
		&menu.play_button,
		game_state.assets.button_tile,
		source,
		"PLAY",
		20 * scale,
		raylib.WHITE,
	) {
		raylib.StopMusicStream(game_state.assets.menu_music)
		game_state.scene = .World
	}

    if texture_button_update(
        &menu.credits_button,
        game_state.assets.button_tile,
        source,
        "CREDITS",
        20 * scale,
        raylib.WHITE
    ) {
        raylib.StopMusicStream(game_state.assets.menu_music)
        game_state.scene = .Credits
    }

	raylib.EndDrawing()
}
