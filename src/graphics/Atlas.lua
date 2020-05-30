local Atlas = {
    path = "",
}

Atlas.__index = Atlas


function Atlas:new(t)
    local o = t or self
    setmetatable(o, self)

    o.image = Love.graphics.newImage(o.path)
    return o
end


return Atlas
