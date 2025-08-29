-- Noob_x Hub for Anime Fighters Simulator

-- واجهة GUI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Noob_x Hub", "BloodTheme")

-- 🥷 AutoFarm Tab
local autoFarm = window:NewTab("AutoFarm")
local autoFarmSection = autoFarm:NewSection("Farm Options")

autoFarmSection:NewToggle("Auto Click Damage", "يفعل الضرب التلقائي", function(state)
    _G.AutoClickDamage = state
    spawn(function()
        while _G.AutoClickDamage do
            game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
            wait()
        end
    end)
end)

-- 🥚 Egg Tab
local eggTab = window:NewTab("Egg")
local eggSection = eggTab:NewSection("فتح البيض")

eggSection:NewToggle("Auto Open Eggs", "يفتح البيض تلقائيًا", function(state)
    _G.AutoOpenEggs = state
    spawn(function()
        while _G.AutoOpenEggs do
            game:GetService("ReplicatedStorage").Remote.OpenEgg:InvokeServer("Basic")
            wait(1)
        end
    end)
end)

-- 🚀 Teleport Tab
local tpTab = window:NewTab("Teleport")
local tpSection = tpTab:NewSection("النقل السريع")

tpSection:NewButton("Teleport to Spawn", "ينقلك إلى البداية", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end)

-- 🌐 Settings Tab
local settingsTab = window:NewTab("Settings")
local settingsSection = settingsTab:NewSection("الإعدادات")

settingsSection:NewDropdown("Language", "اختر اللغة", {"العربية", "English"}, function(lang)
    print("Language selected:", lang)
end)
