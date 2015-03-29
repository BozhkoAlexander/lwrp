--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        gate.lua
*  PURPOSE:     gate actions server file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local gatesData = {
	kacc = {
		left = {id = 986, x = 2497.4, y = 2769.1, z = 11.53, rx = 0, ry = 0, rz = 90, 
				ox = 2497.4, oy = 2762.03, oz = 11.53, orx = 0, ory = 0, orz = 0, crx = 0, cry = 0, crz = 0},
		right = {id = 985, x = 2497.4, y = 2777.08, z = 11.53, rx = 0, ry = 0, rz = 90, 
				ox = 2497.4, oy = 2784.78, oz = 11.53, orx = 0, ory = 0, orz = 0, crx = 0, cry = 0, crz = 0} 
	},
	kaccArmy = {
		left = {id = 968, x = 2692.8, y = 2849.35, z = 10.7, rx = 0, ry = 90, rz = 90, 
				ox = 2692.8, oy = 2849.35, oz = 10.7, orx = 0, ory = -90, orz = 0, crx = 0, cry = 90, crz = 0}
	}
}
local keysData = {
	kacc = {x = 2503.1, y = 2778.5, z = 9.85},
	kaccArmy = {x = 2692.8, y = 2848.3, z = 9.85}
}

local gates = {}
local keys = {}

function initGates()
	for k, g in pairs(gatesData) do
		local gate = {}
		if g.left then 
			gate.left = Object(g.left.id, g.left.x, g.left.y, g.left.z, g.left.rx, g.left.ry, g.left.rz)
			gate.lOpenPos = {x = g.left.ox, y = g.left.oy, z = g.left.oz, rx = g.left.orx, ry = g.left.ory, rz = g.left.orz} 
			gate.lClosePos = {x = g.left.x, y = g.left.y, z = g.left.z, rx = g.left.crx, ry = g.left.cry, rz = g.left.crz} 
		end
		if g.right then 
			gate.right = Object(g.right.id, g.right.x, g.right.y, g.right.z, g.right.rx, g.right.ry, g.right.rz) 
			gate.rOpenPos = {x = g.right.ox, y = g.right.oy, z = g.right.oz, rx = g.right.orx, ry = g.right.ory, rz = g.right.orz} 
			gate.rClosePos = {x = g.right.x, y = g.right.y, z = g.right.z, rx = g.right.crx, ry = g.right.cry, rz = g.right.crz} 
		end
		gate.closed = true

		local keyData = keysData[k]
		keys[k] = Marker(Vector3(keyData.x, keyData.y, keyData.z), "cylinder", 1, 255, 255, 0 ,255)
		addEventHandler( "onMarkerHit", keys[k], function ( hitElement, matchingDimension )
			if (matchingDimension == false) then return end
			if (hitElement.type ~= "player") then return end
			for k,key in pairs(keys) do
				if key == source then
					 triggerClientEvent(hitElement, "onPlayerHitGateMarker", hitElement, key, k)
				end
			end
		end )

		gates[k] = gate
	end
end

function toogleGate( gateId )
	local gate = gates[gateId]
	if (not gate) then outputDebugString("Gates "..gateId.." not found.") return end
	if gate.closed then
		if gate.left then
			gate.left:move(2000, Vector3(gate.lOpenPos.x, gate.lOpenPos.y, gate.lOpenPos.z), Vector3(gate.lOpenPos.rx, gate.lOpenPos.ry, gate.lOpenPos.rz))
		end
		if gate.right then
			gate.right:move(2000, Vector3(gate.rOpenPos.x, gate.rOpenPos.y, gate.rOpenPos.z), Vector3(gate.rOpenPos.rx, gate.rOpenPos.ry, gate.rOpenPos.rz))
		end
	else
		if gate.left then
			gate.left:move(2000, Vector3(gate.lClosePos.x, gate.lClosePos.y, gate.lClosePos.z), Vector3(gate.lClosePos.rx, gate.lClosePos.ry, gate.lClosePos.rz))
		end
		if gate.right then
			gate.right:move(2000, Vector3(gate.rClosePos.x, gate.rClosePos.y, gate.rClosePos.z), Vector3(gate.rClosePos.rx, gate.rClosePos.ry, gate.rClosePos.rz))
		end
	end
	gate.closed = not gate.closed
end

addEventHandler ( "onResourceStart", getRootElement(), function ( res )
	if res.name ~= "lw" then return end
	initGates()
end )

addEvent("onToggleGate", true)
addEventHandler("onToggleGate", getRootElement(), function ( marker, gateId )
	local gate = gates[gateId]
	for i,player in ipairs(Player.getAllAlive()) do
		local x, y, z = player.position
		local vector = Vector3(gate.lOpenPos.x, gate.lOpenPos.y, gate.lOpenPos.z)
		local distance = getDistanceBetweenPoints3D(vector, x, y, z)
		if distance <= 50 then
			triggerClientEvent(player, "onGateToggled", player, vector.x, vector.y, vector.z)
		end
	end
	toogleGate(gateId)
end)