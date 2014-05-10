--@import see.rt.security.PermissionPolicy

local managers = Array:new()

--[[
    Checks whether the given permission is given by the active security managers.
    @param number:permission
]]
function SecurityManager.check(permission)
    for manager in managers:iAll() do
        if manager.enabled then
            if manager.permissions[permission] then
                return false
            end
        end
    end
    return true
end

function SecurityManager:init()
    self.enabled = false
    self.permissions = { }
    managers:add(self)
end

function SecurityManager:setEnabled(enabled)
    self.enabled = enabled
end

function SecurityManager:getEnabled()
    return self.enabled
end

function SecurityManager:addPolicy(permission, allowed)
    self.permissions[permission] = not allowed
end

function SecurityManager:getPolicies(permission)
    return permissions[permission]
end