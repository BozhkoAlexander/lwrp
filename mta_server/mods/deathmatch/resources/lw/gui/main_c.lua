--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        main_c.lua
*  PURPOSE:     (GUI) Main script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

adminPanel = nil
  
addEventHandler("onClientResourceStart", getRootElement(), function(res) 
	if res.name ~= "lw" then return end
	adminPanel = DXWindow.create( 0.7*scrX, 0.2*scrY, 300, 300, nil, "Admin panel")
	adminPanel.spawnButton = DXButton.create(20, 40, 80, 35, adminPanel, "Spawn")
	outputDebugString(adminPanel.spawnButton.class)
	adminPanel.spawnButton.onClick = function ( self, button, state )
		outputDebugString("test")
	end
end)