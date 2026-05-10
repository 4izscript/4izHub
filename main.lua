print([[
██╗  ██╗██╗███████╗██╗  ██╗██╗   ██╗██████╗     ██╗      ██████╗  █████╗ ██████╗ ███████╗██████╗ 
██║  ██║██║╚══███╔╝██║  ██║██║   ██║██╔══██╗    ██║     ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████║██║  ███╔╝ ███████║██║   ██║██████╔╝    ██║     ██║   ██║███████║██║  ██║█████╗  ██║  ██║
╚════██║██║ ███╔╝  ██╔══██║██║   ██║██╔══██╗    ██║     ██║   ██║██╔══██║██║  ██║██╔══╝  ██║  ██║
     ██║██║███████╗██║  ██║╚██████╔╝██████╔╝    ███████╗╚██████╔╝██║  ██║██████╔╝███████╗██████╔╝
     ╚═╝╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═════╝ 
]])

-- Logic 
local Players = game:GetService("Players")
local author_id = 5028543455
local author_image = Players:GetUserThumbnailAsync(author_id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

-- Fly Logic Variables & Functions
local FlyEnabled = false
local FlySpeed = 50
local BodyVelocity, BodyGyro
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function updateFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    
    if FlyEnabled then
        if not BodyVelocity then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Parent = root
        end
        if not BodyGyro then
            BodyGyro = Instance.new("BodyGyro")
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.P = 10000
            BodyGyro.CFrame = root.CFrame
            BodyGyro.Parent = root
        end
        character.Humanoid.PlatformStand = true
    else
        if BodyVelocity then BodyVelocity:Destroy() BodyVelocity = nil end
        if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = false
        end
    end
end

task.spawn(function()
    while true do
        if FlyEnabled and game.Players.LocalPlayer.Character and BodyVelocity and BodyGyro then
            local camera = workspace.CurrentCamera
            local moveDir = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            
            if moveDir.Magnitude > 0 then
                BodyVelocity.Velocity = moveDir.Unit * FlySpeed
            else
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            BodyGyro.CFrame = camera.CFrame
        end
        task.wait()
    end
end)

-- Infinite Jump Logic
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)

-- speed logic

local Speed = 50
task.spawn(function()
    while true do
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Speed
        end
        task.wait()
    end
end)

-- List Player
local Players = game:GetService("Players")
local SelectedPlayerName = nil

local function getPlayers()
    local players = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    return players
end

-- Teleport To Player
local function TeleportToPlayer(targetPlayer)
    if not targetPlayer then return end
    local character = game.Players.LocalPlayer.Character
    local targetCharacter = targetPlayer.Character
    
    if character and targetCharacter and character:FindFirstChild("HumanoidRootPart") and targetCharacter:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame
    end
end

-- View Player
local function ViewPlayer(targetPlayer)
    if not targetPlayer then return end
    local camera = workspace.CurrentCamera
    local targetCharacter = targetPlayer.Character
    
    if targetCharacter and targetCharacter:FindFirstChild("Humanoid") then
        camera.CameraSubject = targetCharacter.Humanoid
    end
end

-- Teleport To CFrame
local function TeleportToCFrame(targetCFrame)
    if not targetCFrame then return end
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = targetCFrame
    end
end


-- List The Dealership Cframe
local Dealerhsipjakarta = {Mercedez = CFrame.new(100, 100, 100),}
local Dealerhsipjatim = {Mercedez = CFrame.new(100, 100, 100),}
local Dealerhsipjateng = {Mercedez = CFrame.new(100, 100, 100),}
local Dealerhsipjabar = {Mercedez = CFrame.new(100, 100, 100),}

local SelectedDealershipJakarta = nil
local SelectedDealershipJatim = nil
local SelectedDealershipJateng = nil
local SelectedDealershipJabar = nil

-- Loaded Wind Ui
local Version = "1.6.62"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

-- Load Themes from external file
local githubThemesUrl = "https://raw.githubusercontent.com/username/repo/main/themes.lua"
local success, content = pcall(function() return game:HttpGet(githubThemesUrl) end)
if success then
    loadstring(content)()
else
    WindUI:AddTheme({
        Name = "Dark",
            Accent = Color3.fromHex("#ae81ff"),
            Background = Color3.fromHex("#0a0a1a"),
        })
    end

-- Theme Load end

-- Window Loaded
local Window = WindUI:CreateWindow({
    Title = "4izHub | Car Driving Indonesia",
    Icon = "door-open",
    Author = "by .Fxcaaax and .inc",
    Folder = "4izHub|Car Driving Indonesia",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.LeftShift,
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            local DisplayName = game.Players.LocalPlayer.DisplayName
            setclipboard(DisplayName)
            WindUI:Notify({
                Title = "Copied",
                Content = "Your Username "..DisplayName.." Already Copyied",
                Duration = 5,
                Icon = "solar:notification-unread-lines-bold-duotone",
            })
        end,},                                                  
})

-- Tag Loaded
Window:Tag({Title = "V.1.1",Icon = "github",Color = Color3.fromHex("#30ff6a"),Radius = 13,})

-- FPS Tag (Inisialisasi tanpa gradient redundant)
local FPSTag = Window:Tag({
    Title = "FPS: 0",
    Radius = 0,
    })

task.spawn(function()
    local RunService = game:GetService("RunService")
    while true do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        FPSTag:SetTitle("FPS: " .. fps)
        
        -- Warna Gradient berubah secara dinamis berdasarkan FPS
        if fps < 30 then
            FPSTag:SetColor(WindUI:Gradient({
                ["0"]   = { Color = Color3.fromHex("#FF416C"), Transparency = 0 },
                ["100"] = { Color = Color3.fromHex("#FF4B2B"), Transparency = 0 },
            }, { Rotation = 45 }))
        elseif fps < 60 then
            FPSTag:SetColor(WindUI:Gradient({
                ["0"]   = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
                ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
            }, { Rotation = 45 }))
        else
            FPSTag:SetColor(WindUI:Gradient({
                ["0"]   = { Color = Color3.fromHex("#ae81ff"), Transparency = 0 },
                ["100"] = { Color = Color3.fromHex("#f093fb"), Transparency = 0 },
            }, { Rotation = 45 }))
        end
    end
end)

-- tabs loaded
local Tabs = {
    Home = Window:Tab({Title = "Home",Icon = "solar:home-2-bold-duotone",Locked = false,}),
    Player = Window:Tab({Title = "Player",Icon = "solar:user-rounded-bold-duotone",Locked = false,}),
    Teleport = Window:Tab({Title = "Teleport",Icon = "solar:map-point-bold-duotone",Locked = false,}),
    AutoFarm = Window:Tab({Title = "Auto Farm",Icon = "solar:money-bag-bold-duotone",Locked = false,}),
    Settings = Window:Tab({Title = "Settings",Icon = "solar:settings-line-duotone",Locked = false,})
}

-- tabs end

-- section loaded
local sectab = {
    UpdateSec = Tabs.Home:Section({Title = "Update",}),
    InfoSec = Tabs.Home:Section({Title = "Info",}),
    Movement = Tabs.Player:Section({Title = "Movement",}),
    TeleportPlayer = Tabs.Player:Section({Title = "Teleport To Player",Box = true,}),
    TeleportDealership = Tabs.Teleport:Section({Title = "Teleport To Dealership",Box = true,}),
}

-- section end

-- Home tab
sectab.UpdateSec:Paragraph({
    Title = "Changelog For V1.1",
    Desc = "- Added New UI \n- Added New Settings \n- Added New Teleport \n- Added New Auto Farm",
    Buttons = {
        {
            Icon = "solar:login-2-bold-duotone",
            Title = "Join Our Discord",
            Callback = function() 
                local success = pcall(function()
                    WindUI:OpenURL("https://discord.gg/4izhub")
                end)
                if not success then
                    setclipboard("https://discord.gg/4izhub")
                end
            end,
        }
    }
})
sectab.InfoSec:Paragraph({
    Title = "This Script Made By Fxcaaax",
    Desc = "Follow Me On roblox",
    ImageSize = 65,
    Image = author_image,
})

-- Home tab end

-- Player tab
sectab.Movement:Toggle({
    Title = "Fly",
    Desc = "Acitve it to Fly",
    Value = false,
    Callback = function(v)
        FlyEnabled = v
        updateFly()
    end
})

sectab.Movement:Slider({
    Title = "Fly Speed",
    Desc = "Set The Speed Fly",
    Min = 10,
    Max = 300,
    Step = 1,
    Value = 50,
    Callback = function(v)
        FlySpeed = v
    end
})
sectab.Movement:Toggle({
    Title = "Infinity Jump",
    Desc = "Acitve it to Infinity Jump",
    Value = false,
    Callback = function(v)
        InfiniteJumpEnabled = v
    end
})
sectab.Movement:Slider({
    Title = "Speed",
    Desc = "Acitve it to Speed",
    Value = 60,
    Min = 1,
    Max = 300,
    Step = 10,
    Callback = function(v)
        Speed = v
    end
})
-- Teleport Or View Player In the game
sectab.TeleportPlayer:Dropdown({
    Title = "Teleport Or View Player",
    Desc = "Teleport To Player in The Game",
    Values = getPlayers(),
    Value = "Select Player",
    Callback = function(option) 
        SelectedPlayerName = option
    end
})
sectab.TeleportPlayer:Button({
    Icon = "solar:login-2-bold-duotone",
    Title = "Teleport",
    Callback = function() 
        if SelectedPlayerName then
            TeleportToPlayer(Players:FindFirstChild(SelectedPlayerName))
        end
    end,
})
sectab.TeleportPlayer:Button({
    Icon = "solar:eye-bold-duotone",
    Title = "View",
    Callback = function() 
        ViewPlayer(Players:FindFirstChild(SelectedPlayerName))
    end,
})
-- Player tab end

-- Teleport Tab


--Dealership Jakarta
local JakartaDealershipDropdown = sectab.TeleportDealership:Dropdown({
    Title = "Teleport To Dealership Jakarta",
    Desc = "Teleport To Dealership in The Game",
    Values = Dealerhsipjakarta,
    Value = "Select Dealership Jakarta",
    Callback = function(option) 
        SelectedDealershipJakarta = option
    end
})
sectab.TeleportDealership:Button({
    Icon = "solar:login-2-bold-duotone",
    Title = "Teleport",
    Callback = function() 
        if SelectedDealershipJakarta then
            TeleportToCFrame(Dealerhsipjakarta[SelectedDealershipJakarta])
        end
    end,
})

--Dealership Jatim
local JatimDealershipDropdown = sectab.TeleportDealership:Dropdown({
    Title = "Teleport To Dealership Jatim",
    Desc = "Teleport To Dealership in The Game",
    Values = Dealerhsipjatim,
    Value = "Select Dealership Jatim",
    Callback = function(option) 
        SelectedDealershipJatim = option
    end
})
sectab.TeleportDealership:Button({
    Icon = "solar:login-2-bold-duotone",
    Title = "Teleport",
    Callback = function() 
        if SelectedDealershipJatim then
            TeleportToCFrame(Dealerhsipjatim[SelectedDealershipJatim])
        end
    end,
})

-- Dealership Jateng
local JatengDealershipDropdown = sectab.TeleportDealership:Dropdown({
    Title = "Teleport To Dealership Jateng",
    Desc = "Teleport To Dealership in The Game",
    Values = Dealerhsipjateng,
    Value = "Select Dealership Jateng",
    Callback = function(option) 
        SelectedDealershipJateng = option
    end
})
sectab.TeleportDealership:Button({
    Icon = "solar:login-2-bold-duotone",
    Title = "Teleport",
    Callback = function() 
        if SelectedDealershipJateng then
            TeleportToCFrame(Dealerhsipjateng[SelectedDealershipJateng])
        end
    end,
})

-- Dealership Jabar
local JabarDealershipDropdown = sectab.TeleportDealership:Dropdown({
    Title = "Teleport To Dealership Jabar",
    Desc = "Teleport To Dealership in The Game",
    Values = Dealerhsipjabar,
    Value = "Select Dealership Jabar",
    Callback = function(option) 
        SelectedDealershipJabar = option
    end
})
sectab.TeleportDealership:Button({
    Icon = "solar:login-2-bold-duotone",
    Title = "Teleport",
    Callback = function() 
        if SelectedDealershipJabar then
            TeleportToCFrame(Dealerhsipjabar[SelectedDealershipJabar])
        end
    end,
})

-- logic for the dropdown hide or no with place id
if game.PlaceId == 11431041001 then
    JakartaDealershipDropdown:Lock()
    JatimDealershipDropdown:Lock()
    JatengDealershipDropdown:Lock()
    JabarDealershipDropdown:Lock()

elseif game.PlaceId == 114310411001 then
    JakartaDealershipDropdown:Lock()
    JatengDealershipDropdown:Lock()
    JabarDealershipDropdown:Lock()
    JatimDealershipDropdown:Unlock()

elseif game.PlaceId == 114310412001 then
    JakartaDealershipDropdown:Lock()
    JatimDealershipDropdown:Lock()
    JabarDealershipDropdown:Lock()
    JatengDealershipDropdown:Unlock()

elseif game.PlaceId == 114310413001 then
    JakartaDealershipDropdown:Lock()
    JatimDealershipDropdown:Lock()
    JatengDealershipDropdown:Lock()
    JabarDealershipDropdown:Unlock()
end
