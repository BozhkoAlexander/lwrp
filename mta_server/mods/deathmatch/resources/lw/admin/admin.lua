
--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        admin.lua
*  PURPOSE:     Server side admin logic
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

--Respawn positions
SpawnPos = {
	lsAirport1 = { x = 1682.55, y = -2327.25, z = -2.67, r = 0}
}

addEvent("admin:spawn:incognito", true)
addEventHandler("admin:spawn:incognito", root, function ()
	outputDebugString("Player "..source.name.." will spawn incognito.")
	local pos = SpawnPos.lsAirport1
	source:fadeCamera(true)
	source:setCameraTarget(source)
	source:spawn(pos.x, pos.y, pos.z, pos.r, 183, 0, 0)
end)

--admin:vehicle
addEvent("admin:vehicle", true)
addEventHandler("admin:vehicle", root, function ( id )
	outputDebugString("Player "..source.name.." will get a vehicle.")
	local x, y, z = getElementPosition(source)
	vehicle = Vehicle(id, Vector3(x+4, y, z+0.2)); -- Create a vehicle and spawn it at the middle of SA.
    vehicle:setColor(34, 34, 34); -- Set its color.
end)

--giveWeapon
addEvent("admin:weapon", true)
addEventHandler("admin:weapon", root, function ( id )
	outputDebugString("Player "..source.name.." will get a weapon.")
	giveWeapon(source, id, 120)
end)