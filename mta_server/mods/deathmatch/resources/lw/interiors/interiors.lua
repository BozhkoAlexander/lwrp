--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        interiors_c.lua
*  PURPOSE:     interiors server file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local interiors = { {id = 1, x = 1405.3120, y = -8.2928, z = 1000.9130}, --Склад в Лос-Сантосе
					{id = 18, x = 1296.6310, y = 0.5920, z = 1001.0230},
					{id = 5, x = 322.1117, y = 1119.3270, z = 1083.8830} } -- Нарокманский притон

function setInterior( playerSource, interiorIndex )
	if (interiorIndex <= #interiors) then
		local interior = interiors[interiorIndex]
		setElementInterior(playerSource, interior.id, interior.x, interior.y, interior.z)
	end
end


function setInt ( playerSource, command , parameter )
	setInterior(playerSource, tonumber(parameter))
end
addCommandHandler ( "int", setInt )