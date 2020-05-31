require "src.util"

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
