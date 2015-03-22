--
-- c_roadshine.lua
--
local shader15, tec = dxCreateShader ( "shaders/roadshine.fx" )
addEventHandler( "onClientResourceStart", resourceRoot,
	function()




		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader
		local shader15, tec = dxCreateShader ( "shaders/roadshine.fx" )

		if not shader15 then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
		--	outputChatBox( "Using technique " .. tec )

			-- Apply shader to all world textures
			
		end
	end

)

function roadshine_shader_on(spoon_in_ear)
if spoon_in_ear==1 then engineApplyShaderToWorldTexture ( shader15, "*" ) 
else
engineRemoveShaderFromWorldTexture ( shader15, "*" )
end
end