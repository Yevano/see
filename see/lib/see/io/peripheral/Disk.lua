--@import see.io.Peripheral
--@import see.io.peripheral.AbstractPeripheral

--@extends see.io.peripheral.AbstractPeripheral

--[[
	Wrapper for disk peripherals
	@param see.base.String:what side the disk is on (can be on network as well)
]]
function Disk:init(location)
	self:super(AbstractPeripheral).init(location)
end

function Disk:isPresent()
	return Peripheral.call(self.location, "isPresent")
end

function Disk:hasData()
	return Peripheral.call(self.location, "hasData")
end

function Disk:getMountPath()
	return Peripheral.call(self.location, "getMountPath")
end

function Disk:setLabel(label)
	Peripheral.call(self.location, "setLabel", label)
end

function Disk:getLabel()
	return Peripheral.call(self.location, "getLabel")
end

function Disk:getID()
	return Peripheral.call(self.location, "getID")
end

function Disk:hasAudio()
	return Peripheral.call(self.location, "hasAudio")
end

function Disk:hasAudioTitle()
	return Peripheral.call(self.location, "hasAudioTitle")
end

function Disk:playAudio()
	Peripheral.call(self.location, "playAudio")
end

function Disk:stopAudio()
	Peripheral.call(self.location, "stopAudio")
end

function Disk:eject()
	Peripheral.call(self.location, "eject")
end