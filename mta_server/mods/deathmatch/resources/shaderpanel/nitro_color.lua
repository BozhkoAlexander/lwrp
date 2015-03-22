
chosen_red_nitro=0
chosen_green_nitro=127
chosen_blue_nitro=255
function build_kolor_dialog_1()
	
	local gui = {}
    gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 420, 168
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	guikolornitro = guiCreateWindow(left, top, windowWidth, windowHeight, "Nitro", false)
	guiWindowSetSizable(guikolornitro, false)
	
	gui["kolor_nitro_label"] = guiCreateLabel(170, 15, 167, 31, ":Choose Color:", false, guikolornitro)
	guiLabelSetHorizontalAlign(gui["kolor_nitro_label"], "left", false)
	guiLabelSetVerticalAlign(gui["kolor_nitro_label"], "center")
	
	guikolor_nitro_button = guiCreateButton(10, 135, 401, 23, "Ok", false, guikolornitro)
	if on_kolor_button_clicked then
		addEventHandler("onClientGUIClick", guikolor_nitro_button, on_kolor_nitro_button_clicked, false)
	end
	
	guired_nitro_scroll_bar = guiCreateScrollBar(10, 45, 351, 20,true, false, guikolornitro)
	guigreen_nitro_scroll_bar = guiCreateScrollBar(10, 75, 351, 21,true, false, guikolornitro)
	guiblue_nitro_scroll_bar = guiCreateScrollBar(10, 105, 351, 21,true, false, guikolornitro)
	
	gui["czer_nitro_label"] = guiCreateLabel(380, 48, 46, 20, "Red", false, guikolornitro)
	guiLabelSetHorizontalAlign(gui["czer_nitro_label"], "left", false)
	guiLabelSetVerticalAlign(gui["czer_nitro_label"], "center")
	
	gui["ziel_nitro_label"] = guiCreateLabel(380, 78, 46, 20, "Green", false, guikolornitro)
	guiLabelSetHorizontalAlign(gui["ziel_nitro_label"], "left", false)
	guiLabelSetVerticalAlign(gui["ziel_nitro_label"], "center")
	
	gui["nieb_nitro_label"] = guiCreateLabel(380, 108, 46, 20, "Blue", false, guikolornitro)
	guiLabelSetHorizontalAlign(gui["nieb_nitro_label"], "left", false)
	guiLabelSetVerticalAlign(gui["nieb_nitro_label"], "center")
	
	return gui, windowWidth, windowHeight
end

build_kolor_dialog_1()



guiSetVisible(guikolornitro, false)
showCursor(false)
guiScrollBarSetScrollPosition(guired_nitro_scroll_bar,0)
guiScrollBarSetScrollPosition(guigreen_nitro_scroll_bar,50)
guiScrollBarSetScrollPosition(guiblue_nitro_scroll_bar,100)


setElementData(guired_nitro_scroll_bar, "Typ_nitro_kol", 1)
setElementData(guigreen_nitro_scroll_bar, "Typ_nitro_kol", 2)
setElementData(guiblue_nitro_scroll_bar, "Typ_nitro_kol", 3)




function closeButtonnitro()
guiSetVisible(guikolornitro, false)
end
addEventHandler ( "onClientGUIClick", guikolor_nitro_button, closeButtonnitro, false )



function updatecolnitro(Scrol)
	local positnitro = guiScrollBarGetScrollPosition(Scrol)
	local cchosnitro = getElementData(Scrol, "Typ_nitro_kol")
change_color_nitro(cchosnitro,positnitro)

end
addEventHandler("onClientGUIScroll", getRootElement(), updatecolnitro)


function change_color_nitro(ch_color_nitro,ch_pos_nitro)
if ch_color_nitro==1 then chosen_red_nitro=(ch_pos_nitro/100)*255 colormynitro(chosen_red_nitro,chosen_green_nitro,chosen_blue_nitro) end
if ch_color_nitro==2 then chosen_green_nitro=(ch_pos_nitro/100)*255 colormynitro(chosen_red_nitro,chosen_green_nitro,chosen_blue_nitro) end
if ch_color_nitro==3 then chosen_blue_nitro=(ch_pos_nitro/100)*255 colormynitro(chosen_red_nitro,chosen_green_nitro,chosen_blue_nitro) end

end