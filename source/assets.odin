package game

import "vendor:raylib"

Assets :: struct {
    blaster_a: raylib.Model
}


assets_init :: proc(assets: ^Assets) {
    assets.blaster_a = raylib.LoadModel("assets/kenney_blaster_kit/blaster-a.glb")
    
}

assets_destroy :: proc(assets: ^Assets) {
    raylib.UnloadModel(assets.blaster_a)
}