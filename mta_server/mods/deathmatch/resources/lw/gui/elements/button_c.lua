--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        label_c.lua.lua
*  PURPOSE:     (GUI) DXButton
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXButton = Class(DXView)

function DXButton.create( x, y, w, h, parent, title, borderColor, backgroundColor, titleColor, font )
	if not borderColor then borderColor = dxColors.blue end
	if not backgroundColor then backgroundColor = dxColors.backgroundColor end
	if not titleColor then titleColor = dxColors.darkGray end
	if not font then font = dxFonts.arial end
	if not titleColor then titleColor = dxColors.lightGray end

	self = DXView.create(x, y, w, h, parent)
	self:setClass(DXButton)
	self.borderColor = borderColor
	self.backgroundColor = backgroundColor
	self.state = DXState.normal

	self.titleLabel = DXLabel.create( 0, 0, w, h, self, title, nil, font, 1.2, "center", "center" )

	self.class = "DXButton"

	return self
end

function DXButton:setState( state )
	self.state = state
end

function DXButton:draw( )
	if not self.visible then return end
	dxDrawRectangle(self.absX, self.absY, self.w, self.h, self.backgroundColor)
	dxDrawRectangle(self.absX, self.absY, self.w, 1, self.borderColor)
	dxDrawRectangle(self.absX, self.absY, 1, self.h, self.borderColor)
	dxDrawRectangle(self.absX+self.w-1, self.absY, 1, self.h, self.borderColor)
	dxDrawRectangle(self.absX, self.absY+self.h-1, self.w, 1, self.borderColor)
end

function DXButton:OnClick( )
	outputDebugString("No implementation for click.")
end