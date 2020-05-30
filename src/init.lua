local function init(love)
    local all_functions = {}

    local game = {}
    game.draw = require "src.game.draw"
    game.load = require "src.game.load"
    game.update = require "src.game.update"

    for func_name, get_func in pairs(game) do
        game[func_name] = get_func(love)
        all_functions[func_name] = game[func_name]
    end

    local input = {}
    input.k = require "src.input.keyboard"
    input.m = require "src.input.mouse"
    input.w = require "src.input.window"

    for component, get_funcs in pairs(input) do
        input[component] = get_funcs(love)

        for func_name, func in pairs(input[component]) do
            all_functions[func_name] = func
        end
    end

    return all_functions
end

return init
