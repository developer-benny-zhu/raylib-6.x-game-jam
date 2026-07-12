package game

import "core:math/linalg"
import "vendor:raylib"

Button_State :: enum {
	Normal,
	Hovered,
	Pressed,
}

Texture_Button :: struct {
	bounds: raylib.Rectangle,
	state:  Button_State,
}

texture_button_update :: proc(
	button: ^Texture_Button,
	texture: raylib.Texture2D,
	source: raylib.Rectangle,
	text: cstring = "",
	font_size: f32 = 20,
	text_color: raylib.Color = raylib.BLACK,
	tints: [Button_State]raylib.Color = {
		.Normal = raylib.WHITE,
		.Hovered = {200, 200, 200, 255},
		.Pressed = {150, 150, 150, 255},
	},
) -> bool {
	mouse_pos := raylib.GetMousePosition()
	is_clicked := false

	if raylib.CheckCollisionPointRec(mouse_pos, button.bounds) {
		if raylib.IsMouseButtonDown(.LEFT) {
			button.state = .Pressed
		} else if raylib.IsMouseButtonReleased(.LEFT) && button.state == .Pressed {
			button.state = .Hovered
			is_clicked = true
		} else if button.state != .Pressed {
			button.state = .Hovered
		}
	} else {
		button.state = .Normal
	}

	raylib.DrawTexturePro(texture, source, button.bounds, {0, 0}, 0, tints[button.state])

	if text != "" {
		center_pos := linalg.Vector2f32 {
			button.bounds.x + (button.bounds.width / 2),
			button.bounds.y + (button.bounds.height / 2),
		}

		draw_text(
			text = text,
			position = center_pos,
			font = raylib.GetFontDefault(),
			font_size = font_size,
			origin = Origin.Center,
			tint = text_color,
		)
	}

	return is_clicked
}
