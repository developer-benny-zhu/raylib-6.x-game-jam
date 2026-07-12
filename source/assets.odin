package game


import "vendor:raylib"

Assets :: struct {
	kenney_hexagon_sheet: raylib.Texture2D,
	ginger_bill:          raylib.Texture2D,
	button_tile:          raylib.Texture2D,
	banner_tile_1:        raylib.Texture2D,
	banner_tile_2:        raylib.Texture2D,
	banner_tile_3:        raylib.Texture2D,
	pop_up_tile:          raylib.Texture2D,
}

assets_init :: proc(assets: ^Assets) {
	assets.kenney_hexagon_sheet = raylib.LoadTexture("assets/kenney_hexagon_sheet.png")
	assets.ginger_bill = raylib.LoadTexture("assets/ginger_bill.png")

	assets.button_tile = raylib.LoadTexture("assets/kenney_pixel_adventure_ui/button_tile.png")
	assets.banner_tile_1 = raylib.LoadTexture("assets/kenney_pixel_adventure_ui/banner_tile_1.png")
	assets.banner_tile_2 = raylib.LoadTexture("assets/kenney_pixel_adventure_ui/banner_tile_2.png")
	assets.banner_tile_3 = raylib.LoadTexture("assets/kenney_pixel_adventure_ui/banner_tile_3.png")
	assets.pop_up_tile = raylib.LoadTexture("assets/kenney_pixel_adventure_ui/pop_up_tile.png")
}

assets_destroy :: proc(assets: ^Assets) {
	raylib.UnloadTexture(assets.kenney_hexagon_sheet)
	raylib.UnloadTexture(assets.ginger_bill)

	raylib.UnloadTexture(assets.button_tile)
	raylib.UnloadTexture(assets.banner_tile_1)
	raylib.UnloadTexture(assets.banner_tile_2)
	raylib.UnloadTexture(assets.banner_tile_3)
	raylib.UnloadTexture(assets.pop_up_tile)
}
