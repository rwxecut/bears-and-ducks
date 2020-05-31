local Logger = {
    component = ""
}

Logger.__index = Logger


function Logger:new(t)
    local o = t or self
    setmetatable(o, self)

    if o.component ~= nil then
        o.component = " <" .. o.component .. ">"
    end
    return o
end


function Logger:info(text)
    print("INFO" .. (self.component or "") .. ":", text)
end


function Logger:warn(text)
    print("WARN" .. (self.component or "") .. ":", text)
end

return Logger
