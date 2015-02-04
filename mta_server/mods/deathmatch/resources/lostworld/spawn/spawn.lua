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

local spawnX, spawnY, spawnZ = 1682.55, -2327.25, -2.67

function spawn(player)
	player = player.player
	spawnPlayer(source, player.pos.x, player.pos.y, player.pos.z, player.pos.r, player.skin)
	fadeCamera(source, true)
	setCameraTarget(source, source)
	setPlayerNametagShowing(source, false)
	outputDebugString("But I'm here!")
end
addEvent("onPlayerLogined", true)
addEventHandler("onPlayerLogined", getRootElement(), spawn)

function removePlayer(player)
	spawnPlayer(player, spawnX, spawnY, spawnZ,  0, 0, 0, 65535)
	fadeCamera(player, false)
	setCameraTarget(player, nil)
end

addEventHandler("onPlayerWasted", getRootElement(),
	function(totalAmmo, killer, killerWeapon, bodypart, stealth)
		setTimer(fadeCamera, 8000, 1, source, false)
		setTimer(spawnPlayer, 10000, 1, source, spawnX, spawnY, spawnZ)
		setTimer(fadeCamera, 10000, 1, source, true)
	end
)
