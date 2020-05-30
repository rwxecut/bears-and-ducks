local main = require "src.main"


for key, value in pairs(main) do
    love[key] = value
end
