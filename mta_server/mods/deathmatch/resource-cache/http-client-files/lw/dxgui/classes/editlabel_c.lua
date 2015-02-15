--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        editlabel_c.lua
*  PURPOSE:     (GUI) Edit label class file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXEditLabel = class ("DXEditLabel", virtual(DXView), {
	textLabel = nil;
	borderColor = tocolor(150, 150, 150);
	backgroundColor = tocolor(34, 34, 34);
	onClicked = nil;

	edited = false;
	backTimer = nil;
})

function DXEditLabel:__init ( x, y, w, h, backgroundColor, borderColor, textColor, text, scale, font, alignX, alignY, clip, wordBreak )
	self.DXView:__init(x, y, w, h, textColor)
	self.borderColor = borderColor or tocolor(150, 150, 150)
	self.backgroundColor = backgroundColor or tocolor(0, 0, 0, 0)
	self.textLabel = DXLabel(5, 0, w-5, h, textColor, text, nil, nil, "left", "center")
	self:addSubview(self.textLabel)

	self.onClicked = function ( self )
		self.edited = true
	end
end

function DXEditLabel:draw ( )
	local x, y, w, h = self:getFrame()
	local absX, absY = self:getAbsPos()
	dxDrawRectangle(absX, absY, w, h, self.backgroundColor)
	dxDrawRectangle(absX, absY, w, 1, self.borderColor)
	dxDrawRectangle(absX, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX + w - 1, absY, 1, h, self.borderColor)
	dxDrawRectangle(absX, absY + h - 1, w, 1, self.borderColor)
	self.textLabel:draw()
end

function DXEditLabel:isEdited ( )
	return self.edited
end

function DXEditLabel:setEdited ( edited )
	self.edited = edited
end

function DXEditLabel:setText ( text )
	if self.textLabel.setText then
		self.textLabel:setText(text)
	else
		DXLabel.setText(self.textLabel, text)
	end
end

function DXEditLabel:startBackTimer ( )
	if self.backTimer then self.backTimer:destroy() end
	self.backTimer = Timer(triggerEvent, 100, 0, "onClientKey", root, "backspace", true)
end

function DXEditLabel:stopBackTimer ( )
	if self.backTimer then
		self.backTimer:destroy()
		self.backTimer = nil
	end
end

function DXEditLabel:backspace ( )
	if string.len(self.textLabel.text) > 0 then
		if string.len(self.textLabel.text) > 1 then
			local code = string.byte(string.sub(self.textLabel.text, -2))
			if code == 208 or code == 209 then
				self.textLabel:setText(string.sub(self.textLabel.text, 1, string.len(self.textLabel.text)-2))
				return self.textLabel.text
			end
		end
		DXEditLabel.setText(self, string.sub(self.textLabel.text, 1, string.len(self.textLabel.text)-1))
		--self.textLabel:setText(string.sub(self.textLabel.text, 1, string.len(self.textLabel.text)-1))
		
	end
	return self.textLabel.text
end

--[[ Documentation:
Class name: DXEditLabel	Parent class: DXView

private fields:
	string text - text
	float scale - scale of text
	mixed font - font of text
	string alignX - "left", "center", "right"
	string alignY - "top", "center", "bottom"
	bool clip - if set to true, the parts of the text that don't fit within the bounding box will be cut off.
	bool wordBreak - if set to true, the text will wrap to a new line whenever it reaches the right side of the bounding box. If false, the text will always be completely on one line.

public methods:
	void draw() - drawing view on every frame

constructors:
	DXEditLabel([float x, float y, float w, float h, color color, string text, float scale, mixed font, string alignX, string alignY, bool clip, bool wordBreak])
]]