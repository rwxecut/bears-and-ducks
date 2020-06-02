CONSTS = {
    cell_side_real = 32,
    grid_draw_radius = 5,
}

Construct = require "src.util.Construct"
Copy = require "src.util.Copy"
Logger = require "src.util.Logger"

Character = require "src.entities.Character"
Cellular = require "src.entities.Cellular"
GameLoader = require "src.entities.GameLoader"
Grid = require "src.entities.Grid"
Platform = require "src.entities.Platform"
PlatformGroup = require "src.entities.PlatformGroup"
Stage = require "src.entities.Stage"
StageCarousel = require "src.entities.StageCarousel"
UserInterface = require "src.entities.UserInterface"
ZoomCamera = require "src.entities.ZoomCamera"

GraphicsLoader = require "src.graphics.GraphicsLoader"
Sprite = require "src.graphics.Sprite"
SpriteBatched = require "src.graphics.SpriteBatched"
SpriteSingle = require "src.graphics.SpriteSingle"


local all_functions = {}
local components = {
    g = {
        draw = require "src.game.draw",
        load = require "src.game.load",
        update = require "src.game.update",
    },
    k = require "src.input.keyboard",
    m = require "src.input.mouse",
    w = require "src.input.window",
}

for _, funcs in pairs(components) do
    for func_name, func in pairs(funcs) do
        all_functions[func_name] = func
    end
end

return all_functions
