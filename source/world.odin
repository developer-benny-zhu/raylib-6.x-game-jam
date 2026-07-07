package game

import "vendor:raylib"

World :: struct {
    player: Player
}


world_init :: proc(world: ^World) {
    player_init(&world.player)
}

world_update :: proc(world: ^World) {
    player_update(&world.player)
}