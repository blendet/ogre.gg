local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

_G.val = nil

local inazuma = Material.Load({
    Title = "Inazuma Rebirth | Ogre.gg",
    Style = 1,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark",
})

local main = inazuma.New({
    Title = "MAIN"
})

local dribble = main.Toggle({
    Text = "Anti Tackle",
    Callback = function(Value)
    _G.anti = Value
        while _G.anti == true do 
            game:GetService("Players").LocalPlayer.Character.SprintADribbles.Dribble:FireServer()
            wait(.1)
        end
    end,
})

local hisapower = main.Toggle({
    Text = "Infinite Energy",
    Callback = function(Value)
    _G.eng = Value
        while _G.eng == true do 
            game:GetService("Players").LocalPlayer.Character.TPGaining.Get:FireServer()
            wait(.1)
        end
    end,
})

local autofarm = inazuma.New({
    Title = "AUTO FARM"
})

local farm = autofarm.Button({
    Text = "Money/XP Farm",
    Callback = function()
    
    getgenv().farming = true 

    local JSONEncode, JSONDecode, GenerateGUID = 
    game.HttpService.JSONEncode, 
    game.HttpService.JSONDecode,
    game.HttpService.GenerateGUID
    local Request = syn and syn.request or request
    game.Players.LocalPlayer.Character.Tackle.Disabled = true
    game:GetService("StarterPlayer").StarterCharacterScripts.Tackle.Disabled = true
    game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(
        function(v)
            if v.Name == "MoneyAndEXPQuest" and v:FindFirstChild("MainFrame") then
                v.MainFrame.Frame.Agree.Visible = true
            end
        end
    )

    function click_button(button)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(
            button.AbsolutePosition.X + button.AbsoluteSize.X / 2,
            button.AbsolutePosition.Y + 50,
            0,
            true,
            button,
            1
        )
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(
            button.AbsolutePosition.X + button.AbsoluteSize.X / 2,
            button.AbsolutePosition.Y + 50,
            0,
            false,
            button,
            1
        )
    end
    old =
        hookfunction(
        wait,
        function(t)
            if t and not (checkcaller()) then
                return old()
            end
            return old(t)
        end
    )

    task.spawn(
        function()
            while task.wait() do
                if getgenv().farming then
                    pcall(
                        function()
                            click_button(
                                game:GetService("Players").LocalPlayer.PlayerGui.MoneyAndEXPQuest.MainFrame.Frame.Agree
                            )
                        end
                    )
                end
            end
        end
    )
    task.spawn(
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(
                810.918457,
                286.200317,
                -270.419952,
                -0.34223482,
                1.02101794e-08,
                0.939614475,
                2.98544265e-08,
                1,
                7.49754599e-12,
                -0.939614475,
                2.80542167e-08,
                -0.34223482
            )
            wait(3)
            while task.wait() do
                if getgenv().farming then
                    game:GetService("Workspace").GettingBoxPart.CFrame =
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    task.wait(1)
                    game:GetService("Workspace").GettingBoxPart.CFrame = CFrame.new(763, 286, -327)
                    fireproximityprompt(game:GetService("Workspace").IceCreamGuy.ExpMoneyQuest.ProximityPrompt)
                end
            end
        end
    )

        end,
})

local player = inazuma.New({
    Title = "PLAYER"
})

local walkspeed = player.Slider({
    Text = "Walk Speed",
    Callback = function(Value)
        getgenv().WalkSpeedValue = Value
    end,
    Min = 16,
    Max = 200,
    Def = 300
})

local walk = player.Toggle({
    Text = "Apply Changes",
    Callback = function(Value)
    _G.sj = Value
    local Player = game:service'Players'.LocalPlayer;
    
    Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
        if _G.sj == true then
            Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
        end
    end)
        
    Player.Character.Humanoid:GetPropertyChangedSignal'JumpPower':Connect(function()
        if _G.sj == true then
            Player.Character.Humanoid.JumpPower = getgenv().JumpPowerValue;
        end
    end)
        
    if _G.sj == true then
        Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
        Player.Character.Humanoid.JumpPower = getgenv().JumpPowerValue;
    end
    end,
    Enabled = false
})

local tp = inazuma.New({
    Title = "TELEPORTS"
})

local teleports = tp.Dropdown({
    Text = "Teleport",
    Callback = function(Value)
        if Value == "Ice Cream Quest" then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local location = CFrame.new(796.225342, 286.200287, -268.612122, -0.157564446, 2.30860522e-08, -0.987508714, 1.99423233e-08, 1, 2.01961257e-08, 0.987508714, -1.65110254e-08, -0.157564446)
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = location
        elseif Value == "Squat Buyer" then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local location = CFrame.new(-259.385376, 240.154984, 111.550682, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = location
    
        elseif Value == "Power Quest" then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local location = CFrame.new(482.419434, 706.841858, 33.9277649, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = location
       
        elseif Value == "Speed Quest" then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local location = CFrame.new(-250.202713, 239.758545, 423.833893, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = location

        elseif Value == "Dribble Quest" then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local location = CFrame.new(-873.134583, 257.127502, -252.500259, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07)
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = location
   
        end
    end,
    Options = {
        "Squat Buyer",
        "Ice Cream Quest",
        "Power Quest",
        "Dribble Quest",
        "Speed Quest"
    },
    Menu = {
        Information = function(self)
            X.Banner({
                Text = "Test alert!"
            })
        end
    }
})
