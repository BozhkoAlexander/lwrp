--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        view_c.lua
*  PURPOSE:     (GUI) View file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXView = class('DXView', {
	x = 0;
 	y = 0;
 	w = 0;
 	h = 0;
 	color = tocolor(255, 255, 255);
})

function DXView:__init( x, y, w, h, color )
	self.x = x or 0
	self.y = y or 0
	self.w = w or 0
	self.h = h or 0
	self.color = color or tocolor(255, 255, 255)
end

function DXView:draw( )
	dxDrawRectangle(self.x, self.y, self.w, self.h, self.color)
end

function DXView:frame( )
	return self.x, self.y, self.w, self.h
end

function DXView:color( )
	return self.color
end