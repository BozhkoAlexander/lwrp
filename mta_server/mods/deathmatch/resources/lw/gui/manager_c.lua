--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        manager_c.lua
*  PURPOSE:     (GUI) Manager script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

dxElements = {}

scrX, scrY = guiGetScreenSize()

addEventHandler("onClientRender", root, function ( )
	for i, element in ipairs(dxElements) do
		if element.draw then
			element:draw()
		end
	end
end)

addEventHandler("onClientClick", getRootElement(), function ( button, state, absX, absY)
	for i, element in ipairs(dxElements) do
		if element.class == "DXButton"  and isInside(absX, absY, element) then
			element:onClick(button, state)
		end
	end
end)