--@import see.rt.ClassLoader

--@native __rt
--@native pairs
--@native setmetatable
--@native setfenv
--@native xpcall
--@native rawget

--@extends see.rt.ClassLoader

local function copy(t)
    local r = { }
    for k, v in pairs(t) do
        r[k] = v
    end
    return r
end

local function getPackageName(package, del)
    if not del then del = "." end
    for i = #package, 0, -1 do
        if i == 0 or package:sub(i, i) == del then
            return package:sub(i + 1)
        end
    end
end

function DefaultClassLoader:loadClass(def, annotations, name, refName, env)
	local className = getPackageName(name)

    if __rt.classes[name] then
        return __rt.classes[name]
    end

    if not refName then
        env = copy(__rt.standardGlobals)
    end

    local anon = refName ~= nil
    refName = refName or className

    local class = { }

    local fdtnl = false
    if name == "see.base.Object" then
        __rt.base.Object = class
        fdtnl = true
    end

    if name == "see.rt.Class" then
        __rt.rt.Class = class
        fdtnl = true
    end

    __rt.classes[name] = class
    __rt.classLookup[class] = true
    __rt.classTables[class] = { __name = name }

    setmetatable(class, __rt.classMT)

    if not fdtnl then
        -- Import base classes.
        for k, class in pairs(__rt.base) do
            env[k] = class
        end

        -- Import Events class for convenience.
        env["Events"] = __rt.event.Events
    end

    -- Setup class environment.
    env[refName] = class
    setfenv(def, env)
    xpcall(def, errorHandler)

    local abool = true
    for k, v in pairs(annotations) do
        local ret
        if anon then
            ret = __rt:executeTableStyleAnnotation(env, class, k, v)
        else
            ret = __rt:executeAnnotation(env, class, v)
        end
        if ret then
            abool = false
        end
    end

    -- Extend Object by default.
    if abool and __rt.base.Object and name ~= "see.base.Object" then
        --rawset(class, "super", __rt.base.Object)
        __rt.classTables[class].__super = __rt.base.Object
    end

    local static = rawget(__rt.classTables[class], "__static")
    if static then
        static()
    end

    return class
end