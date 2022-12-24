-- MAIN VARIABLES
local mobs = {}
getgenv().mob = nil 

-- AUTO SKILL VARIABLES
getgenv().lmb = nil
getgenv().e = nil
getgenv().r = nil
getgenv().t = nil
getgenv().v = nil
getgenv().b = nil
getgenv().y = nil
getgenv().z = nil

-- LOCAL PLAYER VARIABLES
_G.sj = nil
getgenv().WalkSpeedValue = 17
getgenv().JumpPowerValue = 51

-- ITEM FARM
local items = {}
getgenv().item = nil

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

-- AUTO ITEM
local itemFarmSection = Main:NewSection("Auto Item Farm")

-- ITEMS
for _,v in pairs(game:GetService("Workspace").Map.Items.SpawnedItems:GetChildren()) do
    insert = true 
    for _,v2 in pairs(items) do if v2 == v.Name then insert = false end end
    if insert then table.insert(items, v.Name) end 
end

local itemdropdown = itemFarmSection:NewDropdown("Choose Item", "Chooses the item to autofarm", items, function(v) -- CREATES A item DROPDOWN TO CHOOSE THE items (USES THE TABLE FROM THE items SECTION ABOVE)
    getgenv().item = v
end)

itemFarmSection:NewToggle("Start Item Farm", "Toggles the autofarming of the items", function(v) 
    getgenv().autofarmitems = v
    while wait() do 
        if getgenv().autofarmitems == false then return end
        if getgenv().item == nil then 
            game.StarterGui:SetCore("SendNotification", { 
                Title = "Error!", 
                Text = "You havent selected a item with the dropdown above\nUntoggle this toggle!", 
                Icon = "", 
                Duration = 2.5 
            })
            getgenv().autofarmitems = false 
            return 
        end
        local item = game:GetService("Workspace").Map.Items.SpawnedItems:FindFirstChild(getgenv().item)
        if item == nil then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Info!", 
                Text = "There is currently no spawned items of this type!\nJust wait until they spawn",
                Icon = "",
                Duration = 2.5 
            })
            while wait() do 
                wait()
                if getgenv().autofarmitems == false then return end 
                if game:GetService("Workspace").Map.Items.SpawnedItems:FindFirstChild(getgenv().item) ~= nil then break; end
            end 
        else
            local item2 = item
            while wait() do
                item = game:GetService("Workspace").Map.Items.SpawnedItems:FindFirstChild(getgenv().item)
                if item ~= item2 then break; end
                if getgenv().autofarmitems == false then return end 
                if item ~= nil then
                    if item:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame
                        fireproximityprompt(item.ProximityPrompt, 9999)
                    end
                    if item:FindFirstChild("Handle") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Handle.CFrame
                        fireproximityprompt(item.Handle.ProximityPrompt, 9999)
                    end
                end
                wait() 
            end
        end
    end
end)

-- UPDATING THE ITEMS
game:GetService("Workspace").Map.Items.SpawnedItems.ChildAdded:Connect(function() 
    for _,v2 in pairs(items) do table.remove(items, _) end 
    for _,v in pairs(game:GetService("Workspace").Map.Items.SpawnedItems:GetChildren()) do
        insert = true 
        for _,v2 in pairs(items) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(items, v.Name) end 
    end
    itemdropdown:Refresh(items)
end)
 
game:GetService("Workspace").Map.Items.SpawnedItems.ChildRemoved:Connect(function() 
    for _,v2 in pairs(items) do table.remove(items, _) end
    for _,v in pairs(game:GetService("Workspace").Map.Items.SpawnedItems:GetChildren()) do
        insert = true 
        for _,v2 in pairs(items) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(items, v.Name) end
    end
    itemdropdown:Refresh(items)
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

-- LOCAL PLAYER
local Main = Window:NewTab("Local Player")
local LocalSection = Main:NewSection("Local Player")

LocalSection:NewSlider("Walk Speed", "", 150, 16, function(s)
    getgenv().WalkSpeedValue = s
end)

LocalSection:NewSlider("Jump Force", "", 150, 16, function(s)
    getgenv().JumpPowerValue = s
end)

LocalSection:NewToggle("Apply Changes", "", function(state)
    _G.sj = state
    local Player = game:GetService("Players").LocalPlayer
    
    Player.Character.Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(function()
        if _G.sj == true then
            Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
        end
    end)
        
    Player.Character.Humanoid:GetPropertyChangedSignal('JumpPower'):Connect(function()
        if _G.sj == true then
            Player.Character.Humanoid.JumpPower = getgenv().JumpPowerValue;
        end
    end)
        
    if _G.sj == true then
        Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
        Player.Character.Humanoid.JumpPower = getgenv().JumpPowerValue;
    end
    
    if _G.sj == false then
        Player.Character.Humanoid.WalkSpeed = 24;
        Player.Character.Humanoid.JumpPower = 50;
    end
end)
