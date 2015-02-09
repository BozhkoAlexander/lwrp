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
	
function stopMinigunDamage(attacker, weapon, bodypart)
	local hp = getElementHealth(localPlayer)
	if bodypart == 9 then
		setElementHealth(localPlayer, 0)
	end
	if weapon == 4 then
		setElementHealth(localPlayer, hp - 28)
	elseif weapon == 8 then
		setElementHealth(localPlayer, hp - 39)
	elseif weapon == 22 then
		if bodypart == 3 then
			setElementHealth(localPlayer, hp - 26)
		end
	elseif weapon == 23 then
		if bodypart == 3 then
			setElementHealth(localPlayer, hp - 37)
		end
	elseif weapon == 24 then
		if bodypart == 3 then
			setElementHealth(localPlayer, hp - 8)
		end
	elseif weapon == 29 then
		if bodypart == 3 then
			setElementHealth(localPlayer, hp - 22)
		end
	elseif weapon == 32 or weapon == 28 then
		if bodypart == 3 then
			setElementHealth(localPlayer, hp - 13)
		end
	elseif weapon == 30 or weapon == 31 then
		if bodypart ~= 9 then
			setElementHealth(localPlayer, hp - 40)
		end
	elseif weapon == 33 or weapon == 34 then
		if bodypart ~= 9 then
			setElementHealth(localPlayer, 0)
		end
	elseif weapon == 37 then
		setElementHealth(localPlayer,hp - 0.5)
	end
	outputDebugString(getPlayerName(attacker).." with "..weapon.." to "..bodypart.." test "..getElementHealth(localPlayer))
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )