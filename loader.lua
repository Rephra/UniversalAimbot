-- Universal Aimbot Loader
-- Simple and reliable loader with GUI

print("🎯 Universal Aimbot Loader Starting...")

-- Configuration
local CONFIG = {
    REPO_URL = "https://raw.githubusercontent.com/Rephra/UniversalAimbot/main/AimbotWithObsidian.lua",
    VERSION = "1.0.0",
    AUTHOR = "Nullinject"
}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Create GUI Function
local function createLoaderGUI()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotLoader"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Add stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 80)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "🎯 Universal Aimbot"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Version
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Size = UDim2.new(1, 0, 0, 20)
    version.Position = UDim2.new(0, 0, 0, 70)
    version.BackgroundTransparency = 1
    version.Text = "v" .. CONFIG.VERSION .. " by " .. CONFIG.AUTHOR
    version.TextColor3 = Color3.fromRGB(150, 150, 170)
    version.TextSize = 14
    version.Font = Enum.Font.Gotham
    version.Parent = mainFrame
    
    -- Progress Bar Background
    local progressBG = Instance.new("Frame")
    progressBG.Name = "ProgressBG"
    progressBG.Size = UDim2.new(0.8, 0, 0, 8)
    progressBG.Position = UDim2.new(0.1, 0, 0, 130)
    progressBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    progressBG.BorderSizePixel = 0
    progressBG.Parent = mainFrame
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressBG
    
    -- Progress Bar Fill
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.Position = UDim2.new(0, 0, 0, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = progressBG
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = progressBar
    
    -- Status Text
    local statusText = Instance.new("TextLabel")
    statusText.Name = "StatusText"
    statusText.Size = UDim2.new(1, 0, 0, 30)
    statusText.Position = UDim2.new(0, 0, 0, 160)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Initializing..."
    statusText.TextColor3 = Color3.fromRGB(200, 200, 220)
    statusText.TextSize = 16
    statusText.Font = Enum.Font.Gotham
    statusText.Parent = mainFrame
    
    -- Percentage Text
    local percentText = Instance.new("TextLabel")
    percentText.Name = "PercentText"
    percentText.Size = UDim2.new(1, 0, 0, 25)
    percentText.Position = UDim2.new(0, 0, 0, 190)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(0, 200, 100)
    percentText.TextSize = 18
    percentText.Font = Enum.Font.GothamBold
    percentText.Parent = mainFrame
    
    return screenGui, statusText, percentText, progressBar
end

-- Update Progress Function
local function updateProgress(statusText, percentText, progressBar, progress, status)
    if statusText then statusText.Text = status end
    if percentText then percentText.Text = progress .. "%" end
    
    if progressBar then
        local tween = TweenService:Create(
            progressBar,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(progress / 100, 0, 1, 0)}
        )
        tween:Play()
    end
end

-- Main Loader Function
local function startLoader()
    print("Creating loader GUI...")
    
    -- Create GUI
    local gui, statusText, percentText, progressBar = createLoaderGUI()
    
    -- Step 1: Initialize
    updateProgress(statusText, percentText, progressBar, 10, "🔄 Connecting to repository...")
    wait(0.5)
    
    -- Step 2: Download script
    updateProgress(statusText, percentText, progressBar, 30, "📥 Downloading aimbot script...")
    
    local downloadSuccess, scriptContent = pcall(function()
        return game:HttpGet(CONFIG.REPO_URL)
    end)
    
    if not downloadSuccess then
        updateProgress(statusText, percentText, progressBar, 0, "❌ Download failed!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error downloading script:", scriptContent)
        wait(3)
        gui:Destroy()
        return
    end
    
    updateProgress(statusText, percentText, progressBar, 60, "✅ Script downloaded successfully!")
    print("✅ Downloaded script (" .. #scriptContent .. " characters)")
    wait(0.5)
    
    -- Step 3: Compile script
    updateProgress(statusText, percentText, progressBar, 80, "⚙️ Compiling script...")
    
    local compileSuccess, compiledScript = pcall(function()
        return loadstring(scriptContent)
    end)
    
    if not compileSuccess or not compiledScript then
        updateProgress(statusText, percentText, progressBar, 0, "❌ Compilation failed!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error compiling script:", compiledScript)
        wait(3)
        gui:Destroy()
        return
    end
    
    updateProgress(statusText, percentText, progressBar, 90, "🔧 Script compiled successfully!")
    wait(0.5)
    
    -- Step 4: Execute
    updateProgress(statusText, percentText, progressBar, 100, "🚀 Launching Universal Aimbot...")
    statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
    wait(1)
    
    -- Execute the script
    local executeSuccess, executeError = pcall(compiledScript)
    
    if executeSuccess then
        updateProgress(statusText, percentText, progressBar, 100, "✅ Universal Aimbot loaded!")
        print("🎯 Universal Aimbot loaded successfully!")
        wait(2)
    else
        updateProgress(statusText, percentText, progressBar, 0, "❌ Execution failed!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error executing script:", executeError)
        wait(3)
    end
    
    -- Clean up GUI
    gui:Destroy()
end

-- Start the loader
startLoader()
