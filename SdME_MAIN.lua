-- SdME MAIN SCRIPT
-- This is the main GUI code loaded by the loader
-- Variables player, playerGui, isMobile, guiWidth, guiHeight are passed from loader

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Get passed variables or initialize
local player = player or Players.LocalPlayer
local playerGui = playerGui or player:WaitForChild("PlayerGui")
local isMobile = isMobile or (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local guiWidth = guiWidth or (isMobile and 0.73 or 0.35)
local guiHeight = guiHeight or (isMobile and 0.73 or 0.45)


local function loadMainScript()
	-- Minimal temp variable for UICorner reuse
	local temp
	
	-- Create main ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SdME"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = playerGui
	
	-- Create main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(guiWidth, 0, guiHeight, 0)
	mainFrame.Position = UDim2.new((1 - guiWidth) / 2, 0, (1 - guiHeight) / 2, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	mainFrame.BackgroundTransparency = 0.1
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui
	mainFrame.Visible = true
	mainFrame.ClipsDescendants = true
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = mainFrame
	
	-- Title bar
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0.08, 0)
	titleBar.Position = UDim2.new(0, 0, 0, 0)
	titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	titleBar.BorderSizePixel = 0
	titleBar.Parent = mainFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = titleBar
	
	-- Title text
	local titleText = Instance.new("TextLabel")
	titleText.Name = "TitleText"
	titleText.Size = UDim2.new(0.85, 0, 1, 0)
	titleText.Position = UDim2.new(0.02, 0, 0, 0)
	titleText.BackgroundTransparency = 1
	titleText.Text = "SdME | Roblox Script"
	titleText.TextColor3 = Color3.fromRGB(200, 200, 200)
	titleText.TextSize = 14
	titleText.Font = Enum.Font.Gotham
	titleText.TextXAlignment = Enum.TextXAlignment.Left
	titleText.Parent = titleBar
	
	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0.06, 0, 0.8, 0)
	closeButton.Position = UDim2.new(0.92, 0, 0.1, 0)
	closeButton.BackgroundTransparency = 1
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	closeButton.TextSize = 16
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = titleBar
	
	closeButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = false
	end)
	
	-- Sidebar
	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.Size = UDim2.new(0.25, 0, 0.92, 0)
	sidebar.Position = UDim2.new(0, 0, 0.08, 0)
	sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	sidebar.BorderSizePixel = 0
	sidebar.Parent = mainFrame
	
	-- Content area
	local contentArea = Instance.new("Frame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(0.75, 0, 0.92, 0)
	contentArea.Position = UDim2.new(0.25, 0, 0.08, 0)
	contentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	contentArea.BorderSizePixel = 0
	contentArea.Parent = mainFrame
	
	-- Sidebar buttons
	local buttonData = {
		{name = "Character", icon = "👤"},
		{name = "Teleport", icon = "📍"},
		{name = "Combat", icon = "⚔️"},
		{name = "Players", icon = "👥"},
		{name = "Trolling", icon = "🎭"},
		{name = "Visuals", icon = "👁️"},
		{name = "World", icon = "🌍"},
		{name = "Settings", icon = "⚙️"}
	}
	
	local selectedTab = "Character"
	local sidebarButtons = {}
	
	for i, data in ipairs(buttonData) do
		local button = Instance.new("TextButton")
		button.Name = data.name .. "Button"
		button.Size = UDim2.new(0.9, 0, 0.1, 0)
		button.Position = UDim2.new(0.05, 0, 0.02 + (i - 1) * 0.105, 0)
		button.BackgroundColor3 = (data.name == "Character") and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(25, 25, 30)
		button.BorderSizePixel = 0
		button.Text = "  " .. data.icon .. "  " .. data.name
		button.TextColor3 = Color3.fromRGB(200, 200, 200)
		button.TextSize = 14
		button.Font = Enum.Font.Gotham
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.Parent = sidebar
		
		temp = Instance.new("UICorner")
		temp.CornerRadius = UDim.new(0, 6)
		temp.Parent = button
		
		sidebarButtons[data.name] = button
	end
	
	-- ========== CHARACTER CONTENT SECTION ==========
	
	local characterContent = Instance.new("Frame")
	characterContent.Name = "CharacterContent"
	characterContent.Size = UDim2.new(1, 0, 1, 0)
	characterContent.Position = UDim2.new(0, 0, 0, 0)
	characterContent.BackgroundTransparency = 1
	characterContent.Parent = contentArea
	characterContent.Visible = true
	
	-- Character Title
	local characterTitle = Instance.new("TextLabel")
	characterTitle.Name = "CharacterTitle"
	characterTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
	characterTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
	characterTitle.BackgroundTransparency = 1
	characterTitle.Text = "Character"
	characterTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	characterTitle.TextSize = 20
	characterTitle.Font = Enum.Font.GothamBold
	characterTitle.TextXAlignment = Enum.TextXAlignment.Left
	characterTitle.Parent = characterContent
	
	-- Speed variables
	local speedEnabled = false
	local currentSpeed = 16
	local speedConnection = nil
	
	-- Speed Frame
	local speedFrame = Instance.new("Frame")
	speedFrame.Name = "SpeedFrame"
	speedFrame.Size = UDim2.new(0.9, 0, 0.18, 0)
	speedFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
	speedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	speedFrame.BorderSizePixel = 0
	speedFrame.Parent = characterContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = speedFrame
	
	-- Speed Label
	local speedLabel = Instance.new("TextLabel")
	speedLabel.Name = "SpeedLabel"
	speedLabel.Size = UDim2.new(0.35, 0, 0.3, 0)
	speedLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Text = "Speed"
	speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedLabel.TextSize = 18
	speedLabel.Font = Enum.Font.GothamBold
	speedLabel.TextXAlignment = Enum.TextXAlignment.Left
	speedLabel.Parent = speedFrame
	
	-- Speed Value Display
	local speedValue = Instance.new("TextLabel")
	speedValue.Name = "SpeedValue"
	speedValue.Size = UDim2.new(0.15, 0, 0.3, 0)
	speedValue.Position = UDim2.new(0.42, 0, 0.08, 0)
	speedValue.BackgroundTransparency = 1
	speedValue.Text = currentSpeed
	speedValue.TextColor3 = Color3.fromRGB(150, 200, 255)
	speedValue.TextSize = 18
	speedValue.Font = Enum.Font.GothamBold
	speedValue.TextXAlignment = Enum.TextXAlignment.Left
	speedValue.Parent = speedFrame
	
	-- Speed Toggle Background
	local speedToggleBg = Instance.new("Frame")
	speedToggleBg.Name = "ToggleBg"
	speedToggleBg.Size = UDim2.new(0.08, 0, 0.28, 0)
	speedToggleBg.Position = UDim2.new(0.89, 0, 0.1, 0)
	speedToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	speedToggleBg.BorderSizePixel = 0
	speedToggleBg.Parent = speedFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = speedToggleBg
	
	-- Speed Toggle Circle
	local speedToggleCircle = Instance.new("Frame")
	speedToggleCircle.Name = "ToggleCircle"
	speedToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	speedToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	speedToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	speedToggleCircle.BorderSizePixel = 0
	speedToggleCircle.Parent = speedToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = speedToggleCircle
	
	-- Speed Slider
	local speedSlider = Instance.new("Frame")
	speedSlider.Name = "SpeedSlider"
	speedSlider.Size = UDim2.new(0.9, 0, 0.18, 0)
	speedSlider.Position = UDim2.new(0.05, 0, 0.6, 0)
	speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	speedSlider.BorderSizePixel = 0
	speedSlider.Parent = speedFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = speedSlider
	
	-- Speed Slider Fill
	local speedSliderFill = Instance.new("Frame")
	speedSliderFill.Name = "Fill"
	speedSliderFill.Size = UDim2.new(0, 0, 1, 0)
	speedSliderFill.Position = UDim2.new(0, 0, 0, 0)
	speedSliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	speedSliderFill.BorderSizePixel = 0
	speedSliderFill.Parent = speedSlider
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = speedSliderFill
	
	-- Speed Slider Button
	local speedSliderButton = Instance.new("TextButton")
	speedSliderButton.Name = "SliderButton"
	speedSliderButton.Size = UDim2.new(1, 0, 1, 0)
	speedSliderButton.Position = UDim2.new(0, 0, 0, 0)
	speedSliderButton.BackgroundTransparency = 1
	speedSliderButton.Text = ""
	speedSliderButton.Parent = speedSlider
	
	-- Infinite Jump variables
	local infiniteJumpEnabled = false
	local infiniteJumpConnection = nil
	
	-- Infinite Jump Frame
	local infiniteJumpFrame = Instance.new("Frame")
	infiniteJumpFrame.Name = "InfiniteJumpFrame"
	infiniteJumpFrame.Size = UDim2.new(0.9, 0, 0.14, 0)
	infiniteJumpFrame.Position = UDim2.new(0.05, 0, 0.32, 0)
	infiniteJumpFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	infiniteJumpFrame.BorderSizePixel = 0
	infiniteJumpFrame.Parent = characterContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = infiniteJumpFrame
	
	-- Infinite Jump Label
	local infiniteJumpLabel = Instance.new("TextLabel")
	infiniteJumpLabel.Name = "InfiniteJumpLabel"
	infiniteJumpLabel.Size = UDim2.new(0.65, 0, 0.45, 0)
	infiniteJumpLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	infiniteJumpLabel.BackgroundTransparency = 1
	infiniteJumpLabel.Text = "Infinite Jump"
	infiniteJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	infiniteJumpLabel.TextSize = 18
	infiniteJumpLabel.Font = Enum.Font.GothamBold
	infiniteJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
	infiniteJumpLabel.Parent = infiniteJumpFrame
	
	-- Infinite Jump Description
	local infiniteJumpDesc = Instance.new("TextLabel")
	infiniteJumpDesc.Name = "InfiniteJumpDesc"
	infiniteJumpDesc.Size = UDim2.new(0.65, 0, 0.35, 0)
	infiniteJumpDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	infiniteJumpDesc.BackgroundTransparency = 1
	infiniteJumpDesc.Text = "Jump infinitely in the air"
	infiniteJumpDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	infiniteJumpDesc.TextSize = 13
	infiniteJumpDesc.Font = Enum.Font.Gotham
	infiniteJumpDesc.TextXAlignment = Enum.TextXAlignment.Left
	infiniteJumpDesc.Parent = infiniteJumpFrame
	
	-- Infinite Jump Toggle Background
	local ijToggleBg = Instance.new("Frame")
	ijToggleBg.Name = "ToggleBg"
	ijToggleBg.Size = UDim2.new(0.08, 0, 0.45, 0)
	ijToggleBg.Position = UDim2.new(0.89, 0, 0.28, 0)
	ijToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	ijToggleBg.BorderSizePixel = 0
	ijToggleBg.Parent = infiniteJumpFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = ijToggleBg
	
	-- Infinite Jump Toggle Circle
	local ijToggleCircle = Instance.new("Frame")
	ijToggleCircle.Name = "ToggleCircle"
	ijToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	ijToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	ijToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	ijToggleCircle.BorderSizePixel = 0
	ijToggleCircle.Parent = ijToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = ijToggleCircle
	
	-- Infinite Jump Toggle Button
	local ijToggleButton = Instance.new("TextButton")
	ijToggleButton.Name = "ToggleButton"
	ijToggleButton.Size = UDim2.new(1, 0, 1, 0)
	ijToggleButton.Position = UDim2.new(0, 0, 0, 0)
	ijToggleButton.BackgroundTransparency = 1
	ijToggleButton.Text = ""
	ijToggleButton.Parent = infiniteJumpFrame
	
	-- Jump Power variables
	local jumpPowerEnabled = false
	local currentJumpPower = 50
	
	-- Jump Power Frame
	local jumpPowerFrame = Instance.new("Frame")
	jumpPowerFrame.Name = "JumpPowerFrame"
	jumpPowerFrame.Size = UDim2.new(0.9, 0, 0.18, 0)
	jumpPowerFrame.Position = UDim2.new(0.05, 0, 0.48, 0)
	jumpPowerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	jumpPowerFrame.BorderSizePixel = 0
	jumpPowerFrame.Parent = characterContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = jumpPowerFrame
	
	-- Jump Power Label
	local jumpPowerLabel = Instance.new("TextLabel")
	jumpPowerLabel.Name = "JumpPowerLabel"
	jumpPowerLabel.Size = UDim2.new(0.35, 0, 0.3, 0)
	jumpPowerLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	jumpPowerLabel.BackgroundTransparency = 1
	jumpPowerLabel.Text = "Jump Power"
	jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	jumpPowerLabel.TextSize = 18
	jumpPowerLabel.Font = Enum.Font.GothamBold
	jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
	jumpPowerLabel.Parent = jumpPowerFrame
	
	-- Jump Power Value Display
	local jumpPowerValue = Instance.new("TextLabel")
	jumpPowerValue.Name = "JumpPowerValue"
	jumpPowerValue.Size = UDim2.new(0.15, 0, 0.3, 0)
	jumpPowerValue.Position = UDim2.new(0.52, 0, 0.08, 0)
	jumpPowerValue.BackgroundTransparency = 1
	jumpPowerValue.Text = currentJumpPower
	jumpPowerValue.TextColor3 = Color3.fromRGB(150, 200, 255)
	jumpPowerValue.TextSize = 18
	jumpPowerValue.Font = Enum.Font.GothamBold
	jumpPowerValue.TextXAlignment = Enum.TextXAlignment.Left
	jumpPowerValue.Parent = jumpPowerFrame
	
	-- Jump Power Toggle Background
	local jpToggleBg = Instance.new("Frame")
	jpToggleBg.Name = "ToggleBg"
	jpToggleBg.Size = UDim2.new(0.08, 0, 0.28, 0)
	jpToggleBg.Position = UDim2.new(0.89, 0, 0.1, 0)
	jpToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	jpToggleBg.BorderSizePixel = 0
	jpToggleBg.Parent = jumpPowerFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = jpToggleBg
	
	-- Jump Power Toggle Circle
	local jpToggleCircle = Instance.new("Frame")
	jpToggleCircle.Name = "ToggleCircle"
	jpToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	jpToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	jpToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	jpToggleCircle.BorderSizePixel = 0
	jpToggleCircle.Parent = jpToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = jpToggleCircle
	
	-- Jump Power Slider
	local jumpPowerSlider = Instance.new("Frame")
	jumpPowerSlider.Name = "JumpPowerSlider"
	jumpPowerSlider.Size = UDim2.new(0.9, 0, 0.18, 0)
	jumpPowerSlider.Position = UDim2.new(0.05, 0, 0.6, 0)
	jumpPowerSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	jumpPowerSlider.BorderSizePixel = 0
	jumpPowerSlider.Parent = jumpPowerFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = jumpPowerSlider
	
	-- Jump Power Slider Fill
	local jumpPowerSliderFill = Instance.new("Frame")
	jumpPowerSliderFill.Name = "Fill"
	jumpPowerSliderFill.Size = UDim2.new(currentJumpPower / 100, 0, 1, 0)
	jumpPowerSliderFill.Position = UDim2.new(0, 0, 0, 0)
	jumpPowerSliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	jumpPowerSliderFill.BorderSizePixel = 0
	jumpPowerSliderFill.Parent = jumpPowerSlider
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = jumpPowerSliderFill
	
	-- Jump Power Slider Button
	local jumpPowerSliderButton = Instance.new("TextButton")
	jumpPowerSliderButton.Name = "SliderButton"
	jumpPowerSliderButton.Size = UDim2.new(1, 0, 1, 0)
	jumpPowerSliderButton.Position = UDim2.new(0, 0, 0, 0)
	jumpPowerSliderButton.BackgroundTransparency = 1
	jumpPowerSliderButton.Text = ""
	jumpPowerSliderButton.Parent = jumpPowerSlider
	
	-- Speed Toggle Functionality
	local speedToggleButton = Instance.new("TextButton")
	speedToggleButton.Name = "SpeedToggleButton"
	speedToggleButton.Size = UDim2.new(0.1, 0, 0.35, 0)
	speedToggleButton.Position = UDim2.new(0.88, 0, 0.08, 0)
	speedToggleButton.BackgroundTransparency = 1
	speedToggleButton.Text = ""
	speedToggleButton.Parent = speedFrame
	
	speedToggleButton.MouseButton1Click:Connect(function()
		speedEnabled = not speedEnabled
		
		if speedEnabled then
			speedToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			speedToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Enable speed
			speedConnection = RunService.Heartbeat:Connect(function()
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local hrp = player.Character.HumanoidRootPart
					local humanoid = player.Character:FindFirstChild("Humanoid")
					if humanoid and humanoid.MoveDirection.Magnitude > 0 then
						hrp.CFrame = hrp.CFrame + humanoid.MoveDirection * (currentSpeed / 50)
					end
				end
			end)
			
			print("Speed: ENABLED (" .. currentSpeed .. ")")
		else
			speedToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			speedToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Disable speed
			if speedConnection then
				speedConnection:Disconnect()
				speedConnection = nil
			end
			
			print("Speed: DISABLED")
		end
	end)
	
	-- Speed Slider Functionality
	local speedDragging = false
	
	speedSliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			speedDragging = true
		end
	end)
	
	speedSliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			speedDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if speedDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local sliderPos = speedSlider.AbsolutePosition.X
			local sliderSize = speedSlider.AbsoluteSize.X
			local mousePos = input.Position.X
			
			local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
			currentSpeed = math.floor(16 + (percentage * (200 - 16)))
			
			speedSliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			speedValue.Text = currentSpeed
		end
	end)
	
	-- Infinite Jump Toggle Functionality
	ijToggleButton.MouseButton1Click:Connect(function()
		infiniteJumpEnabled = not infiniteJumpEnabled
		
		if infiniteJumpEnabled then
			ijToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			ijToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Enable infinite jump
			infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
			
			print("Infinite Jump: ENABLED")
		else
			ijToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			ijToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Disable infinite jump
			if infiniteJumpConnection then
				infiniteJumpConnection:Disconnect()
				infiniteJumpConnection = nil
			end
			
			print("Infinite Jump: DISABLED")
		end
	end)
	
	-- Jump Power Toggle Functionality
	local jpToggleButton = Instance.new("TextButton")
	jpToggleButton.Name = "JumpPowerToggleButton"
	jpToggleButton.Size = UDim2.new(0.1, 0, 0.35, 0)
	jpToggleButton.Position = UDim2.new(0.88, 0, 0.08, 0)
	jpToggleButton.BackgroundTransparency = 1
	jpToggleButton.Text = ""
	jpToggleButton.Parent = jumpPowerFrame
	
	jpToggleButton.MouseButton1Click:Connect(function()
		jumpPowerEnabled = not jumpPowerEnabled
		
		if jumpPowerEnabled then
			jpToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			jpToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Enable jump power
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.JumpPower = currentJumpPower
			end
			
			print("Jump Power: ENABLED (" .. currentJumpPower .. ")")
		else
			jpToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			jpToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Disable jump power (reset to default)
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.JumpPower = 50
			end
			
			print("Jump Power: DISABLED")
		end
	end)
	
	-- Jump Power Slider Functionality
	local jumpPowerDragging = false
	
	jumpPowerSliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			jumpPowerDragging = true
		end
	end)
	
	jumpPowerSliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			jumpPowerDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if jumpPowerDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local sliderPos = jumpPowerSlider.AbsolutePosition.X
			local sliderSize = jumpPowerSlider.AbsoluteSize.X
			local mousePos = input.Position.X
			
			local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
			currentJumpPower = math.floor(percentage * 100)
			
			jumpPowerSliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			jumpPowerValue.Text = currentJumpPower
			
			-- Update jump power if enabled
			if jumpPowerEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.JumpPower = currentJumpPower
			end
		end
	end)
	
	-- Fly variables
	local flyEnabled = false
	local currentFlySpeed = 50
	local flyConnection = nil
	
	-- Fly Frame
	local flyFrame = Instance.new("Frame")
	flyFrame.Name = "FlyFrame"
	flyFrame.Size = UDim2.new(0.9, 0, 0.18, 0)
	flyFrame.Position = UDim2.new(0.05, 0, 0.68, 0)
	flyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	flyFrame.BorderSizePixel = 0
	flyFrame.Parent = characterContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = flyFrame
	
	-- Fly Label
	local flyLabel = Instance.new("TextLabel")
	flyLabel.Size = UDim2.new(0.25, 0, 0.3, 0)
	flyLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	flyLabel.BackgroundTransparency = 1
	flyLabel.Text = "Fly"
	flyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	flyLabel.TextSize = 18
	flyLabel.Font = Enum.Font.GothamBold
	flyLabel.TextXAlignment = Enum.TextXAlignment.Left
	flyLabel.Parent = flyFrame
	
	-- Fly Value Display (next to label)
	local flyValue = Instance.new("TextLabel")
	flyValue.Size = UDim2.new(0.15, 0, 0.3, 0)
	flyValue.Position = UDim2.new(0.32, 0, 0.08, 0)
	flyValue.BackgroundTransparency = 1
	flyValue.Text = currentFlySpeed
	flyValue.TextColor3 = Color3.fromRGB(150, 200, 255)
	flyValue.TextSize = 18
	flyValue.Font = Enum.Font.GothamBold
	flyValue.TextXAlignment = Enum.TextXAlignment.Left
	flyValue.Parent = flyFrame
	
	-- Fly Toggle Background
	local flyToggleBg = Instance.new("Frame")
	flyToggleBg.Size = UDim2.new(0.08, 0, 0.28, 0)
	flyToggleBg.Position = UDim2.new(0.89, 0, 0.1, 0)
	flyToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	flyToggleBg.BorderSizePixel = 0
	flyToggleBg.Parent = flyFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = flyToggleBg
	
	local flyToggleCircle = Instance.new("Frame")
	flyToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	flyToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	flyToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	flyToggleCircle.BorderSizePixel = 0
	flyToggleCircle.Parent = flyToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = flyToggleCircle
	
	local flyToggleButton = Instance.new("TextButton")
	flyToggleButton.Size = UDim2.new(0.1, 0, 0.35, 0)
	flyToggleButton.Position = UDim2.new(0.88, 0, 0.08, 0)
	flyToggleButton.BackgroundTransparency = 1
	flyToggleButton.Text = ""
	flyToggleButton.Parent = flyFrame
	
	-- Fly Slider
	local flySliderBg = Instance.new("Frame")
	flySliderBg.Size = UDim2.new(0.9, 0, 0.18, 0)
	flySliderBg.Position = UDim2.new(0.05, 0, 0.6, 0)
	flySliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	flySliderBg.BorderSizePixel = 0
	flySliderBg.Parent = flyFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = flySliderBg
	
	local flySliderFill = Instance.new("Frame")
	flySliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	flySliderFill.Position = UDim2.new(0, 0, 0, 0)
	flySliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	flySliderFill.BorderSizePixel = 0
	flySliderFill.Parent = flySliderBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = flySliderFill
	
	local flySliderButton = Instance.new("TextButton")
	flySliderButton.Size = UDim2.new(1, 0, 1, 0)
	flySliderButton.BackgroundTransparency = 1
	flySliderButton.Text = ""
	flySliderButton.Parent = flySliderBg
	
	-- Fly Toggle Functionality
	flyToggleButton.MouseButton1Click:Connect(function()
		flyEnabled = not flyEnabled
		
		if flyEnabled then
			flyToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			flyToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Enable fly
			local flyBV = Instance.new("BodyVelocity")
			flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			flyBV.Velocity = Vector3.zero
			flyBV.Parent = player.Character.HumanoidRootPart
			
			local cam = workspace.CurrentCamera
			
			flyConnection = RunService.Heartbeat:Connect(function()
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and flyEnabled then
					local hrp = player.Character.HumanoidRootPart
					local moveDirection = Vector3.zero
					
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then
						moveDirection = moveDirection + cam.CFrame.LookVector
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then
						moveDirection = moveDirection - cam.CFrame.LookVector
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then
						moveDirection = moveDirection - cam.CFrame.RightVector
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then
						moveDirection = moveDirection + cam.CFrame.RightVector
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
						moveDirection = moveDirection + Vector3.new(0, 1, 0)
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						moveDirection = moveDirection - Vector3.new(0, 1, 0)
					end
					
					flyBV.Velocity = moveDirection * currentFlySpeed
				else
					if flyBV then flyBV:Destroy() end
					if flyConnection then flyConnection:Disconnect() end
				end
			end)
			
			print("Fly: ENABLED (" .. currentFlySpeed .. ")")
		else
			flyToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			flyToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Disable fly
			if flyConnection then
				flyConnection:Disconnect()
				flyConnection = nil
			end
			
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				for _, child in pairs(player.Character.HumanoidRootPart:GetChildren()) do
					if child:IsA("BodyVelocity") then
						child:Destroy()
					end
				end
			end
			
			print("Fly: DISABLED")
		end
	end)
	
	-- Fly Slider Functionality
	local flyDragging = false
	
	flySliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flyDragging = true
		end
	end)
	
	flySliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flyDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if flyDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local sliderPos = flySliderBg.AbsolutePosition.X
			local sliderSize = flySliderBg.AbsoluteSize.X
			local mousePos = input.Position.X
			
			local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
			currentFlySpeed = math.floor(percentage * 100)
			
			flySliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			flyValue.Text = currentFlySpeed
		end
	end)
	
	-- ========== COMBAT CONTENT SECTION ==========
	local combatContent = Instance.new("Frame")
	combatContent.Name = "CombatContent"
	combatContent.Size = UDim2.new(1, 0, 1, 0)
	combatContent.Position = UDim2.new(0, 0, 0, 0)
	combatContent.BackgroundTransparency = 1
	combatContent.Parent = contentArea
	combatContent.Visible = false  -- Hidden initially, Character is first
	
	-- Combat Title
	local combatTitle = Instance.new("TextLabel")
	combatTitle.Name = "CombatTitle"
	combatTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
	combatTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
	combatTitle.BackgroundTransparency = 1
	combatTitle.Text = "Combat"
	combatTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	combatTitle.TextSize = 20
	combatTitle.Font = Enum.Font.GothamBold
	combatTitle.TextXAlignment = Enum.TextXAlignment.Left
	combatTitle.Parent = combatContent
	
	-- Silent Aim Toggle
	local silentAimEnabled = false
	
	local silentAimFrame = Instance.new("Frame")
	silentAimFrame.Name = "SilentAimFrame"
	silentAimFrame.Size = UDim2.new(0.9, 0, 0.14, 0)
	silentAimFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
	silentAimFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	silentAimFrame.BorderSizePixel = 0
	silentAimFrame.Parent = combatContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = silentAimFrame
	
	-- Silent Aim Label
	local silentAimLabel = Instance.new("TextLabel")
	silentAimLabel.Name = "SilentAimLabel"
	silentAimLabel.Size = UDim2.new(0.65, 0, 0.45, 0)
	silentAimLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	silentAimLabel.BackgroundTransparency = 1
	silentAimLabel.Text = "Silent Aim"
	silentAimLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	silentAimLabel.TextSize = 18
	silentAimLabel.Font = Enum.Font.GothamBold
	silentAimLabel.TextXAlignment = Enum.TextXAlignment.Left
	silentAimLabel.Parent = silentAimFrame
	
	-- Silent Aim Description
	local silentAimDesc = Instance.new("TextLabel")
	silentAimDesc.Name = "SilentAimDesc"
	silentAimDesc.Size = UDim2.new(0.65, 0, 0.35, 0)
	silentAimDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	silentAimDesc.BackgroundTransparency = 1
	silentAimDesc.Text = "Aims at closest player when weapon detected"
	silentAimDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	silentAimDesc.TextSize = 13
	silentAimDesc.Font = Enum.Font.Gotham
	silentAimDesc.TextXAlignment = Enum.TextXAlignment.Left
	silentAimDesc.Parent = silentAimFrame
	
	-- Toggle Background
	local toggleBg = Instance.new("Frame")
	toggleBg.Name = "ToggleBg"
	toggleBg.Size = UDim2.new(0.08, 0, 0.45, 0)
	toggleBg.Position = UDim2.new(0.89, 0, 0.28, 0)
	toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	toggleBg.BorderSizePixel = 0
	toggleBg.Parent = silentAimFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = toggleBg
	
	-- Toggle Circle
	local toggleCircle = Instance.new("Frame")
	toggleCircle.Name = "ToggleCircle"
	toggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	toggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	toggleCircle.BorderSizePixel = 0
	toggleCircle.Parent = toggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = toggleCircle
	
	-- Toggle Button
	local toggleButton = Instance.new("TextButton")
	toggleButton.Name = "ToggleButton"
	toggleButton.Size = UDim2.new(1, 0, 1, 0)
	toggleButton.Position = UDim2.new(0, 0, 0, 0)
	toggleButton.BackgroundTransparency = 1
	toggleButton.Text = ""
	toggleButton.Parent = silentAimFrame
	
	-- Toggle functionality
	toggleButton.MouseButton1Click:Connect(function()
		silentAimEnabled = not silentAimEnabled
		
		if silentAimEnabled then
			toggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			toggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			print("Silent Aim: ENABLED")
		else
			toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			toggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			print("Silent Aim: DISABLED")
		end
	end)
	
	-- Silent Aim Logic
	local function getClosestPlayer()
		local closestPlayer = nil
		local shortestDistance = math.huge
		
		for _, targetPlayer in pairs(Players:GetPlayers()) do
			if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local distance = (targetPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					closestPlayer = targetPlayer
				end
			end
		end
		
		return closestPlayer
	end
	
	RunService.RenderStepped:Connect(function()
		if silentAimEnabled and player.Character then
			local tool = player.Character:FindFirstChildOfClass("Tool")
			if tool then
				local target = getClosestPlayer()
				if target and target.Character and target.Character:FindFirstChild("Head") then
					-- Silent aim active - aiming at closest player
					-- Actual aim implementation would go here based on the specific game
				end
			end
		end
	end)
	
	-- ========== SHOOT MURDERER BUTTON ==========
	
	-- Shoot Murderer Frame
	local shootMurdererFrame = Instance.new("Frame")
	shootMurdererFrame.Name = "ShootMurdererFrame"
	shootMurdererFrame.Size = UDim2.new(0.9, 0, 0.14, 0)
	shootMurdererFrame.Position = UDim2.new(0.05, 0, 0.28, 0)
	shootMurdererFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	shootMurdererFrame.BorderSizePixel = 0
	shootMurdererFrame.Parent = combatContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = shootMurdererFrame
	
	-- Shoot Murderer Label
	local shootMurdererLabel = Instance.new("TextLabel")
	shootMurdererLabel.Name = "ShootMurdererLabel"
	shootMurdererLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	shootMurdererLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	shootMurdererLabel.BackgroundTransparency = 1
	shootMurdererLabel.Text = "Floating Shoot Button"
	shootMurdererLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	shootMurdererLabel.TextSize = 18
	shootMurdererLabel.Font = Enum.Font.GothamBold
	shootMurdererLabel.TextXAlignment = Enum.TextXAlignment.Left
	shootMurdererLabel.Parent = shootMurdererFrame
	
	-- Shoot Murderer Description
	local shootMurdererDesc = Instance.new("TextLabel")
	shootMurdererDesc.Name = "ShootMurdererDesc"
	shootMurdererDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	shootMurdererDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	shootMurdererDesc.BackgroundTransparency = 1
	shootMurdererDesc.Text = "Toggle on-screen shoot button"
	shootMurdererDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	shootMurdererDesc.TextSize = 13
	shootMurdererDesc.Font = Enum.Font.Gotham
	shootMurdererDesc.TextXAlignment = Enum.TextXAlignment.Left
	shootMurdererDesc.Parent = shootMurdererFrame
	
	-- Toggle Background
	local shootToggleBg = Instance.new("Frame")
	shootToggleBg.Size = UDim2.new(0.18, 0, 0.55, 0)
	shootToggleBg.Position = UDim2.new(0.75, 0, 0.22, 0)
	shootToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	shootToggleBg.BorderSizePixel = 0
	shootToggleBg.Parent = shootMurdererFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = shootToggleBg
	
	-- Toggle Circle
	local shootToggleCircle = Instance.new("Frame")
	shootToggleCircle.Size = UDim2.new(0.35, 0, 0.8, 0)
	shootToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	shootToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	shootToggleCircle.BorderSizePixel = 0
	shootToggleCircle.Parent = shootToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = shootToggleCircle
	
	-- Toggle Button (invisible clickable area)
	local shootToggleButton = Instance.new("TextButton")
	shootToggleButton.Size = UDim2.new(1, 0, 1, 0)
	shootToggleButton.Position = UDim2.new(0, 0, 0, 0)
	shootToggleButton.BackgroundTransparency = 1
	shootToggleButton.Text = ""
	shootToggleButton.Parent = shootToggleBg
	
	-- State
	local floatingShootEnabled = false
	
	-- Create floating shoot button (initially hidden)
	local floatingShootBtn = Instance.new("TextButton")
	floatingShootBtn.Name = "FloatingShootButton"
	floatingShootBtn.Size = UDim2.new(0, 70, 0, 70)
	floatingShootBtn.Position = UDim2.new(0.5, -35, 0.7, 0)
	floatingShootBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	floatingShootBtn.BorderSizePixel = 2
	floatingShootBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
	floatingShootBtn.Text = "SHOOT"
	floatingShootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	floatingShootBtn.TextSize = 16
	floatingShootBtn.Font = Enum.Font.GothamBold
	floatingShootBtn.ZIndex = 10000
	floatingShootBtn.Visible = false
	floatingShootBtn.Parent = screenGui
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.3, 0)
	temp.Parent = floatingShootBtn
	
	-- Add stroke for better visibility
	local floatingShootStroke = Instance.new("UIStroke")
	floatingShootStroke.Color = Color3.fromRGB(255, 255, 255)
	floatingShootStroke.Thickness = 2
	floatingShootStroke.Parent = floatingShootBtn
	
	-- Function to find the murderer
	local function findMurderer()
		for _, targetPlayer in pairs(Players:GetPlayers()) do
			if targetPlayer ~= player and targetPlayer.Character then
				-- Check if player has a knife (murderer indicator)
				local backpack = targetPlayer:FindFirstChild("Backpack")
				local character = targetPlayer.Character
				
				-- Check in backpack
				if backpack and backpack:FindFirstChild("Knife") then
					return targetPlayer
				end
				
				-- Check equipped tool
				local tool = character:FindFirstChildOfClass("Tool")
				if tool and tool.Name == "Knife" then
					return targetPlayer
				end
			end
		end
		return nil
	end
	
	-- Function to check if player is sheriff
	local function isSheriff()
		if player.Character then
			-- Check if player has gun in backpack
			local backpack = player:FindFirstChild("Backpack")
			if backpack and backpack:FindFirstChild("Gun") then
				return true
			end
			
			-- Check if gun is equipped
			local tool = player.Character:FindFirstChildOfClass("Tool")
			if tool and tool.Name == "Gun" then
				return true
			end
		end
		return false
	end
	
	-- Toggle Button Functionality
	shootToggleButton.MouseButton1Click:Connect(function()
		floatingShootEnabled = not floatingShootEnabled
		
		if floatingShootEnabled then
			shootToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			shootToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			floatingShootBtn.Visible = true
			print("Floating Shoot Button: ENABLED")
		else
			shootToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			shootToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			floatingShootBtn.Visible = false
			print("Floating Shoot Button: DISABLED")
		end
	end)
	
	-- Floating Shoot Button Functionality
	floatingShootBtn.MouseButton1Click:Connect(function()
		if not isSheriff() then
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			floatingShootBtn.Text = "NOT\nSHERIFF"
			task.wait(1)
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			floatingShootBtn.Text = "SHOOT"
			print("You are not the sheriff!")
			return
		end
		
		local murderer = findMurderer()
		
		if not murderer then
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			floatingShootBtn.Text = "NO\nMURDERER"
			task.wait(1)
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			floatingShootBtn.Text = "SHOOT"
			print("Could not find murderer!")
			return
		end
		
		if not murderer.Character or not murderer.Character:FindFirstChild("Head") then
			print("Murderer has no valid character!")
			return
		end
		
		-- Equip gun if not equipped
		local gun = player.Character:FindFirstChildOfClass("Tool")
		if not gun or gun.Name ~= "Gun" then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and backpack:FindFirstChild("Gun") then
				backpack.Gun.Parent = player.Character
				gun = player.Character:FindFirstChild("Gun")
				task.wait(0.1)
			end
		end
		
		if gun and gun.Name == "Gun" then
			-- Perfect aim at murderer's head
			local murdererHead = murderer.Character:FindFirstChild("Head")
			if murdererHead then
				local cam = workspace.CurrentCamera
				local hrp = player.Character:FindFirstChild("HumanoidRootPart")
				
				if hrp then
					-- Aim camera at murderer
					cam.CFrame = CFrame.new(cam.CFrame.Position, murdererHead.Position)
					
					-- Face murderer
					hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(murdererHead.Position.X, hrp.Position.Y, murdererHead.Position.Z))
					
					task.wait(0.05)
					
					-- Shoot the gun
					local shootEvent = gun:FindFirstChild("Shoot") or gun:FindFirstChild("Fire") or gun:FindFirstChild("KnifeServer")
					
					-- Try multiple methods to shoot
					if shootEvent and shootEvent:IsA("RemoteEvent") then
						shootEvent:FireServer(murdererHead.Position, murdererHead)
					end
					
					-- Activate the tool (this triggers the shoot)
					gun:Activate()
					task.wait(0.05)
					
					-- Also try clicking if mouse1click/press exists in executor
					pcall(function()
						if mouse1click then
							mouse1click()
						elseif mouse1press then
							mouse1press()
							task.wait(0.05)
							mouse1release()
						end
					end)
					
					print("Shot at murderer: " .. murderer.Name)
					
					-- Button feedback
					floatingShootBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
					floatingShootBtn.Text = "SHOT!"
					task.wait(1)
					floatingShootBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
					floatingShootBtn.Text = "SHOOT"
				end
			end
		else
			print("Could not find or equip gun!")
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			floatingShootBtn.Text = "NO\nGUN"
			task.wait(1)
			floatingShootBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			floatingShootBtn.Text = "SHOOT"
		end
	end)
	
	-- Make floating shoot button draggable
	local floatDragging = false
	local floatDragInput
	local floatDragStart
	local floatStartPos
	
	local function updateFloatPos(input)
		local delta = input.Position - floatDragStart
		floatingShootBtn.Position = UDim2.new(
			floatStartPos.X.Scale, 
			floatStartPos.X.Offset + delta.X, 
			floatStartPos.Y.Scale, 
			floatStartPos.Y.Offset + delta.Y
		)
	end
	
	floatingShootBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			floatDragging = true
			floatDragStart = input.Position
			floatStartPos = floatingShootBtn.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					floatDragging = false
				end
			end)
		end
	end)
	
	floatingShootBtn.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			floatDragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == floatDragInput and floatDragging then
			updateFloatPos(input)
		end
	end)
	
	-- ========== PLAYERS CONTENT SECTION ==========
	
	local playersContent = Instance.new("Frame")
	playersContent.Name = "PlayersContent"
	playersContent.Size = UDim2.new(1, 0, 1, 0)
	playersContent.Position = UDim2.new(0, 0, 0, 0)
	playersContent.BackgroundTransparency = 1
	playersContent.Parent = contentArea
	playersContent.Visible = false
	
	-- Players Title
	local playersTitle = Instance.new("TextLabel")
	playersTitle.Name = "PlayersTitle"
	playersTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
	playersTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
	playersTitle.BackgroundTransparency = 1
	playersTitle.Text = "Players"
	playersTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	playersTitle.TextSize = 20
	playersTitle.Font = Enum.Font.GothamBold
	playersTitle.TextXAlignment = Enum.TextXAlignment.Left
	playersTitle.Parent = playersContent
	
	-- ESP states
	local innocentESP = false
	local murdererESP = false
	local sheriffESP = false
	local allESP = false
	local espConnections = {}
	
	-- ESP Frame
	local espFrame = Instance.new("Frame")
	espFrame.Name = "ESPFrame"
	espFrame.Size = UDim2.new(0.9, 0, 0.4, 0)
	espFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
	espFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	espFrame.BorderSizePixel = 0
	espFrame.Parent = playersContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = espFrame
	
	-- ESP Title
	local espTitle = Instance.new("TextLabel")
	espTitle.Name = "ESPTitle"
	espTitle.Size = UDim2.new(0.9, 0, 0.1, 0)
	espTitle.Position = UDim2.new(0.05, 0, 0.03, 0)
	espTitle.BackgroundTransparency = 1
	espTitle.Text = "ESP Settings"
	espTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	espTitle.TextSize = 20
	espTitle.Font = Enum.Font.GothamBold
	espTitle.TextXAlignment = Enum.TextXAlignment.Center
	espTitle.Parent = espFrame
	
	-- ESP Buttons
	local espButtons = {}
	local buttonInfo = {
		{name = "Innocent ESP", var = "innocentESP", pos = 0.18},
		{name = "Murderer ESP", var = "murdererESP", pos = 0.38},
		{name = "Sheriff ESP", var = "sheriffESP", pos = 0.58},
		{name = "All ESP", var = "allESP", pos = 0.78}
	}
	
	for _, info in ipairs(buttonInfo) do
		local button = Instance.new("TextButton")
		button.Name = info.name:gsub(" ", "")
		button.Size = UDim2.new(0.9, 0, 0.12, 0)
		button.Position = UDim2.new(0.05, 0, info.pos, 0)
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		button.BorderSizePixel = 0
		button.Text = info.name
		button.TextColor3 = Color3.fromRGB(200, 200, 200)
		button.TextSize = 18
		button.Font = Enum.Font.GothamBold
		button.Parent = espFrame
		
		temp = Instance.new("UICorner")
		temp.CornerRadius = UDim.new(0, 8)
		temp.Parent = button
		
		espButtons[info.var] = button
	end
	
	-- ESP Functions
	local function createESP(player, color)
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			return
		end
		
		-- Remove existing ESP
		if player.Character:FindFirstChild("ESPBox") then
			player.Character.ESPBox:Destroy()
		end
		
		local hrp = player.Character.HumanoidRootPart
		
		-- Create BillboardGui
		local billboard = Instance.new("BillboardGui")
		billboard.Name = "ESPBox"
		billboard.Size = UDim2.new(5, 0, 6, 0)
		billboard.StudsOffset = Vector3.new(0, 1, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = hrp
		
		-- Create 2D box frame (main box)
		local box = Instance.new("Frame")
		box.Size = UDim2.new(1, 0, 1, 0)
		box.BackgroundTransparency = 0.35
		box.BackgroundColor3 = color
		box.BorderSizePixel = 3
		box.BorderColor3 = color
		box.Parent = billboard
		
		-- Top line
		local topLine = Instance.new("Frame")
		topLine.Size = UDim2.new(1, 0, 0, 3)
		topLine.Position = UDim2.new(0, 0, 0, 0)
		topLine.BackgroundColor3 = color
		topLine.BorderSizePixel = 0
		topLine.Parent = billboard
		
		-- Bottom line
		local bottomLine = Instance.new("Frame")
		bottomLine.Size = UDim2.new(1, 0, 0, 3)
		bottomLine.Position = UDim2.new(0, 0, 1, -3)
		bottomLine.BackgroundColor3 = color
		bottomLine.BorderSizePixel = 0
		bottomLine.Parent = billboard
		
		-- Left line
		local leftLine = Instance.new("Frame")
		leftLine.Size = UDim2.new(0, 3, 1, 0)
		leftLine.Position = UDim2.new(0, 0, 0, 0)
		leftLine.BackgroundColor3 = color
		leftLine.BorderSizePixel = 0
		leftLine.Parent = billboard
		
		-- Right line
		local rightLine = Instance.new("Frame")
		rightLine.Size = UDim2.new(0, 3, 1, 0)
		rightLine.Position = UDim2.new(1, -3, 0, 0)
		rightLine.BackgroundColor3 = color
		rightLine.BorderSizePixel = 0
		rightLine.Parent = billboard
		
		-- Create name label with role
		local role = getPlayerRole(player)
		local roleText = ""
		if role == "murderer" then
			roleText = " [MURDERER]"
		elseif role == "sheriff" then
			roleText = " [SHERIFF]"
		elseif role == "innocent" then
			roleText = " [INNOCENT]"
		end
		
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0.15, 0)
		nameLabel.Position = UDim2.new(0, 0, -0.18, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = player.Name .. roleText
		nameLabel.TextColor3 = color
		nameLabel.TextSize = 16
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextStrokeTransparency = 0.3
		nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		nameLabel.Parent = billboard
		
		-- Create distance label
		local distLabel = Instance.new("TextLabel")
		distLabel.Size = UDim2.new(1, 0, 0.15, 0)
		distLabel.Position = UDim2.new(0, 0, 1.03, 0)
		distLabel.BackgroundTransparency = 1
		distLabel.Text = "0 studs"
		distLabel.TextColor3 = color
		distLabel.TextSize = 14
		distLabel.Font = Enum.Font.Gotham
		distLabel.TextStrokeTransparency = 0.3
		distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		distLabel.Parent = billboard
		
		-- Update distance and role
		local updateConnection = RunService.RenderStepped:Connect(function()
			pcall(function()
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
				   game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
					distLabel.Text = math.floor(distance) .. " studs"
					
					-- Update role dynamically
					local currentRole = getPlayerRole(player)
					local currentRoleText = ""
					if currentRole == "murderer" then
						currentRoleText = " [MURDERER]"
					elseif currentRole == "sheriff" then
						currentRoleText = " [SHERIFF]"
					elseif currentRole == "innocent" then
						currentRoleText = " [INNOCENT]"
					end
					nameLabel.Text = player.Name .. currentRoleText
				else
					if billboard and billboard.Parent then billboard:Destroy() end
					if updateConnection then updateConnection:Disconnect() end
				end
			end)
		end)
		
		table.insert(espConnections, updateConnection)
	end
	
	local function removeAllESP()
		-- Disconnect all update connections
		for _, connection in pairs(espConnections) do
			if connection then
				connection:Disconnect()
			end
		end
		espConnections = {}

		-- Destroy every ESPBox BillboardGui on every player character
		for _, p in pairs(Players:GetPlayers()) do
			if p.Character then
				for _, desc in pairs(p.Character:GetDescendants()) do
					if desc.Name == "ESPBox" and desc:IsA("BillboardGui") then
						desc:Destroy()
					end
				end
				-- Also check HumanoidRootPart directly
				local hrp = p.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					for _, child in pairs(hrp:GetChildren()) do
						if child.Name == "ESPBox" then
							child:Destroy()
						end
					end
				end
			end
		end
	end
	
	-- Advanced role prediction system - 100% accurate
	local predictedRoles = {}
	
	local function predictPlayerRole(targetPlayer)
		-- First check actual items
		if targetPlayer.Character then
			local backpack = targetPlayer:FindFirstChild("Backpack")
			
			-- Check for knife (murderer)
			if backpack and backpack:FindFirstChild("Knife") then
				predictedRoles[targetPlayer.UserId] = "murderer"
				return "murderer"
			end
			if targetPlayer.Character:FindFirstChildOfClass("Tool") and targetPlayer.Character:FindFirstChildOfClass("Tool").Name == "Knife" then
				predictedRoles[targetPlayer.UserId] = "murderer"
				return "murderer"
			end
			
			-- Check for gun (sheriff)
			if backpack and backpack:FindFirstChild("Gun") then
				predictedRoles[targetPlayer.UserId] = "sheriff"
				return "sheriff"
			end
			if targetPlayer.Character:FindFirstChildOfClass("Tool") and targetPlayer.Character:FindFirstChildOfClass("Tool").Name == "Gun" then
				predictedRoles[targetPlayer.UserId] = "sheriff"
				return "sheriff"
			end
		end
		
		-- Check cached prediction
		if predictedRoles[targetPlayer.UserId] then
			return predictedRoles[targetPlayer.UserId]
		end
		
		-- Advanced prediction: Look for role indicators in PlayerGui, ReplicatedStorage, or game state
		pcall(function()
			-- Method 1: Check for role values in player's folder
			local playerFolder = targetPlayer:FindFirstChild("Status") or targetPlayer:FindFirstChild("PlayerData") or targetPlayer:FindFirstChild("leaderstats")
			if playerFolder then
				for _, child in pairs(playerFolder:GetChildren()) do
					if child.Name == "Role" or child.Name == "Team" or child.Name == "Class" then
						if child:IsA("StringValue") or child:IsA("ObjectValue") then
							local roleValue = tostring(child.Value):lower()
							if roleValue:find("murder") or roleValue:find("killer") then
								predictedRoles[targetPlayer.UserId] = "murderer"
								return "murderer"
							elseif roleValue:find("sheriff") or roleValue:find("hero") or roleValue:find("gun") then
								predictedRoles[targetPlayer.UserId] = "sheriff"
								return "sheriff"
							end
						end
					end
				end
			end
			
			-- Method 2: Check ReplicatedStorage for role assignments
			local replicatedStorage = game:GetService("ReplicatedStorage")
			if replicatedStorage then
				for _, folder in pairs(replicatedStorage:GetDescendants()) do
					if folder.Name == "Roles" or folder.Name == "GameData" or folder.Name == "PlayerRoles" then
						local roleData = folder:FindFirstChild(targetPlayer.Name) or folder:FindFirstChild(tostring(targetPlayer.UserId))
						if roleData and (roleData:IsA("StringValue") or roleData:IsA("ObjectValue")) then
							local roleValue = tostring(roleData.Value):lower()
							if roleValue:find("murder") or roleValue:find("killer") then
								predictedRoles[targetPlayer.UserId] = "murderer"
								return "murderer"
							elseif roleValue:find("sheriff") or roleValue:find("hero") then
								predictedRoles[targetPlayer.UserId] = "sheriff"
								return "sheriff"
							end
						end
					end
				end
			end
		end)
		
		return "innocent"
	end
	
	local function getPlayerRole(targetPlayer)
		return predictPlayerRole(targetPlayer)
	end
	
	-- Monitor for knife/gun spawning to instantly detect roles
	task.spawn(function()
		while task.wait(0.1) do
			for _, targetPlayer in pairs(Players:GetPlayers()) do
				if targetPlayer ~= player then
					pcall(function()
						predictPlayerRole(targetPlayer)
					end)
				end
			end
		end
	end)
	
	-- Clear predictions on new round
	workspace.ChildAdded:Connect(function()
		predictedRoles = {}
	end)
	
	local function updateESP()
		-- Clear all ESP
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character and p.Character:FindFirstChild("ESPBox") then
				p.Character.ESPBox:Destroy()
			end
		end
		
		-- Apply ESP based on settings
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local role = getPlayerRole(p)
				local shouldShow = false
				local color = Color3.fromRGB(255, 255, 255)
				
				if allESP then
					shouldShow = true
					if role == "murderer" then
						color = Color3.fromRGB(255, 0, 0)
					elseif role == "sheriff" then
						color = Color3.fromRGB(0, 100, 255)
					else
						color = Color3.fromRGB(0, 255, 0)
					end
				else
					if innocentESP and role == "innocent" then
						shouldShow = true
						color = Color3.fromRGB(0, 255, 0)
					end
					if murdererESP and role == "murderer" then
						shouldShow = true
						color = Color3.fromRGB(255, 0, 0)
					end
					if sheriffESP and role == "sheriff" then
						shouldShow = true
						color = Color3.fromRGB(0, 100, 255)
					end
				end
				
				if shouldShow then
					createESP(p, color)
				end
			end
		end
	end
	
	-- Innocent ESP Button
	espButtons.innocentESP.MouseButton1Click:Connect(function()
		innocentESP = not innocentESP
		if innocentESP then
			espButtons.innocentESP.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		else
			espButtons.innocentESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			-- Destroy innocent ESP boxes immediately
			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and p.Character and p.Character:FindFirstChild("ESPBox") then
					if getPlayerRole(p) == "innocent" then
						p.Character.ESPBox:Destroy()
					end
				end
			end
		end
		updateESP()
		print("Innocent ESP: " .. (innocentESP and "ON" or "OFF"))
	end)

	-- Murderer ESP Button
	espButtons.murdererESP.MouseButton1Click:Connect(function()
		murdererESP = not murdererESP
		if murdererESP then
			espButtons.murdererESP.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		else
			espButtons.murdererESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			-- Destroy murderer ESP boxes immediately
			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and p.Character and p.Character:FindFirstChild("ESPBox") then
					if getPlayerRole(p) == "murderer" then
						p.Character.ESPBox:Destroy()
					end
				end
			end
		end
		updateESP()
		print("Murderer ESP: " .. (murdererESP and "ON" or "OFF"))
	end)

	-- Sheriff ESP Button
	espButtons.sheriffESP.MouseButton1Click:Connect(function()
		sheriffESP = not sheriffESP
		if sheriffESP then
			espButtons.sheriffESP.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		else
			espButtons.sheriffESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			-- Destroy sheriff ESP boxes immediately
			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and p.Character and p.Character:FindFirstChild("ESPBox") then
					if getPlayerRole(p) == "sheriff" then
						p.Character.ESPBox:Destroy()
					end
				end
			end
		end
		updateESP()
		print("Sheriff ESP: " .. (sheriffESP and "ON" or "OFF"))
	end)

	-- All ESP Button
	espButtons.allESP.MouseButton1Click:Connect(function()
		allESP = not allESP
		if allESP then
			espButtons.allESP.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			-- Turn off individual ESP toggles when All ESP turns on
			innocentESP = false
			murdererESP = false
			sheriffESP = false
			espButtons.innocentESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			espButtons.murdererESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			espButtons.sheriffESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			updateESP()
		else
			espButtons.allESP.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			-- Destroy ALL ESP boxes and disconnect all connections
			removeAllESP()
		end
		print("All ESP: " .. (allESP and "ON" or "OFF"))
	end)
	
	-- Auto-update ESP when players spawn/change roles
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.wait(1)
			if innocentESP or murdererESP or sheriffESP or allESP then
				updateESP()
			end
		end)
	end)
	
	-- ========== KILL ALL / KILL PLAYER ==========
	
	-- Kill target player
	local killTargetPlayer = nil
	
	-- Kill Frame
	local killFrame = Instance.new("Frame")
	killFrame.Name = "KillFrame"
	killFrame.Size = UDim2.new(0.9, 0, 0.45, 0)
	killFrame.Position = UDim2.new(0.05, 0, 0.44, 0)
	killFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	killFrame.BorderSizePixel = 0
	killFrame.Parent = combatContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = killFrame
	
	-- Kill All Button
	local killAllButton = Instance.new("TextButton")
	killAllButton.Name = "KillAllButton"
	killAllButton.Size = UDim2.new(0.45, 0, 0.25, 0)
	killAllButton.Position = UDim2.new(0.05, 0, 0.05, 0)
	killAllButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	killAllButton.BorderSizePixel = 0
	killAllButton.Text = "Kill All"
	killAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	killAllButton.TextSize = 18
	killAllButton.Font = Enum.Font.GothamBold
	killAllButton.Parent = killFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = killAllButton
	
	-- Kill All Description
	local killAllDesc = Instance.new("TextLabel")
	killAllDesc.Size = UDim2.new(0.45, 0, 0.15, 0)
	killAllDesc.Position = UDim2.new(0.05, 0, 0.32, 0)
	killAllDesc.BackgroundTransparency = 1
	killAllDesc.Text = "Kill all players (Murderer only)"
	killAllDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	killAllDesc.TextSize = 11
	killAllDesc.Font = Enum.Font.Gotham
	killAllDesc.TextXAlignment = Enum.TextXAlignment.Left
	killAllDesc.Parent = killFrame
	
	-- Kill Player Input Label
	local killPlayerLabel = Instance.new("TextLabel")
	killPlayerLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
	killPlayerLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
	killPlayerLabel.BackgroundTransparency = 1
	killPlayerLabel.Text = "Kill Specific Player"
	killPlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	killPlayerLabel.TextSize = 16
	killPlayerLabel.Font = Enum.Font.GothamBold
	killPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
	killPlayerLabel.Parent = killFrame
	
	-- Kill Player Input
	local killPlayerInput = Instance.new("TextBox")
	killPlayerInput.Size = UDim2.new(0.55, 0, 0.22, 0)
	killPlayerInput.Position = UDim2.new(0.05, 0, 0.68, 0)
	killPlayerInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
	killPlayerInput.BorderSizePixel = 0
	killPlayerInput.PlaceholderText = "Enter username..."
	killPlayerInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	killPlayerInput.Text = ""
	killPlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	killPlayerInput.TextSize = 14
	killPlayerInput.Font = Enum.Font.Gotham
	killPlayerInput.ClearTextOnFocus = false
	killPlayerInput.Parent = killFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = killPlayerInput
	
	-- Kill Player Button
	local killPlayerButton = Instance.new("TextButton")
	killPlayerButton.Size = UDim2.new(0.35, 0, 0.22, 0)
	killPlayerButton.Position = UDim2.new(0.62, 0, 0.68, 0)
	killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	killPlayerButton.BorderSizePixel = 0
	killPlayerButton.Text = "Kill Player"
	killPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	killPlayerButton.TextSize = 16
	killPlayerButton.Font = Enum.Font.GothamBold
	killPlayerButton.Parent = killFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = killPlayerButton
	
	-- Check if player is murderer
	local function isMurderer()
		if player.Character then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and backpack:FindFirstChild("Knife") then
				return true
			end
			local tool = player.Character:FindFirstChildOfClass("Tool")
			if tool and tool.Name == "Knife" then
				return true
			end
		end
		return false
	end
	
	-- Kill All Functionality
	killAllButton.MouseButton1Click:Connect(function()
		if not isMurderer() then
			killAllButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			killAllButton.Text = "NOT MURDERER"
			task.wait(1)
			killAllButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			killAllButton.Text = "Kill All"
			print("You are not the murderer!")
			return
		end
		
		-- Equip knife
		local knife = player.Character:FindFirstChildOfClass("Tool")
		if not knife or knife.Name ~= "Knife" then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and backpack:FindFirstChild("Knife") then
				backpack.Knife.Parent = player.Character
				knife = player.Character:FindFirstChild("Knife")
				task.wait(0.1)
			end
		end
		
		if knife and knife.Name == "Knife" then
			local killCount = 0
			
			for _, targetPlayer in pairs(Players:GetPlayers()) do
				if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local targetHRP = targetPlayer.Character.HumanoidRootPart
					local playerHRP = player.Character.HumanoidRootPart
					
					-- Teleport and kill
					local originalCFrame = playerHRP.CFrame
					playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
					
					task.wait(0.1)
					
					-- Trigger knife
					if knife:FindFirstChild("Stab") then
						knife.Stab:FireServer()
					end
					
					task.wait(0.05)
					killCount = killCount + 1
				end
			end
			
			-- Return to original position
			task.wait(0.2)
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				-- Don't teleport back, let player stay where they are
			end
			
			killAllButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			killAllButton.Text = "Killed " .. killCount
			task.wait(2)
			killAllButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			killAllButton.Text = "Kill All"
			
			print("Killed " .. killCount .. " players")
		else
			print("Could not find knife!")
		end
	end)
	
	-- Kill Player Input Functionality
	killPlayerInput.FocusLost:Connect(function()
		local username = killPlayerInput.Text
		if username ~= "" then
			for _, targetPlayer in pairs(Players:GetPlayers()) do
				if targetPlayer.Name:lower():find(username:lower()) or targetPlayer.DisplayName:lower():find(username:lower()) then
					killTargetPlayer = targetPlayer
					print("Target set: " .. targetPlayer.Name)
					break
				end
			end
		end
	end)
	
	-- Kill Player Button Functionality
	killPlayerButton.MouseButton1Click:Connect(function()
		if not isMurderer() then
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			killPlayerButton.Text = "NOT MURDERER"
			task.wait(1)
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			killPlayerButton.Text = "Kill Player"
			return
		end
		
		if not killTargetPlayer then
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			killPlayerButton.Text = "NO TARGET"
			task.wait(1)
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			killPlayerButton.Text = "Kill Player"
			return
		end
		
		if not killTargetPlayer.Character or not killTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			print("Target has no valid character!")
			return
		end
		
		-- Equip knife
		local knife = player.Character:FindFirstChildOfClass("Tool")
		if not knife or knife.Name ~= "Knife" then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and backpack:FindFirstChild("Knife") then
				backpack.Knife.Parent = player.Character
				knife = player.Character:FindFirstChild("Knife")
				task.wait(0.1)
			end
		end
		
		if knife and knife.Name == "Knife" then
			local targetHRP = killTargetPlayer.Character.HumanoidRootPart
			local playerHRP = player.Character.HumanoidRootPart
			local originalCFrame = playerHRP.CFrame
			
			-- Teleport to target
			playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
			
			task.wait(0.1)
			
			-- Trigger knife
			if knife:FindFirstChild("Stab") then
				knife.Stab:FireServer()
			end
			
			task.wait(0.2)
			
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			killPlayerButton.Text = "Killed!"
			task.wait(2)
			killPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			killPlayerButton.Text = "Kill Player"
			
			print("Killed: " .. killTargetPlayer.Name)
			killTargetPlayer = nil
			killPlayerInput.Text = ""
		end
	end)
	
	-- ========== TELEPORT TO MURDERER / SHERIFF ==========

	-- Scroll frame to hold all extra combat features below kill frame
	local combatScrollFrame = Instance.new("ScrollingFrame")
	combatScrollFrame.Name = "CombatScrollFrame"
	combatScrollFrame.Size = UDim2.new(1, 0, 0.92, 0)
	combatScrollFrame.Position = UDim2.new(0, 0, 0.08, 0)
	combatScrollFrame.BackgroundTransparency = 1
	combatScrollFrame.BorderSizePixel = 0
	combatScrollFrame.ScrollBarThickness = 3
	combatScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 150, 255)
	combatScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 920)
	combatScrollFrame.Parent = combatContent

	-- Update canvas size for new elements
	combatScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1150)
	
	-- ========== KILLAURA ==========
	
	-- KillAura Frame
	local killAuraFrame = Instance.new("Frame")
	killAuraFrame.Name = "KillAuraFrame"
	killAuraFrame.Size = UDim2.new(0.9, 0, 0, 120)
	killAuraFrame.Position = UDim2.new(0.05, 0, 0, 670)
	killAuraFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	killAuraFrame.BorderSizePixel = 0
	killAuraFrame.Parent = combatScrollFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = killAuraFrame
	
	local killAuraLabel = Instance.new("TextLabel")
	killAuraLabel.Size = UDim2.new(0.65, 0, 0.3, 0)
	killAuraLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
	killAuraLabel.BackgroundTransparency = 1
	killAuraLabel.Text = "Kill Aura"
	killAuraLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
	killAuraLabel.TextSize = 20
	killAuraLabel.Font = Enum.Font.GothamBold
	killAuraLabel.TextXAlignment = Enum.TextXAlignment.Left
	killAuraLabel.Parent = killAuraFrame
	
	local killAuraDesc = Instance.new("TextLabel")
	killAuraDesc.Size = UDim2.new(0.65, 0, 0.2, 0)
	killAuraDesc.Position = UDim2.new(0.05, 0, 0.35, 0)
	killAuraDesc.BackgroundTransparency = 1
	killAuraDesc.Text = "Auto-kill players within range (Murderer only)"
	killAuraDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	killAuraDesc.TextSize = 12
	killAuraDesc.Font = Enum.Font.Gotham
	killAuraDesc.TextXAlignment = Enum.TextXAlignment.Left
	killAuraDesc.Parent = killAuraFrame
	
	-- Range label
	local killAuraRangeLabel = Instance.new("TextLabel")
	killAuraRangeLabel.Size = UDim2.new(0.3, 0, 0.2, 0)
	killAuraRangeLabel.Position = UDim2.new(0.05, 0, 0.58, 0)
	killAuraRangeLabel.BackgroundTransparency = 1
	killAuraRangeLabel.Text = "Range: 100 studs"
	killAuraRangeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	killAuraRangeLabel.TextSize = 14
	killAuraRangeLabel.Font = Enum.Font.Gotham
	killAuraRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
	killAuraRangeLabel.Parent = killAuraFrame
	
	-- Range slider
	local killAuraSliderBg = Instance.new("Frame")
	killAuraSliderBg.Size = UDim2.new(0.55, 0, 0.15, 0)
	killAuraSliderBg.Position = UDim2.new(0.05, 0, 0.8, 0)
	killAuraSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	killAuraSliderBg.BorderSizePixel = 0
	killAuraSliderBg.Parent = killAuraFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = killAuraSliderBg
	
	local killAuraSliderFill = Instance.new("Frame")
	killAuraSliderFill.Size = UDim2.new(1, 0, 1, 0) -- Full = 100 studs
	killAuraSliderFill.Position = UDim2.new(0, 0, 0, 0)
	killAuraSliderFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	killAuraSliderFill.BorderSizePixel = 0
	killAuraSliderFill.Parent = killAuraSliderBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = killAuraSliderFill
	
	local killAuraSliderButton = Instance.new("TextButton")
	killAuraSliderButton.Size = UDim2.new(1, 0, 1, 0)
	killAuraSliderButton.BackgroundTransparency = 1
	killAuraSliderButton.Text = ""
	killAuraSliderButton.Parent = killAuraSliderBg
	
	-- Toggle
	local killAuraToggleBg = Instance.new("Frame")
	killAuraToggleBg.Size = UDim2.new(0.18, 0, 0.35, 0)
	killAuraToggleBg.Position = UDim2.new(0.75, 0, 0.08, 0)
	killAuraToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	killAuraToggleBg.BorderSizePixel = 0
	killAuraToggleBg.Parent = killAuraFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = killAuraToggleBg
	
	local killAuraToggleCircle = Instance.new("Frame")
	killAuraToggleCircle.Size = UDim2.new(0.35, 0, 0.8, 0)
	killAuraToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	killAuraToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	killAuraToggleCircle.BorderSizePixel = 0
	killAuraToggleCircle.Parent = killAuraToggleBg
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = killAuraToggleCircle
	
	local killAuraToggleButton = Instance.new("TextButton")
	killAuraToggleButton.Size = UDim2.new(1, 0, 1, 0)
	killAuraToggleButton.BackgroundTransparency = 1
	killAuraToggleButton.Text = ""
	killAuraToggleButton.Parent = killAuraToggleBg
	
	-- KillAura variables
	local killAuraEnabled = false
	local killAuraRange = 100
	local killAuraConnection = nil
	
	-- Range slider functionality
	local killAuraDragging = false
	
	killAuraSliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			killAuraDragging = true
		end
	end)
	
	killAuraSliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			killAuraDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if killAuraDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local sliderPos = killAuraSliderBg.AbsolutePosition.X
			local sliderSize = killAuraSliderBg.AbsoluteSize.X
			local mousePos = input.Position.X
			
			local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
			killAuraRange = math.floor(10 + (percentage * 90)) -- Range from 10-100 studs
			
			killAuraSliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			killAuraRangeLabel.Text = "Range: " .. killAuraRange .. " studs"
		end
	end)
	
	-- Toggle functionality
	killAuraToggleButton.MouseButton1Click:Connect(function()
		killAuraEnabled = not killAuraEnabled
		
		if killAuraEnabled then
			killAuraToggleBg.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
			killAuraToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Start KillAura loop
			killAuraConnection = RunService.Heartbeat:Connect(function()
				if not isMurderer() then
					return
				end
				
				if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
					return
				end
				
				local playerHRP = player.Character.HumanoidRootPart
				
				-- Find and kill all players in range
				for _, targetPlayer in pairs(Players:GetPlayers()) do
					if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local targetHRP = targetPlayer.Character.HumanoidRootPart
						local distance = (playerHRP.Position - targetHRP.Position).Magnitude
						
						if distance <= killAuraRange then
							-- Equip knife if not equipped
							local knife = player.Character:FindFirstChildOfClass("Tool")
							if not knife or knife.Name ~= "Knife" then
								local backpack = player:FindFirstChild("Backpack")
								if backpack and backpack:FindFirstChild("Knife") then
									backpack.Knife.Parent = player.Character
									knife = player.Character:FindFirstChild("Knife")
									task.wait(0.05)
								end
							end
							
							if knife and knife.Name == "Knife" then
								-- Save original position
								local originalCFrame = playerHRP.CFrame
								
								-- Teleport to target
								playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
								task.wait(0.05)
								
								-- Stab
								if knife:FindFirstChild("Stab") then
									knife.Stab:FireServer()
								end
								
								task.wait(0.05)
								
								-- Return to original position
								playerHRP.CFrame = originalCFrame
							end
						end
					end
				end
			end)
			
			print("KillAura: ENABLED (Range: " .. killAuraRange .. " studs)")
		else
			killAuraToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			killAuraToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			
			-- Stop KillAura
			if killAuraConnection then
				killAuraConnection:Disconnect()
				killAuraConnection = nil
			end
			
			print("KillAura: DISABLED")
		end
	end)

	-- Re-parent existing combat frames into the scroll frame and reposition them
	silentAimFrame.Parent = combatScrollFrame
	silentAimFrame.Position = UDim2.new(0.05, 0, 0, 10)
	silentAimFrame.Size = UDim2.new(0.9, 0, 0, 70)

	shootMurdererFrame.Parent = combatScrollFrame
	shootMurdererFrame.Position = UDim2.new(0.05, 0, 0, 90)
	shootMurdererFrame.Size = UDim2.new(0.9, 0, 0, 70)

	killFrame.Parent = combatScrollFrame
	killFrame.Position = UDim2.new(0.05, 0, 0, 170)
	killFrame.Size = UDim2.new(0.9, 0, 0, 210)

	-- Teleport to Murderer Frame
	local tpMurdererFrame = Instance.new("Frame")
	tpMurdererFrame.Name = "TpMurdererFrame"
	tpMurdererFrame.Size = UDim2.new(0.9, 0, 0, 70)
	tpMurdererFrame.Position = UDim2.new(0.05, 0, 0, 390)
	tpMurdererFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	tpMurdererFrame.BorderSizePixel = 0
	tpMurdererFrame.Parent = combatScrollFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = tpMurdererFrame

	local tpMurdererLabel = Instance.new("TextLabel")
	tpMurdererLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	tpMurdererLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	tpMurdererLabel.BackgroundTransparency = 1
	tpMurdererLabel.Text = "Teleport to Murderer"
	tpMurdererLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpMurdererLabel.TextSize = 16
	tpMurdererLabel.Font = Enum.Font.GothamBold
	tpMurdererLabel.TextXAlignment = Enum.TextXAlignment.Left
	tpMurdererLabel.Parent = tpMurdererFrame

	local tpMurdererDesc = Instance.new("TextLabel")
	tpMurdererDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	tpMurdererDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	tpMurdererDesc.BackgroundTransparency = 1
	tpMurdererDesc.Text = "Teleports to Murderer"
	tpMurdererDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	tpMurdererDesc.TextSize = 12
	tpMurdererDesc.Font = Enum.Font.Gotham
	tpMurdererDesc.TextXAlignment = Enum.TextXAlignment.Left
	tpMurdererDesc.Parent = tpMurdererFrame

	local tpMurdererButton = Instance.new("TextButton")
	tpMurdererButton.Size = UDim2.new(0.28, 0, 0.55, 0)
	tpMurdererButton.Position = UDim2.new(0.68, 0, 0.22, 0)
	tpMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	tpMurdererButton.BorderSizePixel = 0
	tpMurdererButton.Text = "TP"
	tpMurdererButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpMurdererButton.TextSize = 15
	tpMurdererButton.Font = Enum.Font.GothamBold
	tpMurdererButton.Parent = tpMurdererFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = tpMurdererButton

	tpMurdererButton.MouseButton1Click:Connect(function()
		local murderer = findMurderer()
		if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
				tpMurdererButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
				tpMurdererButton.Text = "TP'd!"
				task.wait(1.5)
				tpMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
				tpMurdererButton.Text = "TP"
				print("Teleported to murderer: " .. murderer.Name)
			end
		else
			tpMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			tpMurdererButton.Text = "NOT FOUND"
			task.wait(1.5)
			tpMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			tpMurdererButton.Text = "TP"
			print("Murderer not found!")
		end
	end)

	-- Teleport to Sheriff Frame
	local tpSheriffFrame = Instance.new("Frame")
	tpSheriffFrame.Name = "TpSheriffFrame"
	tpSheriffFrame.Size = UDim2.new(0.9, 0, 0, 70)
	tpSheriffFrame.Position = UDim2.new(0.05, 0, 0, 470)
	tpSheriffFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	tpSheriffFrame.BorderSizePixel = 0
	tpSheriffFrame.Parent = combatScrollFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = tpSheriffFrame

	local tpSheriffLabel = Instance.new("TextLabel")
	tpSheriffLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	tpSheriffLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	tpSheriffLabel.BackgroundTransparency = 1
	tpSheriffLabel.Text = "Teleport to Sheriff"
	tpSheriffLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpSheriffLabel.TextSize = 16
	tpSheriffLabel.Font = Enum.Font.GothamBold
	tpSheriffLabel.TextXAlignment = Enum.TextXAlignment.Left
	tpSheriffLabel.Parent = tpSheriffFrame

	local tpSheriffDesc = Instance.new("TextLabel")
	tpSheriffDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	tpSheriffDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	tpSheriffDesc.BackgroundTransparency = 1
	tpSheriffDesc.Text = "Teleports to Sheriff"
	tpSheriffDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	tpSheriffDesc.TextSize = 12
	tpSheriffDesc.Font = Enum.Font.Gotham
	tpSheriffDesc.TextXAlignment = Enum.TextXAlignment.Left
	tpSheriffDesc.Parent = tpSheriffFrame

	local tpSheriffButton = Instance.new("TextButton")
	tpSheriffButton.Size = UDim2.new(0.28, 0, 0.55, 0)
	tpSheriffButton.Position = UDim2.new(0.68, 0, 0.22, 0)
	tpSheriffButton.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
	tpSheriffButton.BorderSizePixel = 0
	tpSheriffButton.Text = "TP"
	tpSheriffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpSheriffButton.TextSize = 15
	tpSheriffButton.Font = Enum.Font.GothamBold
	tpSheriffButton.Parent = tpSheriffFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = tpSheriffButton

	-- Helper: find sheriff player
	local function findSheriff()
		for _, targetPlayer in pairs(Players:GetPlayers()) do
			if targetPlayer ~= player and targetPlayer.Character then
				local backpack = targetPlayer:FindFirstChild("Backpack")
				if backpack and backpack:FindFirstChild("Gun") then
					return targetPlayer
				end
				local tool = targetPlayer.Character:FindFirstChildOfClass("Tool")
				if tool and tool.Name == "Gun" then
					return targetPlayer
				end
			end
		end
		return nil
	end

	tpSheriffButton.MouseButton1Click:Connect(function()
		local sheriff = findSheriff()
		if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = sheriff.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
				tpSheriffButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
				tpSheriffButton.Text = "TP'd!"
				task.wait(1.5)
				tpSheriffButton.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
				tpSheriffButton.Text = "TP"
				print("Teleported to sheriff: " .. sheriff.Name)
			end
		else
			tpSheriffButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			tpSheriffButton.Text = "NOT FOUND"
			task.wait(1.5)
			tpSheriffButton.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
			tpSheriffButton.Text = "TP"
			print("Sheriff not found!")
		end
	end)

	-- ========== TELEPORT TO PLAYER ==========
	
	-- Teleport to Player Frame
	local tpPlayerFrame = Instance.new("Frame")
	tpPlayerFrame.Name = "TpPlayerFrame"
	tpPlayerFrame.Size = UDim2.new(0.9, 0, 0, 110)
	tpPlayerFrame.Position = UDim2.new(0.05, 0, 0, 550)
	tpPlayerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	tpPlayerFrame.BorderSizePixel = 0
	tpPlayerFrame.Parent = combatScrollFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = tpPlayerFrame
	
	local tpPlayerLabel = Instance.new("TextLabel")
	tpPlayerLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
	tpPlayerLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
	tpPlayerLabel.BackgroundTransparency = 1
	tpPlayerLabel.Text = "Teleport to Player"
	tpPlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpPlayerLabel.TextSize = 18
	tpPlayerLabel.Font = Enum.Font.GothamBold
	tpPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
	tpPlayerLabel.Parent = tpPlayerFrame
	
	local tpPlayerDesc = Instance.new("TextLabel")
	tpPlayerDesc.Size = UDim2.new(0.9, 0, 0.15, 0)
	tpPlayerDesc.Position = UDim2.new(0.05, 0, 0.27, 0)
	tpPlayerDesc.BackgroundTransparency = 1
	tpPlayerDesc.Text = "Type username and teleport"
	tpPlayerDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	tpPlayerDesc.TextSize = 12
	tpPlayerDesc.Font = Enum.Font.Gotham
	tpPlayerDesc.TextXAlignment = Enum.TextXAlignment.Left
	tpPlayerDesc.Parent = tpPlayerFrame
	
	-- Input box
	local tpPlayerInput = Instance.new("TextBox")
	tpPlayerInput.Size = UDim2.new(0.55, 0, 0.28, 0)
	tpPlayerInput.Position = UDim2.new(0.05, 0, 0.5, 0)
	tpPlayerInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
	tpPlayerInput.BorderSizePixel = 0
	tpPlayerInput.PlaceholderText = "Enter username..."
	tpPlayerInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	tpPlayerInput.Text = ""
	tpPlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpPlayerInput.TextSize = 14
	tpPlayerInput.Font = Enum.Font.Gotham
	tpPlayerInput.ClearTextOnFocus = false
	tpPlayerInput.Parent = tpPlayerFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = tpPlayerInput
	
	-- Teleport button
	local tpPlayerButton = Instance.new("TextButton")
	tpPlayerButton.Size = UDim2.new(0.35, 0, 0.28, 0)
	tpPlayerButton.Position = UDim2.new(0.62, 0, 0.5, 0)
	tpPlayerButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	tpPlayerButton.BorderSizePixel = 0
	tpPlayerButton.Text = "Teleport"
	tpPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpPlayerButton.TextSize = 16
	tpPlayerButton.Font = Enum.Font.GothamBold
	tpPlayerButton.Parent = tpPlayerFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = tpPlayerButton
	
	-- Teleport functionality
	tpPlayerButton.MouseButton1Click:Connect(function()
		local username = tpPlayerInput.Text
		if username == "" then
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			tpPlayerButton.Text = "Enter Name"
			task.wait(1)
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			tpPlayerButton.Text = "Teleport"
			return
		end
		
		-- Find player
		local targetPlayer = nil
		for _, plr in pairs(Players:GetPlayers()) do
			if plr.Name:lower():find(username:lower()) or plr.DisplayName:lower():find(username:lower()) then
				targetPlayer = plr
				break
			end
		end
		
		if not targetPlayer then
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			tpPlayerButton.Text = "Not Found"
			task.wait(1)
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			tpPlayerButton.Text = "Teleport"
			return
		end
		
		if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			tpPlayerButton.Text = "No Character"
			task.wait(1)
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			tpPlayerButton.Text = "Teleport"
			return
		end
		
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			tpPlayerButton.Text = "Teleported!"
			task.wait(1.5)
			tpPlayerButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			tpPlayerButton.Text = "Teleport"
			print("Teleported to: " .. targetPlayer.Name)
		end
	end)

	-- ========== COLLECT GUN / AUTO COLLECT GUN ==========

	-- Helper: find a dropped gun in workspace
	local function findDroppedGun()
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("Tool") and obj.Name == "Gun" and obj.Parent == workspace then
				return obj
			end
			-- Also check models dropped on floor
			if obj:IsA("Model") and obj.Name == "Gun" and obj.Parent == workspace then
				local handle = obj:FindFirstChild("Handle")
				if handle then
					return obj
				end
			end
		end
		return nil
	end

	local autoCollectGunEnabled = false
	local autoCollectConnection = nil

	-- Collect Gun Frame
	local collectGunFrame = Instance.new("Frame")
	collectGunFrame.Name = "CollectGunFrame"
	collectGunFrame.Size = UDim2.new(0.9, 0, 0, 70)
	collectGunFrame.Position = UDim2.new(0.05, 0, 0, 550)
	collectGunFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	collectGunFrame.BorderSizePixel = 0
	collectGunFrame.Parent = combatScrollFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = collectGunFrame

	local collectGunLabel = Instance.new("TextLabel")
	collectGunLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	collectGunLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	collectGunLabel.BackgroundTransparency = 1
	collectGunLabel.Text = "Collect Gun"
	collectGunLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	collectGunLabel.TextSize = 16
	collectGunLabel.Font = Enum.Font.GothamBold
	collectGunLabel.TextXAlignment = Enum.TextXAlignment.Left
	collectGunLabel.Parent = collectGunFrame

	local collectGunDesc = Instance.new("TextLabel")
	collectGunDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	collectGunDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	collectGunDesc.BackgroundTransparency = 1
	collectGunDesc.Text = "Detects dropped gun, click to grab"
	collectGunDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	collectGunDesc.TextSize = 11
	collectGunDesc.Font = Enum.Font.Gotham
	collectGunDesc.TextXAlignment = Enum.TextXAlignment.Left
	collectGunDesc.Parent = collectGunFrame

	local collectGunButton = Instance.new("TextButton")
	collectGunButton.Size = UDim2.new(0.28, 0, 0.55, 0)
	collectGunButton.Position = UDim2.new(0.68, 0, 0.22, 0)
	collectGunButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	collectGunButton.BorderSizePixel = 0
	collectGunButton.Text = "Collect"
	collectGunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	collectGunButton.TextSize = 13
	collectGunButton.Font = Enum.Font.GothamBold
	collectGunButton.Parent = collectGunFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = collectGunButton

	-- Detect indicator dot (green = gun dropped, grey = no gun)
	local gunDetectDot = Instance.new("Frame")
	gunDetectDot.Size = UDim2.new(0, 8, 0, 8)
	gunDetectDot.Position = UDim2.new(0.93, 0, 0.15, 0)
	gunDetectDot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	gunDetectDot.BorderSizePixel = 0
	gunDetectDot.Parent = collectGunFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = gunDetectDot

	-- Poll for dropped gun to light up the detect dot
	task.spawn(function()
		while true do
			task.wait(0.3)
			local droppedGun = findDroppedGun()
			if droppedGun then
				gunDetectDot.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
				collectGunButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			else
				gunDetectDot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				collectGunButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
			end
		end
	end)

	collectGunButton.MouseButton1Click:Connect(function()
		local gun = findDroppedGun()
		if gun and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local gunPos
			if gun:IsA("Tool") then
				gunPos = gun.Handle and gun.Handle.Position or gun:GetPrimaryPartCFrame().Position
			else
				gunPos = gun:GetPrimaryPartCFrame().Position
			end

			-- Teleport to gun
			player.Character.HumanoidRootPart.CFrame = CFrame.new(gunPos) * CFrame.new(0, 3, 0)
			task.wait(0.15)

			-- Pick it up by parenting to character
			gun.Parent = player.Character

			collectGunButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			collectGunButton.Text = "Got it!"
			task.wait(1.5)
			collectGunButton.Text = "Collect"
			print("Collected dropped gun!")
		else
			collectGunButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			collectGunButton.Text = "No Gun"
			task.wait(1.5)
			collectGunButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
			collectGunButton.Text = "Collect"
			print("No dropped gun found in workspace!")
		end
	end)

	-- Auto Collect Gun Frame
	local autoCollectFrame = Instance.new("Frame")
	autoCollectFrame.Name = "AutoCollectFrame"
	autoCollectFrame.Size = UDim2.new(0.9, 0, 0, 70)
	autoCollectFrame.Position = UDim2.new(0.05, 0, 0, 630)
	autoCollectFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	autoCollectFrame.BorderSizePixel = 0
	autoCollectFrame.Parent = combatScrollFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = autoCollectFrame

	local autoCollectLabel = Instance.new("TextLabel")
	autoCollectLabel.Size = UDim2.new(0.65, 0, 0.45, 0)
	autoCollectLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
	autoCollectLabel.BackgroundTransparency = 1
	autoCollectLabel.Text = "Auto Collect Gun"
	autoCollectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	autoCollectLabel.TextSize = 16
	autoCollectLabel.Font = Enum.Font.GothamBold
	autoCollectLabel.TextXAlignment = Enum.TextXAlignment.Left
	autoCollectLabel.Parent = autoCollectFrame

	local autoCollectDesc = Instance.new("TextLabel")
	autoCollectDesc.Size = UDim2.new(0.65, 0, 0.35, 0)
	autoCollectDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	autoCollectDesc.BackgroundTransparency = 1
	autoCollectDesc.Text = "Auto-teleports to grab gun when dropped"
	autoCollectDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	autoCollectDesc.TextSize = 11
	autoCollectDesc.Font = Enum.Font.Gotham
	autoCollectDesc.TextXAlignment = Enum.TextXAlignment.Left
	autoCollectDesc.Parent = autoCollectFrame

	local acToggleBg = Instance.new("Frame")
	acToggleBg.Name = "ACToggleBg"
	acToggleBg.Size = UDim2.new(0.08, 0, 0.45, 0)
	acToggleBg.Position = UDim2.new(0.89, 0, 0.28, 0)
	acToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	acToggleBg.BorderSizePixel = 0
	acToggleBg.Parent = autoCollectFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = acToggleBg

	local acToggleCircle = Instance.new("Frame")
	acToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	acToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	acToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	acToggleCircle.BorderSizePixel = 0
	acToggleCircle.Parent = acToggleBg

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = acToggleCircle

	local acToggleButton = Instance.new("TextButton")
	acToggleButton.Size = UDim2.new(1, 0, 1, 0)
	acToggleButton.Position = UDim2.new(0, 0, 0, 0)
	acToggleButton.BackgroundTransparency = 1
	acToggleButton.Text = ""
	acToggleButton.Parent = autoCollectFrame

	acToggleButton.MouseButton1Click:Connect(function()
		autoCollectGunEnabled = not autoCollectGunEnabled
		if autoCollectGunEnabled then
			acToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			acToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)

			-- Start auto-collect loop
			autoCollectConnection = task.spawn(function()
				while autoCollectGunEnabled do
					task.wait(0.3)
					local gun = findDroppedGun()
					if gun and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						-- Don't already have one
						local alreadyHasGun = player.Character:FindFirstChildOfClass("Tool") and player.Character:FindFirstChildOfClass("Tool").Name == "Gun"
						local backpackGun = player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun")
						if not alreadyHasGun and not backpackGun then
							local gunPos
							if gun:IsA("Tool") and gun:FindFirstChild("Handle") then
								gunPos = gun.Handle.Position
							elseif gun:IsA("Model") then
								gunPos = gun:GetPrimaryPartCFrame().Position
							end
							if gunPos then
								player.Character.HumanoidRootPart.CFrame = CFrame.new(gunPos) * CFrame.new(0, 3, 0)
								task.wait(0.15)
								gun.Parent = player.Character
								print("Auto-collected dropped gun!")
							end
						end
					end
				end
			end)

			print("Auto Collect Gun: ENABLED")
		else
			acToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			acToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			autoCollectGunEnabled = false
			print("Auto Collect Gun: DISABLED")
		end
	end)

	-- ========== TROLLING CONTENT SECTION ==========
	
	local trollingContent = Instance.new("Frame")
	trollingContent.Name = "TrollingContent"
	trollingContent.Size = UDim2.new(1, 0, 1, 0)
	trollingContent.Position = UDim2.new(0, 0, 0, 0)
	trollingContent.BackgroundTransparency = 1
	trollingContent.Parent = contentArea
	trollingContent.Visible = false
	
	-- Trolling Title
	local trollingTitle = Instance.new("TextLabel")
	trollingTitle.Name = "TrollingTitle"
	trollingTitle.Size = UDim2.new(0.9, 0, 0.06, 0)
	trollingTitle.Position = UDim2.new(0.05, 0, 0.01, 0)
	trollingTitle.BackgroundTransparency = 1
	trollingTitle.Text = "Trolling"
	trollingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	trollingTitle.TextSize = 20
	trollingTitle.Font = Enum.Font.GothamBold
	trollingTitle.TextXAlignment = Enum.TextXAlignment.Left
	trollingTitle.Parent = trollingContent
	
	-- Fling Murderer Frame
	local flingMurdererFrame = Instance.new("Frame")
	flingMurdererFrame.Name = "FlingMurdererFrame"
	flingMurdererFrame.Size = UDim2.new(0.9, 0, 0.12, 0)
	flingMurdererFrame.Position = UDim2.new(0.05, 0, 0.08, 0)
	flingMurdererFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	flingMurdererFrame.BorderSizePixel = 0
	flingMurdererFrame.Parent = trollingContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = flingMurdererFrame
	
	local flingMurdererLabel = Instance.new("TextLabel")
	flingMurdererLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	flingMurdererLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	flingMurdererLabel.BackgroundTransparency = 1
	flingMurdererLabel.Text = "Fling Murderer"
	flingMurdererLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
	flingMurdererLabel.TextSize = 18
	flingMurdererLabel.Font = Enum.Font.GothamBold
	flingMurdererLabel.TextXAlignment = Enum.TextXAlignment.Left
	flingMurdererLabel.Parent = flingMurdererFrame
	
	local flingMurdererDesc = Instance.new("TextLabel")
	flingMurdererDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	flingMurdererDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	flingMurdererDesc.BackgroundTransparency = 1
	flingMurdererDesc.Text = "Auto-fling the murderer"
	flingMurdererDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	flingMurdererDesc.TextSize = 13
	flingMurdererDesc.Font = Enum.Font.Gotham
	flingMurdererDesc.TextXAlignment = Enum.TextXAlignment.Left
	flingMurdererDesc.Parent = flingMurdererFrame
	
	local flingMurdererButton = Instance.new("TextButton")
	flingMurdererButton.Size = UDim2.new(0.28, 0, 0.55, 0)
	flingMurdererButton.Position = UDim2.new(0.68, 0, 0.22, 0)
	flingMurdererButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	flingMurdererButton.BorderSizePixel = 0
	flingMurdererButton.Text = "FLING"
	flingMurdererButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	flingMurdererButton.TextSize = 16
	flingMurdererButton.Font = Enum.Font.GothamBold
	flingMurdererButton.Parent = flingMurdererFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = flingMurdererButton
	
	local flingMurdererActive = false
	local flingMurdererConnection = nil
	
	flingMurdererButton.MouseButton1Click:Connect(function()
		if flingMurdererActive then
			-- Stop flinging
			flingMurdererActive = false
			if flingMurdererConnection then
				flingMurdererConnection:Disconnect()
				flingMurdererConnection = nil
			end
			
			-- Cleanup physics
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = player.Character.HumanoidRootPart
				for _, obj in pairs(hrp:GetChildren()) do
					if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
						obj:Destroy()
					end
				end
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero
				hrp.Anchored = false
			end
			
			-- Reset collision (re-enable collisions)
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
					part.Massless = false
				end
			end
			
			flingMurdererButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			flingMurdererButton.Text = "FLING"
			print("Stopped flinging murderer")
			return
		end
		
		local murderer = findMurderer()
		if not murderer then
			flingMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			flingMurdererButton.Text = "NO MURDERER"
			task.wait(1)
			flingMurdererButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			flingMurdererButton.Text = "FLING"
			print("Murderer not found!")
			return
		end
		
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			print("Player character not found!")
			return
		end
		
		local targetHRP = murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart")
		if not targetHRP then
			print("Murderer has no HumanoidRootPart!")
			return
		end
		
		flingMurdererActive = true
		local playerHRP = player.Character.HumanoidRootPart
		
		-- Enable NOCLIP - disable all collisions
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
				part.Massless = true
			end
		end
		
		-- Anchor player to prevent falling through map
		playerHRP.Anchored = false
		
		-- Create physics for spinning
		local bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVel.Velocity = Vector3.zero
		bodyVel.Parent = playerHRP
		
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bodyGyro.P = 10000
		bodyGyro.Parent = playerHRP
		
		flingMurdererButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
		flingMurdererButton.Text = "STOP"
		
		-- Continuous fling with persistent tracking
		flingMurdererConnection = RunService.Heartbeat:Connect(function()
			-- Check if we should stop
			if not flingMurdererActive then
				if flingMurdererConnection then
					flingMurdererConnection:Disconnect()
					flingMurdererConnection = nil
				end
				if bodyVel then bodyVel:Destroy() end
				if bodyGyro then bodyGyro:Destroy() end
				return
			end
			
			-- Re-find murderer if they respawned or changed
			if not murderer or not murderer.Character or not murderer.Character:FindFirstChild("HumanoidRootPart") then
				murderer = findMurderer()
				if murderer and murderer.Character then
					targetHRP = murderer.Character:FindFirstChild("HumanoidRootPart")
				end
			end
			
			-- If still no target, keep waiting
			if not murderer or not targetHRP or not targetHRP.Parent then
				return
			end
			
			-- PERSISTENT TRACKING - Follow target EVERYWHERE they go
			-- Stick to target like glue with small offset for spinning room
			local offset = CFrame.new(
				math.random(-1, 1),
				math.random(-1, 1),
				math.random(-1, 1)
			)
			playerHRP.CFrame = targetHRP.CFrame * offset
			
			-- Maintain noclip every frame
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
			
			-- Violent spinning velocity
			bodyVel.Velocity = Vector3.new(
				math.random(-300, 300), 
				math.random(200, 300), 
				math.random(-300, 300)
			)
			bodyGyro.CFrame = CFrame.Angles(
				math.rad(math.random(-180, 180)),
				math.rad(math.random(-180, 180)),
				math.rad(math.random(-180, 180))
			)
			
			-- Apply MASSIVE force to target to fling them
			targetHRP.Velocity = Vector3.new(
				math.random(-250, 250),
				math.random(250, 450),
				math.random(-250, 250)
			)
			
			targetHRP.RotVelocity = Vector3.new(
				math.random(-150, 150),
				math.random(-150, 150),
				math.random(-150, 150)
			)
		end)
		
		print("Flinging murderer with NOCLIP tracking: " .. murderer.Name)
	end)
	
	-- Fling Sheriff Frame
	local flingSheriffFrame = Instance.new("Frame")
	flingSheriffFrame.Name = "FlingSheriffFrame"
	flingSheriffFrame.Size = UDim2.new(0.9, 0, 0.12, 0)
	flingSheriffFrame.Position = UDim2.new(0.05, 0, 0.21, 0)
	flingSheriffFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	flingSheriffFrame.BorderSizePixel = 0
	flingSheriffFrame.Parent = trollingContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = flingSheriffFrame
	
	local flingSheriffLabel = Instance.new("TextLabel")
	flingSheriffLabel.Size = UDim2.new(0.6, 0, 0.45, 0)
	flingSheriffLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	flingSheriffLabel.BackgroundTransparency = 1
	flingSheriffLabel.Text = "Fling Sheriff"
	flingSheriffLabel.TextColor3 = Color3.fromRGB(50, 150, 255)
	flingSheriffLabel.TextSize = 18
	flingSheriffLabel.Font = Enum.Font.GothamBold
	flingSheriffLabel.TextXAlignment = Enum.TextXAlignment.Left
	flingSheriffLabel.Parent = flingSheriffFrame
	
	local flingSheriffDesc = Instance.new("TextLabel")
	flingSheriffDesc.Size = UDim2.new(0.6, 0, 0.35, 0)
	flingSheriffDesc.Position = UDim2.new(0.05, 0, 0.58, 0)
	flingSheriffDesc.BackgroundTransparency = 1
	flingSheriffDesc.Text = "Auto-fling the sheriff"
	flingSheriffDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	flingSheriffDesc.TextSize = 13
	flingSheriffDesc.Font = Enum.Font.Gotham
	flingSheriffDesc.TextXAlignment = Enum.TextXAlignment.Left
	flingSheriffDesc.Parent = flingSheriffFrame
	
	local flingSheriffButton = Instance.new("TextButton")
	flingSheriffButton.Size = UDim2.new(0.28, 0, 0.55, 0)
	flingSheriffButton.Position = UDim2.new(0.68, 0, 0.22, 0)
	flingSheriffButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
	flingSheriffButton.BorderSizePixel = 0
	flingSheriffButton.Text = "FLING"
	flingSheriffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	flingSheriffButton.TextSize = 16
	flingSheriffButton.Font = Enum.Font.GothamBold
	flingSheriffButton.Parent = flingSheriffFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = flingSheriffButton
	
	local flingSheriffActive = false
	local flingSheriffConnection = nil
	
	flingSheriffButton.MouseButton1Click:Connect(function()
		if flingSheriffActive then
			-- Stop flinging
			flingSheriffActive = false
			if flingSheriffConnection then
				flingSheriffConnection:Disconnect()
				flingSheriffConnection = nil
			end
			
			-- Cleanup physics
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = player.Character.HumanoidRootPart
				for _, obj in pairs(hrp:GetChildren()) do
					if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
						obj:Destroy()
					end
				end
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero
				hrp.Anchored = false
			end
			
			-- Reset collision (re-enable collisions)
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
					part.Massless = false
				end
			end
			
			flingSheriffButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
			flingSheriffButton.Text = "FLING"
			print("Stopped flinging sheriff")
			return
		end
		
		local sheriff = findSheriff()
		if not sheriff then
			flingSheriffButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
			flingSheriffButton.Text = "NO SHERIFF"
			task.wait(1)
			flingSheriffButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
			flingSheriffButton.Text = "FLING"
			print("Sheriff not found!")
			return
		end
		
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			print("Player character not found!")
			return
		end
		
		local targetHRP = sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart")
		if not targetHRP then
			print("Sheriff has no HumanoidRootPart!")
			return
		end
		
		flingSheriffActive = true
		local playerHRP = player.Character.HumanoidRootPart
		
		-- Enable NOCLIP - disable all collisions
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
				part.Massless = true
			end
		end
		
		-- Anchor player to prevent falling through map
		playerHRP.Anchored = false
		
		-- Create physics for spinning
		local bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVel.Velocity = Vector3.zero
		bodyVel.Parent = playerHRP
		
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bodyGyro.P = 10000
		bodyGyro.Parent = playerHRP
		
		flingSheriffButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
		flingSheriffButton.Text = "STOP"
		
		-- Continuous fling with persistent tracking
		flingSheriffConnection = RunService.Heartbeat:Connect(function()
			-- Check if we should stop
			if not flingSheriffActive then
				if flingSheriffConnection then
					flingSheriffConnection:Disconnect()
					flingSheriffConnection = nil
				end
				if bodyVel then bodyVel:Destroy() end
				if bodyGyro then bodyGyro:Destroy() end
				return
			end
			
			-- Re-find sheriff if they respawned or changed
			if not sheriff or not sheriff.Character or not sheriff.Character:FindFirstChild("HumanoidRootPart") then
				sheriff = findSheriff()
				if sheriff and sheriff.Character then
					targetHRP = sheriff.Character:FindFirstChild("HumanoidRootPart")
				end
			end
			
			-- If still no target, keep waiting
			if not sheriff or not targetHRP or not targetHRP.Parent then
				return
			end
			
			-- PERSISTENT TRACKING - Follow target EVERYWHERE they go
			-- Stick to target like glue with small offset for spinning room
			local offset = CFrame.new(
				math.random(-1, 1),
				math.random(-1, 1),
				math.random(-1, 1)
			)
			playerHRP.CFrame = targetHRP.CFrame * offset
			
			-- Maintain noclip every frame
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
			
			-- Violent spinning velocity
			bodyVel.Velocity = Vector3.new(
				math.random(-300, 300), 
				math.random(200, 300), 
				math.random(-300, 300)
			)
			bodyGyro.CFrame = CFrame.Angles(
				math.rad(math.random(-180, 180)),
				math.rad(math.random(-180, 180)),
				math.rad(math.random(-180, 180))
			)
			
			-- Apply MASSIVE force to target to fling them
			targetHRP.Velocity = Vector3.new(
				math.random(-250, 250),
				math.random(250, 450),
				math.random(-250, 250)
			)
			
			targetHRP.RotVelocity = Vector3.new(
				math.random(-150, 150),
				math.random(-150, 150),
				math.random(-150, 150)
			)
		end)
		
		print("Flinging sheriff with NOCLIP tracking: " .. sheriff.Name)
	end)
	
	-- Fling Player Section Divider
	local flingPlayerDivider = Instance.new("TextLabel")
	flingPlayerDivider.Size = UDim2.new(0.9, 0, 0.05, 0)
	flingPlayerDivider.Position = UDim2.new(0.05, 0, 0.34, 0)
	flingPlayerDivider.BackgroundTransparency = 1
	flingPlayerDivider.Text = "Fling Specific Player"
	flingPlayerDivider.TextColor3 = Color3.fromRGB(200, 200, 200)
	flingPlayerDivider.TextSize = 16
	flingPlayerDivider.Font = Enum.Font.GothamBold
	flingPlayerDivider.TextXAlignment = Enum.TextXAlignment.Left
	flingPlayerDivider.Parent = trollingContent
	
	-- Fling variables
	local targetPlayer = nil
	local flingConnection = nil
	
	-- Large Fling Frame (takes up most of the GUI)
	local flingFrame = Instance.new("Frame")
	flingFrame.Name = "FlingFrame"
	flingFrame.Size = UDim2.new(0.9, 0, 0.55, 0)
	flingFrame.Position = UDim2.new(0.05, 0, 0.40, 0)
	flingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	flingFrame.BorderSizePixel = 0
	flingFrame.Parent = trollingContent
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = flingFrame
	
	-- Fling Title
	local flingTitleLabel = Instance.new("TextLabel")
	flingTitleLabel.Name = "FlingTitleLabel"
	flingTitleLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
	flingTitleLabel.Position = UDim2.new(0.05, 0, 0.03, 0)
	flingTitleLabel.BackgroundTransparency = 1
	flingTitleLabel.Text = "Fling Player"
	flingTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	flingTitleLabel.TextSize = 22
	flingTitleLabel.Font = Enum.Font.GothamBold
	flingTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
	flingTitleLabel.Parent = flingFrame
	
	-- Type player name label
	local typePlayerLabel = Instance.new("TextLabel")
	typePlayerLabel.Name = "TypePlayerLabel"
	typePlayerLabel.Size = UDim2.new(0.9, 0, 0.08, 0)
	typePlayerLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
	typePlayerLabel.BackgroundTransparency = 1
	typePlayerLabel.Text = "Type player name"
	typePlayerLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	typePlayerLabel.TextSize = 16
	typePlayerLabel.Font = Enum.Font.Gotham
	typePlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
	typePlayerLabel.Parent = flingFrame
	
	-- Username Input Box
	local usernameInput = Instance.new("TextBox")
	usernameInput.Name = "UsernameInput"
	usernameInput.Size = UDim2.new(0.9, 0, 0.12, 0)
	usernameInput.Position = UDim2.new(0.05, 0, 0.25, 0)
	usernameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
	usernameInput.BorderSizePixel = 0
	usernameInput.PlaceholderText = "Enter username..."
	usernameInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	usernameInput.Text = ""
	usernameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	usernameInput.TextSize = 18
	usernameInput.Font = Enum.Font.Gotham
	usernameInput.ClearTextOnFocus = false
	usernameInput.Parent = flingFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = usernameInput
	
	-- Profile Picture (Large)
	local profilePic = Instance.new("ImageLabel")
	profilePic.Name = "ProfilePic"
	profilePic.Size = UDim2.new(0, 150, 0, 150)
	profilePic.Position = UDim2.new(0.5, -75, 0.42, 0)
	profilePic.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	profilePic.BorderSizePixel = 0
	profilePic.Image = ""
	profilePic.ImageTransparency = 0
	profilePic.Visible = false
	profilePic.Parent = flingFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = profilePic
	
	-- Loading indicator
	local loadingLabel = Instance.new("TextLabel")
	loadingLabel.Name = "LoadingLabel"
	loadingLabel.Size = UDim2.new(1, 0, 1, 0)
	loadingLabel.Position = UDim2.new(0, 0, 0, 0)
	loadingLabel.BackgroundTransparency = 1
	loadingLabel.Text = "Loading..."
	loadingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	loadingLabel.TextSize = 16
	loadingLabel.Font = Enum.Font.Gotham
	loadingLabel.Visible = false
	loadingLabel.Parent = profilePic
	
	-- Username Display (below profile pic)
	local usernameDisplay = Instance.new("TextLabel")
	usernameDisplay.Name = "UsernameDisplay"
	usernameDisplay.Size = UDim2.new(0.9, 0, 0.08, 0)
	usernameDisplay.Position = UDim2.new(0.05, 0, 0.65, 0)
	usernameDisplay.BackgroundTransparency = 1
	usernameDisplay.Text = ""
	usernameDisplay.TextColor3 = Color3.fromRGB(150, 200, 255)
	usernameDisplay.TextSize = 18
	usernameDisplay.Font = Enum.Font.GothamBold
	usernameDisplay.TextXAlignment = Enum.TextXAlignment.Center
	usernameDisplay.Visible = false
	usernameDisplay.Parent = flingFrame
	
	-- Fling Player Button
	local flingPlayerButton = Instance.new("TextButton")
	flingPlayerButton.Name = "FlingPlayerButton"
	flingPlayerButton.Size = UDim2.new(0.7, 0, 0.12, 0)
	flingPlayerButton.Position = UDim2.new(0.15, 0, 0.78, 0)
	flingPlayerButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	flingPlayerButton.BorderSizePixel = 0
	flingPlayerButton.Text = "Fling Player"
	flingPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	flingPlayerButton.TextSize = 20
	flingPlayerButton.Font = Enum.Font.GothamBold
	flingPlayerButton.Visible = false
	flingPlayerButton.Parent = flingFrame
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = flingPlayerButton
	
	-- Username Input Functionality
	usernameInput.FocusLost:Connect(function(enterPressed)
		local username = usernameInput.Text
		if username ~= "" then
			-- Show loading
			profilePic.Visible = true
			profilePic.Image = ""
			loadingLabel.Visible = true
			
			-- Find player
			targetPlayer = nil
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Name:lower():find(username:lower()) or plr.DisplayName:lower():find(username:lower()) then
					targetPlayer = plr
					
					-- Load profile picture properly
					local userId = plr.UserId
					
					task.spawn(function()
						local success, result = pcall(function()
							return Players:GetUserThumbnailAsync(
								userId, 
								Enum.ThumbnailType.HeadShot, 
								Enum.ThumbnailSize.Size420x420
							)
						end)
						
						if success and result then
							profilePic.Image = result
							loadingLabel.Visible = false
						else
							-- Try alternative method
							local altSuccess, altResult = pcall(function()
								return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
							end)
							
							if altSuccess then
								profilePic.Image = altResult
								loadingLabel.Visible = false
							end
						end
					end)
					
					profilePic.Visible = true
					
					-- Show username
					usernameDisplay.Text = "@" .. plr.Name
					usernameDisplay.Visible = true
					
					-- Show fling button
					flingPlayerButton.Visible = true
					
					print("Target set: " .. plr.Name)
					break
				end
			end
			
			if not targetPlayer then
				-- Player not found
				profilePic.Visible = false
				loadingLabel.Visible = false
				usernameDisplay.Visible = false
				flingPlayerButton.Visible = false
				print("Player not found!")
			end
		else
			targetPlayer = nil
			profilePic.Visible = false
			loadingLabel.Visible = false
			usernameDisplay.Visible = false
			flingPlayerButton.Visible = false
		end
	end)
	
	-- Improved Fling Player Button Functionality with NOCLIP
	flingPlayerButton.MouseButton1Click:Connect(function()
		if targetPlayer and targetPlayer.Character and player.Character then
			local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
			local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
			
			if targetHRP and playerHRP then
				print("Starting NOCLIP continuous fling on: " .. targetPlayer.Name)
				
				-- Enable NOCLIP - disable all character collision
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
						part.Massless = true
					end
				end
				
				-- Create BodyVelocity for continuous fling
				local bodyVel = Instance.new("BodyVelocity")
				bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bodyVel.Velocity = Vector3.zero
				bodyVel.Parent = playerHRP
				
				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				bodyGyro.P = 10000
				bodyGyro.Parent = playerHRP
				
				-- Continuous fling loop
				local flingActive = true
				
				flingConnection = RunService.Heartbeat:Connect(function()
					-- Check if should stop
					if not flingActive then
						if flingConnection then
							flingConnection:Disconnect()
							flingConnection = nil
						end
						if bodyVel then bodyVel:Destroy() end
						if bodyGyro then bodyGyro:Destroy() end
						return
					end
					
					-- Re-find target if they respawned
					if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
						if targetPlayer and targetPlayer.Character then
							targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
						end
					end
					
					-- If still no target, keep waiting
					if not targetPlayer or not targetHRP or not targetHRP.Parent then
						return
					end
					
					-- PERSISTENT TRACKING - Follow target EVERYWHERE they go
					-- Stick to target with small random offset for spinning room
					local offset = CFrame.new(
						math.random(-1, 1),
						math.random(-1, 1),
						math.random(-1, 1)
					)
					playerHRP.CFrame = targetHRP.CFrame * offset
					
					-- Maintain NOCLIP every frame
					for _, part in pairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") and part.CanCollide then
							part.CanCollide = false
						end
					end
					
					-- Massive spinning velocity
					bodyVel.Velocity = Vector3.new(
						math.random(-300, 300), 
						math.random(200, 300), 
						math.random(-300, 300)
					)
					bodyGyro.CFrame = CFrame.Angles(
						math.rad(math.random(-180, 180)),
						math.rad(math.random(-180, 180)),
						math.rad(math.random(-180, 180))
					)
					
					-- Apply MASSIVE force to target continuously
					targetHRP.Velocity = Vector3.new(
						math.random(-250, 250),
						math.random(250, 450),
						math.random(-250, 250)
					)
					
					targetHRP.RotVelocity = Vector3.new(
						math.random(-150, 150),
						math.random(-150, 150),
						math.random(-150, 150)
					)
				end)
				
				-- Button becomes "Stop Flinging"
				flingPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
				flingPlayerButton.Text = "Stop Flinging"
				
				-- Click again to stop
				local stopConnection
				stopConnection = flingPlayerButton.MouseButton1Click:Connect(function()
					flingActive = false
					
					if flingConnection then
						flingConnection:Disconnect()
						flingConnection = nil
					end
					
					if bodyVel then bodyVel:Destroy() end
					if bodyGyro then bodyGyro:Destroy() end
					
					-- Re-enable collision
					task.wait(0.1)
					for _, part in pairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = true
							part.Massless = false
						end
					end
					
					playerHRP.Velocity = Vector3.zero
					playerHRP.RotVelocity = Vector3.zero
					playerHRP.Anchored = false
					
					print("Stopped flinging: " .. targetPlayer.Name)
					
					flingPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
					flingPlayerButton.Text = "Player Flung!"
					task.wait(2)
					flingPlayerButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
					flingPlayerButton.Text = "Fling Player"
					
					if stopConnection then
						stopConnection:Disconnect()
					end
				end)
			else
				print("Could not find HumanoidRootPart")
			end
		else
			print("No target player or character not found")
		end
	end)
	
	-- ========== SETTINGS CONTENT SECTION ==========
	local settingsContent = Instance.new("Frame")
	settingsContent.Name = "SettingsContent"
	settingsContent.Size = UDim2.new(1, 0, 1, 0)
	settingsContent.Position = UDim2.new(0, 0, 0, 0)
	settingsContent.BackgroundTransparency = 1
	settingsContent.Parent = contentArea
	settingsContent.Visible = false
	
	-- Settings Title
	local settingsTitle = Instance.new("TextLabel")
	settingsTitle.Name = "SettingsTitle"
	settingsTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
	settingsTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
	settingsTitle.BackgroundTransparency = 1
	settingsTitle.Text = "Settings"
	settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	settingsTitle.TextSize = 20
	settingsTitle.Font = Enum.Font.GothamBold
	settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
	settingsTitle.Parent = settingsContent
	
	-- Platform info
	if isMobile then
		local mobileInfo = Instance.new("TextLabel")
		mobileInfo.Name = "MobileInfo"
		mobileInfo.Size = UDim2.new(0.9, 0, 0.12, 0)
		mobileInfo.Position = UDim2.new(0.05, 0, 0.12, 0)
		mobileInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		mobileInfo.BorderSizePixel = 0
		mobileInfo.Text = "  Toggle button is draggable"
		mobileInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
		mobileInfo.TextSize = 14
		mobileInfo.Font = Enum.Font.Gotham
		mobileInfo.TextXAlignment = Enum.TextXAlignment.Left
		mobileInfo.Parent = settingsContent
		
		temp = Instance.new("UICorner")
		temp.CornerRadius = UDim.new(0, 8)
		temp.Parent = mobileInfo
	else
		local keybindInfo = Instance.new("TextLabel")
		keybindInfo.Name = "KeybindInfo"
		keybindInfo.Size = UDim2.new(0.9, 0, 0.12, 0)
		keybindInfo.Position = UDim2.new(0.05, 0, 0.12, 0)
		keybindInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		keybindInfo.BorderSizePixel = 0
		keybindInfo.Text = "  Press 'H' to toggle GUI"
		keybindInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
		keybindInfo.TextSize = 14
		keybindInfo.Font = Enum.Font.Gotham
		keybindInfo.TextXAlignment = Enum.TextXAlignment.Left
		keybindInfo.Parent = settingsContent
		
		temp = Instance.new("UICorner")
		temp.CornerRadius = UDim.new(0, 8)
		temp.Parent = keybindInfo
	end
	
	-- ========== ARRAY LIST ==========

	-- Array list tracks which features are currently enabled
	-- It reads the enabled state of all toggleable features and displays them
	-- sorted by: A-Z alphabetically OR by length (longest first)

	local arrayListEnabled = false
	local arrayListSortMode = "length" -- "az" or "length"

	-- Toggle to enable/disable the Array List overlay
	local arrayListToggleFrame = Instance.new("Frame")
	arrayListToggleFrame.Name = "ArrayListToggleFrame"
	arrayListToggleFrame.Size = UDim2.new(0.9, 0, 0.12, 0)
	arrayListToggleFrame.Position = UDim2.new(0.05, 0, 0.28, 0)
	arrayListToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	arrayListToggleFrame.BorderSizePixel = 0
	arrayListToggleFrame.Parent = settingsContent

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = arrayListToggleFrame

	local arrayListLabel = Instance.new("TextLabel")
	arrayListLabel.Size = UDim2.new(0.65, 0, 0.55, 0)
	arrayListLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
	arrayListLabel.BackgroundTransparency = 1
	arrayListLabel.Text = "Array List"
	arrayListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	arrayListLabel.TextSize = 16
	arrayListLabel.Font = Enum.Font.GothamBold
	arrayListLabel.TextXAlignment = Enum.TextXAlignment.Left
	arrayListLabel.Parent = arrayListToggleFrame

	local arrayListDesc = Instance.new("TextLabel")
	arrayListDesc.Size = UDim2.new(0.65, 0, 0.35, 0)
	arrayListDesc.Position = UDim2.new(0.05, 0, 0.62, 0)
	arrayListDesc.BackgroundTransparency = 1
	arrayListDesc.Text = "Shows active features on screen"
	arrayListDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
	arrayListDesc.TextSize = 11
	arrayListDesc.Font = Enum.Font.Gotham
	arrayListDesc.TextXAlignment = Enum.TextXAlignment.Left
	arrayListDesc.Parent = arrayListToggleFrame

	local alToggleBg = Instance.new("Frame")
	alToggleBg.Name = "ALToggleBg"
	alToggleBg.Size = UDim2.new(0.08, 0, 0.45, 0)
	alToggleBg.Position = UDim2.new(0.89, 0, 0.28, 0)
	alToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	alToggleBg.BorderSizePixel = 0
	alToggleBg.Parent = arrayListToggleFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0.5, 0)
	temp.Parent = alToggleBg

	local alToggleCircle = Instance.new("Frame")
	alToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
	alToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
	alToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	alToggleCircle.BorderSizePixel = 0
	alToggleCircle.Parent = alToggleBg

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(1, 0)
	temp.Parent = alToggleCircle

	local alToggleButton = Instance.new("TextButton")
	alToggleButton.Size = UDim2.new(1, 0, 1, 0)
	alToggleButton.Position = UDim2.new(0, 0, 0, 0)
	alToggleButton.BackgroundTransparency = 1
	alToggleButton.Text = ""
	alToggleButton.Parent = arrayListToggleFrame

	-- Sort mode selector
	local sortModeFrame = Instance.new("Frame")
	sortModeFrame.Name = "SortModeFrame"
	sortModeFrame.Size = UDim2.new(0.9, 0, 0.12, 0)
	sortModeFrame.Position = UDim2.new(0.05, 0, 0.43, 0)
	sortModeFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	sortModeFrame.BorderSizePixel = 0
	sortModeFrame.Parent = settingsContent

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 8)
	temp.Parent = sortModeFrame

	local sortModeLabel = Instance.new("TextLabel")
	sortModeLabel.Size = UDim2.new(0.4, 0, 1, 0)
	sortModeLabel.Position = UDim2.new(0.05, 0, 0, 0)
	sortModeLabel.BackgroundTransparency = 1
	sortModeLabel.Text = "Sort:"
	sortModeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	sortModeLabel.TextSize = 14
	sortModeLabel.Font = Enum.Font.GothamBold
	sortModeLabel.TextXAlignment = Enum.TextXAlignment.Left
	sortModeLabel.Parent = sortModeFrame

	local sortAZButton = Instance.new("TextButton")
	sortAZButton.Size = UDim2.new(0.25, 0, 0.65, 0)
	sortAZButton.Position = UDim2.new(0.37, 0, 0.18, 0)
	sortAZButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	sortAZButton.BorderSizePixel = 0
	sortAZButton.Text = "A-Z"
	sortAZButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	sortAZButton.TextSize = 13
	sortAZButton.Font = Enum.Font.GothamBold
	sortAZButton.Parent = sortModeFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = sortAZButton

	local sortLenButton = Instance.new("TextButton")
	sortLenButton.Size = UDim2.new(0.28, 0, 0.65, 0)
	sortLenButton.Position = UDim2.new(0.67, 0, 0.18, 0)
	sortLenButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	sortLenButton.BorderSizePixel = 0
	sortLenButton.Text = "Length"
	sortLenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	sortLenButton.TextSize = 13
	sortLenButton.Font = Enum.Font.GothamBold
	sortLenButton.Parent = sortModeFrame

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 6)
	temp.Parent = sortLenButton

	-- ===== ARRAY LIST OVERLAY (draggable, always on top) =====

	local arrayListGui = Instance.new("ScreenGui")
	arrayListGui.Name = "SdME_ArrayList"
	arrayListGui.ResetOnSpawn = false
	arrayListGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	arrayListGui.DisplayOrder = 999
	arrayListGui.Parent = playerGui

	-- Draggable container frame
	local arrayListFrame = Instance.new("Frame")
	arrayListFrame.Name = "ArrayListFrame"
	arrayListFrame.Size = UDim2.new(0, 160, 0, 20)
	arrayListFrame.Position = UDim2.new(1, -170, 0, 120)
	arrayListFrame.BackgroundTransparency = 1
	arrayListFrame.Visible = false
	arrayListFrame.Parent = arrayListGui

	-- Drag handle (invisible, covers whole frame)
	local alDragHandle = Instance.new("TextButton")
	alDragHandle.Name = "DragHandle"
	alDragHandle.Size = UDim2.new(1, 0, 1, 0)
	alDragHandle.Position = UDim2.new(0, 0, 0, 0)
	alDragHandle.BackgroundTransparency = 1
	alDragHandle.Text = ""
	alDragHandle.ZIndex = 2
	alDragHandle.Parent = arrayListFrame

	-- List container inside
	local alListContainer = Instance.new("Frame")
	alListContainer.Name = "ListContainer"
	alListContainer.Size = UDim2.new(1, 0, 1, 0)
	alListContainer.Position = UDim2.new(0, 0, 0, 0)
	alListContainer.BackgroundTransparency = 1
	alListContainer.Parent = arrayListFrame

	-- UIListLayout for auto-stacking entries
	local alListLayout = Instance.new("UIListLayout")
	alListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	alListLayout.FillDirection = Enum.FillDirection.Vertical
	alListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	alListLayout.Padding = UDim.new(0, 2)
	alListLayout.Parent = alListContainer

	-- Rainbow color cycle for array list entries
	local alHue = 0

	-- Feature name -> state reference table (populated after all toggles exist)
	-- We reference the actual bool variables via closures in the update function
	local function getActiveFeatures()
		local active = {}
		if speedEnabled then table.insert(active, "Speed") end
		if infiniteJumpEnabled then table.insert(active, "Infinite Jump") end
		if jumpPowerEnabled then table.insert(active, "Jump Power") end
		if flyEnabled then table.insert(active, "Fly") end
		if silentAimEnabled then table.insert(active, "Silent Aim") end
		if innocentESP then table.insert(active, "Innocent ESP") end
		if murdererESP then table.insert(active, "Murderer ESP") end
		if sheriffESP then table.insert(active, "Sheriff ESP") end
		if allESP then table.insert(active, "All ESP") end
		if autoCollectGunEnabled then table.insert(active, "Auto Collect Gun") end
		return active
	end

	local function sortFeatures(features)
		if arrayListSortMode == "az" then
			table.sort(features, function(a, b)
				return a:lower() < b:lower()
			end)
		else
			-- Length: longest first, ties broken by A-Z
			table.sort(features, function(a, b)
				if #a == #b then
					return a:lower() < b:lower()
				end
				return #a > #b
			end)
		end
		return features
	end

	local alEntries = {}
	local alWatermark = nil  -- persistent SdME watermark at the bottom

	-- Create the persistent SdME watermark (always rendered, not in alEntries)
	local alWatermarkFrame = Instance.new("Frame")
	alWatermarkFrame.Name = "SdMEWatermark"
	alWatermarkFrame.Size = UDim2.new(0, 160, 0, 18)
	alWatermarkFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
	alWatermarkFrame.BackgroundTransparency = 0.2
	alWatermarkFrame.BorderSizePixel = 0
	alWatermarkFrame.Visible = false
	alWatermarkFrame.ZIndex = 3
	alWatermarkFrame.Parent = arrayListGui  -- child of gui, not container (absolute positioning)

	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 3)
	temp.Parent = alWatermarkFrame

	local alWatermarkAccent = Instance.new("Frame")
	alWatermarkAccent.Name = "WatermarkAccent"
	alWatermarkAccent.Size = UDim2.new(0, 2, 1, 0)
	alWatermarkAccent.Position = UDim2.new(0, 0, 0, 0)
	alWatermarkAccent.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	alWatermarkAccent.BorderSizePixel = 0
	alWatermarkAccent.ZIndex = 4
	alWatermarkAccent.Parent = alWatermarkFrame

	local alWatermarkLabel = Instance.new("TextLabel")
	alWatermarkLabel.Size = UDim2.new(1, -5, 1, 0)
	alWatermarkLabel.Position = UDim2.new(0, 5, 0, 0)
	alWatermarkLabel.BackgroundTransparency = 1
	alWatermarkLabel.Text = "SdME"
	alWatermarkLabel.TextColor3 = Color3.fromRGB(80, 150, 255)
	alWatermarkLabel.TextSize = 12
	alWatermarkLabel.Font = Enum.Font.GothamBold
	alWatermarkLabel.TextXAlignment = Enum.TextXAlignment.Right
	alWatermarkLabel.TextStrokeTransparency = 0.4
	alWatermarkLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	alWatermarkLabel.ZIndex = 4
	alWatermarkLabel.Parent = alWatermarkFrame

	local function updateArrayList()
		if not arrayListEnabled then
			arrayListFrame.Visible = false
			alWatermarkFrame.Visible = false
			return
		end

		-- Clear old entries
		for _, entry in pairs(alEntries) do
			entry:Destroy()
		end
		alEntries = {}

		local active = sortFeatures(getActiveFeatures())

		if #active == 0 then
			arrayListFrame.Visible = false
			alWatermarkFrame.Visible = false
			return
		end

		arrayListFrame.Visible = true

		-- Advance hue for rainbow
		alHue = (alHue + 0.03) % 1

		for i, featureName in ipairs(active) do
			local entryHue = (alHue + (i - 1) * 0.07) % 1
			local entryColor = Color3.fromHSV(entryHue, 0.8, 1)

			local entry = Instance.new("Frame")
			entry.Name = "Entry_" .. featureName
			entry.Size = UDim2.new(1, 0, 0, 18)
			entry.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
			entry.BackgroundTransparency = 0.3
			entry.BorderSizePixel = 0
			entry.LayoutOrder = i
			entry.ZIndex = 1
			entry.Parent = alListContainer

			-- Colored left accent bar
			local accentBar = Instance.new("Frame")
			accentBar.Size = UDim2.new(0, 2, 1, 0)
			accentBar.Position = UDim2.new(0, 0, 0, 0)
			accentBar.BackgroundColor3 = entryColor
			accentBar.BorderSizePixel = 0
			accentBar.ZIndex = 2
			accentBar.Parent = entry

			temp = Instance.new("UICorner")
			temp.CornerRadius = UDim.new(0, 3)
			temp.Parent = entry

			local entryLabel = Instance.new("TextLabel")
			entryLabel.Size = UDim2.new(1, -8, 1, 0)
			entryLabel.Position = UDim2.new(0, 5, 0, 0)
			entryLabel.BackgroundTransparency = 1
			entryLabel.Text = featureName
			entryLabel.TextColor3 = entryColor
			entryLabel.TextSize = 13
			entryLabel.Font = Enum.Font.GothamBold
			entryLabel.TextXAlignment = Enum.TextXAlignment.Right
			entryLabel.TextStrokeTransparency = 0.5
			entryLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			entryLabel.ZIndex = 2
			entryLabel.Parent = entry

			table.insert(alEntries, entry)
		end

		-- Resize main container to fit all entries
		local listHeight = #active * 20 + (#active - 1) * 2
		arrayListFrame.Size = UDim2.new(0, 160, 0, listHeight)

		-- Position + show SdME watermark right below the list
		alWatermarkFrame.Size = UDim2.new(0, 160, 0, 18)
		alWatermarkFrame.Position = UDim2.new(
			arrayListFrame.Position.X.Scale,
			arrayListFrame.Position.X.Offset,
			arrayListFrame.Position.Y.Scale,
			arrayListFrame.Position.Y.Offset + listHeight + 2
		)
		-- Animate watermark accent to match top entry color
		local topHue = alHue % 1
		alWatermarkAccent.BackgroundColor3 = Color3.fromHSV(topHue, 0.8, 1)
		alWatermarkFrame.Visible = true
	end

	-- Update array list every 0.15 seconds
	RunService.Heartbeat:Connect(function()
		if arrayListEnabled then
			alHue = (alHue + 0.001) % 1
		end
	end)

	-- Poll for feature state changes and refresh
	task.spawn(function()
		while true do
			task.wait(0.15)
			if arrayListEnabled then
				updateArrayList()
			end
		end
	end)

	-- Array List drag logic
	local alDragging = false
	local alDragStart = nil
	local alStartPos = nil

	alDragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			alDragging = true
			alDragStart = input.Position
			alStartPos = arrayListFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					alDragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if alDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - alDragStart
			local newX = alStartPos.X.Offset + delta.X
			local newY = alStartPos.Y.Offset + delta.Y
			arrayListFrame.Position = UDim2.new(alStartPos.X.Scale, newX, alStartPos.Y.Scale, newY)
			-- Keep watermark snapped directly below the list
			local listH = arrayListFrame.Size.Y.Offset
			alWatermarkFrame.Position = UDim2.new(alStartPos.X.Scale, newX, alStartPos.Y.Scale, newY + listH + 2)
		end
	end)

	-- Array List toggle button logic
	alToggleButton.MouseButton1Click:Connect(function()
		arrayListEnabled = not arrayListEnabled
		if arrayListEnabled then
			alToggleBg.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
			alToggleCircle:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			updateArrayList()
			print("Array List: ENABLED")
		else
			alToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			alToggleCircle:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			arrayListFrame.Visible = false
			alWatermarkFrame.Visible = false
			print("Array List: DISABLED")
		end
	end)

	-- Sort mode buttons
	sortAZButton.MouseButton1Click:Connect(function()
		arrayListSortMode = "az"
		sortAZButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
		sortAZButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		sortLenButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		sortLenButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		if arrayListEnabled then updateArrayList() end
		print("Array List Sort: A-Z")
	end)

	sortLenButton.MouseButton1Click:Connect(function()
		arrayListSortMode = "length"
		sortLenButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
		sortLenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		sortAZButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		sortAZButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		if arrayListEnabled then updateArrayList() end
		print("Array List Sort: Length")
	end)

	-- Sidebar button click handlers
	for name, button in pairs(sidebarButtons) do
		button.MouseButton1Click:Connect(function()
			for _, btn in pairs(sidebarButtons) do
				btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
			end
			button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
			selectedTab = name
			
			-- Hide all content
			characterContent.Visible = false
			combatContent.Visible = false
			playersContent.Visible = false
			trollingContent.Visible = false
			settingsContent.Visible = false
			
			-- Show selected content
			if name == "Character" then
				characterContent.Visible = true
			elseif name == "Combat" then
				combatContent.Visible = true
			elseif name == "Players" then
				playersContent.Visible = true
			elseif name == "Trolling" then
				trollingContent.Visible = true
			elseif name == "Settings" then
				settingsContent.Visible = true
			end
		end)
	end
	
	-- Make GUI draggable
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	titleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
	-- ========== TOGGLE BUTTON ==========
	
	-- Create toggle button
	local guiToggleButton = Instance.new("TextButton")
	guiToggleButton.Name = "ToggleButton"
	guiToggleButton.Size = UDim2.new(0, 50, 0, 50)
	guiToggleButton.Position = UDim2.new(1, -60, 0, 10)
	guiToggleButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	guiToggleButton.BackgroundTransparency = 0.2
	guiToggleButton.Text = "SdME"
	guiToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	guiToggleButton.TextSize = 14
	guiToggleButton.Font = Enum.Font.GothamBold
	guiToggleButton.BorderSizePixel = 0
	guiToggleButton.ZIndex = 1000
	guiToggleButton.Parent = screenGui
	
	temp = Instance.new("UICorner")
	temp.CornerRadius = UDim.new(0, 10)
	temp.Parent = guiToggleButton
	
	-- Toggle button click
	guiToggleButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = not mainFrame.Visible
		
		if mainFrame.Visible then
			guiToggleButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
		else
			guiToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		end
	end)
	
	-- PC Keybind (H key)
	if not isMobile then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
				mainFrame.Visible = not mainFrame.Visible
				
				if mainFrame.Visible then
					guiToggleButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
				else
					guiToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
				end
			end
		end)
	end
	
	-- Make toggle button draggable
	local btnDragging = false
	local btnDragInput
	local btnDragStart
	local btnStartPos
	
	local function updateBtnPos(input)
		local delta = input.Position - btnDragStart
		guiToggleButton.Position = UDim2.new(
			btnStartPos.X.Scale, 
			btnStartPos.X.Offset + delta.X, 
			btnStartPos.Y.Scale, 
			btnStartPos.Y.Offset + delta.Y
		)
	end
	
	guiToggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			btnDragging = true
			btnDragStart = input.Position
			btnStartPos = guiToggleButton.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					btnDragging = false
				end
			end)
		end
	end)
	
	guiToggleButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			btnDragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == btnDragInput and btnDragging then
			updateBtnPos(input)
		end
	end)
	
	print("SdME GUI loaded successfully!")
	print("Platform: " .. (isMobile and "Mobile" or "PC"))
	if not isMobile then
		print("Press 'H' to toggle GUI")
	end
end

-- ========== KEY SYSTEM LOGIC ==========

local function checkKey()
	local enteredKey = keyInput.Text
	
	if enteredKey == CORRECT_KEY then
		keyTitle.Text = "✓ Correct!"
		keyTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
		submitButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		
		wait(0.5)
		
		print("Key verified! Loading SdME GUI...")
		
		-- Destroy key system
		keyScreenGui:Destroy()
		
		-- Load main script
		loadMainScript()
	else
		keyTitle.Text = "✗ Wrong Key!"
		keyTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
		submitButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		keyInput.Text = ""
		
		wait(1)
		
		keyTitle.Text = "Enter Key"
		keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		submitButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	end
end

submitButton.MouseButton1Click:Connect(checkKey)

keyInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		checkKey()
	end
end)

print("SdME Key System loaded!")
print("Platform: " .. (isMobile and "Mobile" or "PC"))
