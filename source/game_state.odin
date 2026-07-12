package game

Scene :: enum {
	Splash,
	Main_Menu,
	World,
}

Game_State :: struct {
	splash:    Splash_Screen,
	main_menu: Main_Menu,
	world:     World,
	scene:     Scene,
	assets:    Assets,
}

game_state_init :: proc(game_state: ^Game_State) {
	assets_init(&game_state.assets)
	splash_screen_init(&game_state.splash)
	main_menu_init(&game_state.main_menu)
	world_init(&game_state.world)
	game_state.scene = .Splash
}

game_state_update :: proc(game_state: ^Game_State) {
	switch game_state.scene {
	case .Splash:
		splash_screen_update(&game_state.splash, game_state)
	case .Main_Menu:
		main_menu_update(&game_state.main_menu, game_state)
	case .World:
		world_update(&game_state.world, game_state)
	}
}

game_state_destroy :: proc(game_state: ^Game_State) {
	assets_destroy(&game_state.assets)
}
