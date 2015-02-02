--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        view_c.lua.lua
*  PURPOSE:     (GUI) DXView
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

DXView = Class()

function DXView.create( x, y, w, h, parent )
	if type(parent) ~= "table" then parent = nil end

	self = {}
	setmetatable(self, {__index = DXView})

	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.visible = true
	self.parent = parent

	if parent then
		self.absX = parent.absX+self.x 
		self.absY = parent.absY+self.y
	else
		self.absX = self.x
		self.absY = self.y
	end

	if parent then
		self.parent:addSubview(self)
	end
	table.insert(dxElements, self)

	self.class = "DXView"

	return self
	
end

function DXView:initSubViews( )
	self.subviews = {}
end

function DXView:addSubview( subview )
	if not self.subviews then self:initSubViews() end
	table.insert(self.subviews, subview)
end

function DXView:draw( )
	--outputDebugString(self.class.." has no draw method.")
end

function  DXView:setClass( class )
	setmetatable(self, {__index = class})
end