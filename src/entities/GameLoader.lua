local log = Logger:new {
    component = "GameLoader"
}


local GameLoader = {
    new = Construct,
    path = "",
}


function GameLoader:loadCarousel(grid)
    local data = require(self.path)

    local carousel = StageCarousel:new {
        grid = grid,
        current = data.initial,
    }

    for stage_name, stage_data in pairs(data.stages) do
        local pg = PlatformGroup:new()
        for _, platform in pairs(stage_data.platforms) do
            local p = Platform:new {
                pos = Vector(platform[1], platform[2]),
                dim = Vector(platform[3] or 1, platform[4] or 1),
            }
            pg:addPlatform(p, true)
        end

        local spawn = Cellular:new {
            pos = Vector(stage_data.spawn[1], stage_data.spawn[2])
        }

        carousel:set(stage_name, Stage:new {
            prev = stage_data.prev,
            next = stage_data.next,
            spawn = spawn,
            platform_g = pg,
        })
    end

    return carousel
end


return GameLoader
