package game

import "vendor:raylib"

Game_State :: struct {
    player: Player
}


game_state_init :: proc(game_state: ^Game_State) {
    player_init(&game_state.player)
}

game_state_update :: proc(game_state: ^Game_State) {
    player_update(&game_state.player)
}