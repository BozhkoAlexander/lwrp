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

addEventHandler("onClientResourceStart", getRootElement(), function ( startedRes )
	local view = DXWindow(50, 50, 350, 400, LWColor.back, LWColor.main, LWColor.title, "Admin panel")
	table.insert(DXViews, view)
	outputDebugString("view "..classname(view))
end)