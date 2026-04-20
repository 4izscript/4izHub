local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Theme Definition
WindUI:AddTheme({
    Name = "Purple Night", 
    
    -- Core
    Accent = WindUI:Gradient({                                                      
        ["0"] = { Color = Color3.fromHex("#a78bfa"), Transparency = 0 },            
        ["100"] = { Color = Color3.fromHex("#7c3aed"), Transparency = 0 },        
    }, {                                                                            
        Rotation = 45,                                                               
    }),
    Background = Color3.fromHex("#09090b"),
    BackgroundTransparency = 0.05,
    Outline = Color3.fromHex("#1e1b4b"),
    Text = Color3.fromHex("#fafafa"),
    Placeholder = Color3.fromHex("#71717a"),
    Button = Color3.fromHex("#1e1e2e"),
    Icon = Color3.fromHex("#a78bfa"),
    Hover = Color3.fromHex("#ffffff"),
    
    -- Window
    WindowBackground = Color3.fromHex("#09090b"),
    WindowShadow = Color3.fromHex("#000000"),
    WindowTopbarButtonIcon = Color3.fromHex("#d4d4d8"),
    WindowTopbarTitle = Color3.fromHex("#fafafa"),
    WindowTopbarAuthor = Color3.fromHex("#a1a1aa"),
    WindowTopbarIcon = Color3.fromHex("#fafafa"),
    
    -- Tabs & Elements
    TabBackground = Color3.fromHex("#fafafa"),
    TabTitle = Color3.fromHex("#fafafa"),
    TabIcon = Color3.fromHex("#a1a1aa"),
    
    ElementBackground = Color3.fromHex("#18181b"),
    ElementTitle = Color3.fromHex("#fafafa"),
    ElementDesc = Color3.fromHex("#a1a1aa"),
    ElementIcon = Color3.fromHex("#a78bfa"),
    
    -- Controls
    Toggle = Color3.fromHex("#27272a"),
    ToggleBar = Color3.fromHex("#fafafa"),
    
    Checkbox = Color3.fromHex("#27272a"),
    CheckboxIcon = Color3.fromHex("#fafafa"),
    
    Slider = Color3.fromHex("#27272a"),
    SliderThumb = Color3.fromHex("#fafafa"),
    
    -- Dialogs & Popups
    DialogBackground = Color3.fromHex("#09090b"),
    DialogTitle = Color3.fromHex("#fafafa"),
    DialogContent = Color3.fromHex("#d4d4d8"),
    DialogIcon = Color3.fromHex("#a78bfa"),
})

WindUI:SetTheme("Purple Night")

-- Window Creation
local Window = WindUI:CreateWindow({
    Title = "Purple Hub",
    Icon = "sparkles",
    Author = "by Antigravity",
    Folder = "PurpleHubConfig",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Purple Night",
})

-- Home Tab
local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "home",
})

local ChangelogSection = HomeTab:Section({
    Title = "Changelog",
})

ChangelogSection:Paragraph({
    Title = "Version 1.0.0",
    Desc = "- Initial Release\n- Added Purple Night Theme\n- Added Auto Farm system\n- Added Setting system",
})

-- Auto Farm Tab
local FarmTab = Window:Tab({
    Title = "Auto Farm",
    Icon = "swords",
})

local MainFarmSection = FarmTab:Section({
    Title = "Main Farming",
})

MainFarmSection:Toggle({
    Title = "Auto Farm Level",
    Desc = "Automatically farms levels for you",
    Value = false,
    Callback = function(state)
        print("Auto Farm Level: " .. tostring(state))
    end
})

-- Settings Tab
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

local UISettingsSection = SettingsTab:Section({
    Title = "UI Settings",
})

UISettingsSection:Dropdown({
    Title = "Change Theme",
    Desc = "Select a theme to apply",
    Values = WindUI:GetThemes(),
    Value = { WindUI:GetCurrentTheme() },
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

UISettingsSection:Toggle({
    Title = "Transparent Mode",
    Value = Window:GetTransparency(),
    Callback = function(val)
        Window:ToggleTransparency(val)
    end
})

UISettingsSection:Keybind({
    Title = "Toggle UI",
    Value = "LeftShift",
    Callback = function(key)
        print("Toggle key set to: " .. key)
    end
})

Window:EditOpenButton({
    Title = "Open Hub",
    Icon = "layout",
    Enabled = true,
})
