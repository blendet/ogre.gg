-- VARIABLES
local mobs = {}
getgenv().mob = nil 
getgenv().lmb = nil
getgenv().e = nil
getgenv().r = nil
getgenv().t = nil
getgenv().v = nil
getgenv().b = nil
getgenv().y = nil
getgenv().z = nil


-- MOBS
for _,v in pairs(game:GetService("Workspace").NPCs.Hostile:GetChildren()) do 
    insert = true
    for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end
    if insert then table.insert(mobs, v.Name) end
end

-- UI LIBRARY
local Library = loadstring(game:HttpGet("https:/raw.githubusercontent.com/Attrixx/Scandia/main/KavoUiLib.lua"))()
local Window = Library.CreateLib("Roblox is Unbreakable | Ogre.gg", "Ocean") 

-- MAIN
local Main = Window:NewTab("Main")
local MobFarmSection = Main:NewSection("Mob Farm") 

local mobdropdown = MobFarmSection:NewDropdown("Choose Mob", "Chooses the mob to autofarm", mobs, function(v)
    getgenv().mob = v
end)

MobFarmSection:NewToggle("Start Mob Farm", "Toggles the autofarming of the mobs", function(v)
    getgenv().autofarmmobs = v
    while wait() do 
        if getgenv().autofarmmobs == false then return end 
        if getgenv().mob == nil then 
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error!",
                Text = "You havent selected a mob with the dropdown above\nUntoggle this toggle!", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "",
                Duration = 2.5
            })
            getgenv().autofarmmobs = false 
            return
        end
        local mob = game:GetService("Workspace").NPCs.Hostile:FindFirstChild(getgenv().mob)
        if mob == nil then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Info!",
                Text = "There is currently no spawned mobs of this type!\nJust wait until they spawn", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "",
                Duration = 2.5
            })
            while wait() do
                wait() 
                if getgenv().autofarmmobs == false then return end -- IF THE TOGGLE IS OFF THEN STOP THE LOOP
                if game:GetService("Workspace").NPCs.Hostile:FindFirstChild(getgenv().mob) ~= nil then break; end
            end -- IF THE MOB IS SPAWNED THEN GO ON WITH THE AUTOFARM
        else
            local mob2 = mob
            while wait() do
                mob = game:GetService("Workspace").NPCs.Hostile:FindFirstChild(getgenv().mob)
                if mob ~= mob2 then break; end
                if getgenv().autofarmmobs == false then return end -- IF THE TOGGLE IS OFF THEN STOP THE LOOP
                if mob ~= nil then
                    if mob:FindFirstChild("Humanoid") then
                        if mob.Humanoid.Health == 0 then wait(0.1) mob:Destroy() break; end -- IF THE MOB IS DEAD THEN JUST DESTROY IT FOR FASTER FARMING
                    end
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,5) -- TELEPORT TO THE MOB
                    end
                end
                wait() -- WAIT SO WE DONT CRASH
            end
        end
    end
end)

-- UPDATING THE MOBS
game:GetService("Workspace").NPCs.Hostile.ChildAdded:Connect(function() 
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end 
    for _,v in pairs(game:GetService("Workspace").NPCs.Hostile:GetChildren()) do 
        insert = true -- VALUE TO CHECK THE MOB
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(mobs, v.Name) end 
    end
    mobdropdown:Refresh(mobs)
end)

game:GetService("Workspace").NPCs.Hostile.ChildRemoved:Connect(function() 
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end 

    for _,v in pairs(game:GetService("Workspace").NPCs.Hostile:GetChildren()) do 
        insert = true -- VALUE TO CHECK THE MOB
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(mobs, v.Name) end
    end
    mobdropdown:Refresh(mobs)
end)

-- AUTO SKILLS
local AutoSkills = Window:NewTab("Auto Skills")
local AutoSkillsSection = AutoSkills:NewSection("Auto Skills")

AutoSkillsSection:NewToggle("LMB", "", function(state)
    getgenv().lmb = state
    while getgenv().lmb == true do
        local args = {
            [1] = "Light Punch Stand",
            [2] = true,
            [3] = false
        }
        
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("E", "", function(state)
    getgenv().e = state
    while getgenv().e == true do
        local args = {
            [1] = "Barrage",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait(v)
    end
end)

AutoSkillsSection:NewToggle("R", "", function(state)
    getgenv().r = state
    while getgenv().r == true do
        local args = {
            [1] = "Heavy Punch",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("T", "", function(state)
    getgenv().t = state
    while getgenv().t == true do
        local args = {
            [1] = "Throwing Knives",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("V", "", function(state)
    getgenv().v = state
    while getgenv().v == true do
        local args = {
            [1] = "Chop",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("B", "", function(state)
    getgenv().b = state
    while getgenv().b == true do
        local args = {
            [1] = "Road Roller",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("Y", "", function(state)
    getgenv().y = state
    while getgenv().y == true do
        local args = {
            [1] = "The World",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)

AutoSkillsSection:NewToggle("Z", "", function(state)
    getgenv().z = state
    while getgenv().z == true do
        local args = {
            [1] = "Shin Kick",
            [2] = true,
            [3] = false
        }
        game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer(unpack(args))
        wait()
    end
end)
