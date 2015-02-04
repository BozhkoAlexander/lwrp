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
	
lwFonts = { ["higherup"] = dxCreateFont("/fonts/AA Higherup.ttf", 16),
		["base"] = dxCreateFont("/fonts/Base 02.ttf", 10),
		["gost"] = dxCreateFont("/fonts/Gost Type B.ttf", 10),
		["caviar"] = dxCreateFont("/fonts/Caviar Dreams.ttf", 12),
		["europe"] = dxCreateFont("/fonts/EuropeExt.otf", 10),
		["boycott"] = dxCreateFont("/fonts/RUSBoycott.ttf", 25),
		["denistina"] = dxCreateFont("/fonts/Denistina.ttf", 18),
		["oldType"] = dxCreateFont("/fonts/oldType.ttf", 12)
}

lwColors = { lwBlue = {r = 0, g = 199, b = 254, a = 255},
			 lwDarkBlue = {r = 32, g = 65, b = 84, a = 255},
			 lwWhite = {r = 200, g = 200, b = 200, a = 255},
			 lwBlack = {r = 30, g = 30, b = 30, a = 255},
			 lwGray = {r = 88, g = 88, b = 88, a = 255}
}

-- LOST WORLD DEISGN

function createLWButton(x, y, w, h, target, title, id)
	local button = createButton(x, y, w, h, target, title, id)
	button.color = lwColors.lwBlue
	setColor(button, lwColors.lwDarkBlue, State.pressed)
	button.label.color = lwColors.lwDarkBlue
	setColor(button.label, lwColors.lwGray, State.highlighted)
	setColor(button.label, lwColors.lwWhite, State.pressed)
	button.label.font = lwFonts.higherup
	button.label.scale = 1
	return button
end

function createLWLabel(x, y, w, h, target, text, id)
	local label = createLabel(x, y, w, h, target, text, id)
	label.color = lwColors.lwBlue
	label.font = lwFonts.higherup
	label.scale = 1.2
	return label
end

function createLWEditBox(x, y, w, h, target, id)
	local editbox = createEditBox(x, y, w, h, target, id)
	editbox.color = lwColors.lwGray
	editbox.color.a = 200
	editbox.label.color = lwColors.lwBlack
	editbox.label.font = lwFonts.caviar
	editbox.label.scale = 1
	return editbox
end

function createInfoBox(editbox, id, texts)
	local iBox = createView(editbox.x+editbox.w+10, editbox.y, 238, 16+15*#texts, editbox.target, id)
	iBox.color = createColor(0, 0, 0, 100)
	iBox.strings = {}
	for i = 1, #texts do
		iBox.strings[i] = createLabel(iBox.x+8, iBox.y+8+15*(i-1), 222, 15, editbox.target, texts[i])
		iBox.strings[i].color = lwColors.lwBlue
		iBox.strings[i].alignX = "left"
	end
	iBox.setVisible = function(self, visible)
		self.visible = visible
		for i = 1, #self.strings do
			self.strings[i].visible = visible
		end
	end
	return iBox
end

function createMessageBox(x, y, w, h, target, text, id)
	local box = createView(x, y, w, h, target, id)
	box.label = createLabel(x, y, w, h, target, text, id)
	box.color = createColor(0, 0, 0, 100)
	box.toggleVisible = function(self)
		self.visible = not self.visible
		self.label.visible = not self.label.visible
	end
	box:toggleVisible()
	box.showMessage = function(self)
		self:toggleVisible()
		setTimer(self.toggleVisible, 5000, 1, self)
	end
	return box
end