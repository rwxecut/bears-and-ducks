local function Construct(self, t)
    local o = t or {}
    self.__index = self
    return setmetatable(o, self)
end

return Construct
