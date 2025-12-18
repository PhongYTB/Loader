local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local isTeleporting = false
local isStealing = false
local fastStealOn = true  -- Mặc định bật fast steal

-- Auto load Fast Steal khi vào game
local fastStealLoop = nil
local fastStealConn = nil

-- Các function từ code gốc
local function getCharacter()
    local char = LocalPlayer.Character
    if not char or not char.Parent then
        char = LocalPlayer.CharacterAdded:Wait()
    end
    return char
end

local function getMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in ipairs(plots:GetChildren()) do
        local label = plot:FindFirstChild("PlotSign")
        and plot.PlotSign:FindFirstChild("SurfaceGui")
        and plot.PlotSign.SurfaceGui:FindFirstChild("Frame")
        and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
        if label then
            local t = (label.ContentText or label.Text or "")
            if t:find(LocalPlayer.DisplayName) and t:find("Base") then
                return plot
            end
        end
    end
    return nil
end

local function getDeliveryHitbox()
    local myPlot = getMyPlot()
    if not myPlot then return nil end
    local delivery = myPlot:FindFirstChild("DeliveryHitbox") or myPlot:FindFirstChild("DeliveryHitbox", true)
    if delivery and delivery:IsA("BasePart") then
        return delivery
    end
    return nil
end

-- Function Fast Steal tự động load
local function patchPrompt(prompt)
    if not prompt:IsA("ProximityPrompt") then return end
    local ok = pcall(function()
        if prompt.HoldDuration > 0.01 then
            prompt.HoldDuration = 0.01
        end
    end)
    if not ok then
        -- Bỏ qua lỗi
    end
end

local function startFastSteal()
    if not fastStealOn then return end
    
    -- Xử lý tất cả prompts hiện có
    task.spawn(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                patchPrompt(obj)
            end
        end
    end)
    
    -- Vòng lặp kiểm tra liên tục
    if not fastStealLoop then
        fastStealLoop = task.spawn(function()
            while fastStealOn do
                local ok, err = pcall(function()
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") then
                            patchPrompt(obj)
                        end
                    end
                end)
                if not ok then
                    warn("[PHONG SCRIPT] FastSteal loop error:", err)
                end
                task.wait(0.08)
            end
            fastStealLoop = nil
        end)
    end
    
    -- Lắng nghe prompt mới
    if fastStealConn then fastStealConn:Disconnect() end
    fastStealConn = workspace.DescendantAdded:Connect(function(obj)
        if fastStealOn and obj:IsA("ProximityPrompt") then
            patchPrompt(obj)
        end
    end)
end

-- Function Instant Steal từ code gốc (chỉ teleport 1 lần)
local function doInstantSteal()
    if isStealing then return end
    
    isStealing = true
    
    -- Cập nhật UI
    if uiStatus then
        uiStatus.Text = "STEALING..."
        uiStatus.TextColor3 = Color3.fromRGB(100, 200, 100)
    end
    
    local character = getCharacter()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        isStealing = false
        if uiStatus then
            uiStatus.Text = "ERROR: NO HRP"
            uiStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.wait(1.5)
            uiStatus.Text = "READY"
            uiStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        return 
    end
    
    local delivery = getDeliveryHitbox()
    if not delivery then 
        isStealing = false
        if uiStatus then
            uiStatus.Text = "NO DELIVERY"
            uiStatus.TextColor3 = Color3.fromRGB(255, 150, 50)
            task.wait(1.5)
            uiStatus.Text = "READY"
            uiStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        return 
    end
    
    -- Tính vị trí đích TỪ CODE GỐC
    local targetCF = delivery.CFrame + delivery.CFrame.LookVector * 3 + Vector3.new(0, 3, 0)
    
    -- Teleport 1 LẦN tới delivery (không teleport lại)
    hrp.CFrame = targetCF
    
    -- Cập nhật trạng thái hoàn thành
    task.wait(0.3)
    
    if uiStatus then
        uiStatus.Text = "COMPLETE ✓"
        uiStatus.TextColor3 = Color3.fromRGB(100, 200, 100)
    end
    
    -- Reset sau 1.5 giây
    task.wait(1.2)
    isStealing = false
    
    if uiStatus then
        uiStatus.Text = "READY"
        uiStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

local function createUI()
    local guiParent = game:GetService("CoreGui")
    pcall(function()
        if gethui then
            local h = gethui()
            if h then guiParent = h end
        end
    end)
    
    local old = guiParent:FindFirstChild("PhongScript_InstantSteal")
    if old then old:Destroy() end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PhongScript_InstantSteal"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    screenGui.Parent = guiParent
    
    -- Frame chính - chỉ có Instant Steal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 220, 0, 130)
    mainFrame.Position = UDim2.new(1, -230, 0.02, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 40, 70)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = true
    mainFrame.Parent = screenGui
    
    -- Bo tròn 4 góc
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 14)
    cardCorner.Parent = mainFrame
    
    -- Gradient màu xanh
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(30, 60, 120)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 40, 90)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(15, 30, 70))
    }
    gradient.Rotation = 90
    gradient.Parent = mainFrame
    
    -- Phần header tiêu đề (có thể kéo TOÀN BỘ FRAME)
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(30, 50, 90)
    header.BackgroundTransparency = 0.3
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 14)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, -20, 0.5, 0)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.Font = Enum.Font.GothamBold
    title.Text = "PHONG SCRIPT"
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(150, 200, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.BackgroundTransparency = 1
    subtitle.Size = UDim2.new(1, -20, 0.5, 0)
    subtitle.Position = UDim2.new(0, 15, 0, 20)
    subtitle.Font = Enum.Font.GothamSemibold
    subtitle.Text = "INSTANT STEAL 🚀"
    subtitle.TextSize = 14
    subtitle.TextColor3 = Color3.fromRGB(100, 180, 255)
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header
    
    -- Nút Instant Steal chính
    local stealBtn = Instance.new("TextButton")
    stealBtn.Name = "StealBtn"
    stealBtn.Size = UDim2.new(1, -30, 0, 60)
    stealBtn.Position = UDim2.new(0, 15, 0, 45)
    stealBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
    stealBtn.AutoButtonColor = true
    stealBtn.Font = Enum.Font.GothamBold
    stealBtn.Text = "INSTANT STEAL"
    stealBtn.TextSize = 18
    stealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stealBtn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = stealBtn
    
    -- Trạng thái steal
    local statusFrame = Instance.new("Frame")
    statusFrame.Name = "StatusFrame"
    statusFrame.Size = UDim2.new(1, -30, 0, 25)
    statusFrame.Position = UDim2.new(0, 15, 0, 110)
    statusFrame.BackgroundTransparency = 1
    statusFrame.Parent = mainFrame
    
    uiStatus = Instance.new("TextLabel")
    uiStatus.BackgroundTransparency = 1
    uiStatus.Size = UDim2.new(1, 0, 1, 0)
    uiStatus.Font = Enum.Font.GothamSemibold
    uiStatus.Text = "READY"
    uiStatus.TextSize = 14
    uiStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    uiStatus.TextXAlignment = Enum.TextXAlignment.Center
    uiStatus.Parent = statusFrame
    
    -- Hiệu ứng hover cho nút
    stealBtn.MouseEnter:Connect(function()
        if not isStealing then
            stealBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
        end
    end)
    
    stealBtn.MouseLeave:Connect(function()
        if not isStealing then
            stealBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
        end
    end)
    
    -- Tính năng kéo di chuyển menu (TOÀN BỘ FRAME có thể kéo)
    do
        local dragging = false
        local dragInput, dragStart, startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
        
        -- Có thể kéo từ TOÀN BỘ FRAME
        mainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
                dragInput = input
                
                -- Hiệu ứng khi kéo
                mainFrame.BackgroundTransparency = 0.15
                
                input.Changed:Connect(function(i)
                    if i.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        mainFrame.BackgroundTransparency = 0.05
                    end
                end)
            end
        end)
        
        mainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input == dragInput then
                update(input)
            end
        end)
        
        -- Cũng có thể kéo từ header
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
                dragInput = input
                
                mainFrame.BackgroundTransparency = 0.15
                
                input.Changed:Connect(function(i)
                    if i.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        mainFrame.BackgroundTransparency = 0.05
                    end
                end)
            end
        end)
    end
    
    -- Sự kiện click nút Instant Steal
    stealBtn.MouseButton1Click:Connect(function()
        if not isStealing then
            -- Hiệu ứng click
            stealBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 80)
            stealBtn.Text = "STEALING..."
            
            -- Thực hiện Instant Steal (1 lần teleport)
            doInstantSteal()
            
            -- Reset nút sau khi hoàn thành
            if not isStealing then
                stealBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
                stealBtn.Text = "INSTANT STEAL"
            end
        end
    end)
    
    -- Border tinh tế
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(50, 100, 180)
    border.Thickness = 2
    border.Parent = mainFrame
    
    -- Shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, -4, 0, -4)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = mainFrame
    shadow.ZIndex = -1
    
    -- Nút reset vị trí về góc phải
    local resetBtn = Instance.new("TextButton")
    resetBtn.Name = "ResetBtn"
    resetBtn.Size = UDim2.new(0, 20, 0, 20)
    resetBtn.Position = UDim2.new(1, -25, 0, 5)
    resetBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 160)
    resetBtn.Text = "↺"
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 12
    resetBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    resetBtn.Parent = header
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(1, 0)
    resetCorner.Parent = resetBtn
    
    resetBtn.MouseButton1Click:Connect(function()
        mainFrame.Position = UDim2.new(1, -230, 0.02, 0)
    end)
    
    return {
        MainFrame = mainFrame,
        StealBtn = stealBtn,
        StatusLabel = uiStatus
    }
end

-- Khởi tạo UI
local ui = createUI()

-- Tự động load Fast Steal khi vào game
task.wait(1)
startFastSteal()

-- Thông báo khi load
print("[PHONG SCRIPT] Loaded Successfully!")
print("Features: Instant Steal (1-time teleport)")
print("UI Size: 220x130 (Fully Movable)")
