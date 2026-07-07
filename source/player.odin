package game

import "core:math/linalg"
import "vendor:raylib"

Player :: struct {
    camera: raylib.Camera3D,
    position: linalg.Vector3f32,
    velocity: linalg.Vector3f32
}


player_init :: proc(player: ^Player) {
    player.camera.position = {0.0, 2.0, 4.0}
    player.camera.target = {0.0, 2.0, 0.0}
    player.camera.up = {0.0, 1.0, 0.0}
    player.camera.fovy = 60.0
    player.camera.projection = .PERSPECTIVE
    raylib.DisableCursor()
}

player_update :: proc(player: ^Player) {
    raylib.UpdateCamera(&player.camera, .FIRST_PERSON) 
}