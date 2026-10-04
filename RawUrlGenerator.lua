local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local COLORS = {
    background = Color3.fromRGB(16, 18, 25),
    panel = Color3.fromRGB(23, 26, 35),
    sidebar = Color3.fromRGB(19, 21, 29),
    input = Color3.fromRGB(30, 34, 45),
    border = Color3.fromRGB(48, 53, 68),
    text = Color3.fromRGB(235, 238, 246),
    muted = Color3.fromRGB(143, 150, 169),
    accent = Color3.fromRGB(119, 94, 255),
    accentHover = Color3.fromRGB(139, 117, 255),
    success = Color3.fromRGB(105, 218, 163),
    error = Color3.fromRGB(255, 118, 126),
}

local guiParent

if type(gethui) == "function" then
    local ok, result = pcall(gethui)
    if ok then
        guiParent = result
    end
end

guiParent = guiParent or CoreGui

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RawUrlGenerator"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentOk = pcall(function()
    screenGui.Parent = guiParent
end)

if not parentOk and player then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local function create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function addCorner(object, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius),
    }, object)
end

local function addStroke(object, color, transparency)
    create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = 1,
    }, object)
end

local function addLabel(parent, text, position, size, textSize, color, font)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Position = position,
        Size = size,
        Text = text,
        TextColor3 = color or COLORS.text,
        TextSize = textSize or 14,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    }, parent)
end

local window = create("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(620, 390),
    BackgroundColor3 = COLORS.background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, screenGui)
addCorner(window, 12)
addStroke(window, COLORS.border, 0.15)

local topBar = create("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
}, window)

addLabel(
    topBar,
    "  ◈   RAW URL GENERATOR",
    UDim2.fromOffset(8, 0),
    UDim2.new(1, -108, 1, 0),
    13,
    COLORS.text,
    Enum.Font.GothamBold
)

local minimizeButton = create("TextButton", {
    Name = "MinimizeButton",
    Position = UDim2.new(1, -76, 0, 12),
    Size = UDim2.fromOffset(28, 28),
    BackgroundColor3 = COLORS.input,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    TextColor3 = COLORS.muted,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
}, topBar)
addCorner(minimizeButton, 7)

local closeButton = create("TextButton", {
    Name = "CloseButton",
    Position = UDim2.new(1, -40, 0, 12),
    Size = UDim2.fromOffset(28, 28),
    BackgroundColor3 = COLORS.input,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    TextColor3 = COLORS.muted,
    TextSize = 19,
    Font = Enum.Font.Gotham,
}, topBar)
addCorner(closeButton, 7)

local body = create("Frame", {
    Name = "Body",
    Position = UDim2.fromOffset(0, 52),
    Size = UDim2.new(1, 0, 1, -52),
    BackgroundTransparency = 1,
}, window)

local sidebar = create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 174, 1, 0),
    BackgroundColor3 = COLORS.sidebar,
    BorderSizePixel = 0,
}, body)

addLabel(
    sidebar,
    "CATEGORIAS",
    UDim2.fromOffset(18, 20),
    UDim2.new(1, -36, 0, 20),
    10,
    COLORS.muted,
    Enum.Font.GothamBold
)

local categoryButton = create("TextButton", {
    Name = "GitHubRawCategory",
    Position = UDim2.fromOffset(12, 52),
    Size = UDim2.new(1, -24, 0, 40),
    BackgroundColor3 = Color3.fromRGB(43, 39, 70),
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "  ◈   GitHub RAW",
    TextColor3 = COLORS.text,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
}, sidebar)
addCorner(categoryButton, 8)

create("Frame", {
    Position = UDim2.fromOffset(0, 9),
    Size = UDim2.new(0, 3, 1, -18),
    BackgroundColor3 = COLORS.accent,
    BorderSizePixel = 0,
}, categoryButton)

local content = create("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(174, 0),
    Size = UDim2.new(1, -174, 1, 0),
    BackgroundTransparency = 1,
}, body)

addLabel(
    content,
    "Gerar URL RAW",
    UDim2.fromOffset(24, 20),
    UDim2.new(1, -48, 0, 28),
    19,
    COLORS.text,
    Enum.Font.GothamBold
)

addLabel(
    content,
    "Converta um link de arquivo do GitHub.",
    UDim2.fromOffset(24, 49),
    UDim2.new(1, -48, 0, 20),
    11,
    COLORS.muted
)

addLabel(
    content,
    "LINK DO GITHUB",
    UDim2.fromOffset(24, 88),
    UDim2.new(1, -48, 0, 18),
    10,
    COLORS.muted,
    Enum.Font.GothamBold
)

local inputBox = create("TextBox", {
    Name = "GitHubUrlInput",
    Position = UDim2.fromOffset(24, 112),
    Size = UDim2.new(1, -48, 0, 42),
    BackgroundColor3 = COLORS.input,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    PlaceholderText = "https://github.com/usuario/repo/blob/main/arquivo.lua",
    PlaceholderColor3 = COLORS.muted,
    Text = "",
    TextColor3 = COLORS.text,
    TextSize = 11,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)
addCorner(inputBox, 8)
addStroke(inputBox, COLORS.border, 0.2)

create("UIPadding", {
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
}, inputBox)

local generateButton = create("TextButton", {
    Name = "GenerateButton",
    Position = UDim2.fromOffset(24, 166),
    Size = UDim2.fromOffset(142, 37),
    BackgroundColor3 = COLORS.accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Gerar URL RAW",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 11,
    Font = Enum.Font.GothamBold,
}, content)
addCorner(generateButton, 8)

local clearButton = create("TextButton", {
    Name = "ClearButton",
    Position = UDim2.fromOffset(174, 166),
    Size = UDim2.fromOffset(78, 37),
    BackgroundColor3 = COLORS.input,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Limpar",
    TextColor3 = COLORS.muted,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
}, content)
addCorner(clearButton, 8)
addStroke(clearButton, COLORS.border, 0.2)

addLabel(
    content,
    "RESULTADO",
    UDim2.fromOffset(24, 220),
    UDim2.new(1, -48, 0, 18),
    10,
    COLORS.muted,
    Enum.Font.GothamBold
)

local outputBox = create("TextBox", {
    Name = "RawUrlOutput",
    Position = UDim2.fromOffset(24, 244),
    Size = UDim2.new(1, -48, 0, 48),
    BackgroundColor3 = COLORS.input,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    PlaceholderText = "A URL RAW será exibida aqui",
    PlaceholderColor3 = COLORS.muted,
    Text = "",
    TextColor3 = COLORS.success,
    TextSize = 11,
    Font = Enum.Font.Code,
    TextEditable = false,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
}, content)
addCorner(outputBox, 8)
addStroke(outputBox, COLORS.border, 0.2)

create("UIPadding", {
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
}, outputBox)

local statusLabel = addLabel(
    content,
    " ",
    UDim2.fromOffset(24, 298),
    UDim2.new(1, -48, 0, 20),
    10,
    COLORS.muted
)

local reopenButton = create("TextButton", {
    Name = "ReopenButton",
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 20, 1, -20),
    Size = UDim2.fromOffset(158, 42),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "  ◈   Abrir Gerador RAW",
    TextColor3 = COLORS.text,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Visible = false,
}, screenGui)
addCorner(reopenButton, 10)
addStroke(reopenButton, COLORS.border, 0.1)

local minimized = false

local function generateRawUrl(value)
    local url = value:match("^%s*(.-)%s*$")

    if url == "" then
        return nil, "Cole uma URL do GitHub."
    end

    if not url:match("^https?://") then
        url = "https://" .. url
    end

    if url:match("^https?://raw%.githubusercontent%.com/") then
        return url
    end

    url = url:gsub("[?#].*$", "")

    local user, repository, branch, filePath =
        url:match("^https?://github%.com/([^/]+)/([^/]+)/blob/([^/]+)(/.+)$")

    if not user or not repository or not branch or not filePath then
        return nil, "Use um link de arquivo do GitHub com /blob/."
    end

    repository = repository:gsub("%.git$", "")

    return "https://raw.githubusercontent.com/"
        .. user .. "/" .. repository .. "/" .. branch .. filePath
end

generateButton.MouseButton1Click:Connect(function()
    local rawUrl, errorMessage = generateRawUrl(inputBox.Text)

    if rawUrl then
        outputBox.Text = rawUrl
        outputBox.TextColor3 = COLORS.success
        statusLabel.Text = "URL RAW gerada."
        statusLabel.TextColor3 = COLORS.success
    else
        outputBox.Text = ""
        statusLabel.Text = errorMessage
        statusLabel.TextColor3 = COLORS.error
    end
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        generateButton:Activate()
    end
end)

clearButton.MouseButton1Click:Connect(function()
    inputBox.Text = ""
    outputBox.Text = ""
    statusLabel.Text = " "
    inputBox:CaptureFocus()
end)

minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    body.Visible = not minimized
    minimizeButton.Text = minimized and "□" or "—"

    TweenService:Create(
        window,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = minimized and UDim2.fromOffset(300, 52) or UDim2.fromOffset(620, 390) }
    ):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    window.Visible = false
    reopenButton.Visible = true
end)

reopenButton.MouseButton1Click:Connect(function()
    window.Visible = true
    reopenButton.Visible = false
end)

generateButton.MouseEnter:Connect(function()
    TweenService:Create(
        generateButton,
        TweenInfo.new(0.15),
        { BackgroundColor3 = COLORS.accentHover }
    ):Play()
end)

generateButton.MouseLeave:Connect(function()
    TweenService:Create(
        generateButton,
        TweenInfo.new(0.15),
        { BackgroundColor3 = COLORS.accent }
    ):Play()
end)

local dragging = false
local dragStart
local windowStart
local dragInput

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        windowStart = window.Position
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            windowStart.X.Scale,
            windowStart.X.Offset + delta.X,
            windowStart.Y.Scale,
            windowStart.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
