local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'Solar System Exploitation 2',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    ['Settings'] = Window:AddTab('Settings'),
}

local leftgroup = Tabs.Main:AddLeftGroupbox('World')
local farm = Tabs.Main:AddLeftGroupbox("Farm")
local rightgroup = Tabs.Main:AddRightGroupbox('Player')
local credits = Tabs.Settings:AddRightGroupbox('Credits')

local planetCoords = {
    ["Miranda"] = CFrame.new(-24984.8379, -0.740695715, 26005.9219, -0.703192294, 0.697636425, 0.137200534, -0.198705956, -0.00755099719, -0.98003006, -0.682668686, -0.716412187, 0.143934309)
}
local planets = {}
for i,a in ipairs(planetCoords) do
    table.insert(planets, i)
end
local player = game.Players.LocalPlayer
local character = player.Character
print(character)
print(character.Name)

function farmShockstones(amount)
    local originalPos = character.HumanoidRootPart.CFrame
    amount = math.clamp(amount, 1, 5)
    local count = 0
    character:PivotTo(planetCoords["Miranda"])
    while count < amount do
        wait()
        local shockstone = workspace.Planets.Miranda:FindFirstChild("Shockstone")
        if shockstone then
            fireclickdetector(shockstone.ClickDetector)
        end
    end
    character:PivotTo(originalPos)

end
local shockstoneFarmNum
farm:AddSlider('Shockstones', {
    Text = 'Shockstones',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Compact = false,

    Callback = function(num)
        shockstoneFarmNum = num
    end
})
farm:AddButton({
    Text = 'Farm Shockstones',
    Func = function()
        farmShockstones(shockstoneFarmNum)
    end,
    DoubleClick = true,
})
leftgroup:AddDropdown('Teleport', {
    Values = planets,
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Teleport',
    --Tooltip = 'what do you think it does', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        character:PivotTo(planetCoords[Value])
    end
})
rightgroup:AddButton({
    Text = 'Pipe Desync',
    Func = function()
    if character:FindFirstChild("Pipe") == nil then return end
        if character.Pipe.RopeConstraint ~= nil then
            character.Pipe.RopeConstraint:Destroy()
        end
    end,
    DoubleClick = false,
    Tooltip = "You must hold a pipe to do this.\nYou can't do this twice on the same pipe.\n\nThis will make you be able to move further than you normally can while holding a pipe.\nFor other players you will be frozen in midair.\nCan be used in multiple ways."
})
-- UI Settings
local MenuGroup = Tabs['Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)

credits:AddLabel("Linoria UI Library - existing.")
credits:AddLabel("")
credits:AddLabel("Exotic - scripting solo for once,")
credits:AddLabel("finding ingame bugs and exploits")
credits:AddLabel("and wasting his time with this.")
