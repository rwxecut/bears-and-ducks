Character = require "src.entities.character"
Grid = require "src.entities.grid"
Platform = require "src.entities.platform"

local function load()
    local window_width = 800
    local window_height = 600
    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")

    local window_radius =
        math.sqrt(math.pow(window_width, 2) + math.pow(window_height, 2))

    GRID = Grid:new {
        radius = window_radius,
        step = 32
    }

    PLATFORM = Platform:new {
        x = 100,
        y = 100,
        width = 400,
    }

    CHAR = Character:new {
        width = 16,
        height = 32,
        x = PLATFORM.x,
        y = PLATFORM.y,
    }

    CAM = Camera(CHAR.x, CHAR.y)
    CAM._zoom_min = -5
    CAM._zoom_max = 5
    CAM._zoom_current = 0
    CAM._zoom_desired = 0

    MOUSE = {
        window_x = window_width / 2, window_y = window_height / 2
    }
end

return load
