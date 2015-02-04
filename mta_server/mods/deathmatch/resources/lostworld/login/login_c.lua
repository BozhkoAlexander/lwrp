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
	
localUser = nil --Global client user data
	
playerState = 0 --[[0 - joined, 1 - logined]]
local loginState = 0 --[[0 - start, 1 - registration, 2 - rules]]

local soundTheme = nil

local mainTarget = nil
local loginTarget = nil
local registerTarget = nil
local rulesTarget = nil
local rulesView = nil

local registerData = {}

function setPlayerState(state)
	playerState = state
	if state == 1 then
		removeTarget(mainTarget)
		removeTarget(loginTarget)
		removeTarget(registerTarget)
		removeTarget(rulesTarget)
		removeTarget(rulesView)
		
		stopSound(soundTheme)
		showCursor(false)
	end
end

function setLoginState(state)
	setPlayerState(0)
	mainTarget.visible = true
	loginTarget.visible = state == 0
	registerTarget.visible = state == 1
	rulesTarget.visible = state == 2
	rulesView.visible = state == 2
	loginState = state
end

local function initLoginTarget(scrW, scrH, scaleX, scaleY)
	loginTarget = createTarget(0.5*scrW-scaleX*572, 0.5*scrH-scaleY*322, scaleX*1144, scaleY*644, "login")
	local city1 = createView(0, 0, loginTarget.w, loginTarget.h, loginTarget)
	city1.image = "/images/city1.png"
	local title = createView(0.5*loginTarget.w-scaleX*175, 5, scaleX*351, scaleX*89, loginTarget)
	title.image = "/images/title.png"
	
	local loginLabel = createLWLabel(0.5*loginTarget.w-150, 0.33*loginTarget.h, 300, 30, loginTarget, "ИМЯ ПОЛЬЗОВАТЕЛЯ")
	loginTarget.usernameEditBox = createLWEditBox(loginLabel.x, loginLabel.y+28, loginLabel.w, loginLabel.h, loginTarget, "username")
	local passLabel = createLWLabel(loginLabel.x, loginLabel.y+70, 300, 30, loginTarget, "ПАРОЛЬ")
	loginTarget.passEditBox = createLWEditBox(passLabel.x, passLabel.y+28, passLabel.w, passLabel.h, loginTarget, "password")
	loginTarget.passEditBox.label.mask = true
	loginTarget.loginButton = createLWButton(loginTarget.w/2-110, loginLabel.y+150, 95, 35, loginTarget, "ВОЙТИ", "login")
	loginTarget.registerButton = createLWButton(loginTarget.w/2+15, loginLabel.y+150, 95, 35, loginTarget, "РЕГИСТРАЦИЯ", "register")
	loginTarget.errorLabel = createLabel(passLabel.x, loginTarget.loginButton.y+50, 300, 50, loginTarget, "Неверное имя пользователя или пароль")
	loginTarget.errorLabel.font = lwFonts.caviar
	loginTarget.errorLabel.color = lwColors.lwBlue
	loginTarget.errorLabel.visible = false
end

local function initInfoBoxes()
	usernameInfo = {
		"Имя пользователя должно быть",
		"не короче 6 сиволов и может",
		"содержать:",
		"- буквы латинского алфавита [A-z, a-z];",
		"- цифры [0-9];",
		"- символы ['-','_','.']."
	}
	registerTarget.nameIBox = createInfoBox(registerTarget.usernameEditBox, "usernameInfo", usernameInfo)
	registerTarget.nameIBox:setVisible(false)
	emailInfo = {
		"E-mail должен быть реальным",
		"существующим адресом электронной",
		"почты, например: example@mail.com."
	}
	registerTarget.emailIBox = createInfoBox(registerTarget.emailEditBox, "emailInfo", emailInfo)
	registerTarget.emailIBox:setVisible(false)
	passInfo = {
		"Пароль должен быть",
		"не корчое 8 символов и может",
		"содержать:",
		"- буквы латинского алфавита [A-z, a-z];",
		"- цифры [0-9]."
	}
	registerTarget.passIBox = createInfoBox(registerTarget.passEditBox, "passInfo", passInfo)
	registerTarget.passIBox:setVisible(false)
	confirmInfo = {"Пароли должны совпадать."}
	registerTarget.confirmIBox = createInfoBox(registerTarget.confirmEditBox, "confirmInfo", confirmInfo)
	registerTarget.confirmIBox:setVisible(false)
end

local function initRegisterTarget(scrW, scrH, scaleX, scaleY)
	registerTarget = createTarget(0.5*scrW-scaleX*572, 0.5*scrH-scaleY*459, scaleX*1145, scaleY*919, "signup")
	local city2 = createView(0, 0, registerTarget.w, registerTarget.h, registerTarget)
	city2.image = "/images/city2.png"
	local title = createView(0.5*registerTarget.w-scaleX*175, 5, scaleX*351, scaleX*89, registerTarget)
	title.image = "/images/title.png"
	
	local titleLabel = createLWLabel(0, title.h+20, registerTarget.w, 20, registerTarget, "РЕГИСТРАЦИЯ")
	titleLabel.font = lwFonts.boycott
	usernameLabel = createLWLabel(registerTarget.w/2-470, 0.33*registerTarget.h, 300, 30, registerTarget, "ИМЯ ПОЛЬЗОВАТЕЛЯ:")
	usernameLabel.alignX = "right"
	registerTarget.usernameEditBox = createLWEditBox(registerTarget.w/2-150, usernameLabel.y-3, 300, 30, registerTarget, "username")
	emailLabel = createLWLabel(usernameLabel.x, usernameLabel.y+50, 300, 30, registerTarget, "E-MAIL:")
	emailLabel.alignX = "right"
	registerTarget.emailEditBox = createLWEditBox(registerTarget.usernameEditBox.x, emailLabel.y-3, 300, 30, registerTarget, "email")
	passwordLabel = createLWLabel(usernameLabel.x, usernameLabel.y+100, 300, 30, registerTarget, "ПАРОЛЬ:")
	passwordLabel.alignX = "right"
	registerTarget.passEditBox = createLWEditBox(registerTarget.usernameEditBox.x, passwordLabel.y-3, 300, 30, registerTarget, "password")
	registerTarget.passEditBox.label.mask = true
	confirmLabel = createLWLabel(usernameLabel.x, usernameLabel.y+150, 300, 30, registerTarget, "ПОВТОРИТЕ ПАРОЛЬ:")
	confirmLabel.alignX = "right"
	registerTarget.confirmEditBox = createLWEditBox(registerTarget.usernameEditBox.x, confirmLabel.y-3, 300, 30, registerTarget, "confirm")
	registerTarget.confirmEditBox.label.mask = true
	
	registerTarget.backButton = createLWButton(registerTarget.usernameEditBox.x, usernameLabel.y+200, 95, 35, registerTarget, "НАЗАД", "back")
	registerTarget.registerButton = createLWButton(registerTarget.usernameEditBox.x+registerTarget.usernameEditBox.w-115, usernameLabel.y+200, 95, 35, registerTarget, "РЕГИСТРАЦИЯ", "signup")
	initInfoBoxes()
	
	registerTarget.errorLabel = createLabel(registerTarget.usernameEditBox.x, registerTarget.confirmEditBox.y+100, 300, 50, registerTarget, "")
	registerTarget.errorLabel.font = lwFonts.caviar
	registerTarget.errorLabel.color = lwColors.lwBlue
end

local function getRules()
	local hFile = fileOpen("rules.txt", true)
	local rules = ""
	if hFile then
		while not fileIsEOF(hFile) do
			buffer = fileRead(hFile, 512)
			rules = rules..buffer
		end 
		fileClose(hFile)
	else
		outputDebugString("Unable to open rules.txt")
	end
	return rules
end

local function initRulesTarget(scrW, scrH, scaleX, scaleY)
	rulesTarget = createTarget(0.5*scrW-scaleX*572, 0.5*scrH-scaleY*459, scaleX*1145, scaleY*919, "rules")
	local city3 = createView(0, 0, rulesTarget.w, rulesTarget.h, rulesTarget)
	city3.image = "/images/city3.png"
	local title = createView(0.5*rulesTarget.w-scaleX*175, 5, scaleX*351, scaleX*89, rulesTarget)
	title.image = "/images/title.png"
	local titleLabel = createLWLabel(0, title.h+20, rulesTarget.w, 20, rulesTarget, "ПРАВИЛА СЕРВЕРА")
	titleLabel.font = lwFonts.boycott
	local rules = getRules()
	
	rulesView = createLWScrollView(rulesTarget.x+6, rulesTarget.y+titleLabel.y+30, rulesTarget.w-10, rulesTarget.h -(titleLabel.y+30) - 65, nil, nil, "rulesView")
	rulesView.contentView.color = createColor(0, 0, 0, 220)
	rulesView.contentView.h = 145*15
	local textLabel = createLabel(8, 8, rulesView.h-29, rulesView.contentView.h-16, rulesView, rules)
	textLabel.color = lwColors.lwBlue
	textLabel.alignX = "left"
	textLabel.alignY = "top"
	
	rulesTarget.declineButton = createLWButton(registerTarget.w/2-105, rulesTarget.h-50, 95, 35, rulesTarget, "НЕ ПРИНИМАЮ", "decline")
	rulesTarget.acceptButton = createLWButton(registerTarget.w/2+10, rulesTarget.h-50, 95, 35, rulesTarget, "ПРИНИМАЮ", "accept")
end

function valid()
	if loginState == 1 then
		local nameV = string.len(registerData.username) >= 6 and not string.match(registerData.username, "[^a-zA-Z0-9%-._]")
		local emailV = string.len(registerData.email) > 0 and string.match(registerData.email, '.+@.+%..+')
		local passV = string.len(registerData.password) >= 8 and not string.match(registerData.password, "[^a-zA-Z0-9]")
		local confirmV = registerData.password == registerData.confirm
		return nameV and emailV and passV and confirmV
	end
end

function joinHandler(res)	
	if getResourceName(res) ~= "lostworld" then return end
	setElementDimension(localPlayer, 65535)
	call (getResourceFromName("radar"), "setVisible", false)
	call (getResourceFromName("hud"), "setVisible", false)
	
	soundTheme = playSound("/sounds/LW001.mp3", true) --Play wasted.mp3 from the sounds folder
	setSoundVolume(soundTheme, 0.7) -- set the sound volume to 50%
	
	showCursor(true)
	
	local scrW, scrH = guiGetScreenSize()
	local scaleX = scrW / 1920
	local scaleY = scrH / 1080
	mainTarget = createTarget(0, 0, scrW, scrH, "background")
	local background = createView(0, 0, scrW, scrH, mainTarget)
	if scrW/scrH == 4/3 then
		background.image = "/images/background4x3.png"
	else
		background.image = "/images/background.png"
	end
	local logo = createView(0.98*scrW-scaleX*150, 0.15*scrH-scaleY*150, scaleX*150, scaleX*150, mainTarget)--528
	logo.image = "/images/logo.png"
	initLoginTarget(scrW, scrH, scaleX, scaleY)
	initRegisterTarget(scrW, scrH, scaleX, scaleY)
	initRulesTarget(scrW, scrH, scaleX, scaleY)
	
	setLoginState(0)
	localUser = nil
end
addEventHandler("onClientResourceStart", getRootElement(), joinHandler)

addEventHandler("onClientResourceStop", getRootElement(),
    function (stoppedRes)
		if not stoppedRes or getResourceName(stoppedRes) ~= "lostworld" then return end
        triggerServerEvent("logoffUser", getRootElement(), localPlayer, localUser)
    end
);

addEventHandler("onButtonReleased", getRootElement(),
function (button)
	if button.id == loginTarget.loginButton.id then
		outputDebugString("Try login as "..loginTarget.usernameEditBox.label.text.." with password "..loginTarget.passEditBox.label.text.."...")
		triggerServerEvent("loginUser", getRootElement(), localPlayer, loginTarget.usernameEditBox.label.text, loginTarget.passEditBox.label.text)
	elseif button.id == loginTarget.registerButton.id then
		setLoginState(1)
	elseif button.id == registerTarget.backButton.id then
		setLoginState(0)
	elseif button.id == registerTarget.registerButton.id then
		registerData.username = registerTarget.usernameEditBox.label.text
		registerData.email = registerTarget.emailEditBox.label.text
		registerData.password = registerTarget.passEditBox.label.text
		registerData.confirm = registerTarget.confirmEditBox.label.text
		if valid() then
			triggerServerEvent("findUser", getRootElement(), localPlayer, registerData.username, registerData.email)
			registerTarget.errorLabel.text = ""
		else
			registerTarget.errorLabel.text = "Проверьте правильность введенных данных"
			outputDebugString("Invalid registration data. Check all fields.")
		end
	elseif button.id == rulesTarget.declineButton.id then
		setLoginState(0)
	elseif button.id == rulesTarget.acceptButton.id then
		triggerServerEvent("regsiterNewUser", getRootElement(), localPlayer, registerData.username, registerData.email, registerData.password)
	end
end
)

addEventHandler("onEditBoxStartEditing", getRootElement(),
function (editbox)
	if registerTarget.visible then
		registerTarget.nameIBox:setVisible(editbox.id == registerTarget.usernameEditBox.id)
		registerTarget.emailIBox:setVisible(editbox.id == registerTarget.emailEditBox.id)
		registerTarget.passIBox:setVisible(editbox.id == registerTarget.passEditBox.id)
		registerTarget.confirmIBox:setVisible(editbox.id == registerTarget.confirmEditBox.id)
	end
end
)

addEvent("onRegisterDataChecked", true)
addEventHandler("onRegisterDataChecked", localPlayer, 
function (result)
	if result then
		registerTarget.errorLabel.text = "Пользователь с такими данными уже существует"
		outputDebugString("User with these data already exists. Change the data.")
	else
		registerTarget.errorLabel.text = ""
		setLoginState(2)
	end
end
)

addEvent("onUserCreated", true)
addEventHandler("onUserCreated", localPlayer, 
function (result)
	if result then
		setLoginState(0)
	else
		setLoginState(1)
		outputDebugString("Duplicate data.")
	end
end
)

addEvent("onUserLogined", true)
addEventHandler("onUserLogined", localPlayer,
function (user)
	if user then 
		setPlayerState(1)
		localUser = user
		triggerServerEvent("getPlayer", getRootElement(), localPlayer, localUser)
		loginTarget.errorLabel.visible = false
	else
		localUser = nil
		outputDebugString("Invalid login data")
		loginTarget.errorLabel.visible = true
	end
end)

addEvent("onGetPlayerFinished", true)
addEventHandler("onGetPlayerFinished", localPlayer,
function(player)
	if player then
		localUser.player = player
		triggerServerEvent("onPlayerLogined", localPlayer, localUser)
	else
		outputDebugString("User "..localUser.name.." has no player. To create...")
		startCreatePlayer()
	end
end)