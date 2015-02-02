--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        adminpanel_c.lua
*  PURPOSE:     (GUI) Main script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

function createAdminPanel( )
	self = DXWindow.create( 0.7*scrX, 0.2*scrY, 300, 300, nil, "Admin panel")
	self.spawnButton = DXButton.create(20, 40, 80, 35, self, "Spawn")
	outputDebugString(self.spawnButton.class)
	self.spawnButton.onClick = function ( self, button, state )
		outputDebugString("test")
	end
	return self
end