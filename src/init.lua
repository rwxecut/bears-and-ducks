Logger = require "src.util.Logger"

Character = require "src.entities.Character"
Cell = require "src.entities.Cell"
Cellular = require "src.entities.Cellular"
GameLoader = require "src.entities.GameLoader"
Grid = require "src.entities.Grid"
Platform = require "src.entities.Platform"
Stage = require "src.entities.Stage"
StageCarousel = require "src.entities.StageCarousel"
UI = require "src.entities.UI"
ZoomCamera = require "src.entities.ZoomCamera"

Atlas = require "src.graphics.Atlas"
GraphicsLoader = require "src.graphics.GraphicsLoader"
Sprite = require "src.graphics.Sprite"

local all_functions = {}
local components = {}

components.g = {}
components.g.draw = require "src.game.draw"
components.g.load = require "src.game.load"
components.g.update = require "src.game.update"
components.k = require "src.input.keyboard"
components.m = require "src.input.mouse"
components.w = require "src.input.window"

for _component, funcs in pairs(components) do
    for func_name, func in pairs(funcs) do
        all_functions[func_name] = func
    end
end

return all_functions
