function shader_panel_configuration()
--- Shader Config. configuration file
--- Enable menu settings 'true'/'false'

guiSetEnabled(guicarpaintboxgfx,true) --- Shader Car Paint
guiSetEnabled(guinitrobox,true) --- Shader Nitro
---   guiSetEnabled(guinitrocolorbutton,false) ---Nitro Colors
guiSetEnabled(guiwaterbox,true) --- Shader Water
guiSetEnabled(guiroadshinebox,true) ---Shader roadshine
   guiSetEnabled(guiroad1radio, false) ---Shader roadshine 1
   guiSetEnabled(guiroad3radio, false) ---Shader roadshine 3
guiSetEnabled(guibloomboxgfx,true) --- Shader HDR Contrast/Bloom
 ---  guiSetEnabled(guishadercolorbutton,false) --- Screen Colors
 ---  guiSetEnabled(guicontrastcontrast, false) --- Contrast
 ---  guiSetEnabled(guicontrastbloom, false) --- Bloom
 ---  guiSetEnabled(guigrayscalebutton, false) --- Monochromatic colors
 ---  guiSetEnabled(guiinvertcolorsbutton, false) --- Weird colors

--- Chosen menu settings

guiCheckBoxSetSelected(guicarpaintboxgfx,true) --- Shader Car Paint
guiCheckBoxSetSelected(guinitrobox,false)  ---Nitro Colors
guiCheckBoxSetSelected(guiwaterbox,true) --- Shader Water
guiCheckBoxSetSelected(guiroadshinebox,false)  ---Shader roadshine

guiRadioButtonSetSelected(guiroad1radio, false) ---Shader roadshine 1
guiRadioButtonSetSelected(guiroad3radio, false) ---Shader roadshine 3

guiCheckBoxSetSelected(guibloomboxgfx,false) --- Shader HDR Contrast/Bloom
   guiCheckBoxSetSelected(guicontrastcontrast, false) --- Contrast
   guiCheckBoxSetSelected(guicontrastbloom, false) --- Bloom
   guiCheckBoxSetSelected(guigrayscalebutton, false) --- Monochromatic colors
   guiCheckBoxSetSelected(guiinvertcolorsbutton, false) --- Weird colors

--- Apply settings 
  on_applybuttongfx_clicked()
end

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), shader_panel_configuration)
 


