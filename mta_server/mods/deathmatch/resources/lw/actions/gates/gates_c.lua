--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        gate.lua
*  PURPOSE:     gate actions client file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local _marker = nil
local _gateId = nil

-- Add a new event called onPlayerHitGateMarker
addEvent ( "onPlayerHitGateMarker", true )
addEventHandler ( "onPlayerHitGateMarker", getRootElement(), function ( marker, gateId )
	outputChatBox("Press E to open/close gate.")
	_marker = marker
	_gateId = gateId
end )

function markerLeave ( leavingPlayer, matchingDimension )
    outputChatBox ( getPlayerName(leavingPlayer) .. " left a marker" )
end
 
addEventHandler ( "onClientMarkerLeave", getRootElement(), function ( leavingPlayer, matchingDimension )
	_marker = nil
	_gateId = nil
end )

addEventHandler("onPressedInteractiveAction", localPlayer, function ( )
	if (not _marker or not _gateId) then return end
	triggerServerEvent("onToggleGate", localPlayer, _marker, _gateId)
end)

addEvent("onGateToggled", true)
addEventHandler("onGateToggled", getRootElement(), function ( x, y, z )
	playSFX3D("script", 198, 0, x, y, z, false)
	local x, y, z = getElementPosition(localPlayer)
end)

