package game


import "core:math"
import "core:math/linalg"
import "vendor:raylib"


BLACK_SCREEN_START :: 0
BLACK_SCREEN_END :: 1

LOGO_SCREEN_START :: 1
LOGO_SCREEN_END :: 3


LOGO_SCREEN_TEXT :: "A Game By COOKIE POLICE"
LOGO_SCREEN_FONT_SIZE :: 32
LOGO_SCREEN_FONT_COlOR :: raylib.WHITE

MADE_WITH_SCREEN_START :: 3
MADE_WITH_SCREEN_END :: 7
MADE_WITH_SCREEN_FONT_COLOR :: raylib.WHITE
MADE_WITH_SCREEN_TEXT :: "Made With Odin and Raylib"
MADE_WITH_SCREEN_FONT_SIZE :: 32

TRANSITION_TIME :: 0.3

// HOLY hard coding, good thing im never touching this code ever again in my life... maybe... if my OCD doesn't get to me

Splash_Screen :: struct {
	timer: f32,
}


splash_screen_draw :: proc(splash_screen: Splash_Screen, assets: Assets) {
	raylib.BeginDrawing()
	switch splash_screen.timer {
	case BLACK_SCREEN_START ..< BLACK_SCREEN_END:
		raylib.ClearBackground(raylib.BLACK)
	case LOGO_SCREEN_START ..< LOGO_SCREEN_END:
		raylib.ClearBackground(raylib.BLACK)
		color := LOGO_SCREEN_FONT_COlOR
		update_fade(&color, splash_screen.timer, LOGO_SCREEN_START, LOGO_SCREEN_END, TRANSITION_TIME)
		width := raylib.MeasureText(LOGO_SCREEN_TEXT, LOGO_SCREEN_FONT_SIZE)
		height := LOGO_SCREEN_FONT_SIZE
		position_x := (raylib.GetScreenWidth() - i32(width)) / 2
		position_y := (raylib.GetScreenHeight() - i32(height)) / 2
		raylib.DrawText(LOGO_SCREEN_TEXT, position_x, position_y, LOGO_SCREEN_FONT_SIZE, color)
	case MADE_WITH_SCREEN_START ..= MADE_WITH_SCREEN_END:
		raylib.ClearBackground(raylib.BLACK)
		color := MADE_WITH_SCREEN_FONT_COLOR
		update_fade(&color, splash_screen.timer, MADE_WITH_SCREEN_START, MADE_WITH_SCREEN_END, TRANSITION_TIME)
		text_width := raylib.MeasureText(MADE_WITH_SCREEN_TEXT, MADE_WITH_SCREEN_FONT_SIZE)
		text_height := MADE_WITH_SCREEN_FONT_SIZE

		position_x := (raylib.GetScreenWidth() - i32(text_width)) / 2
		position_y := ((raylib.GetScreenHeight() - i32(text_height)) / 2) - 200
		raylib.DrawText(
			MADE_WITH_SCREEN_TEXT,
			position_x,
			position_y,
			MADE_WITH_SCREEN_FONT_SIZE,
			color,
		)


		raylib.DrawTexturePro(
			assets.ginger_bill,
			{0, 0, f32(assets.ginger_bill.width), f32(assets.ginger_bill.height)},
			{f32(raylib.GetScreenWidth()) / 2, f32(raylib.GetScreenHeight()) / 2, 272, 304.25},
			{272 / 2, 304.25 / 2},
			0,
			{255, 255, 255, color.a},
		)


	}
	raylib.EndDrawing()
}

splash_screen_update :: proc(splash_screen: ^Splash_Screen, delta_time: f32) {
	splash_screen.timer += delta_time
}


fade_in :: proc(color: ^raylib.Color, elapsed: f32, duration: f32) {
	t: f32 = math.clamp(elapsed / duration, 0.0, 1.0)
	color.a = u8(linalg.lerp(f32(0), f32(255), t))
}

fade_out :: proc(color: ^raylib.Color, elapsed: f32, duration: f32) {
	t: f32 = math.clamp(elapsed / duration, 0.0, 1.0)
	color.a = u8(linalg.lerp(f32(255), f32(0), t))
}


update_fade :: proc(
	color: ^raylib.Color,
	time: f32,
	start_time: f32,
	end_time: f32,
	duration: f32,
) {
	if time < start_time + duration {
		fade_in(color, time - start_time, duration)
	} else if time > end_time - duration {
		fade_out(color, time - (end_time - duration), duration)
	}
}