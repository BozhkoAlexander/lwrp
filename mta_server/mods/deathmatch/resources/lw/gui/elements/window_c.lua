--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        window_c.lua
*  PURPOSE:     (GUI) DXWindow
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXWindow = Class(DXView)

function DXWindow.create( x, y, w, h, parent, title, borderColor, backgroundColor, titleColor, font )
	if not borderColor then borderColor = dxColors.blue end
	if not backgroundColor then backgroundColor = dxColors.backgroundColor end
	if not titleColor then titleColor = dxColors.darkGray end
	if not font then font = dxFonts.header end

	self = DXView.create(x, y, w, h, parent)
	self:setClass(DXWindow)
	self.borderColor = borderColor
	self.backgroundColor = backgroundColor

	self.titleLabel = DXLabel.create( 0, 0, w, 20, self, title, titleColor, font, 1, "center", "center" )

	self.class = "DXWindow"

	return self
end

function DXWindow:draw( )
	if not self.visible then return end
	dxDrawRectangle(self.absX, self.absY, self.w, self.h, self.backgroundColor)
	dxDrawRectangle(self.absX, self.absY, self.w, 20, self.borderColor)
	dxDrawRectangle(self.absX, self.absY, 1, self.h, self.borderColor)
	dxDrawRectangle(self.absX+self.w-1, self.absY, 1, self.h, self.borderColor)
	dxDrawRectangle(self.absX, self.absY+self.h-1, self.w, 1, self.borderColor)
end