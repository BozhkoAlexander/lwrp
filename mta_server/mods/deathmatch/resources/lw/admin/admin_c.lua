--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        admin_c.lua
*  PURPOSE:     (GUI) Client side admin logic
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

Admin = {}

function Admin.spawnIncognito()
	triggerServerEvent("admin:spawn:incognito", localPlayer)
end