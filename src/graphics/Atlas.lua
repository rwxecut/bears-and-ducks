local Atlas = {
    path = "",
}


function Atlas:new(t)
    local o = Construct(self, t)
    o.image = Love.graphics.newImage(o.path)
    return o
end


return Atlas
