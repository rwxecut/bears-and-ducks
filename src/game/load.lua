local function load()
    local window_width = 800
    local window_height = 600
    local window_radius = math.sqrt(window_width^2 + window_height^2)

    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")
    Love.graphics.setDefaultFilter("linear", "nearest")

    local graphics_l = GraphicsLoader:new {
        path = "assets/textures.map"
    }
    SPRITES = graphics_l:loadSprites()

    UI = UserInterface:new {
        show_help = true,
        show_performance = true,
        show_char_info = true,
        show_char_collisions = true,
        help = "[ and ] - level switch, j or LMB - jump, q w scroll - cam control, pointer - movement, d - debug mode",
    }

    MOUSE = {
        x_window = window_width / 2,
        y_window = window_height / 2,
        pressed_1 = false,
    }

    KB = {
        pressed_j = false,
    }

    local game_l = GameLoader:new{
        path = "assets/stages.map",
    }
    SC = game_l:loadCarousel(Grid:new {
        radius_real = window_radius,
    })

    local char_pos_real = SC:getCurrent().character:realPos()
    CAM = ZoomCamera:new(char_pos_real.x, char_pos_real.y)
end

return load
