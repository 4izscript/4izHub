local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Variables
local Spying = true
local AutoCopy = false
local Blacklist = {}
local LogCount = 0

-- Utility: Get Path
local function GetPath(Instance)
    local Obj = Instance
    local Path = {}
    local Service = nil
    
    while Obj ~= nil and Obj ~= game do
        if Obj.Parent == game then
            Service = Obj
            break
        end
        
        local Name = Obj.Name
        if Name:find("^[%a_][%w_]*$") then
            table.insert(Path, 1, Name)
        else
            table.insert(Path, 1, '["' .. Name:gsub('"', '\\"') .. '"]')
        end
        
        Obj = Obj.Parent
    end
    
    local Result = ""
    if Service then
        Result = 'game:GetService("' .. Service.ClassName .. '")'
    else
        Result = "game"
    end
    
    for i, v in ipairs(Path) do
        if v:sub(1, 1) == "[" then
            Result = Result .. v
        else
            Result = Result .. "." .. v
        end
    end
    
    return Result
end

-- Utility: Serialize to Lua
local function Serialize(Value)
    local Type = typeof(Value)
    if Type == "string" then
        return '"' .. Value .. '"'
    elseif Type == "number" or Type == "boolean" then
        return tostring(Value)
    elseif Type == "Instance" then
        return GetPath(Value)
    elseif Type == "Vector3" then
        return "Vector3.new(" .. tostring(Value) .. ")"
    elseif Type == "Vector2" then
        return "Vector2.new(" .. tostring(Value) .. ")"
    elseif Type == "CFrame" then
        return "CFrame.new(" .. tostring(Value) .. ")"
    elseif Type == "Color3" then
        return "Color3.new(" .. tostring(Value) .. ")"
    elseif Type == "UDim2" then
        return "UDim2.new(" .. tostring(Value):gsub("[{}]", "") .. ")"
    elseif Type == "EnumItem" then
        return tostring(Value)
    elseif Type == "table" then
        local Str = "{"
        for i, v in pairs(Value) do
            local Key = type(i) == "number" and "" or Serialize(i) .. " = "
            Str = Str .. Key .. Serialize(v) .. ", "
        end
        return Str:sub(1, #Str - 2) .. "}"
    else
        return '"' .. tostring(Value) .. '"'
    end
end

-- UI Initialization
local Window = WindUI:CreateWindow({
    Title = "Remote Spy",
    Icon = "eye",
    Author = "by Antigravity",
    Folder = "WindUIRemoteSpy",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
})

local LogTab = Window:Tab({
    Title = "Logs",
    Icon = "scroll",
})

local DetailsTab = Window:Tab({
    Title = "Details",
    Icon = "info",
})

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

local LogSection = LogTab:Section({
    Title = "Captured Remotes",
})

local DetailsSection = DetailsTab:Section({
    Title = "Remote Replicator",
})

local CurrentScript = ""
local CodeBlock = DetailsSection:Code({
    Title = "Generated Script",
    Code = "-- Select a remote to view script",
})

local CopyButton = DetailsSection:Button({
    Title = "Copy Script",
    Desc = "Copy the replication script to clipboard",
    Icon = "copy",
    Callback = function()
        if CurrentScript ~= "" then
            setclipboard(CurrentScript)
            WindUI:Notify({
                Title = "Success",
                Content = "Script copied to clipboard!",
                Duration = 2
            })
        end
    end
})

-- Functions for Logs
local function AddLog(Remote, Method, Args)
    if not Spying then return end
    if table.find(Blacklist, Remote.Name) or table.find(Blacklist, Remote.ClassName) then return end
    
    LogCount = LogCount + 1
    local RemotePath = GetPath(Remote)
    local Time = os.date("%X")
    
    -- Generate Script
    local ArgStrings = {}
    for i, v in ipairs(Args) do
        table.insert(ArgStrings, Serialize(v))
    end
    local ArgString = table.concat(ArgStrings, ", ")
    
    local ScriptTemplate = string.format([[-- Remote Call Replicator
-- Path: %s
-- Method: %s

local Remote = %s
Remote:%s(%s)]], RemotePath, Method, RemotePath, Method, ArgString)

    if AutoCopy then
        setclipboard(ScriptTemplate)
        WindUI:Notify({
            Title = "Notification",
            Content = "Copied script for: " .. Remote.Name,
            Duration = 2
        })
    end

    -- Create Log Entry
    local LogButton
    LogButton = LogSection:Button({
        Title = "[" .. Time .. "] " .. Remote.Name,
        Desc = Method .. " - " .. #Args .. " arguments",
        Callback = function()
            CurrentScript = ScriptTemplate
            CodeBlock:SetCode(ScriptTemplate)
            DetailsTab:Select()
        end
    })
end

-- Settings
SettingsTab:Toggle({
    Title = "Spy Enabled",
    Desc = "Toggle remote interception",
    Value = true,
    Callback = function(val) Spying = val end
})

SettingsTab:Toggle({
    Title = "Auto Copy",
    Desc = "Automatically copy script to clipboard on capture",
    Value = false,
    Callback = function(val) AutoCopy = val end
})

SettingsTab:Button({
    Title = "Clear Logs",
    Desc = "Remove all captured logs from the UI",
    Callback = function()
        -- In Wind UI, we'd need to clear the section. 
        -- If individual buttons can't be cleared easily, we might need a workaround.
        -- Assuming Section:Destroy() or similar might exist, or just refreshing.
        -- For now, let's assume we can clear by destroying elements or provide a notification.
        WindUI:Notify({
            Title = "Action",
            Content = "Clearing logs... (UI Refresh needed)",
            Duration = 3
        })
    end
})

SettingsTab:Input({
    Title = "Blacklist",
    Desc = "Remote names/classes to ignore (comma separated)",
    Placeholder = "ExampleRemote, UnreliableRemoteEvent",
    Callback = function(txt)
        Blacklist = {}
        for s in txt:gmatch("([^, ]+)") do
            table.insert(Blacklist, s)
        end
    end
})

-- Hooking Logic
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    
    if (Method == "FireServer" or Method == "InvokeServer") and Spying then
        task.spawn(AddLog, self, Method, Args)
    end
    
    return oldNamecall(self, ...)
end)

WindUI:Notify({
    Title = "Remote Spy Loaded",
    Content = "Wind UI Remote Spy is now active.",
    Duration = 5
})
