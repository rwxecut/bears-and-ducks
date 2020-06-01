local function load()
    local window_width = 800
    local window_height = 600
    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")
    Love.graphics.setDefaultFilter("linear", "nearest")

    local window_radius = math.sqrt(window_width^2 + window_height^2)

    local graphics_l = GraphicsLoader:new {
        path = "assets/textures.map"
    }
    SPRITES = graphics_l:loadSprites()

    UI = UserInterface:new {
        show_fps = true,
        show_coordinates = true,
    }

    MOUSE = {
        window_x = window_width / 2, window_y = window_height / 2
    }

    local game_l = GameLoader:new{
        path = "assets/stages.map",
        grid = Grid:new {
            radius = window_radius,
        },
    }
    SC = game_l:loadCarousel()

    CAM = ZoomCamera:new(
        SC:getCurrent().character.x,
        SC:getCurrent().character.y)
end

return load
