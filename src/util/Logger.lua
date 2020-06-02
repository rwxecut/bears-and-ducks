local Logger = {
    component = "",
    enable_info = true,
}


function Logger:new(t)
    local o = Construct(self, t)
    if o.component then
        o.component = " <" .. o.component .. ">"
    end
    return o
end


function Logger:debug(...)
    if self.enable_debug then
        print("DEBUG" .. (self.component or "") .. ":", ...)
    end
end


function Logger:info(...)
    if self.enable_info then
        print("INFO " .. (self.component or "") .. ":", ...)
    end
end


function Logger:warn(...)
    print("WARN " .. (self.component or "") .. ":", ...)
end



return Logger
