--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        label_c.lua
*  PURPOSE:     (GUI) Label class file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXLabel = class ("DXLabel", virtual(DXView), {
	text = "";
	scale = 1;
	font = "default";
	alignX = "left";
	alignY = "top";
	clip = false;
	wordBreak = false;
})

function DXLabel:__init ( x, y, w, h, color, text, scale, font, alignX, alignY, clip, wordBreak )
	self.DXView:__init(x, y, w, h, color)
	self.text = text or ""
	self.scale = scale or 1
	self.font = font or "default"
	self.alignX = alignX or "left"
	self.alignY = alignY or "top"
	self.clip = clip or false
	self.wordBreak = wordBreak or false
end

function DXLabel:draw ( )
	local x, y, w, h = self:getFrame()
	local absX, absY = self:getAbsPos()
	dxDrawText(self.text, absX, absY, absX + w, absY + h, self:getColor(), self.scale, self.font, self.alignX, self.alignY, self.clip, self.wordBreak)
end

function DXLabel:setText( text )
	self.text = text
end

--[[ Documentation:
Class name: DXLabel	Parent class: DXView

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
	DXLabel([float x, float y, float w, float h, color color, string text, float scale, mixed font, string alignX, string alignY, bool clip, bool wordBreak])
]]