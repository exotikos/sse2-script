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
local autobuy = Tabs.Main:AddRightGroupbox('Auto')

local planetCoords = {
    ["Miranda"] = CFrame.new(-24984.8379, -0.740695715, 26005.9219, -0.703192294, 0.697636425, 0.137200534, -0.198705956, -0.00755099719, -0.98003006, -0.682668686, -0.716412187, 0.143934309),
    ["Venus"] = CFrame.new(-14795.5957, -3597.45923, -16981.3262, -0.0227449723, 0.281385332, 0.959325254, -0.963689029, 0.249196067, -0.0959415957, -0.266056627, -0.926673412, 0.265500009)
}
local planets = {}
local itemFuncs = {
    ["test"] = function() print("this is a test function") end,
    ["test2"] = function() print("this is a test function2") end
}
local items = {}
local item
for i,_ in next, itemFuncs do
    table.insert(items, i)
end
for i,_ in next, planetCoords do
    table.insert(planets, i)
end
local player = game.Players.LocalPlayer
local character = player.Character
print(character)
print(character.Name)

function farmShockstones(amount)
    if amount == nil then amount = 1 end
    local originalPos = character.HumanoidRootPart.CFrame
    amount = math.clamp(amount, 1, 5)
    local count = 0
    character:PivotTo(planetCoords["Miranda"])
    while count < amount do
        wait(1)
        local shockstone = workspace.Planets.Miranda.MirandaStoneScript:FindFirstChild("Shockstone")
        if shockstone then
            fireclickdetector(shockstone.ClickDetector)
            count += 1
        end
    end
    character:PivotTo(originalPos)

end
local shockstoneFarmNum
farm:AddSlider('Shockstones', {
    Text = 'Shockstones',
    Default = 1,
    Min = 1,
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
    Tooltip = "Does not use bombs."
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
autobuy:AddSlider('ItemAmount', {
    Text = 'Buy',
    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,

    Callback = function(num)
        shockstoneFarmNum = num
    end
})
autobuy:AddDropdown('Item', {
    Values = items,
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Tooltip = 'Item', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        item = Value
        print(item)
    end
})
autobuy:AddButton({
    Text = 'Get',
    Func = function()
        if item == nil then return end
        itemFuncs[item]()
    end,
    DoubleClick = false,
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
