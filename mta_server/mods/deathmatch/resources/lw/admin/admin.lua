--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        admin.lua
*  PURPOSE:     (GUI) Server side admin logic
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
	source:spawn(pos.x, pos.y, pos.z, pos.r, 0, 0, 0)
end)