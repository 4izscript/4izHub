local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "4izHub | Car Driving Indonesia",
    Icon = "door-open",
    Author = "by Bahlil,",
    Folder = "286_-_7_+28",
    
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
        local player = game.Players.LocalPlayer
        if player then
            setclipboard(player.Name)

            WindUI:Notify({
                Title = "Success",
                Content = "Username copied to clipboard",
                Duration = 3,
                Icon = "check",
            })
        end
    end,
}
})

-- Tag
Window:Tag({Title = "V.1.1",Icon = "solar:info-square-bold-duotone",Color = Color3.fromHex("#30ff6a"),Radius = 5,})

-- Section Home
local MainSection = Window:Section({Title = "Main",Opened = true,})

-- Home Tab
local Tab = Window:Tab({Title = "Home",Icon = "solar:home-angle-2-bold-duotone",Locked = false,})
local player = game.Players.LocalPlayer
local userId = player.UserId

local avatarUrl = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" 
    .. userId .. "&size=420x420&format=Png&isCircular=false"

local Welcome Text = HomeTab:Paragraph({
    Title = "Welcome, " .. player.Name,
    Desc = "Enjoy using this script!",
    Image = avatarUrl,
    ImageSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "user",
            Title = "Copy Username",
            Callback = function()
                setclipboard(player.Name)
            end,
        }
    }
})
