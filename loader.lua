loadstring([[
-- Universal Aimbot Loader
-- Created by Nullinject

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

-- Create loading GUI
local function createLoadingGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UniversalAimbotLoader"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
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
end

-- Animate loading bar
local function animateProgress(loadingBar, progressText, targetProgress)
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
    
    -- Update progress text safely
    spawn(function()
        local currentProgress = 0
        local progressStr = progressText.Text:gsub("%%", "")
        if progressStr and progressStr ~= "" then
            currentProgress = tonumber(progressStr) or 0
        end
        
        for i = currentProgress, targetProgress do
            progressText.Text = tostring(i) .. "%"
            wait(0.01)
        end
    end)
end

-- Function to load the script
local function loadScript()
    -- Create loading GUI
    local gui, statusText, progressText, loadingBar = createLoadingGUI()
    
    -- Simulate loading steps
    statusText.Text = "Connecting to repository..."
    animateProgress(loadingBar, progressText, 25)
    wait(1)
    
    statusText.Text = "Downloading script..."
    animateProgress(loadingBar, progressText, 50)
    
    -- Attempt to load the script
    local success, result = pcall(function()
        return game:HttpGet(config.repository .. "AimbotWithObsidian.lua")
    end)
    
    animateProgress(loadingBar, progressText, 75)
    wait(0.5)
    
    -- Check if the script was loaded successfully
    if success then
        statusText.Text = "Script loaded successfully!"
        animateProgress(loadingBar, progressText, 100)
        wait(1)
        
        statusText.Text = "Executing aimbot..."
        wait(1)
        
        -- Execute the script
        loadstring(result)()
        
        -- Success message
        statusText.Text = "Universal Aimbot loaded!"
        statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(2)
        
        -- Remove GUI
        gui:Destroy()
        print("Script loaded successfully!")
    else
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
]])()
