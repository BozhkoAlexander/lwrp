--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        commands.lua
*  PURPOSE:     Console commands for development
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

function setLocation ( playerSource, command , parameter )
	if not parameter then
		local vector = playerSource.position
		local rot = playerSource.rotation
		outputDebugString(playerSource.name.."'s position: x - "..vector.x..", y - "..vector.y..", z - "..vector.z..", r - "..rot.z)
	end
end
addCommandHandler ( "loc", setLocation )