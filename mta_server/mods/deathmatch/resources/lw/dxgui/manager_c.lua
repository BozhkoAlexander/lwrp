--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        manager_c.lua
*  PURPOSE:     (GUI) Events file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXViews = {}

LWColor = {
	main = tocolor(0, 186, 255),
	alert = tocolor(255, 128, 0),
	back = tocolor(87, 87, 87),
	back2 = tocolor(187, 187, 187),
	title = tocolor(34, 34, 34)
}

addEventHandler("onClientRender", getRootElement(), function ( )
	for i, view in ipairs(DXViews) do
		--outputDebugString("here "..classname(view))
		view:draw()
	end
end)