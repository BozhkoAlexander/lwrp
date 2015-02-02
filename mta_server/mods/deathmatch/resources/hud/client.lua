local screenW,screenH = guiGetScreenSize()
local resW, resH = 1280, 720
local x, y =  (screenW/resW), (screenH/resH)

local visible = true

function setVisible(_visible)
	visible = _visible
end

function HudGtaV ( )
if not visible then return end
dxDrawImage(x*1145, y*110, 100, 50, "img/"..getPedWeapon(getLocalPlayer())..".png")


local money = string.format("%08d", getPlayerMoney(getLocalPlayer()))
dxDrawBorderedText(money.." ₽", screenW-200, y*50, screenW-50, y*40,tocolor(73,208,141,255),1.0,"pricedown","right","top",false,false,false)

showammo1 = getPedAmmoInClip (localPlayer,getPedWeaponSlot(localPlayer))
showammo2 = getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)
dxDrawBorderedText("".. showammo2 ,x*1150, y*75, x*1205, y*40,tocolor(255, 255, 255,255),1.0,"pricedown","right","top",false,false,false)
dxDrawBorderedText("".. showammo1 ,x*1212, y*75, x*750, y*40,tocolor(190, 190, 190,255),1.0,"pricedown","left","top",false,false,false)


local altura = 25
local imageL, imageA = 25,25
local star01, star02, star03, star04, star05, star06 = 1220, 1193, 1165, 1138, 1110, 1080
local image = "wanted/star.png"
wanted = getPlayerWantedLevel (getLocalPlayer())

	if wanted == 1 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 02 --fundo
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 03 --fundo
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end
	if wanted == 2 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image) -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 03 --fundo
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end

	if wanted == 3 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image) -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image) -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
 
	end
	
	if wanted == 4 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image) -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image) -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image) -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end

	if wanted == 5 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image) -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image) -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image) -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image) -- star 05
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image, 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end
	if wanted == 6 then 
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, image) -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, image) -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, image) -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, image) -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, image) -- star 05
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, image) -- star 06
	end

--------------------------------------------
end

function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, HudGtaV)
	else
		removeEventHandler("onClientRender", root, HudGtaV)
	end
	isVisible = not isVisible
end
bindKey ("F11", "down", toggleRadar)


local hudTable = {

"ammo",
"armour",
"clock",
"health",
"money",
"weapon",
"wanted",

"area_name",
"vehicle_name",
"breath",
"clock"
}

addEventHandler("onClientRender", root, HudGtaV)
addEventHandler("onClientResourceStart", resourceRoot,
    function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, false)
	end
    end
)

addEventHandler("onClientResourceStop", resourceRoot,
    function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, true)
	end
    end
)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end
