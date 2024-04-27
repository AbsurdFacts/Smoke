local Smoke = {}
Smoke.Owner = {
	"Aphoon_best1"
}
Smoke.PrivateUsers = {
	"snoopyprivateismean",
	"volvxlx"
}
Smoke.Connections = {}

function Smoke:Executed()
	return "Smoke Executed"
end

function isPrivateUser(playerName)
	return Smoke.Private[playerName] or false
end

-- Create ScreenGui in PlayerGui for it to be visible
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "SmokeGui"
screenGui.ResetOnSpawn = true

local menuFrame = Instance.new("Frame", screenGui)
menuFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
menuFrame.Position = UDim2.new(0.638, 0, 0.222, 0)
menuFrame.Visible = true

function Smoke:CreateButton(text, position, callback)
	local btn = Instance.new("TextButton", menuFrame)
	btn.Text = text
	btn.Size = UDim2.new(0.8, 0, 0.05, 0)
	btn.Position = position
	btn.MouseButton1Click:Connect(callback)
end

function Smoke:CreateNotification(parent, name, text, duration)
	local notification = Instance.new("TextLabel")
	notification.Parent = parent
	notification.Name = name
	notification.Text = text
	notification.Size = UDim2.new(0, 200, 0, 50)
	notification.Position = UDim2.new(0.5, -100, 0, -50) -- Center top
	notification.BackgroundColor3 = Color3.new(1, 1, 1)
	notification.TextColor3 = Color3.new(0, 0, 0)

	-- Auto-remove after duration
	task.delay(duration, function()
		notification:Destroy()
	end)
end
Smoke:CreateButton("Speed", UDim2.new(0, 0, 0.1, 0), function()
	local player = game.Players.LocalPlayer
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 100
	end
end)

Smoke:CreateButton("ESP", UDim2.new(0, 0, 0.2, 0), function()
	local FillColor = Color3.fromRGB(175,25,255)
	local DepthMode = "AlwaysOnTop"
	local FillTransparency = 0.5
	local OutlineColor = Color3.fromRGB(255,255,255)
	local OutlineTransparency = 0

	local CoreGui = game:FindService("CoreGui")
	local Players = game:FindService("Players")
	local lp = Players.LocalPlayer
	local connections = {}

	local Storage = Instance.new("Folder")
	Storage.Parent = CoreGui
	Storage.Name = "Highlight_Storage"

	local function Highlight(plr)
		local Highlight = Instance.new("Highlight")
		Highlight.Name = plr.Name
		Highlight.FillColor = FillColor
		Highlight.DepthMode = DepthMode
		Highlight.FillTransparency = FillTransparency
		Highlight.OutlineColor = OutlineColor
		Highlight.OutlineTransparency = 0
		Highlight.Parent = Storage

		local plrchar = plr.Character
		if plrchar then
			Highlight.Adornee = plrchar
		end

		connections[plr] = plr.CharacterAdded:Connect(function(char)
			Highlight.Adornee = char
		end)
	end

	Players.PlayerAdded:Connect(Highlight)
	for i,v in next, Players:GetPlayers() do
		Highlight(v)
	end

	Players.PlayerRemoving:Connect(function(plr)
		local plrname = plr.Name
		if Storage[plrname] then
			Storage[plrname]:Destroy()
		end
		if connections[plr] then
			connections[plr]:Disconnect()
		end
	end)
end)

local plr = game.Players.LocalPlayer

if plr.Name == "Aphoon_best1" then
	Smoke:CreateButton("UltraSpeed", UDim2.new(0, 0, 0.7, 0), function()
		local player = game.Players.LocalPlayer
		local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = 500
		end
	end)
	Smoke:CreateButton("OwnerNameTag", UDim2.new(0, 0, 0.8, 0), function()
		local TextChatService = game:GetService("TextChatService")
		local Properties = Instance.new("TextChatMessageProperties")
		local r, g, b = 0, 255, 238 -- Change this to whatever color you want your tags to be.
		local ChatTagText = "[SMOKE OWNER]" -- Change YourChatTagText to what you want your role to be.
		local TagOwners = {"Aphoon_best1",} -- Change "YourMAINRobloxUsername and SomeoneelsesRobloxUsername"to who ever you want to have this ChatTag.

		TextChatService.OnIncomingMessage = function(Message: TextChatMessage)
			if Message.TextSource then
				local Player = game:GetService("Players"):GetPlayerByUserId(Message.TextSource.UserId)
				if table.find(TagOwners, Player.Name) then
					Properties.PrefixText = "<font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. ChatTagText .. "</font> " .. Message.PrefixText
				end
			end
			return Properties
		end
	end)
end

return Smoke
