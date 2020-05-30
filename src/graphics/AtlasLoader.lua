local AtlasLoader = {
    path = "",
}

AtlasLoader.__index = AtlasLoader


function AtlasLoader:new(t)
    local o = t or self
    setmetatable(o, self)
    return o
end


return AtlasLoader
