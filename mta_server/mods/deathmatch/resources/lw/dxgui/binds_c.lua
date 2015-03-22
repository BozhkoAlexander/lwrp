--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        binds_c.lua
*  PURPOSE:     (GUI) Key bindings
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

function bindKeys( )
	bindKey("F3", "up", toggleAdminPanel)
end

function updateCursor( )
	if isCursorShowing() ~= checkCursor() then toggleCursor() end
end

function checkCursor( )
	for i,view in ipairs(DXViews) do
		if view:getVisible() then return true end
	end
	return false
end

function toggleCursor( )
	showCursor(not isCursorShowing())
end