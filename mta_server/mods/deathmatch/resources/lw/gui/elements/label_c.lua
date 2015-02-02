--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        label_c.lua.lua
*  PURPOSE:     (GUI) DXLabel
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXLabel = Class(DXView)

function DXLabel.create( x, y, w, h, parent, text, textColor, font, scale, alignX, alignY )
	if not textColor then textColor = dxColors.lightGray end
	if not font then font = dxFonts.default end
	if not scale then scale = 1 end
	if not alignX then alignX = "left" end
	if not alignY then alignY = "top" end

	self = DXView.create(x, y, w, h, parent)
	self:setClass(DXLabel)
	self.text = text
	self.textColor = textColor
	self.font = font
	self.scale = scale
	self.alignX = alignX
	self.alignY = alignY
	DXLabel.class = "DXLabel"

	return self
end

function DXLabel:draw( )
	if not self.visible then return end
	 dxDrawText (self.text, self.absX, self.absY, self.absX+self.w, self.absY+self.h, self.textColor, self.scale, self.font, self.alignX, self.alignY)
end