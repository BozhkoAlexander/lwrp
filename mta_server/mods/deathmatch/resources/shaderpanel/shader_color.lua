
chosen_red_shader=255
chosen_green_shader=255
chosen_blue_shader=255
function build_kolor_dialog_2()
	
	local gui = {}
    gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 420, 168
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	guikolorshader = guiCreateWindow(left, top, windowWidth, windowHeight, "Screen", false)
	guiWindowSetSizable(guikolorshader, false)
	
	gui["kolor_shader_label"] = guiCreateLabel(170, 15, 167, 31, ":Choose Color:", false, guikolorshader)
	guiLabelSetHorizontalAlign(gui["kolor_shader_label"], "left", false)
	guiLabelSetVerticalAlign(gui["kolor_shader_label"], "center")
	
	guikolor_shader_button = guiCreateButton(10, 135, 401, 23, "Ok", false, guikolorshader)
	if on_kolor_button_clicked then
		addEventHandler("onClientGUIClick", guikolor_shader_button, on_kolor_shader_button_clicked, false)
	end
	
	guired_shader_scroll_bar = guiCreateScrollBar(10, 45, 351, 20,true, false, guikolorshader)
	guigreen_shader_scroll_bar = guiCreateScrollBar(10, 75, 351, 21,true, false, guikolorshader)
	guiblue_shader_scroll_bar = guiCreateScrollBar(10, 105, 351, 21,true, false, guikolorshader)
	
	gui["czer_shader_label"] = guiCreateLabel(380, 48, 46, 20, "Red", false, guikolorshader)
	guiLabelSetHorizontalAlign(gui["czer_shader_label"], "left", false)
	guiLabelSetVerticalAlign(gui["czer_shader_label"], "center")
	
	gui["ziel_shader_label"] = guiCreateLabel(380, 78, 46, 20, "Green", false, guikolorshader)
	guiLabelSetHorizontalAlign(gui["ziel_shader_label"], "left", false)
	guiLabelSetVerticalAlign(gui["ziel_shader_label"], "center")
	
	gui["nieb_shader_label"] = guiCreateLabel(380, 108, 46, 20, "Blue", false, guikolorshader)
	guiLabelSetHorizontalAlign(gui["nieb_shader_label"], "left", false)
	guiLabelSetVerticalAlign(gui["nieb_shader_label"], "center")
	
	return gui, windowWidth, windowHeight
end

build_kolor_dialog_2()



guiSetVisible(guikolorshader, false)
showCursor(false)
guiScrollBarSetScrollPosition(guired_shader_scroll_bar,100)
guiScrollBarSetScrollPosition(guigreen_shader_scroll_bar,100)
guiScrollBarSetScrollPosition(guiblue_shader_scroll_bar,100)


setElementData(guired_shader_scroll_bar, "Typ_shader_kol", 1)
setElementData(guigreen_shader_scroll_bar, "Typ_shader_kol", 2)
setElementData(guiblue_shader_scroll_bar, "Typ_shader_kol", 3)




function closeButtonshader()
guiSetVisible(guikolorshader, false)
end
addEventHandler ( "onClientGUIClick", guikolor_shader_button, closeButtonshader, false )



function updatecolguikolorshader(Scrol)
	local positshader = guiScrollBarGetScrollPosition(Scrol)
	local cchosshader = getElementData(Scrol, "Typ_shader_kol")
change_color_shader(cchosshader,positshader)

end
addEventHandler("onClientGUIScroll", getRootElement(), updatecolguikolorshader)


function change_color_shader(ch_color_shader,ch_pos_shader)
if ch_color_shader==1 then chosen_red_shader=(ch_pos_shader/100)*255 colormyshader(chosen_red_shader,chosen_green_shader,chosen_blue_shader) end
if ch_color_shader==2 then chosen_green_shader=(ch_pos_shader/100)*255 colormyshader(chosen_red_shader,chosen_green_shader,chosen_blue_shader) end
if ch_color_shader==3 then chosen_blue_shader=(ch_pos_shader/100)*255 colormyshader(chosen_red_shader,chosen_green_shader,chosen_blue_shader) end

end