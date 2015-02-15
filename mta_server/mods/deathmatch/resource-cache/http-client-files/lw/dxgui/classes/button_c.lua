--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        button_c.lua
*  PURPOSE:     (GUI) Button class file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXButton = class ("DXButton", virtual(DXView), {
	borderColor = tocolor(150, 150, 150);
	titleLabel = nil;
	onClicked = nil;
})

function DXButton:__init ( x, y, w, h, color, borderColor, textColor, title)
	self.DXView:__init(x, y, w, h, color)
	self.borderColor = borderColor or tocolor(150, 150, 150)
	self.titleLabel = DXLabel(0, 0, w, h, textColor, title, nil, nil, "center", "center")
	self:addSubview(self.titleLabel)
end

function DXButton:draw ( )
	local x, y, w, h = self:getFrame()
	local absX, absY = self:getAbsPos()
	dxDrawRectangle(absX, absY, w, h, self:getColor())
	dxDrawRectangle(absX, absY, w, 1, self.borderColor)
	dxDrawRectangle(absX, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX + w - 1, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX, absY + h - 1, w, 1, self.borderColor)
	self.titleLabel:draw()
end

function DXButton:setOnClicked( func )
	if not func then 
		self.onClicked = nil
	else
		self.onClicked = func
	end
end

--[[ Documentation:
Class name: DXButton	Parent class: DXView

private fields:
	color borderColor - color of borders of button
	DXLabel titleLabel - title label of button
	onClicked = function for action "left mouse button release"

public methods:
	void draw() - drawing view on every frame

constructors:
	DXButton([float x, float y, float w, float h, color color, color borderColor, color textColor, string title])
]]