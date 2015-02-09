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
	self.alignY = alignX or "top"
	self.clip = clip or false
	self.wordBreak = wordBreak or false
end;

function DXLabel:draw ( )
	local x, y, w, h = self:frame()
	dxDrawText(self.text, x, y, x + w, y + h, self:color(), self.scale, self.font, self.alignX, self.alignY, self.clip, self.wordBreak)
end;