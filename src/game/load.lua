Character = require "src.entities.Character"
Grid = require "src.entities.Grid"
Platform = require "src.entities.Platform"
ZoomCamera = require "src.entities.ZoomCamera"

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
        x = 0,
        y = 0,
        width = 320,
    }

    CHAR = Character:new {
        x = PLATFORM.x,
        y = PLATFORM.y,
    }

    CAM = ZoomCamera:new(CHAR.x, CHAR.y)

    MOUSE = {
        window_x = window_width / 2, window_y = window_height / 2
    }
end

return load
