--[[ MTA Lost World Role Play, Author: Alexander Bozhko
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.]]
	
	
function resourceStart()
    local realtime = getRealTime()
 
    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end
addEventHandler("onResourceStart", getRootElement(), resourceStart)

local function spawnCharacter(thePlayer, user)
	local player = user.player
	if not player then return end
	spawnPlayer(thePlayer, player.pos.x, player.pos.y, player.pos.z,  player.pos.r, player.skin)
	setCameraTarget(thePlayer, thePlayer)
	fadeCamera(thePlayer, true)
end

addEvent("newChar:skinSelected", true)
addEventHandler("newChar:skinSelected", getRootElement(),
function(thePlayer, characterData)
	local success = createPlayer(characterData)
	if success then
		local player = getPlayerFromUserId(characterData.userId)
		triggerClientEvent("onGetPlayerFinished", thePlayer, player)
	end
end)

--[[
	characterData:
	userId
	firstName
	lastName
	sex: 1-male, 0-female
	pos.x, pos.y, pos.z, pos.r
	skin
	wStyle
]]
