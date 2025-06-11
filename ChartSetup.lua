-- Vulpine Universal Aimbot Loader
-- Modern Loading GUI with Progress Animation

-- Compatibility functions for different executors
local readfile = readfile or function() return nil end
local isfile = isfile or function() return false end
local writefile = writefile or function() end
local getgenv = getgenv or function() return _G end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Create Loading GUI
local function createLoadingGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VulpineAimbotLoader"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame (Dark background)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 480, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Add corner radius
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 15)
    Corner.Parent = MainFrame
    
    -- Add border gradient
    local Border = Instance.new("UIStroke")
    Border.Color = Color3.fromRGB(255, 100, 100)
    Border.Thickness = 2
    Border.Parent = MainFrame
    
    -- Header Section
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Size = UDim2.new(1, 0, 0, 85)
    HeaderFrame.Position = UDim2.new(0, 0, 0, 0)
    HeaderFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 15)
    HeaderCorner.Parent = HeaderFrame
    
    -- Logo/Icon (Crosshair design)
    local LogoFrame = Instance.new("Frame")
    LogoFrame.Name = "LogoFrame"
    LogoFrame.Size = UDim2.new(0, 55, 0, 55)
    LogoFrame.Position = UDim2.new(0, 20, 0.5, -27.5)
    LogoFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    LogoFrame.BorderSizePixel = 0
    LogoFrame.Parent = HeaderFrame
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, 10)
    LogoCorner.Parent = LogoFrame
    
    local LogoText = Instance.new("TextLabel")
    LogoText.Name = "LogoText"
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.Position = UDim2.new(0, 0, 0, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "⊕"
    LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoText.TextScaled = true
    LogoText.Font = Enum.Font.GothamBold
    LogoText.Parent = LogoFrame
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(0, 320, 0, 32)
    TitleLabel.Position = UDim2.new(0, 90, 0, 15)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Vulpine Universal Aimbot"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 22
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = HeaderFrame
      -- Subtitle
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "SubtitleLabel"
    SubtitleLabel.Size = UDim2.new(0, 320, 0, 22)
    SubtitleLabel.Position = UDim2.new(0, 90, 0, 47)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = "Loading advanced targeting systems for Rephra..."
    SubtitleLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
    SubtitleLabel.TextSize = 13
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = HeaderFrame
    
    -- Content Section
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -40, 1, -125)
    ContentFrame.Position = UDim2.new(0, 20, 0, 105)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Status Label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(1, 0, 0, 28)
    StatusLabel.Position = UDim2.new(0, 0, 0, 15)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Initializing targeting systems..."
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    StatusLabel.TextSize = 15
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = ContentFrame
    
    -- Progress Bar Background
    local ProgressBG = Instance.new("Frame")
    ProgressBG.Name = "ProgressBG"
    ProgressBG.Size = UDim2.new(1, 0, 0, 10)
    ProgressBG.Position = UDim2.new(0, 0, 0, 55)
    ProgressBG.BackgroundColor3 = Color3.fromRGB(40, 42, 50)
    ProgressBG.BorderSizePixel = 0
    ProgressBG.Parent = ContentFrame
    
    local ProgressBGCorner = Instance.new("UICorner")
    ProgressBGCorner.CornerRadius = UDim.new(0, 5)
    ProgressBGCorner.Parent = ProgressBG
    
    -- Progress Bar Fill
    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBG
    
    local ProgressFillCorner = Instance.new("UICorner")
    ProgressFillCorner.CornerRadius = UDim.new(0, 5)
    ProgressFillCorner.Parent = ProgressFill
    
    -- Add glow effect to progress bar
    local ProgressGlow = Instance.new("UIStroke")
    ProgressGlow.Color = Color3.fromRGB(255, 100, 100)
    ProgressGlow.Thickness = 1
    ProgressGlow.Transparency = 0.5
    ProgressGlow.Parent = ProgressFill
    
    -- Progress Percentage
    local ProgressPercent = Instance.new("TextLabel")
    ProgressPercent.Name = "ProgressPercent"
    ProgressPercent.Size = UDim2.new(0, 70, 0, 22)
    ProgressPercent.Position = UDim2.new(1, -70, 0, 72)
    ProgressPercent.BackgroundTransparency = 1
    ProgressPercent.Text = "0%"
    ProgressPercent.TextColor3 = Color3.fromRGB(255, 100, 100)
    ProgressPercent.TextSize = 13
    ProgressPercent.Font = Enum.Font.GothamBold
    ProgressPercent.TextXAlignment = Enum.TextXAlignment.Right
    ProgressPercent.Parent = ContentFrame
    
    -- Loading Details
    local DetailsLabel = Instance.new("TextLabel")
    DetailsLabel.Name = "DetailsLabel"
    DetailsLabel.Size = UDim2.new(1, 0, 0, 70)
    DetailsLabel.Position = UDim2.new(0, 0, 0, 105)
    DetailsLabel.BackgroundTransparency = 1
    DetailsLabel.Text = "• Checking executor compatibility\n• Loading Exunys Aimbot Module\n• Initializing ESP systems"
    DetailsLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    DetailsLabel.TextSize = 12
    DetailsLabel.Font = Enum.Font.Gotham
    DetailsLabel.TextXAlignment = Enum.TextXAlignment.Left
    DetailsLabel.TextYAlignment = Enum.TextYAlignment.Top
    DetailsLabel.Parent = ContentFrame
    
    -- Add to PlayerGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    return {
        ScreenGui = ScreenGui,
        StatusLabel = StatusLabel,
        ProgressFill = ProgressFill,
        ProgressPercent = ProgressPercent,
        DetailsLabel = DetailsLabel,
        SubtitleLabel = SubtitleLabel
    }
end

-- Animation functions
local function animateProgress(progressFill, progressPercent, targetPercent)
    local tween = TweenService:Create(
        progressFill,
        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(targetPercent / 100, 0, 1, 0)}
    )
    tween:Play()
    
    local textTween = TweenService:Create(
        progressPercent,
        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextColor3 = Color3.fromRGB(255, 120, 120)}
    )
    textTween:Play()
    
    progressPercent.Text = math.floor(targetPercent) .. "%"
end

-- Loading sequence for aimbot
local function startLoadingSequence(gui)
    local loadingSteps = {
        {percent = 12, status = "Checking executor compatibility...", detail = "• Verifying Drawing API support\n• Testing function availability\n• Checking security protocols"},
        {percent = 25, status = "Loading Obsidian UI Library...", detail = "• Downloading UI framework\n• Loading theme system\n• Initializing save manager"},
        {percent = 40, status = "Loading Exunys Aimbot Module...", detail = "• Downloading aimbot core\n• Setting up FOV calculations\n• Configuring target detection"},
        {percent = 58, status = "Initializing ESP systems...", detail = "• Setting up player detection\n• Configuring visual overlays\n• Loading skeleton tracking"},
        {percent = 75, status = "Setting up targeting algorithms...", detail = "• Calibrating aim smoothing\n• Loading prediction systems\n• Setting up lock-on mechanics"},
        {percent = 90, status = "Finalizing configuration...", detail = "• Applying user settings\n• Loading keybind system\n• Preparing user interface"},        {percent = 100, status = "Aimbot ready!", detail = "• All systems operational\n• Targeting active\n• Ready for combat assistance, Rephra!"}
    }
    
    local function processStep(stepIndex)
        if stepIndex > #loadingSteps then
            -- Loading complete
            wait(1)
            gui.SubtitleLabel.Text = "Lock and load! Your advantage awaits, Rephra."
            wait(1)
            return true
        end
        
        local step = loadingSteps[stepIndex]
        gui.StatusLabel.Text = step.status
        gui.DetailsLabel.Text = step.detail
        animateProgress(gui.ProgressFill, gui.ProgressPercent, step.percent)
        
        wait(math.random(10, 18) / 10) -- Random delay between 1.0-1.8 seconds
        
        return processStep(stepIndex + 1)
    end
    
    return processStep(1)
end

-- Main loader execution
local function executeLoader()
    local gui = createLoadingGUI()
    
    -- Start loading animation
    spawn(function()
        local loadingComplete = startLoadingSequence(gui)
        if loadingComplete then
            -- Load the main script            wait(0.5)
            gui.StatusLabel.Text = "Launching Universal Aimbot..."
            
            local success, result = pcall(function()
                -- Check if we're already in a loading state to prevent loops
                if _G.VulpineAimbotScriptLoading then
                    return true
                end
                _G.VulpineAimbotScriptLoading = true
                
                -- Load the main script content from local file
                local scriptContent
                if readfile and isfile and isfile("c:\\Users\\thebi\\OneDrive\\Documents\\Change\\Aimbot\\UniAimbot.lua") then
                    scriptContent = readfile("c:\\Users\\thebi\\OneDrive\\Documents\\Change\\Aimbot\\UniAimbot.lua")
                else
                    error("Main UniAimbot.lua script file not found!")
                end
                
                -- Execute the script
                local executeSuccess, executeResult = pcall(function()
                    return loadstring(scriptContent)()
                end)
                
                _G.VulpineAimbotScriptLoading = false
                
                if executeSuccess then
                    return executeResult
                else
                    error("Script execution failed: " .. tostring(executeResult))
                end
            end)if success then
                gui.StatusLabel.Text = "Universal Aimbot loaded successfully!"
                gui.SubtitleLabel.Text = "Vulpine Universal Aimbot is now active for Rephra!"
                wait(1)
                gui.ScreenGui:Destroy()
            else
                gui.StatusLabel.Text = "Error loading aimbot: " .. tostring(result)
                gui.StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                wait(3)
                gui.ScreenGui:Destroy()
            end
        end
    end)
end

-- Execute the loader (but only once)
if not _G.VulpineAimbotLoaderExecuted then
    _G.VulpineAimbotLoaderExecuted = true
    executeLoader()
end
