--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        binds_c.lua
*  PURPOSE:     (GUI) Keys bindings
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

function toggleCursor( )
	showCursor(not isCursorShowing ())
end


addEventHandler("onClientResourceStart", getRootElement(), function(res) 
	if res.name ~= "lw" then return end
	bindKey ("F2", "up", toggleCursor )
end)
