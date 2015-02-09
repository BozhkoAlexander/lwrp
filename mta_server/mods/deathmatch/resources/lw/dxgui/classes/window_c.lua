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
	self.titleLabel = DXLabel(x, y, w, 20, textColor, title, nil, nil, "center", "center")
end;

function DXWindow:draw ( )
	local x, y, w, h = self:frame()
	dxDrawRectangle(x, y, w, h, self:color())
	dxDrawRectangle(x, y, w, 20, self.borderColor)
	dxDrawRectangle(x, y, 1, h, self.borderColor)
	dxDrawRectangle(x + w - 1, y, 1, h, self.borderColor)
	dxDrawRectangle(x, y + h - 1, w, 1, self.borderColor)
	self.titleLabel:draw()
end;