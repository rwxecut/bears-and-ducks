local Copy = {}


function Copy.shallow(orig)
    if type(orig) == "table" then
        local o = {}
        for k, v in next, orig, nil do
            o[k] = v
        end
        setmetatable(o, Copy.deep(getmetatable(orig)))
        return o
    else
        return orig
    end
end


function Copy.deep(orig, already_copied)
    already_copied = already_copied or {}
    if type(orig) == "table" then
        if already_copied[orig] then
            return already_copied[orig]
        else
            local o = {}
            already_copied[orig] = o
            for k, v in next, orig, nil do
                o[Copy.deep(k, already_copied)] = Copy.deep(v, already_copied)
            end
            setmetatable(o, Copy.deep(getmetatable(orig), already_copied))
            return o
        end
    else
        return orig
    end
end


function Copy.localizeField(table, field)
    if type(table) == "table" and not rawget(table, field) then
        table[field] = Copy.deep(table[field])
    end
end


--[[
    TESTS
]]--

-- Test naive
local a, a_c
a = {
    b = "text"
}
a_c = a
a_c.b = "other"
assert(a.b == "other")


-- Test shallow 1 (usual keys)
a = {
    b = "text"
}
a_c = Copy.shallow(a)
assert(a ~= a_c)
a_c.b = "other"
assert(a.b == "text")


-- Test shallow 2 (table inside)
a = {
    b = {
        text = "text"
    }
}
a_c = Copy.shallow(a)
assert(a ~= a_c)
a_c.b.text = "other"
assert(a.b.text == "other")

a_c.b = "there was a table"
assert(type(a.b) == "table")


-- Test shallow 3 (recursive)
a = {}
a.b = a
a_c = Copy.shallow(a)
assert(a_c ~= a)
assert(a_c.b == a)


-- Test deep 1 (same as shallow 1)
a = {
    b = "text"
}
a_c = Copy.deep(a)
assert(a ~= a_c)
a_c.b = "other"
assert(a.b == "text")


-- Test deep 2 (same as shallow 2)
a = {
    b = {
        text = "text"
    }
}
a_c = Copy.deep(a)
a_c.b.text = "other"
assert(a.b.text == "text")

a_c.b = "there was a table"
assert(a.b.text == "text")


-- Test deep 3 (same as shallow 3)
a = {}
a.b = a
a_c = Copy.deep(a)
assert(a ~= a_c)
assert(a == a.b)
assert(a_c == a_c.b)
assert(a.b ~= a_c.b)


-- TODO: add tests with metatables


return Copy
