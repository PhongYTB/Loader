local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ////////////////////////////////////////////////////
-- // GUI SETUP
-- ////////////////////////////////////////////////////

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TabGuiVietnameseStyle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Tab Frame (The button to open/close the GUI)
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(0, 60, 0, 60)
TabFrame.Position = UDim2.new(0.5, -40, 0, 20)
TabFrame.BackgroundTransparency = 0.3
TabFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = ScreenGui

local CornerTab = Instance.new("UICorner")
CornerTab.CornerRadius = UDim.new(0, 15)
CornerTab.Parent = TabFrame

local StrokeTab = Instance.new("UIStroke")
StrokeTab.Color = Color3.new(1, 0, 0)
StrokeTab.Thickness = 3
StrokeTab.Parent = TabFrame

local TabTitleLabel = Instance.new("TextLabel")
TabTitleLabel.Name = "TabTitleLabel"
TabTitleLabel.Size = UDim2.new(1, -20, 1, 0)
TabTitleLabel.Position = UDim2.new(0, 10, 0, 0)
TabTitleLabel.BackgroundTransparency = 1
TabTitleLabel.TextColor3 = Color3.new(1, 0, 0)
TabTitleLabel.Text = "VN HUB"
TabTitleLabel.TextSize = 16
TabTitleLabel.Font = Enum.Font.GothamBold
TabTitleLabel.TextStrokeTransparency = 0.3
TabTitleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
TabTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TabTitleLabel.Parent = TabFrame

-- Main GUI Frame
local MainGuiPositionHidden = UDim2.new(0.5, -200, 0.5, -125)
local MainGuiFrame = Instance.new("Frame")
MainGuiFrame.Name = "MainGuiFrame"
MainGuiFrame.Size = UDim2.new(0, 400, 0, 250)
MainGuiFrame.Position = MainGuiPositionHidden
MainGuiFrame.BackgroundTransparency = 1
MainGuiFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainGuiFrame.BorderSizePixel = 0
MainGuiFrame.Visible = false
MainGuiFrame.Parent = ScreenGui

local CornerMain = Instance.new("UICorner")
CornerMain.CornerRadius = UDim.new(0, 10)
CornerMain.Parent = MainGuiFrame

local StrokeMain = Instance.new("UIStroke")
StrokeMain.Color = Color3.new(1, 0, 0)
StrokeMain.Thickness = 3
StrokeMain.Transparency = 1
StrokeMain.Parent = MainGuiFrame

local MainGuiTitle = Instance.new("TextLabel")
MainGuiTitle.Name = "MainGuiTitle"
MainGuiTitle.Size = UDim2.new(1, 0, 0, 30)
MainGuiTitle.Position = UDim2.new(0, 0, 0, 5)
MainGuiTitle.BackgroundTransparency = 1
MainGuiTitle.TextColor3 = Color3.new(1, 0, 0)
MainGuiTitle.Text = "Vietnamese Hub"
MainGuiTitle.TextSize = 18
MainGuiTitle.Font = Enum.Font.GothamBold
MainGuiTitle.TextStrokeTransparency = 0.3
MainGuiTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
MainGuiTitle.TextTransparency = 1
MainGuiTitle.Parent = MainGuiFrame

local TabSelectionFrame = Instance.new("Frame")
TabSelectionFrame.Name = "TabSelectionFrame"
TabSelectionFrame.Size = UDim2.new(0, 80, 1, -50)
TabSelectionFrame.Position = UDim2.new(0, 10, 0, 40)
TabSelectionFrame.BackgroundTransparency = 1
TabSelectionFrame.BorderSizePixel = 0
TabSelectionFrame.Parent = MainGuiFrame

local ListLayoutTabs = Instance.new("UIListLayout")
ListLayoutTabs.Parent = TabSelectionFrame
ListLayoutTabs.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutTabs.Padding = UDim.new(0, 5)
ListLayoutTabs.HorizontalAlignment = Enum.HorizontalAlignment.Center

local DividerLine = Instance.new("Frame")
DividerLine.Name = "DividerLine"
DividerLine.Size = UDim2.new(0, 2, 1, -50)
DividerLine.Position = UDim2.new(0, 92, 0, 40)
DividerLine.BackgroundColor3 = Color3.new(1, 0, 0)
DividerLine.BackgroundTransparency = 1
DividerLine.BorderSizePixel = 0
DividerLine.Parent = MainGuiFrame

local CornerDivider = Instance.new("UICorner")
CornerDivider.CornerRadius = UDim.new(1, 0)
CornerDivider.Parent = DividerLine

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -106, 1, -50)
ContentFrame.Position = UDim2.new(0, 100, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainGuiFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.new(1, 0, 0)
ScrollFrame.ScrollBarImageTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ClipsDescendants = true
ScrollFrame.Parent = ContentFrame

local ListLayoutContent = Instance.new("UIListLayout")
ListLayoutContent.Parent = ScrollFrame
ListLayoutContent.SortOrder = Enum.SortOrder.LayoutOrder
ListLayoutContent.Padding = UDim.new(0, 10)

-- ////////////////////////////////////////////////////
-- // FEATURE FRAMES (Content)
-- ////////////////////////////////////////////////////

-- Fly Frame (Info Tab)
local FlyFrame = Instance.new("Frame")
FlyFrame.Name = "FlyFrame"
FlyFrame.Size = UDim2.new(1, -10, 0, 50)
FlyFrame.Position = UDim2.new(0, 5, 0, 0)
FlyFrame.BackgroundTransparency = 0.7
FlyFrame.BackgroundColor3 = Color3.new(1, 0, 0)
FlyFrame.BorderSizePixel = 0
FlyFrame.LayoutOrder = 1
FlyFrame.Parent = ScrollFrame
FlyFrame.Visible = false

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Name = "FlyLabel"
FlyLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
FlyLabel.Position = UDim2.new(0, 15, 0, 5)
FlyLabel.BackgroundTransparency = 1
FlyLabel.TextColor3 = Color3.new(1, 1, 1)
FlyLabel.Text = "Tiktok: @Vietnamsehub"
FlyLabel.TextSize = 18
FlyLabel.Font = Enum.Font.GothamBold
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.TextYAlignment = Enum.TextYAlignment.Center
FlyLabel.Parent = FlyFrame

local FlyDescription = Instance.new("TextLabel")
FlyDescription.Name = "FlyDescription"
FlyDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
FlyDescription.Position = UDim2.new(0, 15, 0.6, -5)
FlyDescription.BackgroundTransparency = 1
FlyDescription.TextColor3 = Color3.new(0.7, 0.7, 0.7)
FlyDescription.Text = "Follow để cập nhật script mới"
FlyDescription.TextSize = 12
FlyDescription.Font = Enum.Font.Gotham
FlyDescription.TextXAlignment = Enum.TextXAlignment.Left
FlyDescription.TextYAlignment = Enum.TextYAlignment.Top
FlyDescription.Parent = FlyFrame

-- Jump Frame (Main Tab)
local JumpFrame = Instance.new("Frame")
JumpFrame.Name = "JumpFrame"
JumpFrame.Size = UDim2.new(1, -10, 0, 50)
JumpFrame.Position = UDim2.new(0, 5, 0, 0)
JumpFrame.BackgroundTransparency = 0.7
JumpFrame.BackgroundColor3 = Color3.new(0, 1, 0)
JumpFrame.BorderSizePixel = 0
JumpFrame.LayoutOrder = 3
JumpFrame.Parent = ScrollFrame

local CornerJump = Instance.new("UICorner")
CornerJump.CornerRadius = UDim.new(0, 8)
CornerJump.Parent = JumpFrame

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Name = "JumpLabel"
JumpLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
JumpLabel.Position = UDim2.new(0, 15, 0, 5)
JumpLabel.BackgroundTransparency = 1
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Text = "Nhảy trên không"
JumpLabel.TextSize = 18
JumpLabel.Font = Enum.Font.GothamBold
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.TextYAlignment = Enum.TextYAlignment.Center
JumpLabel.Parent = JumpFrame

local JumpDescription = Instance.new("TextLabel")
JumpDescription.Name = "JumpDescription"
JumpDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
JumpDescription.Position = UDim2.new(0, 15, 0.6, -5)
JumpDescription.BackgroundTransparency = 1
JumpDescription.TextColor3 = Color3.new(0.7, 0.7, 0.7)
JumpDescription.Text = "Nhảy trên không do no copy"
JumpDescription.TextSize = 12
JumpDescription.Font = Enum.Font.Gotham
JumpDescription.TextXAlignment = Enum.TextXAlignment.Left
JumpDescription.TextYAlignment = Enum.TextYAlignment.Top
JumpDescription.Parent = JumpFrame

local JumpToggleContainer = Instance.new("Frame")
JumpToggleContainer.Name = "JumpToggleContainer"
JumpToggleContainer.Size = UDim2.new(0, 60, 0, 26)
JumpToggleContainer.Position = UDim2.new(1, -70, 0.5, -13)
JumpToggleContainer.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
JumpToggleContainer.BorderSizePixel = 0
JumpToggleContainer.Parent = JumpFrame

local CornerJumpToggleContainer = Instance.new("UICorner")
CornerJumpToggleContainer.CornerRadius = UDim.new(0, 13)
CornerJumpToggleContainer.Parent = JumpToggleContainer

local StrokeJumpToggleContainer = Instance.new("UIStroke")
StrokeJumpToggleContainer.Color = Color3.new(1, 0, 0)
StrokeJumpToggleContainer.Thickness = 0
StrokeJumpToggleContainer.Parent = JumpToggleContainer

local JumpToggleButton = Instance.new("Frame")
JumpToggleButton.Name = "JumpToggleButton"
JumpToggleButton.Size = UDim2.new(0, 22, 0, 22)
JumpToggleButton.Position = UDim2.new(0, 2, 0.5, -11)
JumpToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
JumpToggleButton.BorderSizePixel = 0
JumpToggleButton.Parent = JumpToggleContainer

local CornerJumpToggleButton = Instance.new("UICorner")
CornerJumpToggleButton.CornerRadius = UDim.new(0, 11)
CornerJumpToggleButton.Parent = JumpToggleButton

-- Part Transparent Frame (Settings Tab)
local TransparentFrame = Instance.new("Frame")
TransparentFrame.Name = "TransparentFrame"
TransparentFrame.Size = UDim2.new(1, -10, 0, 50)
TransparentFrame.Position = UDim2.new(0, 5, 0, 0)
TransparentFrame.BackgroundTransparency = 0.7
TransparentFrame.BackgroundColor3 = Color3.new(1, 0.5, 0)
TransparentFrame.BorderSizePixel = 0
TransparentFrame.LayoutOrder = 1
TransparentFrame.Parent = ScrollFrame
TransparentFrame.Visible = false

local CornerTransparent = Instance.new("UICorner")
CornerTransparent.CornerRadius = UDim.new(0, 8)
CornerTransparent.Parent = TransparentFrame

local TransparentLabel = Instance.new("TextLabel")
TransparentLabel.Name = "TransparentLabel"
TransparentLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
TransparentLabel.Position = UDim2.new(0, 15, 0, 5)
TransparentLabel.BackgroundTransparency = 1
TransparentLabel.TextColor3 = Color3.new(1, 1, 1)
TransparentLabel.Text = "Part Trong suốt"
TransparentLabel.TextSize = 18
TransparentLabel.Font = Enum.Font.GothamBold
TransparentLabel.TextXAlignment = Enum.TextXAlignment.Left
TransparentLabel.TextYAlignment = Enum.TextYAlignment.Center
TransparentLabel.Parent = TransparentFrame

local TransparentDescription = Instance.new("TextLabel")
TransparentDescription.Name = "TransparentDescription"
TransparentDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
TransparentDescription.Position = UDim2.new(0, 15, 0.6, -5)
TransparentDescription.BackgroundTransparency = 1
TransparentDescription.TextColor3 = Color3.new(0.7, 0.7, 0.7)
TransparentDescription.Text = "Làm trong suốt tất cả part"
TransparentDescription.TextSize = 12
TransparentDescription.Font = Enum.Font.Gotham
TransparentDescription.TextXAlignment = Enum.TextXAlignment.Left
TransparentDescription.TextYAlignment = Enum.TextYAlignment.Top
TransparentDescription.Parent = TransparentFrame

local TransparentToggleContainer = Instance.new("Frame")
TransparentToggleContainer.Name = "TransparentToggleContainer"
TransparentToggleContainer.Size = UDim2.new(0, 60, 0, 26)
TransparentToggleContainer.Position = UDim2.new(1, -70, 0.5, -13)
TransparentToggleContainer.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
TransparentToggleContainer.BorderSizePixel = 0
TransparentToggleContainer.Parent = TransparentFrame

local CornerTransparentToggleContainer = Instance.new("UICorner")
CornerTransparentToggleContainer.CornerRadius = UDim.new(0, 13)
CornerTransparentToggleContainer.Parent = TransparentToggleContainer

local StrokeTransparentToggleContainer = Instance.new("UIStroke")
StrokeTransparentToggleContainer.Color = Color3.new(1, 0, 0)
StrokeTransparentToggleContainer.Thickness = 0
StrokeTransparentToggleContainer.Parent = TransparentToggleContainer

local TransparentToggleButton = Instance.new("Frame")
TransparentToggleButton.Name = "TransparentToggleButton"
TransparentToggleButton.Size = UDim2.new(0, 22, 0, 22)
TransparentToggleButton.Position = UDim2.new(0, 2, 0.5, -11)
TransparentToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
TransparentToggleButton.BorderSizePixel = 0
TransparentToggleButton.Parent = TransparentToggleContainer

local CornerTransparentToggleButton = Instance.new("UICorner")
CornerTransparentToggleButton.CornerRadius = UDim.new(0, 11)
CornerTransparentToggleButton.Parent = TransparentToggleButton

-- Nhảy Cao (High Jump) Frame (Main Tab)
local NhayCaoFrame = Instance.new("Frame")
NhayCaoFrame.Name = "NhayCaoFrame"
NhayCaoFrame.Size = UDim2.new(1, -10, 0, 50)
NhayCaoFrame.Position = UDim2.new(0, 5, 0, 0)
NhayCaoFrame.BackgroundTransparency = 0.7
NhayCaoFrame.BackgroundColor3 = Color3.new(0, 0, 1)
NhayCaoFrame.BorderSizePixel = 0
NhayCaoFrame.LayoutOrder = 2
NhayCaoFrame.Parent = ScrollFrame

local CornerNhayCao = Instance.new("UICorner")
CornerNhayCao.CornerRadius = UDim.new(0, 8)
CornerNhayCao.Parent = NhayCaoFrame

local NhayCaoLabel = Instance.new("TextLabel")
NhayCaoLabel.Name = "NhayCaoLabel"
NhayCaoLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
NhayCaoLabel.Position = UDim2.new(0, 15, 0, 5)
NhayCaoLabel.BackgroundTransparency = 1
NhayCaoLabel.TextColor3 = Color3.new(1, 1, 1)
NhayCaoLabel.Text = "Nhảy Cao"
NhayCaoLabel.TextSize = 18
NhayCaoLabel.Font = Enum.Font.GothamBold
NhayCaoLabel.TextXAlignment = Enum.TextXAlignment.Left
NhayCaoLabel.TextYAlignment = Enum.TextYAlignment.Center
NhayCaoLabel.Parent = NhayCaoFrame

local NhayCaoDescription = Instance.new("TextLabel")
NhayCaoDescription.Name = "NhayCaoDescription"
NhayCaoDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
NhayCaoDescription.Position = UDim2.new(0, 15, 0.6, -5)
NhayCaoDescription.BackgroundTransparency = 1
NhayCaoDescription.TextColor3 = Color3.new(0.7, 0.7, 0.7)
NhayCaoDescription.Text = "Gravity Nhảy cao"
NhayCaoDescription.TextSize = 12
NhayCaoDescription.Font = Enum.Font.Gotham
NhayCaoDescription.TextXAlignment = Enum.TextXAlignment.Left
NhayCaoDescription.TextYAlignment = Enum.TextYAlignment.Top
NhayCaoDescription.Parent = NhayCaoFrame

local NhayCaoToggleContainer = Instance.new("Frame")
NhayCaoToggleContainer.Name = "NhayCaoToggleContainer"
NhayCaoToggleContainer.Size = UDim2.new(0, 60, 0, 26)
NhayCaoToggleContainer.Position = UDim2.new(1, -70, 0.5, -13)
NhayCaoToggleContainer.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
NhayCaoToggleContainer.BorderSizePixel = 0
NhayCaoToggleContainer.Parent = NhayCaoFrame

local CornerNhayCaoToggleContainer = Instance.new("UICorner")
CornerNhayCaoToggleContainer.CornerRadius = UDim.new(0, 13)
CornerNhayCaoToggleContainer.Parent = NhayCaoToggleContainer

local StrokeNhayCaoToggleContainer = Instance.new("UIStroke")
StrokeNhayCaoToggleContainer.Color = Color3.new(1, 0, 0)
StrokeNhayCaoToggleContainer.Thickness = 0
StrokeNhayCaoToggleContainer.Parent = NhayCaoToggleContainer

local NhayCaoToggleButton = Instance.new("Frame")
NhayCaoToggleButton.Name = "NhayCaoToggleButton"
NhayCaoToggleButton.Size = UDim2.new(0, 22, 0, 22)
NhayCaoToggleButton.Position = UDim2.new(0, 2, 0.5, -11)
NhayCaoToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
NhayCaoToggleButton.BorderSizePixel = 0
NhayCaoToggleButton.Parent = NhayCaoToggleContainer

local CornerNhayCaoToggleButton = Instance.new("UICorner")
CornerNhayCaoToggleButton.CornerRadius = UDim.new(0, 11)
CornerNhayCaoToggleButton.Parent = NhayCaoToggleButton

-- ESP Player Frame (ESP Tab)
local EspPlayerFrame = Instance.new("Frame")
EspPlayerFrame.Name = "EspPlayerFrame"
EspPlayerFrame.Size = UDim2.new(1, -10, 0, 50)
EspPlayerFrame.Position = UDim2.new(0, 5, 0, 0)
EspPlayerFrame.BackgroundTransparency = 0.7
EspPlayerFrame.BackgroundColor3 = Color3.new(1, 0.5, 1)
EspPlayerFrame.BorderSizePixel = 0
EspPlayerFrame.LayoutOrder = 1
EspPlayerFrame.Parent = ScrollFrame
EspPlayerFrame.Visible = false

local CornerEspPlayer = Instance.new("UICorner")
CornerEspPlayer.CornerRadius = UDim.new(0, 8)
CornerEspPlayer.Parent = EspPlayerFrame

local EspPlayerLabel = Instance.new("TextLabel")
EspPlayerLabel.Name = "EspPlayerLabel"
EspPlayerLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
EspPlayerLabel.Position = UDim2.new(0, 15, 0, 5)
EspPlayerLabel.BackgroundTransparency = 1
EspPlayerLabel.TextColor3 = Color3.new(1, 1, 1)
EspPlayerLabel.Text = "ESP Player"
EspPlayerLabel.TextSize = 18
EspPlayerLabel.Font = Enum.Font.GothamBold
EspPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
EspPlayerLabel.TextYAlignment = Enum.TextYAlignment.Center
EspPlayerLabel.Parent = EspPlayerFrame

local EspPlayerDescription = Instance.new("TextLabel")
EspPlayerDescription.Name = "EspPlayerDescription"
EspPlayerDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
EspPlayerDescription.Position = UDim2.new(0, 15, 0.6, -5)
EspPlayerDescription.BackgroundTransparency = 1
EspPlayerDescription.TextColor3 = Color3.new(0.7, 0.7, 0.7)
EspPlayerDescription.Text = "Biết người chơi đang ở đâu"
EspPlayerDescription.TextSize = 12
EspPlayerDescription.Font = Enum.Font.Gotham
EspPlayerDescription.TextXAlignment = Enum.TextXAlignment.Left
EspPlayerDescription.TextYAlignment = Enum.TextYAlignment.Top
EspPlayerDescription.Parent = EspPlayerFrame

local EspPlayerToggleContainer = Instance.new("Frame")
EspPlayerToggleContainer.Name = "EspPlayerToggleContainer"
EspPlayerToggleContainer.Size = UDim2.new(0, 60, 0, 26)
EspPlayerToggleContainer.Position = UDim2.new(1, -70, 0.5, -13)
EspPlayerToggleContainer.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
EspPlayerToggleContainer.BorderSizePixel = 0
EspPlayerToggleContainer.Parent = EspPlayerFrame

local CornerEspPlayerToggleContainer = Instance.new("UICorner")
CornerEspPlayerToggleContainer.CornerRadius = UDim.new(0, 13)
CornerEspPlayerToggleContainer.Parent = EspPlayerToggleContainer

local StrokeEspPlayerToggleContainer = Instance.new("UIStroke")
StrokeEspPlayerToggleContainer.Color = Color3.new(1, 0, 0)
StrokeEspPlayerToggleContainer.Thickness = 0
StrokeEspPlayerToggleContainer.Parent = EspPlayerToggleContainer

local EspPlayerToggleButton = Instance.new("Frame")
EspPlayerToggleButton.Name = "EspPlayerToggleButton"
EspPlayerToggleButton.Size = UDim2.new(0, 22, 0, 22)
EspPlayerToggleButton.Position = UDim2.new(0, 2, 0.5, -11)
EspPlayerToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
EspPlayerToggleButton.BorderSizePixel = 0
EspPlayerToggleButton.Parent = EspPlayerToggleContainer

local CornerEspPlayerToggleButton = Instance.new("UICorner")
CornerEspPlayerToggleButton.CornerRadius = UDim.new(0, 11)
CornerEspPlayerToggleButton.Parent = EspPlayerToggleButton

-- Aimbot Frame (Main Tab)
local AimbotFrame = Instance.new("Frame")
AimbotFrame.Name = "AimbotFrame"
AimbotFrame.Size = UDim2.new(1, -10, 0, 50)
AimbotFrame.Position = UDim2.new(0, 5, 0, 0)
AimbotFrame.BackgroundTransparency = 0.7
AimbotFrame.BackgroundColor3 = Color3.new(1, 1, 0)
AimbotFrame.BorderSizePixel = 0
AimbotFrame.LayoutOrder = 5
AimbotFrame.Parent = ScrollFrame

local CornerAimbot = Instance.new("UICorner")
CornerAimbot.CornerRadius = UDim.new(0, 8)
CornerAimbot.Parent = AimbotFrame

local AimbotLabel = Instance.new("TextLabel")
AimbotLabel.Name = "AimbotLabel"
AimbotLabel.Size = UDim2.new(0.6, -10, 0.6, 0)
AimbotLabel.Position = UDim2.new(0, 15, 0, 5)
AimbotLabel.BackgroundTransparency = 1
AimbotLabel.TextColor3 = Color3.new(1, 1, 1)
AimbotLabel.Text = "Aimbot"
AimbotLabel.TextSize = 18
AimbotLabel.Font = Enum.Font.GothamBold
AimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
AimbotLabel.TextYAlignment = Enum.TextYAlignment.Center
AimbotLabel.Parent = AimbotFrame

local AimbotDescription = Instance.new("TextLabel")
AimbotDescription.Name = "AimbotDescription"
AimbotDescription.Size = UDim2.new(0.6, -10, 0.4, 0)
AimbotDescription.Position = UDim2.new(0, 15, 0.6, -5)
AimbotDescription.BackgroundTransparency = 1
AimbotDescription.TextColor3 = Color3.new(0.7, 0
