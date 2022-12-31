-- UI VARIABLES
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Simple Hub | Ogre.gg", HidePremium = false, SaveConfig = true, ConfigFolder = "ogre.gg", IntroText = "ogre.gg"})

-- GAME VARIABLES
local Player = game:GetService("Players").LocalPlayer
local playerList = {}

-- WALK SPEED / JUMP FORCE VARIABLES
getgenv().ws = nil
getgenv().wsValue = nil
getgenv().jfValue = nil

-- TELEPORT VARIABLES
getgenv().selectedPlayer = nil

-- SPAM TELEPORT VARIABLES
getgenv().spamRageEnable = nil
getgenv().x = nil
getgenv().y = nil
getgenv().z = nil

-- AUTHORIZED NOTIFICATION
OrionLib:MakeNotification({
	Name = "Authorized!",
	Content = "You are logged in as "..game.Players.LocalPlayer.Name,
	Image = "rbxassetid://6034837802",
	Time = 5
})

-- LOCAL PLAYER --
local lp = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://6022668898",
	PremiumOnly = false
})

-- WALK SPEED
local ws = lp:AddSection({
	Name = "Walk-Speed"
})

-- WALK SPEED SLIDER
ws:AddSlider({
	Name = "Walk Speed",
	Min = 0,
	Max = 150,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(Value)
		getgenv().wsValue = Value
	end    
})

-- JUMP FORCE
local jf = lp:AddSection({
	Name = "Jump-Force"
})

-- JUMP FORCE SLIDER
jf:AddSlider({
	Name = "Jump Force",
	Min = 0,
	Max = 150,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(Value)
		getgenv().jfValue = Value
	end    
})

-- TOGGLE THE CHANGES
lp:AddToggle({
	Name = "Apply Changes",
	Default = false,
	Callback = function(Value)
	    
	    -- BOOL VALUES
	    getgenv().ws = Value

	    -- BYPASS | CREDITS: garrfield (v3rmillion) | https://v3rmillion.net/member.php?action=profile&uid=1795770
		if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/cooler%20scripts/MTAPI", true))() end
		
		game.Players.LocalPlayer.Character.Humanoid:AddGetHook("WalkSpeed",16)
        game.Players.LocalPlayer.Character.Humanoid:AddSetHook("WalkSpeed")
        
        -- SPEED CHANGE DETECTION
        Player.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if getgenv().ws == true then
                Player.Character.Humanoid.WalkSpeed = getgenv().wsValue;
            end
        end)
        
        -- JUMP POWER CHANGE DETECTION
        Player.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
            if getgenv().ws == true then
                Player.Character.Humanoid.JumpPower = getgenv().jfValue;
            end
        end)
            
        -- CHANGE THE SPEED AND JUMP POWER WHILE ITS TOGGLED ON
        while getgenv().ws == true do
            if getgenv().ws == true then
                Player.Character.Humanoid.WalkSpeed = getgenv().wsValue;
                Player.Character.Humanoid.JumpPower = getgenv().jfValue;
            end
            wait(.1)
        end

        -- DISABLED TOGGLED CHANGES SPEED AND JUMP POWER BACK TO DEFAULT VALUES
        if getgenv().ws == false then
            Player.Character.Humanoid.WalkSpeed = 16
            Player.Character.Humanoid.JumpPower = 50
        end

	end    
})

-- TELEPORT --
local tp = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://6031280883",
	PremiumOnly = false
})

-- TELEPORT TO PLAYER
local playertp = tp:AddSection({
	Name = "Player Teleport"
})

-- WHICH PLAYER YOU WANT TELEPORT TO
for i,v in pairs(game:GetService("Players"):GetPlayers()) do 
    if v ~= game.Players.LocalPlayer then 
        table.insert(playerList,v.Name)
    end
end

-- SELECT PLAYER TO TELEPORT
playertp:AddDropdown({
	Name = "Teleport to: ",
	Default = "",
	Options = {unpack(playerList)},
	Callback = function(Value)
		getgenv().selectedPlayer = Value
	end    
})

-- TELEPORT TO PLAYER
playertp:AddButton({
	Name = "Teleport",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[getgenv().selectedPlayer].Character.HumanoidRootPart.CFrame
  	end    
})

-- SPAM RAGE
local spammer = tp:AddSection({
	Name = "Spam Teleport"
})

-- SELECT PLAYER TO TELEPORT
spammer:AddDropdown({
	Name = "Target: ",
	Default = "",
	Options = {unpack(playerList)},
	Callback = function(Value)
		getgenv().selectedPlayer = Value
	end    
})

-- X POSITION SLIDER
spammer:AddSlider({
	Name = "X",
	Min = 0,
	Max = 15,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(Value)
		getgenv().x = Value
	end    
})

-- Y POSITION SLIDER
spammer:AddSlider({
	Name = "Y",
	Min = 0,
	Max = 15,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(Value)
		getgenv().y = Value
	end    
})

-- Z POSITION SLIDER
spammer:AddSlider({
	Name = "Z",
	Min = 0,
	Max = 15,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(Value)
		getgenv().z = Value
	end    
})

-- ENABLED SPAM RAGE
spammer:AddToggle({
	Name = "Enabled",
	Default = false,
	Callback = function(Value)
	    
	    getgenv().spamRageEnable = Value
	    
		while getgenv().spamRageEnable == true do
		    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[getgenv().selectedPlayer].Character.HumanoidRootPart.CFrame * CFrame.new(getgenv().x,getgenv().y,getgenv().z)
		    wait()
		end
	end    
})
