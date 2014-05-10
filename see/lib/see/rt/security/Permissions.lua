Permissions.FILES       = Permissions.register()
Permissions.NATIVES     = Permissions.register()
Permissions.PERIPHERALS = Permissions.register()
Permissions.HTTP        = Permissions.register()
Permissions.TERMINAL    = Permissions.register()

local permissions = 0

function Permissions.register()
    permissions = permissions + 1
    return permissions
end