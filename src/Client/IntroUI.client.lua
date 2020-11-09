-- wait until game is loaded

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // Variables \ --

local FADE_TWEEN_INFO = TweenInfo.new(0.3)
local MOVE_TWEEN_INFO = TweenInfo.new(0.3)
local INTRO_FADE_TWEEN_INFO = TweenInfo.new(1)
local HOVERED_POS = UDim2.new(0, 0, 0, 0)
local UNHOVERED_POS = UDim2.new(-0.01, 0, 0, 0)

local Core = require(game.ReplicatedStorage.Modules.Core)
local NewTween = Core("newTween")

local p = game.Players.LocalPlayer
local UI = p.PlayerGui:WaitForChild("IntroUI")
local background = UI:WaitForChild("Background")

-- // FUNCTIONS \\ -- 

local function onFrameHovered(frame)
    local transImage = background:FindFirstChild(frame.Name .. "-Trans")
    local fullImage = background:FindFirstChild(frame.Name .. "-Full")
    NewTween(transImage, FADE_TWEEN_INFO, {ImageTransparency = 1})
    NewTween(fullImage, FADE_TWEEN_INFO, {ImageTransparency = 0})
    NewTween(fullImage, MOVE_TWEEN_INFO, {Position = HOVERED_POS})
end

local function onFrameUnhovered(frame)
    local transImage = background:FindFirstChild(frame.Name .. "-Trans")
    local fullImage = background:FindFirstChild(frame.Name .. "-Full")
    NewTween(transImage, FADE_TWEEN_INFO, {ImageTransparency = 0})
    NewTween(fullImage, FADE_TWEEN_INFO, {ImageTransparency = 1})
    NewTween(fullImage, MOVE_TWEEN_INFO, {Position = UNHOVERED_POS})
end

local function onFrameClicked(frame)
    background.Visible = false
    print("changing team to " .. frame.Name)
end

-- // COMPILE \\ --

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
background.Visible = true

for _,frame in pairs(background:GetChildren()) do
    if frame:IsA("ImageButton") then
        frame.MouseEnter:Connect(function()
            onFrameHovered(frame)
        end)
        frame.MouseLeave:Connect(function()
            onFrameUnhovered(frame)
        end)
        frame.MouseButton1Click:Connect(function()
            onFrameClicked(frame)
        end)
    end
end