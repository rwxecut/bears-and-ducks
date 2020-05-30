local input = {}
input.k = require "src.input.keyboard"
input.m = require "src.input.mouse"
input.w = require "src.input.window"


local function load()

end


local function update(dt)

end


local function draw()
    love.graphics.print('The Bears And The Ducks', 400, 300)
end


return {
    load = load,
    update = update,
    draw = draw,
    keypressed = input.k.keypressed,
    keyreleased = input.k.keyreleased,
    mousepressed = input.m.mousepressed,
    mousereleased = input.m.mousereleased,
    focus = input.w.focus,
    quit = input.w.quit,
}
