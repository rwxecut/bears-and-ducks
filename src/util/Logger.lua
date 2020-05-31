local Logger = {
    component = ""
}


function Logger:new(t)
    local o = Construct(self, t)
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
