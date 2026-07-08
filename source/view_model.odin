package game


import "core:math/linalg"
import "vendor:raylib"

BLASTER_A_VIEW_MODEL_POSITION :: linalg.Vector3f32{0.25, -0.2, -1}

View_Model_Kind :: enum {
	Blaster_A,

}

draw_view_model :: proc(view_model_kind: View_Model_Kind, assets: Assets) {
	switch view_model_kind {
	case .Blaster_A:
		raylib.DrawModel(assets.blaster_a, BLASTER_A_VIEW_MODEL_POSITION, 1, raylib.WHITE)
	}
}
