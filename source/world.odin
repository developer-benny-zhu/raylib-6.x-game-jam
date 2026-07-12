package game


import "vendor:raylib"
import "core:math/linalg"
import "core:math"

CAMERA_SPEED :: 100

World :: struct {
    grid: Grid,
    camera: Camera_2D,
    zoom: f32,
    selected_row: int,
    selected_column: int,
}

world_init :: proc(world: ^World) {
    world.grid = Grid {}
    grid_init(&world.grid)
    world.camera = Camera_2D {}
    camera_2d_init(&world.camera)
    world.zoom = 1
    world.selected_row = -1
    world.selected_column = -1
}

world_update :: proc(world: ^World, game_state: ^Game_State) {
    world.camera.velocity = {}
    zoom_change := f32(0)
    wheel_move := raylib.GetMouseWheelMoveV()
    if wheel_move.x != 0 || wheel_move.y != 0 {
        zoom_change += (wheel_move.x + wheel_move.y) * 0.1
    }
    gesture := raylib.GetGestureDetected()
    if gesture == {raylib.Gestures.PINCH_IN} {
        zoom_change -= 0.02
    } else if gesture == {raylib.Gestures.PINCH_OUT} {
        zoom_change += 0.02
    }
    world.camera.zoom = (f32(raylib.GetScreenHeight()) / f32(VIRTUAL_SCREEN_HEIGHT)) * world.zoom
    if zoom_change != 0 {
        mouse_position := raylib.GetMousePosition()
        mouse_world_before := raylib.GetScreenToWorld2D(mouse_position, world.camera)
        world.zoom += zoom_change
        world.zoom = math.clamp(world.zoom, 0.5, 3.0)
        world.camera.zoom = (f32(raylib.GetScreenHeight()) / f32(VIRTUAL_SCREEN_HEIGHT)) * world.zoom
        mouse_world_after := raylib.GetScreenToWorld2D(mouse_position, world.camera)
        world.camera.target += mouse_world_before - mouse_world_after
    }
    if raylib.IsKeyDown(MOVE_UP) {
        world.camera.velocity.y = -CAMERA_SPEED * raylib.GetFrameTime()
    }
    if raylib.IsKeyDown(MOVE_DOWN) {
        world.camera.velocity.y = CAMERA_SPEED * raylib.GetFrameTime()
    }
    if raylib.IsKeyDown(MOVE_LEFT) {
        world.camera.velocity.x = -CAMERA_SPEED * raylib.GetFrameTime()
    }
    if raylib.IsKeyDown(MOVE_RIGHT) {
        world.camera.velocity.x = CAMERA_SPEED * raylib.GetFrameTime()
    }
    camera_2d_update(&world.camera)
    if raylib.IsMouseButtonPressed(.LEFT) {
        mouse_position := raylib.GetScreenToWorld2D(raylib.GetMousePosition(), world.camera)
        found := false
        for row, row_index in world.grid.tiles {
            for _, column_index in row {
                tile_position := grid_tile_position(row_index, column_index)
                if get_distance(mouse_position, tile_position) <= TILE_RADIUS {
                    world.selected_row = row_index
                    world.selected_column = column_index
                    found = true
                    break
                }
            }
            if found {
                break
            }
        }
    }
    raylib.BeginDrawing()
    raylib.ClearBackground(raylib.BLACK)
    raylib.BeginMode2D(world.camera)
    for row, row_index in world.grid.tiles {
        for tile, column_index in row {
            tile_position := grid_tile_position(row_index, column_index)
            selected := row_index == world.selected_row && column_index == world.selected_column
            tile_draw(tile, tile_position, TILE_RADIUS, game_state, selected)
        }
    }
    raylib.EndMode2D()
    raylib.EndDrawing()
}