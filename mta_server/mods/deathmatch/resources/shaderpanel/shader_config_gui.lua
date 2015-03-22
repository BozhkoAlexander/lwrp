local fps=99
local frames,lastsec=0,0,0
local checkframes=0
localPlayer=getLocalPlayer()
local showguiconfig

	gui = {}
    guigfxconfig = {}
	gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 210, 337
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	guigfxconfig = guiCreateWindow(left, top, windowWidth, windowHeight, "Shader Panel", false)
	guiWindowSetSizable(guigfxconfig, false)
        guiSetVisible(guigfxconfig, false)
	
	gui["frameratelabel"] = guiCreateLabel(40, 25, 71, 16, "Frame rate:", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["frameratelabel"], "left", false)
	guiLabelSetVerticalAlign(gui["frameratelabel"], "center")
	
	gui["fpslabel"] = guiCreateLabel(110, 25, 31, 16,"", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["fpslabel"], "left", false)
	guiLabelSetVerticalAlign(gui["fpslabel"], "center")
	
	gui["ftextlabel"] = guiCreateLabel(149, 25, 34, 16, "FPS", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["ftextlabel"], "left", false)
	guiLabelSetVerticalAlign(gui["ftextlabel"], "center")
	
	gui["howfastlabel"] = guiCreateLabel(30, 45, 151, 20, "Fast", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["howfastlabel"], "center", false)
	guiLabelSetVerticalAlign(gui["howfastlabel"], "center")
	
	gui["availshadgfx"] = guiCreateLabel(10, 65, 191, 16, "Available shaders:", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["availshadgfx"], "left", false)
	guiLabelSetVerticalAlign(gui["availshadgfx"], "center")
	
	gui["gfxlabel_5"] = guiCreateLabel(10, 85, 111, 16, "Car Paint shader", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["gfxlabel_5"], "left", false)
	guiLabelSetVerticalAlign(gui["gfxlabel_5"], "center")
	
	gui["gfxlabel_6"] = guiCreateLabel(10, 105, 111, 16, "Nitro shader", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["gfxlabel_6"], "left", false)
	guiLabelSetVerticalAlign(gui["gfxlabel_6"], "center")
	
	gui["gfxlabel_7"] = guiCreateLabel(10, 125, 111, 16, "Water shader", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["gfxlabel_7"], "left", false)
	guiLabelSetVerticalAlign(gui["gfxlabel_7"], "center")
	
	gui["gfxlabel_8"] = guiCreateLabel(10, 215, 111, 16, "Screen shader", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["gfxlabel_8"], "left", false)
	guiLabelSetVerticalAlign(gui["gfxlabel_8"], "center")
	
	gui["gfxlabel_9"] = guiCreateLabel(10, 145, 111, 16, "Roadshine shader", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["gfxlabel_9"], "left", false)
	guiLabelSetVerticalAlign(gui["gfxlabel_9"], "center")
	
	
	
	guiroad1radio = guiCreateRadioButton(20, 165, 85, 21, "Roadshine 1", false, guigfxconfig)
	guiroad3radio = guiCreateRadioButton(20, 185, 85, 21, "Roadshine 3", false, guigfxconfig)
	guiSetEnabled(guiroad1radio, false)
    guiSetEnabled(guiroad3radio, false)
	
	guicarpaintboxgfx = guiCreateCheckBox(130, 85, 16, 17, "", false, false, guigfxconfig)
	
	guinitrobox = guiCreateCheckBox(130, 105, 16, 17, "", false, false, guigfxconfig)
	
	guiwaterbox = guiCreateCheckBox(130, 125, 16, 17, "", false, false, guigfxconfig)
	
	guibloomboxgfx = guiCreateCheckBox(130, 215, 16, 17, "", false, false, guigfxconfig)
	
	guiroadshinebox = guiCreateCheckBox(130, 145, 16, 17, "", false, false, guigfxconfig)
	
	
	gui["creditslabelgfx"] = guiCreateLabel(80, 315, 61, 16, "By Ren172", false, guigfxconfig)
	guiLabelSetHorizontalAlign(gui["creditslabelgfx"], "left", false)
	guiLabelSetVerticalAlign(gui["creditslabelgfx"], "center")
	
	guinitrocolorbutton = guiCreateButton(150, 105, 41, 21, "Color", false, guigfxconfig)
	if on_nitrocolorbutton_clicked then
		addEventHandler("onClientGUIClick", guinitrocolorbutton, on_nitrocolorbutton_clicked, false)
	end
	guiSetEnabled(guinitrocolorbutton,false)
guishadercolorbutton = guiCreateButton(150, 215, 41, 21, "Color", false, guigfxconfig)
if on_bloomcollorbuttongfx_clicked then
		addEventHandler("onClientGUIClick", guishadercolorbutton, on_guishadercolorbutton_clicked, false)
	end
  guiSetEnabled(guishadercolorbutton, false)
	
	applybuttongfx = guiCreateButton(30, 285, 71, 23, "Apply", false, guigfxconfig)
	if on_applybuttongfx_clicked then

		addEventHandler("onClientGUIClick", applybuttongfx, on_applybuttongfx_clicked, false)
	end
	
	closebuttongfx = guiCreateButton(110, 285, 71, 23, "Close", false, guigfxconfig)
	if on_closebuttongfx_clicked then
		addEventHandler("onClientGUIClick", closebuttongfx, on_applybuttongfx_clicked, false)
	end
	
-- guiconfbutton = guiCreateButton(150, 245, 41, 21, "Conf.", false, guigfxconfig)
--	if on_pushButton_clicked then
--		addEventHandler("onClientGUIClick", guiconfbutton, on_pushButton_clicked, false)
--	end
--	guiSetEnabled(guiconfbutton, false)
	
	guicontrastcontrast = guiCreateCheckBox(20, 255, 81, 17, "Contrast", false, false, guigfxconfig)
	
	guicontrastbloom = guiCreateCheckBox(20, 235, 70, 17, "Bloom", false, false, guigfxconfig)
	guigrayscalebutton = guiCreateCheckBox(100, 235, 104, 17, "Monochromatic", false, false, guigfxconfig)
	guiinvertcolorsbutton = guiCreateCheckBox(100, 255, 99, 17, "Mixedup colors", false, false, guigfxconfig)
	guiSetEnabled(guicontrastcontrast, false)
    guiSetEnabled(guicontrastbloom, false)
	guiSetEnabled(guigrayscalebutton, false)
	guiSetEnabled(guiinvertcolorsbutton, false)

function fpscheck()
if checkframes==0 then return end
  local frameticks=getTickCount()
  frames=frames+1
  if frameticks-1000>lastsec then
    local prog=(frameticks-lastsec)
    lastsec=frameticks
    fps=frames/(prog/1000)
    frames=fps*((prog-1000)/1000)
if fps>39 then guiSetText (gui["howfastlabel"],"Fast") end
if fps>29 and fps<39 then guiSetText (gui["howfastlabel"],"Medium") end
if fps>19 and fps<29 then guiSetText (gui["howfastlabel"],"Slow") end
if fps>9 and fps<19 then guiSetText (gui["howfastlabel"],"Very Slow") end
if fps<9 then guiSetText (gui["howfastlabel"],"Unplayable") end
guiSetText ( gui["fpslabel"],fps)
  end
end




function showgfxgui()
showguiconfig=not showguiconfig
if showguiconfig then
checkframes=1
showCursor (true)
guiSetVisible(guigfxconfig, true)
else
checkframes=0
showCursor (false)
guiSetVisible(guigfxconfig, false)
guiSetVisible(guikolornitro, false)
guiSetVisible(guikolorshader, false)
end
end





function on_applybuttongfx_clicked()

	outputChatBox("GFX settings updated")
     if ( guiCheckBoxGetSelected(guicarpaintboxgfx) ) then
         start_carpaint_shadder(1) 
		--	outputChatBox("carpaint on")
        else
          start_carpaint_shadder(0)
		--	outputChatBox("carpaint off")
        end

     if ( guiCheckBoxGetSelected(guiwaterbox) ) then
		--    outputChatBox("water on")
        shader_water_enabled(1)
        else
		--    outputChatBox("water off")
		shader_water_enabled(0)
        
        end	
     if not ( guiCheckBoxGetSelected(guinitrobox) ) then
			resetNitroColor() 
		--	outputChatBox("Nitro reset")
        
        end		

   if ( guiCheckBoxGetSelected(guibloomboxgfx) ) then
		  --  outputChatBox("bloom on")
		  	  
		  
			if  ( guiCheckBoxGetSelected(guicontrastcontrast) ) then shader_contrast_contrast='true'
			else shader_contrast_contrast='false' end
			if  ( guiCheckBoxGetSelected(guicontrastbloom) ) then shader_contrast_bloom='true'
			else shader_contrast_bloom='false' end
			if  ( guiCheckBoxGetSelected(guigrayscalebutton) ) then shader_contrast_gray='true'
			else shader_contrast_gray='false' end	
			if  ( guiCheckBoxGetSelected(guiinvertcolorsbutton) ) then shader_contrast_invcol='true'
			else shader_contrast_invcol='false' end	
          enableContrast()
        else
		
		  --  outputChatBox("bloom off")
		  chosen_red_shader=255
          chosen_green_shader=255
          chosen_blue_shader=255
		  guiScrollBarSetScrollPosition(guired_shader_scroll_bar,100)
          guiScrollBarSetScrollPosition(guigreen_shader_scroll_bar,100)
          guiScrollBarSetScrollPosition(guiblue_shader_scroll_bar,100)
			shader_contrast_contrast='false'
			shader_contrast_bloom='false'
			shader_contrast_gray='false'
		  disableContrast()
		  
		  
        end				
    

          if ( guiCheckBoxGetSelected(guiroadshinebox) ) then
		 --   outputChatBox("roadshine on")
			if (guiRadioButtonGetSelected(guiroad1radio)) then 
		--	outputChatBox("roadshine 1 on")
			disableRoadshine3() 
		roadshine_shader_on(1)
			end
			if (guiRadioButtonGetSelected(guiroad3radio)) then 
		--	outputChatBox("roadshine 3 on")
	        roadshine_shader_on(0)
			enableRoadshine3() 
			end
		 
           
       else
		 --   outputChatBox("roadshine off")
		roadshine_shader_on(0)
			disableRoadshine3() 
        
       end						


	--TODO: Implement your button click handler here
end

function on_guiroadshinebox_clicked()
if ( guiCheckBoxGetSelected(guiroadshinebox) ) then
guiSetEnabled(guiroad1radio, true)
guiSetEnabled(guiroad3radio, true)
else
guiSetEnabled(guiroad1radio, false)
guiSetEnabled(guiroad3radio, false)
end
end

function on_guibloomboxgfx_clicked()
if ( guiCheckBoxGetSelected(guibloomboxgfx) ) then

guiSetEnabled(guishadercolorbutton, true)
guiSetEnabled(guicontrastcontrast, true)
guiSetEnabled(guicontrastbloom, true)
guiSetEnabled(guigrayscalebutton, true)
guiSetEnabled(guiinvertcolorsbutton, true)
else
  
guiSetEnabled(guishadercolorbutton, false)		  
guiSetEnabled(guicontrastcontrast, false)
guiSetEnabled(guicontrastbloom, false)
guiSetEnabled(guigrayscalebutton, false)
guiSetEnabled(guiinvertcolorsbutton, false)
end
end

function on_closebuttongfx_clicked(button, state, absoluteX, absoluteY)
	if (button ~= "left") or (state ~= "up") then
		return
	end
	  guiSetVisible(guikolornitro, false)
	  showgfxgui()
	--TODO: Implement your button click handler here
	
end

function on_guinitrocolorbutton_clicked()
    guiBringToFront (guikolornitro)
	guiSetVisible(guikolornitro, true)
end

function on_guinitrobox_clicked()
if ( guiCheckBoxGetSelected(guinitrobox) ) then
guiSetEnabled(guinitrocolorbutton, true)
else
guiSetEnabled(guinitrocolorbutton, false)
end
end


function on_guishadercolorbutton_clicked()

guiSetVisible(guikolorshader, true)
guiBringToFront (guikolorshader)

end

addEventHandler ( "onClientGUIClick", guishadercolorbutton, on_guishadercolorbutton_clicked,false)
addEventHandler ( "onClientGUIClick", guinitrobox, on_guinitrobox_clicked,false)
addEventHandler ( "onClientGUIClick", guinitrocolorbutton, on_guinitrocolorbutton_clicked,false)
addEventHandler ( "onClientGUIClick", guibloomboxgfx, on_guibloomboxgfx_clicked,false)
addEventHandler ( "onClientGUIClick", guiroadshinebox, on_guiroadshinebox_clicked,false)
addEventHandler ( "onClientGUIClick", applybuttongfx, on_applybuttongfx_clicked,false)
addEventHandler ( "onClientGUIClick", closebuttongfx, on_closebuttongfx_clicked,false)
addCommandHandler('shaderpanel',showgfxgui)


addEventHandler ( "onClientRender", root, fpscheck)
bindKey("F2","down",showgfxgui)



