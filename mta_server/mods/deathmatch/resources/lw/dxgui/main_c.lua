--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        main_c.lua
*  PURPOSE:     (GUI) Main script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local adminPanel = nil

function createAdminPanel( )
	local panel = {}
	--------------------
	local view = DXWindow(250, 50, 350, 400, LWColor.blackTranslucent, LWColor.blue, LWColor.black, "Admin panel")
	local spawnButton = DXButton(10, 300, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Появление")
	spawnButton:setOnClicked(function ( self )
		Admin.spawnIncognito()
	end)
	view:addSubview(spawnButton)

	local carButton = DXButton(10, 345, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Автомобиль")
	carButton:setOnClicked(function ( self )
		Admin.getCar()
	end)
	view:addSubview(carButton)

	--getHydra
	local airButton = DXButton(100, 345, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Самолет")
	airButton:setOnClicked(function ( self )
		Admin.getHydra()
	end)
	view:addSubview(airButton)

	local akButton = DXButton(100, 300, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "АК-74")
	akButton:setOnClicked(function ( self )
		Admin.getWeapon(30)
	end)
	view:addSubview(akButton)

	local airButton = DXButton(190, 345, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Вертолет")
	airButton:setOnClicked(function ( self )
		Admin.getVehicle(487)
	end)
	view:addSubview(airButton)

	local loginLabel = DXLabel(10, 40, 155, 30, LWColor.blue, "Логин:", nil, nil, "right", "center")
	view:addSubview(loginLabel)
	local passLabel = DXLabel(10, 80, 155, 30, LWColor.blue, "Пароль:", nil, nil, "right", "center")
	view:addSubview(passLabel)

	local loginEdit = DXEditLabel(175, 40, 165, 30, nil, LWColor.blue, LWColor.orange, "")
	view:addSubview(loginEdit)
	local passEdit = DXEditLabel(175, 80, 165, 30, nil, LWColor.blue, LWColor.orange, "")
	passEdit:setSecure(true)
	view:addSubview(passEdit)
	---------------------
	local loginButton = DXButton(260, 120, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Войти")
	loginButton:setOnClicked(function ( self )
		Admin.login(loginEdit.textLabel.text, passEdit.textLabel.text)
	end)
	view:addSubview(loginButton)

	panel.view = view
	panel.loginLabel = loginLabel
	panel.loginEdit = loginEdit
	panel.passLabel = passLabel
	panel.passEdit = passEdit
	panel.loginButton = loginButton

	table.insert(DXViews, view)
	return panel
end

addEventHandler("onClientResourceStart", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lw") then return end
	bindKeys()

	adminPanel = createAdminPanel()

	updateCursor()
end)

function toggleAdminPanel( )
	adminPanel.view:setVisible(not adminPanel.view:getVisible())
	updateCursor()
end