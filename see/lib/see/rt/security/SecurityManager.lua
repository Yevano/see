--@import see.rt.security.PermissionPolicy
--@import see.rt.security.SecurityException

local managers = Array:new()

--[[
    Checks whether the given permission is given by the active security managers.
    @param number:permission
    @param any:varargs the arguments to check on the policy
]]
function SecurityManager.check(permission, ...)
    for manager in managers:iAll() do
        if manager.enabled then
            local policies = manager.policies[permission]
            for policy in policies:iAll() do
                if not policy:check(...) then
                    throw(SecurityException:new("")) --TODO exception message
                end
            end
        end
    end
    return true
end

function SecurityManager:init()
    self.enabled = false
    self.policies = { }
    managers:add(self)
end

function SecurityManager:setEnabled(enabled)
    self.enabled = enabled
end

function SecurityManager:getEnabled()
    return self.enabled
end

function SecurityManager:addPolicy(permission, policy)
    local policies = self.policies[permission]
    if not policies then
        policies = Array:new()
        self.policies[permission] = policies
    end
    policies:add(policy)
end

function SecurityManager:getPolicies(permission)
    return policies[permission]
end