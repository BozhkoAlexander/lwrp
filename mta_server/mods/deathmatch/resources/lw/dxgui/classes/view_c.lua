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
 	visible = true;
 	superview = nil;
 	subviews = {};
})

function DXView:__init( x, y, w, h, color )
	self.x = x or 0
	self.y = y or 0
	self.w = w or 0
	self.h = h or 0
	self.color = color or tocolor(255, 255, 255)
	self.visible = true
	self.subviews = {}
end

function DXView:draw( )
	local absX, absY = self:getAbsPos()
	dxDrawRectangle(absX, absY, self.w, self.h, self.color)
end

function DXView:getSuperview( )
	return self.superview
end

function DXView:setSuperview( view )
	self.superview = view
end

function DXView:addSubview( view )
	table.insert(self.subviews, view)
	view:setSuperview(self)
end

function DXView:getSubviews( )
	return self.subviews
end

function DXView:getFrame( )
	return self.x, self.y, self.w, self.h
end

function DXView:getAbsPos( )
	local absX, absY = 0, 0
	if self.superview then
		absX, absY = self.superview:getAbsPos()
	end
	return self.x + absX, self.y + absY
end

function DXView:getColor( )
	return self.color
end

function DXView:getVisible( )
	return self.visible
end

function DXView:setVisible( visible )
	self.visible = visible
end

function DXView:isInside( x, y )
	local absX, absY = self:getAbsPos()
	return (x >= absX) and (x <= absX + self.w) and (y >= absY) and (y <= absY + self.h)
end

--[[ Documentation:
Class name: DXView	Parent class: none

private fields:
	float x, y - position
	float w, h - width and height
	color color - background color (tocolor() function)
	bool visible - element is visible, if true

public methods:
	void draw() - drawing view on every frame
	DXView getSuperview() - return superview
	void setSuperview(DXView view) - set superview (not for use)
	void addSubview(DXView view) -- add new subview
	table getSubviews() - return
	float float float float getFrame() - return x, y, w, h
	float float getAbsPos() - return absolute position of element
	color getColor() - return color field
	bool getVisible() - return value of element visibility
	void setVisible(bool visible) - set visibility of element
	bool isInside(float x, float y) - return true, if point located inside view

constructors:
	DXView([float x, float y, float w, float h, color color])
]]