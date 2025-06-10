-- Universal Aimbot Loader
-- Created by Nullinject

print("=== UNIVERSAL AIMBOT LOADER STARTING ===")

-- Debug information
print("Game service availability check:")
print("- Players service:", game.Players ~= nil)
print("- LocalPlayer:", game.Players.LocalPlayer ~= nil)
if game.Players.LocalPlayer then
    print("- PlayerGui:", game.Players.LocalPlayer:FindFirstChild("PlayerGui") ~= nil)
end
print("- TweenService:", game:GetService("TweenService") ~= nil)

-- Configuration
local config = {
    username = "Nullinject",
    version = "1.0.0",
    repository = "https://raw.githubusercontent.com/Rephra/UniversalAimbot/main/"
}

-- Print loader information
print("Universal Aimbot Loader")
print("Created by " .. config.username)
print("Version: " .. config.version)
print("Loading script...")

-- Immediate GUI test
print("=== PERFORMING IMMEDIATE GUI TEST ===")
local testSuccess, testError = pcall(function()
    local testGui = Instance.new("ScreenGui")
    testGui.Name = "TestGUI"
    testGui.Parent = game.Players.LocalPlayer.PlayerGui
    
    local testFrame = Instance.new("Frame")
    testFrame.Size = UDim2.new(0, 200, 0, 50)
    testFrame.Position = UDim2.new(0, 10, 0, 10)
    testFrame.BackgroundColor3 = Color3.new(1, 0, 0)
    testFrame.Parent = testGui
    
    local testLabel = Instance.new("TextLabel")
    testLabel.Size = UDim2.new(1, 0, 1, 0)
    testLabel.BackgroundTransparency = 1
    testLabel.Text = "GUI TEST WORKING"
    testLabel.TextColor3 = Color3.new(1, 1, 1)
    testLabel.TextScaled = true
    testLabel.Parent = testFrame
    
    wait(1)
    testGui:Destroy()
    print("GUI test successful!")
end)

if not testSuccess then
    print("GUI test failed: " .. tostring(testError))
end

-- Add error protection wrapper
local function safeExecute(func, errorMsg)
    local success, result = pcall(func)
    if not success then
        print("ERROR: " .. errorMsg)
        print("Details: " .. tostring(result))
        return false
    end    return true
end

-- Simple fallback GUI
local function createSimpleGUI()
    print("=== CREATING SIMPLE FALLBACK GUI ===")
    
    local success, result = pcall(function()
        -- Wait a bit to ensure player is ready
        wait(0.5)
        
        local player = game.Players.LocalPlayer
        if not player or not player.PlayerGui then
            error("Player or PlayerGui not available")
        end
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "SimpleAimbotLoader"
        screenGui.Parent = player.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 100)
        frame.Position = UDim2.new(0.5, -150, 0.5, -50)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.BackgroundTransparency = 0.3
        frame.Parent = screenGui
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Loading Universal Aimbot..."
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextScaled = true
        textLabel.Parent = frame
        
        return screenGui, textLabel, textLabel, nil
    end)
    
    if success then
        print("=== SIMPLE GUI CREATED SUCCESSFULLY ===")
        return result
    else
        print("ERROR creating simple GUI: " .. tostring(result))
        return nil, nil, nil, nil
    end
end

-- Create loading GUI
local function createLoadingGUI()
    print("=== CREATING LOADING GUI ===")
    
    -- Add more robust error checking
    if not game.Players.LocalPlayer then
        print("ERROR: LocalPlayer not found!")
        return nil, nil, nil, nil
    end
    
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then
        print("ERROR: PlayerGui not found!")
        return nil, nil, nil, nil
    end
    
    local success, result = pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "UniversalAimbotLoader"
        screenGui.Parent = playerGui
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        print("ScreenGui created successfully")
        
        -- Main frame
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 400, 0, 200)
        mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
        mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui
        print("Main frame created successfully")
        
        -- Corner rounding
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = mainFrame
        
        -- Drop shadow effect
        local shadow = Instance.new("ImageLabel")
        shadow.Name = "Shadow"
        shadow.BackgroundTransparency = 1
        shadow.Position = UDim2.new(0, -10, 0, -10)
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.ZIndex = -1
        shadow.Image = "rbxasset://textures/ui/ChatBubble/TailMask.png"
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ImageTransparency = 0.8
        shadow.Parent = mainFrame
        
        -- Title
        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Position = UDim2.new(0, 0, 0, 10)
        title.BackgroundTransparency = 1
        title.Text = "Universal Aimbot"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.Parent = mainFrame
        
        -- Subtitle
        local subtitle = Instance.new("TextLabel")
        subtitle.Name = "Subtitle"
        subtitle.Size = UDim2.new(1, 0, 0, 20)
        subtitle.Position = UDim2.new(0, 0, 0, 50)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "Created by " .. config.username .. " | v" .. config.version
        subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        subtitle.TextScaled = true
        subtitle.Font = Enum.Font.Gotham
        subtitle.Parent = mainFrame
        
        -- Loading bar background
        local loadingBarBG = Instance.new("Frame")
        loadingBarBG.Name = "LoadingBarBG"
        loadingBarBG.Size = UDim2.new(0.8, 0, 0, 6)
        loadingBarBG.Position = UDim2.new(0.1, 0, 0, 110)
        loadingBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        loadingBarBG.BorderSizePixel = 0
        loadingBarBG.Parent = mainFrame
        
        local loadingBarCorner = Instance.new("UICorner")
        loadingBarCorner.CornerRadius = UDim.new(0, 3)
        loadingBarCorner.Parent = loadingBarBG
        
        -- Loading bar fill
        local loadingBar = Instance.new("Frame")
        loadingBar.Name = "LoadingBar"
        loadingBar.Size = UDim2.new(0, 0, 1, 0)
        loadingBar.Position = UDim2.new(0, 0, 0, 0)
        loadingBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        loadingBar.BorderSizePixel = 0
        loadingBar.Parent = loadingBarBG
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 3)
        fillCorner.Parent = loadingBar
        
        -- Status text
        local statusText = Instance.new("TextLabel")
        statusText.Name = "StatusText"
        statusText.Size = UDim2.new(1, 0, 0, 25)
        statusText.Position = UDim2.new(0, 0, 0, 130)
        statusText.BackgroundTransparency = 1
        statusText.Text = "Initializing..."
        statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
        statusText.TextScaled = true
        statusText.Font = Enum.Font.Gotham
        statusText.Parent = mainFrame
        
        -- Progress percentage
        local progressText = Instance.new("TextLabel")
        progressText.Name = "ProgressText"
        progressText.Size = UDim2.new(1, 0, 0, 20)
        progressText.Position = UDim2.new(0, 0, 0, 160)
        progressText.BackgroundTransparency = 1
        progressText.Text = "0%"
        progressText.TextColor3 = Color3.fromRGB(0, 162, 255)
        progressText.TextScaled = true
        progressText.Font = Enum.Font.GothamBold
        progressText.Parent = mainFrame
          return screenGui, statusText, progressText, loadingBar
    end)
    
    if success then
        print("=== GUI CREATED SUCCESSFULLY ===")
        return result
    else
        print("ERROR creating GUI: " .. tostring(result))
        -- Try a simpler GUI as fallback
        return createSimpleGUI()
    end
end

-- Animate loading bar
local function animateProgress(loadingBar, progressText, targetProgress)
    if not loadingBar or not progressText then
        print("ERROR: Missing GUI elements for animation")
        return
    end
    
    print("Animating progress to: " .. tostring(targetProgress) .. "%")
    
    pcall(function()
        -- Immediately set the progress text
        progressText.Text = tostring(targetProgress) .. "%"
        
        local tween = game:GetService("TweenService"):Create(
            loadingBar,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(targetProgress / 100, 0, 1, 0)}
        )
        tween:Play()
        
        local progressTween = game:GetService("TweenService"):Create(
            progressText,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextTransparency = 0}
        )
        progressTween:Play()
    end)
end

-- Function to load the script
local function loadScript()
    print("=== STARTING SCRIPT LOADING ===")
    
    -- Create loading GUI
    local gui, statusText, progressText, loadingBar = createLoadingGUI()
    
    if not gui then
        print("CRITICAL ERROR: Could not create GUI!")
        print("This might be due to:")
        print("1. LocalPlayer not being available yet")
        print("2. PlayerGui not being ready")
        print("3. Insufficient permissions")
        print("Continuing without GUI...")
        
        -- Continue script execution without GUI
        print("Attempting to download script directly...")
        local success, result = pcall(function()
            return game:HttpGet(config.repository .. "AimbotWithObsidian.lua")
        end)
        
        if success then
            print("Script downloaded successfully! Executing...")
            local executeSuccess, executeResult = pcall(function()
                local compiledScript = loadstring(result)
                if compiledScript then
                    compiledScript()
                    return true
                else
                    error("Failed to compile downloaded script")
                end
            end)
            
            if executeSuccess then
                print("Universal Aimbot loaded successfully!")
            else
                print("ERROR executing script: " .. tostring(executeResult))
            end
        else
            print("ERROR downloading script: " .. tostring(result))
        end
        return
    end
    
    -- Simulate loading steps
    statusText.Text = "Connecting to repository..."
    animateProgress(loadingBar, progressText, 25)
    wait(1)
    
    statusText.Text = "Downloading script..."
    animateProgress(loadingBar, progressText, 50)
    
    -- Attempt to load the script
    print("Attempting to download from: " .. config.repository .. "AimbotWithObsidian.lua")
    local success, result = pcall(function()
        return game:HttpGet(config.repository .. "AimbotWithObsidian.lua")
    end)
    
    animateProgress(loadingBar, progressText, 75)
    wait(0.5)
      -- Check if the script was loaded successfully
    if success then
        print("Script downloaded successfully!")
        print("Script length: " .. tostring(string.len(result)))
        print("First 100 characters: " .. tostring(string.sub(result, 1, 100)))
        
        statusText.Text = "Script loaded successfully!"
        animateProgress(loadingBar, progressText, 100)
        wait(1)
        
        statusText.Text = "Executing aimbot..."
        wait(1)
        
        -- Execute the script with better error handling
        local executeSuccess, executeResult = pcall(function()
            local compiledScript = loadstring(result)
            if compiledScript then
                compiledScript()
                return true
            else
                error("Failed to compile downloaded script")
            end
        end)
        
        if executeSuccess then
            -- Success message
            statusText.Text = "Universal Aimbot loaded!"
            statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
            wait(2)
            
            -- Remove GUI
            gui:Destroy()
            print("Script loaded successfully!")
        else
            print("ERROR executing script: " .. tostring(executeResult))
            statusText.Text = "Execution failed!"
            statusText.TextColor3 = Color3.fromRGB(255, 0, 0)
            
            -- Show error details in GUI
            wait(2)
            statusText.Text = "Exec Error: " .. tostring(executeResult)
            statusText.Font = Enum.Font.Gotham
            
            wait(8)
            gui:Destroy()
        end
    else
        print("ERROR downloading script: " .. tostring(result))
        -- Display error in GUI
        statusText.Text = "Failed to load script!"
        statusText.TextColor3 = Color3.fromRGB(255, 0, 0)
        progressText.Text = "Error"
        progressText.TextColor3 = Color3.fromRGB(255, 0, 0)
        loadingBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        -- Show error details
        wait(2)
        statusText.Text = "Error: " .. tostring(result)
        statusText.Font = Enum.Font.Gotham
        
        warn("Failed to load script: " .. tostring(result))
        wait(5)
        gui:Destroy()
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
