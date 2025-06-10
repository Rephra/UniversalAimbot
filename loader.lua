-- Test Universal Aimbot Loader
-- Created by Nullinject

print("=== LOADER STARTING ===")

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

-- Simple test to ensure we can create GUI
local function testGUI()
    print("=== TESTING GUI CREATION ===")
    
    -- Check if we're in a game
    if not game then
        print("ERROR: Not in Roblox game environment!")
        return false
    end
    
    -- Check if Players service exists
    if not game:GetService("Players") then
        print("ERROR: Players service not found!")
        return false
    end
    
    -- Check if LocalPlayer exists
    local player = game:GetService("Players").LocalPlayer
    if not player then
        print("ERROR: LocalPlayer not found!")
        return false
    end
    
    print("Player found: " .. (player.Name or "Unknown"))
    
    -- Check if PlayerGui exists
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        print("ERROR: PlayerGui not found!")
        return false
    end
    
    print("PlayerGui found successfully!")
    return true
end

-- Create loading GUI
local function createLoadingGUI()
    print("=== CREATING LOADING GUI ===")
    
    if not testGUI() then
        print("GUI test failed - aborting")
        return nil, nil, nil, nil
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UniversalAimbotLoader"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    print("ScreenGui created and parented")
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    print("Main frame created")
    
    -- Corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Universal Aimbot - TEST"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    print("Title created")
    
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
    print("Subtitle created")
    
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
    statusText.Text = "GUI Test Successful!"
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
    progressText.Text = "100%"
    progressText.TextColor3 = Color3.fromRGB(0, 162, 255)
    progressText.TextScaled = true
    progressText.Font = Enum.Font.GothamBold
    progressText.Parent = mainFrame
    
    print("=== GUI CREATED SUCCESSFULLY ===")
    return screenGui, statusText, progressText, loadingBar
end

-- Test the GUI creation
local gui, statusText, progressText, loadingBar = createLoadingGUI()

if gui then
    print("SUCCESS: GUI should be visible now!")
    print("Waiting 10 seconds before cleanup...")
    
    -- Keep it visible for 10 seconds
    wait(10)
    
    print("Cleaning up test GUI...")
    gui:Destroy()
    print("Test completed!")
else
    print("FAILED: Could not create GUI")
end
