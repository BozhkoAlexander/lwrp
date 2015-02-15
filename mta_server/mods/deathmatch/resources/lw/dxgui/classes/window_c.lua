--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        window_c.lua
*  PURPOSE:     (GUI) DXWindow classs
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXWindow = class ("DXWindow", virtual(DXView), {
	borderColor = tocolor(150, 150, 150);
	titleLabel = nil;
})

function DXWindow:__init ( x, y, w, h, color, borderColor, textColor, title)
	self.DXView:__init(x, y, w, h, color)
	self.borderColor = borderColor or tocolor(150, 150, 150)
	self.titleLabel = DXLabel(0, 0, w, 20, textColor, title, nil, nil, "center", "center")
	self:addSubview(self.titleLabel)
end

function DXWindow:draw ( )
	local x, y, w, h = self:getFrame()
	local absX, absY = self:getAbsPos()
	dxDrawRectangle(absX, absY, w, h, self:getColor())
	dxDrawRectangle(absX, absY, w, 20, self.borderColor)
	dxDrawRectangle(absX, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX + w - 1, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX, absY + h - 1, w, 1, self.borderColor)
end

--[[ Documentation:
Class name: DXWindow	Parent class: DXView

private fields:
	color borderColor - color of borders of window
	DXLabel titleLabel - title label of window 

public methods:
	void draw() - drawing view on every frame

constructors:
	DXWindow([float x, float y, float w, float h, color color, color borderColor, color textColor, string title])
]]