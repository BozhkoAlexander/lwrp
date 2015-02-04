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
	
-- 183, 184, 210, 206
-- 193, 13

local createPassTarget = nil
local charSelectionActivity = false
local skinIds = {183, 184, 210, 206}
local pedPos = {{x = 1695.203, y = -2290, z = -1.224, r = -90},
				   {x = 1689.842, y = -2282.655, z = -1.224, r = 90},
				   {x = 1655.862, y = -2274.25, z = -1.224, r = 180},
				   {x = 1655.138, y = -2298.866, z = -1.224, r = 0}}
local camPos = {{x = 1697.1, y = -2290, z = -0.5},
				{x = 1687, y = -2282.655, z = -0.5},
				{x = 1655.862, y = -2276.1, z = -0.5},
				{x = 1655.138, y = -2297, z = -0.5}}
local cur = 0

local function createCharSelectionPeds()
	for i = 1, #skinIds do
		local ped = createPed(skinIds[i], pedPos[i].x, pedPos[i].y, pedPos[i].z, pedPos[i].r, false)
		setElementDimension(ped, 65535)
		setPedAnimation(ped, "ped", "SEAT_IDLE", -1, true, false)
	end
end

local function initRegisterPlayerPage()
	--/images/passport.png
	local scrW, scrH = guiGetScreenSize()
	local scaleX = scrW / 1920
	local scaleY = scrH / 1080
	createPassTarget = createTarget(0.5*scrW-180, 0.5*scrH-101, 360, 203, "pass")
	local card = createView(0, 0, 360, 203, createPassTarget)
	card.image = "/images/passport.png"
	local fNameLabel = createLabel(0, 70, 200, 30, createPassTarget, "ИМЯ: ")
	fNameLabel.alignX = "right"
	fNameLabel.font = lwFonts.oldType
	fNameLabel.color = lwColors.lwBlack
	local lNameLabel = createLabel(0, 100, 200, 30, createPassTarget, "ФАМИЛИЯ: ")
	lNameLabel.alignX = "right"
	lNameLabel.font = lwFonts.oldType
	lNameLabel.color = lwColors.lwBlack
	-- local lNameLabel = createLabel(0, 130, 200, 30, createPassTarget, "ПОЛ (М/Ж): ")
	-- lNameLabel.alignX = "right"
	-- lNameLabel.font = lwFonts.oldType
	-- lNameLabel.color = lwColors.lwBlack
	
	createPassTarget.fNameEditbox = createEditBox(200, 68, 150, 30, createPassTarget, "fname")
	createPassTarget.fNameEditbox.color = nil
	createPassTarget.fNameEditbox.label.color = lwColors.lwBlack
	createPassTarget.fNameEditbox.label.font = lwFonts.oldType
	createPassTarget.lNameEditbox = createEditBox(200, 98, 150, 30, createPassTarget, "lname")
	createPassTarget.lNameEditbox.color = nil
	createPassTarget.lNameEditbox.label.color = lwColors.lwBlack
	createPassTarget.lNameEditbox.label.font = lwFonts.oldType
	setInputedEditBox(createPassTarget.fNameEditbox)
end

function startCreatePlayer()
	fadeCamera(true)
	setCameraMatrix(1380, -2386, 62, 1581, -2271, 13.5)
	createCharSelectionPeds()
	initRegisterPlayerPage()
end

local function nextChar()
	cur = cur + 1
	if cur > #skinIds then cur = 1 end
	setCameraMatrix(camPos[cur].x, camPos[cur].y, camPos[cur].z,  pedPos[cur].x, pedPos[cur].y, pedPos[cur].z)
end

local function prevChar()
	cur = cur - 1
	if cur <= 0 then cur = #skinIds end
	setCameraMatrix(camPos[cur].x, camPos[cur].y, camPos[cur].z,  pedPos[cur].x, pedPos[cur].y, pedPos[cur].z)
end

local function showHUD()
	call (getResourceFromName("radar"), "setVisible", true)
	call (getResourceFromName("hud"), "setVisible", true)
	setChatBoxVisible(true)
end

addEventHandler("onClientKey", root, 
function(button,press)
	if charSelectionActivity and button == "arrow_r" and not press then
		nextChar()
	elseif charSelectionActivity and button == "arrow_l" and not press then
		prevChar()
	elseif button == "enter" and not press then
		if charSelectionActivity and cur ~= 0 then
			local charData = {}
			charData.sex = 1
			charData.wStyle = 118
			if charData.sex == 0 then
				charData.wStyle = 129
			end
			charData.skin = skinIds[cur]
			charData.pos = pedPos[cur]
			charData.userId = localUser.id
			charData.firstName = createPassTarget.fNameEditbox.label.text
			charData.lastName = createPassTarget.lNameEditbox.label.text
			setTimer(showHUD, 1000, 1)
			triggerServerEvent("newChar:skinSelected", getRootElement(), localPlayer, charData)
		elseif #createPassTarget.fNameEditbox.label.text > 1 and #createPassTarget.lNameEditbox.label.text > 2 then
			setInputedEditBox()
			createPassTarget.visible = false
			charSelectionActivity = true
			nextChar()
		end
	end
end)