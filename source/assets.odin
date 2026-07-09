package game

import "vendor:raylib"

Assets :: struct {
    blaster_a: raylib.Model,
    ginger_bill: raylib.Texture2D,
    intro_jingle: raylib.Sound
}


assets_init :: proc(assets: ^Assets) {
    assets.ginger_bill = raylib.LoadTexture("assets/ginger_bill.png")
    assets.blaster_a = raylib.LoadModel("assets/kenney_blaster_kit/blaster-a.glb")
    assets.intro_jingle = raylib.LoadSound("assets/nes_shooter_music/intro_jingle.ogg")
    
}

assets_destroy :: proc(assets: ^Assets) {
    raylib.UnloadTexture(assets.ginger_bill)
    raylib.UnloadModel(assets.blaster_a)
    raylib.UnloadSound(assets.intro_jingle)
}