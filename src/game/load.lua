local function load()
    local window_width = 800
    local window_height = 600
    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")
    Love.graphics.setDefaultFilter("linear", "nearest")

    local window_radius = math.sqrt(window_width^2 + window_height^2)

    PHYS = Bump.newWorld(Cell.size)

    UI = UI:new {
        show_fps = true
    }

    MOUSE = {
        window_x = window_width / 2, window_y = window_height / 2
    }

    local game_l = GameLoader:new{
        path = "assets/stages.map",
        phys = PHYS,
        grid = Grid:new {
            radius = window_radius,
        },
    }
    STAGES = game_l:loadStages()
    STAGES._current_stage = STAGES.room01

    CAM = ZoomCamera:new(
        STAGES._current_stage.character.x,
        STAGES._current_stage.character.y)

    local graphics_l = GraphicsLoader:new {
        path = "assets/textures.map"
    }
    SPRITES = graphics_l:loadSprites()
end

return load
