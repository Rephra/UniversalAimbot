-- Universal Aimbot Loader
-- Created by Rephra

-- Configuration
local config = {
    username = "Rephra",
    version = "1.0.0",
    repository = "https://raw.githubusercontent.com/Rephra/UniversalAimbot/main/"
}

-- Print loader information
print("Universal Aimbot Loader")
print("Created by " .. config.username)
print("Version: " .. config.version)
print("Loading script...")

-- Function to load the script
local function loadScript()
    -- Create a loading message
    local loadingText = Instance.new("Message", workspace)
    loadingText.Text = "Loading Universal Aimbot..."
    
    -- Attempt to load the script
    local success, result = pcall(function()
        return game:HttpGet(config.repository .. "AimbotWithObsidian.lua")
    end)
    
    -- Remove loading message
    loadingText:Destroy()
    
    -- Check if the script was loaded successfully
    if success then
        print("Script loaded successfully!")
        -- Execute the script
        loadstring(result)()
    else
        -- Display error message
        warn("Failed to load script: " .. tostring(result))
        local errorText = Instance.new("Message", workspace)
        errorText.Text = "Failed to load Universal Aimbot. Error: " .. tostring(result)
        wait(5)
        errorText:Destroy()
    end
end

-- Execute the loader
loadScript()

-- Instructions for repository setup (for reference)
--[[
Repository Structure:
- UniversalAimbot (main repository)
  - AimbotWithObsidian.lua (main script)
  - aimbotmodule (module file)
  - README.md (documentation)

To use this loader:
1. Create a GitHub repository named "UniversalAimbot"
2. Upload the script files to the repository
3. Make sure the files are in the main branch
4. Execute this loader script in your game
]]
