package game

import "core:math/linalg"
import "vendor:raylib"

Dialog_Line :: struct {
	speaker: cstring,
	text: cstring,
}

Dialog :: struct {
	active:    bool,
	line_index: int,
	line_count: int,
	lines:     [4]Dialog_Line,
}

dialog_init :: proc(dialog: ^Dialog) {
	dialog.lines = [4]Dialog_Line{
		{speaker = "Armin", text = "This place is strange...\nI should look around."},
		{speaker = "Guide", text = "Click a hex to select it.\nUse the wheel or pinch to zoom."},
		{speaker = "Armin", text = "This box is a simple dialogue system."},
		{speaker = "Guide", text = "Press E, Space, or click to advance."},
	}
	dialog.line_count = len(dialog.lines)
	dialog.line_index = 0
	dialog.active = false
}

dialog_open :: proc(dialog: ^Dialog) {
	dialog.active = true
	dialog.line_index = 0
}

dialog_advance :: proc(dialog: ^Dialog) {
	if !dialog.active do return
	dialog.line_index += 1
	if dialog.line_index >= dialog.line_count {
		dialog.active = false
		dialog.line_index = 0
	}
}

dialog_draw :: proc(dialog: Dialog) {
	if !dialog.active do return

	window_w := f32(raylib.GetScreenWidth())
	window_h := f32(raylib.GetScreenHeight())
	panel_margin := f32(28.0)
	panel_height := window_h * 0.24
	panel := raylib.Rectangle{
		x = panel_margin,
		y = window_h - panel_height - panel_margin,
		width = window_w - panel_margin * 2,
		height = panel_height,
	}

	background := raylib.Color{34, 28, 42, 230}
	border := raylib.Color{220, 214, 200, 180}
	text_color := raylib.Color{245, 236, 226, 255}

	raylib.DrawRectangleRounded(panel, 0.08, 6, background)
	raylib.DrawRectangleRoundedLinesEx(panel, 0.08, 6, 3, border)

	current := dialog.lines[dialog.line_index]
	name_pos := linalg.Vector2f32{panel.x + 28, panel.y + 18}
	body_pos := linalg.Vector2f32{panel.x + 28, panel.y + 58}
	draw_text(current.speaker, name_pos, raylib.GetFontDefault(), 26, .Top_Left, tint = raylib.WHITE)
	draw_text(current.text, body_pos, raylib.GetFontDefault(), 20, .Top_Left, tint = text_color)

	pointer_top := linalg.Vector2f32{panel.x + panel.width * 0.5 - 14, panel.y + panel.height}
	pointer_left := linalg.Vector2f32{pointer_top.x + 14, pointer_top.y + 20}
	pointer_right := linalg.Vector2f32{pointer_top.x + 28, pointer_top.y}
	raylib.DrawTriangle(pointer_top, pointer_left, pointer_right, background)
}