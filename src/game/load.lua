Cell = require "src.entities.Cell"
Cellular = require "src.entities.Cellular"
Character = require "src.entities.Character"
Grid = require "src.entities.Grid"
Platform = require "src.entities.Platform"
ZoomCamera = require "src.entities.ZoomCamera"
UI = require "src.entities.UI"

Atlas = require "src.graphics.Atlas"
GraphicsLoader = require "src.graphics.GraphicsLoader"
Sprite = require "src.graphics.Sprite"

local function load()
    local window_width = 800
    local window_height = 600
    Love.window.setMode(window_width, window_height, nil)
    Love.window.setTitle("Im Natasha")
    Love.graphics.setDefaultFilter("linear", "nearest")

    local window_radius = math.sqrt(window_width^2 + window_height^2)

    PHYS = bump.newWorld(Cell.size)

    UI = UI:new {
        show_fps = true
    }

    GRID = Grid:new {
        radius = window_radius,
    }

    PLATFORM = Platform:new {
        base = Cell:new {x = 0, y = 0},
        width = 3,
    }
    PLATFORM:addToPhys(PHYS)

    PLATFORM2 = Platform:new {
        base = Cell:new {x = 4, y = 2},
        width = 3,
    }
    PLATFORM2:addToPhys(PHYS)

    CHAR = Character:new()
    CHAR:moveToCell(PLATFORM.base)
    CHAR:addToPhys(PHYS)

    CAM = ZoomCamera:new(CHAR.x, CHAR.y)

    MOUSE = {
        window_x = window_width / 2, window_y = window_height / 2
    }

    local gl = GraphicsLoader:new {
        path = "assets/textures.map"
    }

    SPRITES = gl:loadSprites()
end

return load
