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
	
function anim(thePlayer, command, arg)
	if arg then
		setPedWalkingStyle(thePlayer, arg)
	else
		setPedAnimation(thePlayer, "ped", "ARRESTGUN", -1, true, false) --118, 129
	end
end
addCommandHandler("anim", anim)

---1861.936889,54.908092,1061.143554
function spawn(thePlayer, command, arg)
	spawnPlayer(thePlayer, -1861.936889, 54.908092, 1058.143554, 0, 0, 14)
end
addCommandHandler("toair", spawn)

local sitChecker = false
function sit(thePlayer, command, arg)
	if sitChecker then
		setPedAnimation(thePlayer, false)
	else
		setPedAnimation(thePlayer, "ped", "SEAT_IDLE", -1, true, false)
	end
	sitChecker = not sitChecker
end
addCommandHandler("sit", sit)