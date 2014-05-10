--@import see.rt.sercurity.PermissionPolicy
--@import see.rt.sercurity.Permissions

function FilePermissionPolicy:init(callback)
    self:super(PermissionPolicy).init(Permissions.FILES)
    self.callback = callback
end

function FilePermissionPolicy:check(operation, path)
    return callback(operation, path)
end