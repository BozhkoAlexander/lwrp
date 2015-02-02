--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        functions_c.lua
*  PURPOSE:     (GUI) Helper script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

-- Classes

function Class( superclass )
	class = {}
	if superclass then
		setmetatable(class, {__index = superclass})
	end
	return class
end

--Contol states
DXState = {
	normal = 0,
	highlight = 1,
	pressed = 2,
	released = 3
}

--Color
function  dxColor(r ,g, b, a)
	if not a then a = 255 end
	local  self = { r = r, g = g, b = b, a = a }
	self.tocolor = function ( self )
		return tocolor(self.r, self.g, self.b, self.a)
	end

	return self
end

dxColors = { orange = tocolor(255, 128, 0, 255),
			 blue = tocolor(0, 186, 255, 255),
			 lightGray = tocolor(187, 187, 187, 255),
			 backgroundColor = tocolor(87, 87, 87, 128),
			 darkGray = tocolor(40, 40, 40, 255)
}

--Font

dxFonts = { arial = "arial",
			default = "default",
			default_bold = "default-bold",
			header = DxFont("/gui/fonts/ferretface.ttf", 12) 
}

--helper functions
function isInside( x, y, elem )
	return x >= elem.absX and x <= elem.absX+elem.w and y >= elem.absY and y <= elem.absY+elem.h
end


