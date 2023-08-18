--[[MODULES]]--
local kah, success = loadstring(game:HttpGet'https://raw.githubusercontent.com/szcvak/lua/main/Kohl\'s%20Admin%20House/Stellar/API.lua')()({
    ScriptName = 'hypernova',
    Prefix = '#',
    CoerceISU = false
})

kah.Settings.LogFunction = function(msg, col)
    startergui:SetCore("ChatMakeSystemMessage", {
        Text = "[*] "..msg,
        Color = col
    })
end

--[[PROCESSES]]--
local process = {
    walls = false
}

--[[GLOBAL VARIABLES]]--
-- Basic global variables that will be used in the whole script
local lp = game.Players.LocalPlayer
local players = game:GetService'Players':GetPlayers -- Called using players()
local chat = kah:Chat()
local findp = kah:FindPlayer()
local log = kah:Log()

local tint = {
	red = Color3.new(1, 0, 0),
	green = Color3.new(0, 1, 0),
	blue = Color3.new(0, 0, 1),
	yellow = Color3.new(1, 1, 0),
	cyan = Color3.new(0, 1, 1)
}


--[[GUI SETUP]]--
-- Creates an empty list for commands to be shown in the QOL tab in the GUI and so on
local qol = {}
local kohls = {}

--[[COMMAND INITIALIZE]]--
-- Shows the players username and displayname above their head [DisplayName (@Username1234)]
qol.showdn = {
    name = 'Show Display Names',
    description = 'Shows all player\'s display names above their head',
	properties = {
	    above = false,
        forceun = false,
        spacing = 0
	},
	alias = {'showdisplaynames', 'usedn'}
}

-- Changes the player's text color in chat
qol.textchc = {
    name = 'Chat Color',
    description = 'Changes the player\'s chat color',
    properties = {
        color = Color3.new(255, 255, 255)
    },
    alias = {'textcolor', 'chatcol'}
}

kohls.nok = {
    name = 'Remove Obbykill',
    description = 'Makes the red killbricks deal no damage',
    properties = {
        full = false
    },
    alias = {'rok'}
}

kohls.bkcrash = {
    name = 'Hyperbike Crash',
    description = 'Shuts down the server using the hyperbike gear'
}

kohls.fcrash = {
    name = 'Freeze Crash',
    description = 'Shuts down the server using the freeze command'
}

kohls.vgcrash = {
    name = 'Vampire Gear Crash',
    description = 'Shuts down the server using the vampire gear'
}

kohls.walls = {
    name = 'Toggle Walls',
    description = 'Toggles can-collide on the obby walls',
    properties = {
        full = false
    },
    alias = {'cc'}
}

-- Load commands into the KAHAPI module
kah:LoadCommands(qol)
kah:LoadCommands(kohls)

--[[COMMAND SETUP]]--
-- Sets up the commands that we initialized earlier
-- Command is the function that is called when user executes the command
qol.showdn.command = function()
    for _, v in next, players() do
        if v.Character:FindFirstChild'Humanoid' then
            if not qol.showdn.properties.above then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.Name..""..string.rep("\n", qol.showdn.properties.spacing).."(@"..v.Character.Humanoid.DisplayName..")"
            elseif qol.showdn.properties.above then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.DisplayName..""..string.rep("\n", qol.showdn.properties.spacing).."(@"..v.Character.Humanoid.Name..")"
            elseif qol.showdn.properties.showun then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.Name
            end
        end
    end
end

qol.textchc.command = function(newcol)
    -- TODO: Complete after sw is up again
end

kohls.nok.command = function()
    for _, v in next, kah.Game.Workspace.Obby:GetChildren() do
        if v:FindFirstChild'TouchInterest' then
		    if not kohls.nok.properties.full then
		        v.TouchInterest:Destroy()
		        v.CanTouch = false
		    else
		        v:Destroy()
		    end
		end
    end
end

kohls.bkcrash.command = function()
    log('Crashing using bikecrash...', tint.green)
    kah.Crashes:HyperbikeCrash()
end

kohls.fcrash.command = function()
    log('Crashing using freezecrash...', tint.green)
    kah.Crashes:FreezeCrash()
end

kohls.vgcrash.command = function()
    log('Crashing using vgcrash...', tint.green)
    kah.Crashes:VGCrash()
end

kohls.walls.command = function()
    for _, v in next, kah.Game.Workspace['Obby Box']:GetChildren() do
        process.walls = not process.walls
        if v then
	        if process.walls then
	            log('Cancollide turned off', tint.green)
		        if not kohls.walls.properties.full then
		            v.CanCollide = false
		        elseif kohls.walls.properties.full then
		            v:Destroy()
		        end
		    else
		        log('Cancollide turned on', tint.green)
		        v.CanCollide = true
		    end
		else
		    log('Walls do not exist', tint.red)
		end
    end
end

--[[EVENTS]]--
-- Uses the Kohl's API to check if player said a command
game.Players.CommandChatted:Connect(function(sender, command, message)
    kah:Process(sender, command, message)
end)

