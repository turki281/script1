
-- SSJ3 HUB (No Fly Version) by Ali
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SSJ3Hub"

-- Settings table
local settings = {
    speed = 16,
    jump = 50,
    invisible = false,
    language = "English"
}

-- Language texts
local texts = {
    English = {
        main = "Main",
        stats = "Stats",
        settings = "Settings",
        shortcuts = "Shortcuts",
        toggle_invis = "Toggle Invisibility",
        apply = "Apply",
        reset = "Reset",
        speed = "Speed",
        jump = "Jump Power",
        language = "Language",
        shortcuts_list = "F: Toggle Invisibility\nG: Toggle Visibility"
    },
    Arabic = {
        main = "الرئيسية",
        stats = "الخصائص",
        settings = "الإعدادات",
        shortcuts = "الاختصارات",
        toggle_invis = "تفعيل/إلغاء الاختفاء",
        apply = "تطبيق",
        reset = "إعادة ضبط",
        speed = "السرعة",
        jump = "قوة القفز",
        language = "اللغة",
        shortcuts_list = "F: تفعيل الاختفاء\nG: إلغاء الاختفاء"
    }
}

-- Create main button
local openButton = Instance.new("TextButton", gui)
openButton.Draggable = true
openButton.Size = UDim2.new(0, 50, 0, 50)
openButton.Position = UDim2.new(0, 20, 0, 20)
openButton.Text = "N"
openButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
openButton.TextColor3 = Color3.fromRGB(0, 0, 0)
openButton.Font = Enum.Font.GothamBlack
openButton.TextSize = 22
openButton.Visible = true

-- Main frame
local frame = Instance.new("Frame", gui)
frame.Draggable = true
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0, 80, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false

-- Tabs
local tabButtons = {}
local tabFrames = {}

local function createTab(name, order)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 70, 0, 30)
    btn.Position = UDim2.new(0, 10 + (order * 75), 0, 10)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    tabButtons[name] = btn

    local tab = Instance.new("Frame", frame)
    tab.Size = UDim2.new(1, -20, 1, -50)
    tab.Position = UDim2.new(0, 10, 0, 50)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tabFrames[name] = tab
end

createTab("Main", 0)
createTab("Stats", 1)
createTab("Settings", 2)
createTab("Shortcuts", 3)

-- Tab switching
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabFrames) do tab.Visible = false end
        tabFrames[name].Visible = true
    end)
end

-- Main Tab
local invisButton = Instance.new("TextButton", tabFrames.Main)
invisButton.Size = UDim2.new(0, 200, 0, 40)
invisButton.Position = UDim2.new(0, 50, 0, 20)
invisButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invisButton.TextColor3 = Color3.new(1, 1, 1)
invisButton.Font = Enum.Font.GothamBold
invisButton.TextSize = 16

local function setInvisible(state)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = state and 1 or 0
        elseif part:IsA("Decal") then
            part.Transparency = state and 1 or 0
        elseif part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
            part.Enabled = not state
        elseif part:IsA("Accessory") or part:IsA("Tool") then
            part:Destroy()
        end
    end
end

invisButton.MouseButton1Click:Connect(function()
    settings.invisible = not settings.invisible
    setInvisible(settings.invisible)
    invisButton.Text = settings.invisible and texts[settings.language].toggle_invis or texts[settings.language].toggle_invis
end)

-- Stats Tab
local speedBox = Instance.new("TextBox", tabFrames.Stats)
speedBox.Size = UDim2.new(0, 200, 0, 30)
speedBox.Position = UDim2.new(0, 50, 0, 20)
speedBox.Text = tostring(settings.speed)
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14

local jumpBox = Instance.new("TextBox", tabFrames.Stats)
jumpBox.Size = UDim2.new(0, 200, 0, 30)
jumpBox.Position = UDim2.new(0, 50, 0, 60)
jumpBox.Text = tostring(settings.jump)
jumpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpBox.TextColor3 = Color3.new(1, 1, 1)
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 14

local applyButton = Instance.new("TextButton", tabFrames.Stats)
applyButton.Size = UDim2.new(0, 200, 0, 30)
applyButton.Position = UDim2.new(0, 50, 0, 100)
applyButton.TextColor3 = Color3.new(1, 1, 1)
applyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
applyButton.Font = Enum.Font.GothamBold
applyButton.TextSize = 16

applyButton.MouseButton1Click:Connect(function()
    settings.speed = tonumber(speedBox.Text) or 16
    settings.jump = tonumber(jumpBox.Text) or 50
    humanoid.WalkSpeed = settings.speed
    humanoid.JumpPower = settings.jump
end)

-- Settings Tab
local langButton = Instance.new("TextButton", tabFrames.Settings)
langButton.Size = UDim2.new(0, 200, 0, 30)
langButton.Position = UDim2.new(0, 50, 0, 20)
langButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
langButton.TextColor3 = Color3.new(1, 1, 1)
langButton.Font = Enum.Font.GothamBold
langButton.TextSize = 14

langButton.MouseButton1Click:Connect(function()
    settings.language = settings.language == "English" and "Arabic" or "English"
    updateTexts()
end)

local resetButton = Instance.new("TextButton", tabFrames.Settings)
resetButton.Size = UDim2.new(0, 200, 0, 30)
resetButton.Position = UDim2.new(0, 50, 0, 60)
resetButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.Font = Enum.Font.GothamBold
resetButton.TextSize = 14

resetButton.MouseButton1Click:Connect(function()
    settings = { speed = 16, jump = 50, invisible = false, language = settings.language }
    humanoid.WalkSpeed = settings.speed
    humanoid.JumpPower = settings.jump
    setInvisible(false)
    updateTexts()
end)

-- Shortcuts Tab
local shortcutLabel = Instance.new("TextLabel", tabFrames.Shortcuts)
shortcutLabel.Size = UDim2.new(1, -20, 1, -20)
shortcutLabel.Position = UDim2.new(0, 10, 0, 10)
shortcutLabel.BackgroundTransparency = 1
shortcutLabel.TextColor3 = Color3.new(1, 1, 1)
shortcutLabel.Font = Enum.Font.Gotham
shortcutLabel.TextSize = 16
shortcutLabel.TextWrapped = true

-- Update texts
function updateTexts()
    local t = texts[settings.language]
    tabButtons.Main.Text = t.main
    tabButtons.Stats.Text = t.stats
    tabButtons.Settings.Text = t.settings
    tabButtons.Shortcuts.Text = t.shortcuts
    invisButton.Text = t.toggle_invis
    applyButton.Text = t.apply
    resetButton.Text = t.reset
    speedBox.PlaceholderText = t.speed
    jumpBox.PlaceholderText = t.jump
    langButton.Text = t.language
    shortcutLabel.Text = t.shortcuts_list
end

-- Load settings
humanoid.WalkSpeed = settings.speed
humanoid.JumpPower = settings.jump
setInvisible(settings.invisible)
updateTexts()

-- Toggle GUI
openButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Keyboard shortcuts
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        settings.invisible = true
        setInvisible(true)
    elseif input.KeyCode == Enum.KeyCode.G then
        settings.invisible = false
        setInvisible(false)
    end
end)


-- Teleport Feature

-- Teleport فوق الماب
local function teleportAboveMap()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + 100, hrp.Position.Z)
    end
end

-- زر Teleport
local teleportTab = Instance.new("Frame", gui)
teleportTab.Name = "TeleportTab"
teleportTab.Size = UDim2.new(0, 220, 0, 100)
teleportTab.Position = UDim2.new(0, 250, 0, 90)
teleportTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local teleportButton = Instance.new("TextButton", teleportTab)
teleportButton.Size = UDim2.new(1, -20, 0, 40)
teleportButton.Position = UDim2.new(0, 10, 0, 10)
teleportButton.Text = "Teleport فوق الماب"
teleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 16
teleportButton.MouseButton1Click:Connect(teleportAboveMap)


-- ESP Feature

-- ESP للاعبين الآخرين
local function enableESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            if not head:FindFirstChild("ESPTag") then
                local tag = Instance.new("BillboardGui", head)
                tag.Name = "ESPTag"
                tag.Size = UDim2.new(0, 100, 0, 40)
                tag.Adornee = head
                tag.AlwaysOnTop = true

                local nameLabel = Instance.new("TextLabel", tag)
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = plr.Name
                nameLabel.TextColor3 = Color3.new(1, 0, 0)
                nameLabel.TextScaled = true
                nameLabel.Font = Enum.Font.GothamBold
            end
        end
    end
end

-- زر ESP
local espTab = Instance.new("Frame", gui)
espTab.Name = "ESPTab"
espTab.Size = UDim2.new(0, 220, 0, 100)
espTab.Position = UDim2.new(0, 250, 0, 200)
espTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local espButton = Instance.new("TextButton", espTab)
espButton.Size = UDim2.new(1, -20, 0, 40)
espButton.Position = UDim2.new(0, 10, 0, 10)
espButton.Text = "تفعيل ESP"
espButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Font = Enum.Font.GothamBold
espButton.TextSize = 16
espButton.MouseButton1Click:Connect(enableESP)


local originalPosition = nil

-- زر Teleport فوق الماب
local teleportButton = Instance.new("TextButton", frame)
teleportButton.Size = UDim2.new(1, -20, 0, 30)
teleportButton.Position = UDim2.new(0, 10, 0, 250)
teleportButton.Text = "Teleport فوق الماب"
teleportButton.BackgroundColor3 = Color3.fromRGB(40, 40, 120)
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 14

teleportButton.MouseButton1Click:Connect(function()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        originalPosition = hrp.Position
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 100, 0)
    end
end)

-- زر العودة للماب
local returnButton = Instance.new("TextButton", frame)
returnButton.Size = UDim2.new(1, -20, 0, 30)
returnButton.Position = UDim2.new(0, 10, 0, 285)
returnButton.Text = "العودة للماب"
returnButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
returnButton.TextColor3 = Color3.new(1, 1, 1)
returnButton.Font = Enum.Font.GothamBold
returnButton.TextSize = 14

returnButton.MouseButton1Click:Connect(function()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp and originalPosition then
        hrp.CFrame = CFrame.new(originalPosition)
    end
end)


-- زر تفعيل ESP
local espEnabled = false
local espObjects = {}

local espButton = Instance.new("TextButton", frame)
espButton.Size = UDim2.new(1, -20, 0, 30)
espButton.Position = UDim2.new(0, 10, 0, 320)
espButton.Text = "تفعيل ESP"
espButton.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Font = Enum.Font.GothamBold
espButton.TextSize = 14

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "إلغاء ESP" or "تفعيل ESP"

    for _, gui in pairs(espObjects) do
        gui:Destroy()
    end
    espObjects = {}

    if espEnabled then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local tag = Instance.new("BillboardGui", head)
                tag.Size = UDim2.new(0, 100, 0, 20)
                tag.Adornee = head
                tag.AlwaysOnTop = true
                local nameLabel = Instance.new("TextLabel", tag)
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = plr.Name
                nameLabel.TextColor3 = Color3.new(1, 1, 0)
                nameLabel.TextScaled = true
                nameLabel.Font = Enum.Font.GothamBold
                table.insert(espObjects, tag)
            end
        end
    end
end)
