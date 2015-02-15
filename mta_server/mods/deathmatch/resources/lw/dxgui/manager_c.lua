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
	blue = tocolor(0, 186, 255),
	orange = tocolor(255, 128, 0),
	gray = tocolor(87, 87, 87),
	lightGray = tocolor(187, 187, 187),
	blackTranslucent = tocolor(34, 34, 34, 200),
	black = tocolor(34, 34, 34)
}

local function drawView( view )
	if view:getVisible() then
		view:draw()
		for i,subview in ipairs(view:getSubviews()) do
			--outputDebugString("here "..classname(#subview:getSubviews()))
			drawView(subview)
		end
	end
end

addEventHandler("onClientRender", getRootElement(), function ( )
	for i, view in ipairs(DXViews) do
		drawView(view)
	end
end)

------------------ GUI actions ------------------

addEvent("onDXButtonRelease", false)

local function getPressedSubview( view, x, y )
	local pressedView = nil
	if view:getVisible() and view:isInside(x, y) then
		pressedView = view
		if classname(pressedView) == "DXButton" then return pressedView end
		if classname(pressedView) == "DXEditLabel" then return pressedView end
		for i,subview in ipairs(view:getSubviews()) do
			pressedView = getPressedSubview(subview, x, y) or pressedView
		end
	end
	return pressedView
end

local function sendEvent( view, button, state )
	if classname(view) == "DXButton" or classname(view) == "DXEditLabel" then
		if button == "left" then
			if state == "up" then
				view:onClicked()
			end
		end
	end
end

addEventHandler("onClientClick", getRootElement(), function ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	--outputDebugString(button.." ".." "..state.." "..absoluteX.." "..absoluteY)
	local pressedView = nil
	for i,view in ipairs(DXViews) do
		pressedView = getPressedSubview(view, absoluteX, absoluteY)
	end
	if pressedView then sendEvent(pressedView, button, state) end
end )

------------------ Text input ------------------

local function getEditedLabel( view )
	local editLabel = nil
	if not view then
		for i, view in ipairs(DXViews) do
			editLabel = getEditedLabel(view) or editLabel
		end
	else
		if view:getVisible() then
			if classname(view) == "DXEditLabel" and view:isEdited() then return view end
			for i,subview in ipairs(view:getSubviews()) do
				editLabel = getEditedLabel(subview) or editLabel
			end
		end
	end
	return editLabel
end

local editSleep = 0

addEventHandler("onClientKey", root, function(button,press)
	editLabel = getEditedLabel()
	if not editLabel then return end
	if button == "backspace" then
		if press then
			if not editLabel.backTimer then
				editLabel:backspace() 
				editLabel:startBackTimer()
			elseif editSleep > 4 then
				editLabel:backspace()
			end
			editSleep = editSleep + 1
		else
			editSleep = 0
			editLabel:stopBackTimer()
		end
	end
end)

addEventHandler("onClientCharacter", getRootElement(), function ( character )
	editLabel = getEditedLabel()
	if not editLabel then return end
	if editLabel then
		editLabel:setText(editLabel.textLabel.text..character)
	end
end)