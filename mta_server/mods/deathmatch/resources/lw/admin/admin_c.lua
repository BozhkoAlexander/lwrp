--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        admin_c.lua
*  PURPOSE:     Client side admin logic
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

Admin = {}

function Admin.spawnIncognito()
	triggerServerEvent("admin:spawn:incognito", localPlayer)
end

function Admin.getCar()
	triggerServerEvent("admin:vehicle", localPlayer, 411)
end

function Admin.getHydra()
	triggerServerEvent("admin:vehicle", localPlayer, 520)
end

function Admin.getWeapon( id )
	triggerServerEvent("admin:weapon", localPlayer, id)
end