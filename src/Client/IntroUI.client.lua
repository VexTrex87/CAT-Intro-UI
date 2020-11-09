-- wait until game is loaded

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // Variables \ --

local FADE_TWEEN_INFO = TweenInfo.new(0.5)

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
end

local function onFrameUnhovered(frame)
    local transImage = background:FindFirstChild(frame.Name .. "-Trans")
    local fullImage = background:FindFirstChild(frame.Name .. "-Full")
    NewTween(transImage, FADE_TWEEN_INFO, {ImageTransparency = 0})
    NewTween(fullImage, FADE_TWEEN_INFO, {ImageTransparency = 1})
end

-- // COMPILE \\ --

background.Visible = true

for _,frame in pairs(background:GetChildren()) do
    if frame:IsA("Frame") then
        frame.MouseEnter:Connect(function()
            onFrameHovered(frame)
        end)
        frame.MouseLeave:Connect(function()
            onFrameUnhovered(frame)
        end)
    end
end