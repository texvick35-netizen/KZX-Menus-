-- // KZX System PRO v3 - FIXED
-- Aimbot | ESP | NoClip | /a para reabrir | Mobile+PC

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local Lighting         = game:GetService("Lighting")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
local camera    = Workspace.CurrentCamera

-- Limpar anterior
if playerGui:FindFirstChild("KZXSystem") then
    playerGui.KZXSystem:Destroy()
end

-- ============================================================
-- CORES
-- ============================================================
local C = {
    bg     = Color3.fromRGB(12, 12, 14),
    panel  = Color3.fromRGB(18, 18, 21),
    card   = Color3.fromRGB(26, 26, 30),
    border = Color3.fromRGB(50, 50, 58),
    accent = Color3.fromRGB(255, 50, 50),
    on     = Color3.fromRGB(255, 60, 60),
    off    = Color3.fromRGB(50, 50, 58),
    text   = Color3.fromRGB(225, 225, 230),
    sub    = Color3.fromRGB(130, 130, 145),
    white  = Color3.new(1, 1, 1),
}

-- ============================================================
-- ESTADO
-- ============================================================
local S = {
    aimbot       = false,
    teamCheck    = true,
    aliveCheck   = true,
    espNomes     = false,
    espCaixas    = false,
    espLinhas    = false,
    espSaude     = false,
    highlight    = false,
    noclip       = false,
    infiniteJump = false,
    fpsBoost     = false,
    fullbright   = false,
    walkSpeed    = 16,
    jumpPower    = 50,
    fov          = 70,
    aimbotSmooth = 0.2,
}

-- ============================================================
-- GUI
-- ============================================================
local W, H = 340, 400

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "KZXSystem"
ScreenGui.ResetOnSpawn   = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent         = playerGui

local Main = Instance.new("Frame")
Main.Name             = "Main"
Main.AnchorPoint      = Vector2.new(0, 0)
Main.Position         = UDim2.new(0, 20, 0, 60)
Main.Size             = UDim2.new(0, 0, 0, 0)
Main.BackgroundColor3 = C.bg
Main.BorderSizePixel  = 0
Main.ClipsDescendants = true
Main.Parent           = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color       = C.accent
Stroke.Thickness   = 1.2
Stroke.Transparency = 0.5

-- Linha topo
local TopLine = Instance.new("Frame")
TopLine.Size             = UDim2.new(1, 0, 0, 2)
TopLine.BackgroundColor3 = C.accent
TopLine.BorderSizePixel  = 0
TopLine.ZIndex           = 10
TopLine.Parent           = Main

-- ============================================================
-- HEADER
-- ============================================================
local Header = Instance.new("Frame")
Header.Size             = UDim2.new(1, 0, 0, 42)
Header.Position         = UDim2.new(0, 0, 0, 2)
Header.BackgroundColor3 = C.panel
Header.BorderSizePixel  = 0
Header.ZIndex           = 5
Header.Parent           = Main

-- Logo K
local Logo = Instance.new("Frame")
Logo.Size             = UDim2.new(0, 28, 0, 28)
Logo.Position         = UDim2.new(0, 12, 0.5, -14)
Logo.BackgroundColor3 = C.accent
Logo.BorderSizePixel  = 0
Logo.ZIndex           = 6
Logo.Parent           = Header
Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 7)

local LogoLbl = Instance.new("TextLabel")
LogoLbl.Size                = UDim2.new(1,0,1,0)
LogoLbl.BackgroundTransparency = 1
LogoLbl.Text                = "K"
LogoLbl.TextColor3          = C.white
LogoLbl.TextSize            = 16
LogoLbl.Font                = Enum.Font.GothamBold
LogoLbl.ZIndex              = 7
LogoLbl.Parent              = Logo

-- Titulo
local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size                = UDim2.new(0, 140, 0, 22)
TitleLbl.Position            = UDim2.new(0, 48, 0, 6)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text                = "KZX System"
TitleLbl.TextColor3          = C.white
TitleLbl.TextSize            = 15
TitleLbl.Font                = Enum.Font.GothamBold
TitleLbl.TextXAlignment      = Enum.TextXAlignment.Left
TitleLbl.ZIndex              = 6
TitleLbl.Parent              = Header

local VerLbl = Instance.new("TextLabel")
VerLbl.Size                = UDim2.new(0, 100, 0, 14)
VerLbl.Position            = UDim2.new(0, 48, 0, 28)
VerLbl.BackgroundTransparency = 1
VerLbl.Text                = "v3.0 PRO"
VerLbl.TextColor3          = C.accent
VerLbl.TextSize            = 10
VerLbl.Font                = Enum.Font.GothamSemibold
VerLbl.TextXAlignment      = Enum.TextXAlignment.Left
VerLbl.ZIndex              = 6
VerLbl.Parent              = Header

-- Botao Minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size             = UDim2.new(0, 28, 0, 28)
MinBtn.Position         = UDim2.new(1, -68, 0.5, -14)
MinBtn.BackgroundColor3 = C.card
MinBtn.Text             = "-"
MinBtn.TextColor3       = C.sub
MinBtn.TextSize         = 16
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.BorderSizePixel  = 0
MinBtn.ZIndex           = 6
MinBtn.Parent           = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

-- Botao Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size             = UDim2.new(0, 28, 0, 28)
CloseBtn.Position         = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = C.accent
CloseBtn.Text             = "X"
CloseBtn.TextColor3       = C.white
CloseBtn.TextSize         = 13
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.BorderSizePixel  = 0
CloseBtn.ZIndex           = 6
CloseBtn.Parent           = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

-- ============================================================
-- SIDEBAR
-- ============================================================
local Sidebar = Instance.new("Frame")
Sidebar.Size                = UDim2.new(0, 90, 1, -52)
Sidebar.Position            = UDim2.new(0, 6, 0, 47)
Sidebar.BackgroundTransparency = 1
Sidebar.Parent              = Main

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding        = UDim.new(0, 5)
SideLayout.FillDirection  = Enum.FillDirection.Vertical

-- ============================================================
-- AREA CONTEUDO
-- ============================================================
local ContentBg = Instance.new("Frame")
ContentBg.Size             = UDim2.new(1, -106, 1, -56)
ContentBg.Position         = UDim2.new(0, 100, 0, 47)
ContentBg.BackgroundColor3 = C.panel
ContentBg.BorderSizePixel  = 0
ContentBg.Parent           = Main
Instance.new("UICorner", ContentBg).CornerRadius = UDim.new(0, 10)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size                 = UDim2.new(1, -6, 1, -6)
Scroll.Position             = UDim2.new(0, 3, 0, 3)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness   = 3
Scroll.ScrollBarImageColor3 = C.accent
Scroll.CanvasSize           = UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
Scroll.Parent               = ContentBg

local ScrollLayout = Instance.new("UIListLayout", Scroll)
ScrollLayout.Padding       = UDim.new(0, 6)
Instance.new("UIPadding", Scroll).PaddingTop = UDim.new(0, 8)

-- ============================================================
-- STATUS BAR
-- ============================================================
local StatusBar = Instance.new("Frame")
StatusBar.Size             = UDim2.new(1, 0, 0, 24)
StatusBar.Position         = UDim2.new(0, 0, 1, -24)
StatusBar.BackgroundColor3 = C.panel
StatusBar.BorderSizePixel  = 0
StatusBar.ZIndex           = 5
StatusBar.Parent           = Main

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size                = UDim2.new(1, -10, 1, 0)
StatusLbl.Position            = UDim2.new(0, 10, 0, 0)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Text                = "Pronto  |  " .. player.Name
StatusLbl.TextColor3          = C.sub
StatusLbl.TextSize            = 10
StatusLbl.Font                = Enum.Font.Gotham
StatusLbl.TextXAlignment      = Enum.TextXAlignment.Left
StatusLbl.ZIndex              = 6
StatusLbl.Parent              = StatusBar

local function notify(msg)
    StatusLbl.Text = msg
    task.delay(3, function()
        StatusLbl.Text = "Pronto  |  " .. player.Name
    end)
end

-- ============================================================
-- COMPONENTES UI
-- ============================================================
local function MakeSection(title)
    local f = Instance.new("Frame")
    f.Size                = UDim2.new(1, -10, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent              = Scroll

    local line = Instance.new("Frame")
    line.Size             = UDim2.new(1, 0, 0, 1)
    line.Position         = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = C.border
    line.BorderSizePixel  = 0
    line.Parent           = f

    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(0, 0, 1, 0)
    lbl.AutomaticSize     = Enum.AutomaticSize.X
    lbl.BackgroundColor3  = C.panel
    lbl.Text              = "  " .. title .. "  "
    lbl.TextColor3        = C.accent
    lbl.TextSize          = 11
    lbl.Font              = Enum.Font.GothamBold
    lbl.ZIndex            = 2
    lbl.Parent            = f
end

local function MakeToggle(label, default, cb)
    local frame = Instance.new("Frame")
    frame.Size             = UDim2.new(1, -10, 0, 36)
    frame.BackgroundColor3 = C.card
    frame.BorderSizePixel  = 0
    frame.Parent           = Scroll
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 9)

    local lbl = Instance.new("TextLabel")
    lbl.Size               = UDim2.new(1, -68, 1, 0)
    lbl.Position           = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text               = label
    lbl.TextColor3         = C.text
    lbl.Font               = Enum.Font.GothamSemibold
    lbl.TextSize           = 13
    lbl.TextXAlignment     = Enum.TextXAlignment.Left
    lbl.Parent             = frame

    local track = Instance.new("TextButton")
    track.Size             = UDim2.new(0, 42, 0, 22)
    track.Position         = UDim2.new(1, -52, 0.5, -11)
    track.BackgroundColor3 = default and C.on or C.off
    track.Text             = ""
    track.BorderSizePixel  = 0
    track.Parent           = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size              = UDim2.new(0, 16, 0, 16)
    knob.Position          = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3  = C.white
    knob.BorderSizePixel   = 0
    knob.Parent            = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = default
    track.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(track, TweenInfo.new(0.18), {BackgroundColor3 = state and C.on or C.off}):Play()
        TweenService:Create(knob,  TweenInfo.new(0.18), {Position = state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)}):Play()
        cb(state)
        notify(label .. ": " .. (state and "ON" or "OFF"))
    end)

    return frame
end

local function MakeButton(label, cb)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = C.card
    btn.Text             = label
    btn.TextColor3       = C.text
    btn.Font             = Enum.Font.GothamSemibold
    btn.TextSize         = 13
    btn.BorderSizePixel  = 0
    btn.Parent           = Scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(60,20,20)}):Play()
        task.delay(0.15, function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = C.card}):Play()
        end)
        cb()
    end)
end

local function MakeSlider(label, min, max, default, cb)
    local frame = Instance.new("Frame")
    frame.Size             = UDim2.new(1, -10, 0, 46)
    frame.BackgroundColor3 = C.card
    frame.BorderSizePixel  = 0
    frame.Parent           = Scroll
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 9)

    local lbl = Instance.new("TextLabel")
    lbl.Size               = UDim2.new(0.65, 0, 0, 20)
    lbl.Position           = UDim2.new(0, 12, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text               = label
    lbl.TextColor3         = C.text
    lbl.Font               = Enum.Font.GothamSemibold
    lbl.TextSize           = 12
    lbl.TextXAlignment     = Enum.TextXAlignment.Left
    lbl.Parent             = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size            = UDim2.new(0.3, -12, 0, 20)
    valLbl.Position        = UDim2.new(0.7, 0, 0, 6)
    valLbl.BackgroundTransparency = 1
    valLbl.Text            = tostring(default)
    valLbl.TextColor3      = C.accent
    valLbl.Font            = Enum.Font.GothamBold
    valLbl.TextSize        = 12
    valLbl.TextXAlignment  = Enum.TextXAlignment.Right
    valLbl.Parent          = frame

    local track = Instance.new("Frame")
    track.Size             = UDim2.new(1, -24, 0, 5)
    track.Position         = UDim2.new(0, 12, 0, 36)
    track.BackgroundColor3 = C.border
    track.BorderSizePixel  = 0
    track.Parent           = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local pct = (default - min) / (max - min)
    local fill = Instance.new("Frame")
    fill.Size              = UDim2.new(pct, 0, 1, 0)
    fill.BackgroundColor3  = C.accent
    fill.BorderSizePixel   = 0
    fill.Parent            = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size              = UDim2.new(0, 13, 0, 13)
    knob.AnchorPoint       = Vector2.new(0.5, 0.5)
    knob.Position          = UDim2.new(pct, 0, 0.5, 0)
    knob.BackgroundColor3  = C.white
    knob.BorderSizePixel   = 0
    knob.ZIndex            = 3
    knob.Parent            = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local sliding = false
    local function applyPos(inputPos)
        local rx = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * rx)
        valLbl.Text   = tostring(val)
        fill.Size     = UDim2.new(rx, 0, 1, 0)
        knob.Position = UDim2.new(rx, 0, 0.5, 0)
        cb(val)
    end

    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            sliding = true; applyPos(i.Position)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if sliding and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            applyPos(i.Position)
        end
    end)
end

-- ============================================================
-- SISTEMA DE TABS
-- ============================================================
local tabBtns   = {}
local activeTab = ""

local tabList = {
    {name="Player", icon="[P]"},
    {name="Visual",  icon="[V]"},
    {name="Mundo",   icon="[M]"},
    {name="Config",  icon="[C]"},
}

local function clearScroll()
    for _, c in ipairs(Scroll:GetChildren()) do
        if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then
            c:Destroy()
        end
    end
end

local function setActiveTab(name)
    activeTab = name
    clearScroll()
    for n, btn in pairs(tabBtns) do
        local active = n == name
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = active and C.accent or C.card,
            TextColor3       = active and C.white   or C.sub,
        }):Play()
    end
end

for _, td in ipairs(tabList) do
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = C.card
    btn.Text             = td.icon .. " " .. td.name
    btn.TextColor3       = C.sub
    btn.Font             = Enum.Font.GothamSemibold
    btn.TextSize         = 11
    btn.TextXAlignment   = Enum.TextXAlignment.Left
    btn.BorderSizePixel  = 0
    btn.Parent           = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)
    Instance.new("UIPadding", btn).PaddingLeft = UDim.new(0, 10)

    tabBtns[td.name] = btn
    btn.MouseButton1Click:Connect(function()
        setActiveTab(td.name)
        if td.name == "Player" then buildPlayer() end
        if td.name == "Visual" then buildVisual() end
        if td.name == "Mundo"  then buildMundo()  end
        if td.name == "Config" then buildConfig() end
    end)
end

-- ============================================================
-- ESP OBJECTS
-- ============================================================
local espObj = {}

local function removeESP(p)
    if espObj[p] then
        for _, v in pairs(espObj[p]) do
            pcall(function() v:Destroy() end)
        end
        espObj[p] = nil
    end
end

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == player then continue end
        local char = p.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then
            if not espObj[p] then espObj[p] = {} end
            local e = espObj[p]

            -- Caixa
            if S.espCaixas then
                if not e.box then
                    e.box = Instance.new("BoxHandleAdornment")
                    e.box.Color3      = Color3.fromRGB(255,50,50)
                    e.box.AlwaysOnTop = true
                    e.box.ZIndex      = 5
                    e.box.Transparency = 0.55
                end
                e.box.Size    = Vector3.new(3.5, 5, 3.5)
                e.box.Adornee = hrp
                e.box.Parent  = hrp
            elseif e.box then
                e.box:Destroy(); e.box = nil
            end

            -- Billboard (Nomes + HP)
            if S.espNomes or S.espSaude then
                if not e.bill then
                    e.bill = Instance.new("BillboardGui")
                    e.bill.AlwaysOnTop = true
                    e.bill.Size        = UDim2.new(0, 120, 0, 36)
                    e.bill.StudsOffset = Vector3.new(0, 4, 0)

                    e.nameLbl = Instance.new("TextLabel", e.bill)
                    e.nameLbl.Size                 = UDim2.new(1, 0, 0.5, 0)
                    e.nameLbl.BackgroundTransparency = 1
                    e.nameLbl.Font                 = Enum.Font.GothamBold
                    e.nameLbl.TextSize             = 13
                    e.nameLbl.TextColor3           = Color3.new(1,1,1)
                    e.nameLbl.TextStrokeTransparency = 0
                    e.nameLbl.TextStrokeColor3     = Color3.new(0,0,0)

                    e.hpLbl = Instance.new("TextLabel", e.bill)
                    e.hpLbl.Size                   = UDim2.new(1, 0, 0.5, 0)
                    e.hpLbl.Position               = UDim2.new(0, 0, 0.5, 0)
                    e.hpLbl.BackgroundTransparency = 1
                    e.hpLbl.Font                   = Enum.Font.Gotham
                    e.hpLbl.TextSize               = 11
                    e.hpLbl.TextColor3             = Color3.fromRGB(100,255,120)
                    e.hpLbl.TextStrokeTransparency = 0
                    e.hpLbl.TextStrokeColor3       = Color3.new(0,0,0)
                end
                e.bill.Adornee   = hrp
                e.bill.Parent    = hrp
                e.nameLbl.Text    = S.espNomes and p.Name or ""
                e.nameLbl.Visible = S.espNomes
                e.hpLbl.Visible   = S.espSaude
                if S.espSaude then
                    e.hpLbl.Text = math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
                end
            else
                if e.bill then e.bill:Destroy(); e.bill = nil end
            end

            -- Linhas ESP (sem Drawing API - usa Frame 2D na tela)
            if S.espLinhas then
                local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    if not e.lineFrame then
                        e.lineFrame = Instance.new("Frame")
                        e.lineFrame.BackgroundColor3 = Color3.fromRGB(255,50,50)
                        e.lineFrame.BorderSizePixel  = 0
                        e.lineFrame.AnchorPoint      = Vector2.new(0.5, 0)
                        e.lineFrame.ZIndex           = 20
                        e.lineFrame.Parent           = ScreenGui
                    end

                    local cx = camera.ViewportSize.X / 2
                    local cy = camera.ViewportSize.Y

                    local dx = screenPos.X - cx
                    local dy = screenPos.Y - cy
                    local len = math.sqrt(dx*dx + dy*dy)
                    local angle = math.atan2(dy, dx) - math.pi/2

                    e.lineFrame.Size     = UDim2.new(0, 1, 0, len)
                    e.lineFrame.Position = UDim2.new(0, cx, 0, cy)
                    e.lineFrame.Rotation = math.deg(angle)
                    e.lineFrame.Visible  = true
                end
            else
                if e.lineFrame then
                    e.lineFrame:Destroy(); e.lineFrame = nil
                end
            end

            -- Highlight
            if S.highlight then
                if not e.sel then
                    e.sel = Instance.new("SelectionBox")
                    e.sel.Color3        = Color3.fromRGB(255,50,50)
                    e.sel.LineThickness = 0.04
                    e.sel.Adornee      = char
                    e.sel.Parent       = char
                end
            else
                if e.sel then e.sel:Destroy(); e.sel = nil end
            end

        else
            removeESP(p)
        end
    end
end

Players.PlayerRemoving:Connect(removeESP)

-- ============================================================
-- AIMBOT REAL
-- ============================================================
local function getAimbotTarget()
    local bestTarget = nil
    local bestDist   = math.huge
    local vp         = camera.ViewportSize
    local center     = Vector2.new(vp.X / 2, vp.Y / 2)

    for _, p in ipairs(Players:GetPlayers()) do
        if p == player then continue end
        if S.teamCheck and p.Team == player.Team then continue end

        local char = p.Character
        local head = char and char:FindFirstChild("Head")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not head or not hum then continue end
        if S.aliveCheck and hum.Health <= 0 then continue end

        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end

        local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist2D < bestDist then
            bestDist   = dist2D
            bestTarget = head
        end
    end

    return bestTarget
end

-- ============================================================
-- INFINITE JUMP HANDLER
-- ============================================================
local jumpConn
local function setInfiniteJump(v)
    S.infiniteJump = v
    if jumpConn then jumpConn:Disconnect(); jumpConn = nil end
    if v then
        jumpConn = UserInputService.JumpRequest:Connect(function()
            local char = player.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

-- ============================================================
-- HEARTBEAT
-- ============================================================
RunService.Heartbeat:Connect(function(dt)
    -- Aimbot
    if S.aimbot then
        local target = getAimbotTarget()
        if target then
            local targetCF = CFrame.new(camera.CFrame.Position, target.Position)
            camera.CFrame  = camera.CFrame:Lerp(targetCF, S.aimbotSmooth)
        end
    end

    -- NoClip
    if S.noclip then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end

    -- ESP
    if S.espNomes or S.espCaixas or S.espLinhas or S.espSaude or S.highlight then
        updateESP()
    end
end)

-- ============================================================
-- BUILDS DE TABS
-- ============================================================
function buildPlayer()
    MakeSection("Movimento")

    MakeToggle("Infinite Jump", S.infiniteJump, function(v)
        setInfiniteJump(v)
    end)

    MakeToggle("NoClip", S.noclip, function(v)
        S.noclip = v
        if not v then
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end)

    MakeSection("Velocidade")

    MakeSlider("WalkSpeed", 8, 250, S.walkSpeed, function(v)
        S.walkSpeed = v
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
        notify("WalkSpeed: " .. v)
    end)

    MakeSlider("JumpPower", 20, 350, S.jumpPower, function(v)
        S.jumpPower = v
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
        notify("JumpPower: " .. v)
    end)

    MakeSection("Aimbot")

    MakeToggle("Aimbot", S.aimbot, function(v)
        S.aimbot = v
    end)

    MakeToggle("Team Check", S.teamCheck, function(v)
        S.teamCheck = v
    end)

    MakeToggle("Alive Check", S.aliveCheck, function(v)
        S.aliveCheck = v
    end)

    MakeSlider("Smooth (1=rapido 10=lento)", 1, 10, 2, function(v)
        S.aimbotSmooth = v / 10
        notify("Smooth: " .. v)
    end)

    MakeSection("Acoes")

    MakeButton("Respawn", function()
        player:LoadCharacter()
        notify("Respawnando...")
    end)

    MakeButton("Teleportar ao Spawn", function()
        local sp  = Workspace:FindFirstChildOfClass("SpawnLocation")
        local char = player.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and sp then
            hrp.CFrame = sp.CFrame + Vector3.new(0, 4, 0)
            notify("Teleportado!")
        else
            notify("Spawn nao encontrado.")
        end
    end)
end

function buildVisual()
    MakeSection("ESP")

    MakeToggle("ESP Nomes", S.espNomes, function(v)
        S.espNomes = v
    end)

    MakeToggle("ESP Caixas", S.espCaixas, function(v)
        S.espCaixas = v
        if not v then
            for p, e in pairs(espObj) do
                if e.box then e.box:Destroy(); e.box = nil end
            end
        end
    end)

    MakeToggle("ESP Linhas", S.espLinhas, function(v)
        S.espLinhas = v
        if not v then
            for p, e in pairs(espObj) do
                if e.lineFrame then e.lineFrame:Destroy(); e.lineFrame = nil end
            end
        end
    end)

    MakeToggle("ESP Saude", S.espSaude, function(v)
        S.espSaude = v
    end)

    MakeToggle("Highlight", S.highlight, function(v)
        S.highlight = v
        if not v then
            for p, e in pairs(espObj) do
                if e.sel then e.sel:Destroy(); e.sel = nil end
            end
        end
    end)

    MakeSection("Camera")

    MakeSlider("Campo de Visao (FOV)", 50, 120, S.fov, function(v)
        S.fov = v
        camera.FieldOfView = v
        notify("FOV: " .. v)
    end)
end

function buildMundo()
    MakeSection("Iluminacao")

    MakeToggle("Fullbright", S.fullbright, function(v)
        S.fullbright = v
        Lighting.Brightness    = v and 3 or 1
        Lighting.FogEnd        = v and 9e9 or 1000
        Lighting.GlobalShadows = not v
        notify("Fullbright: " .. (v and "ON" or "OFF"))
    end)

    MakeToggle("FPS Boost", S.fpsBoost, function(v)
        S.fpsBoost = v
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("ParticleEmitter") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
                d.Enabled = not v
            end
        end
        notify("FPS Boost: " .. (v and "ON" or "OFF"))
    end)

    MakeSection("Horario")

    MakeButton("Amanhecer (6h)", function()
        Lighting.ClockTime = 6
        notify("Horario: Amanhecer")
    end)

    MakeButton("Meio-Dia (12h)", function()
        Lighting.ClockTime = 12
        notify("Horario: Meio-Dia")
    end)

    MakeButton("Por do Sol (18h)", function()
        Lighting.ClockTime = 18
        notify("Horario: Por do Sol")
    end)

    MakeButton("Meia-Noite (0h)", function()
        Lighting.ClockTime = 0
        notify("Horario: Meia-Noite")
    end)
end

function buildConfig()
    MakeSection("Tema de Cor")

    MakeButton("Vermelho (padrao)", function()
        C.accent = Color3.fromRGB(255,50,50); C.on = C.accent
        Stroke.Color = C.accent; TopLine.BackgroundColor3 = C.accent
        notify("Tema: Vermelho")
    end)

    MakeButton("Azul", function()
        C.accent = Color3.fromRGB(50,120,255); C.on = C.accent
        Stroke.Color = C.accent; TopLine.BackgroundColor3 = C.accent
        notify("Tema: Azul")
    end)

    MakeButton("Verde", function()
        C.accent = Color3.fromRGB(50,210,90); C.on = C.accent
        Stroke.Color = C.accent; TopLine.BackgroundColor3 = C.accent
        notify("Tema: Verde")
    end)

    MakeButton("Roxo", function()
        C.accent = Color3.fromRGB(160,60,255); C.on = C.accent
        Stroke.Color = C.accent; TopLine.BackgroundColor3 = C.accent
        notify("Tema: Roxo")
    end)

    MakeSection("Sistema")

    MakeButton("Fechar Menu  (use /a p/ reabrir)", function()
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.delay(0.35, function()
            ScreenGui.Enabled = false
            Main.Size = UDim2.new(0, W, 0, H)
        end)
        notify("Fechado. Digite /a no chat para reabrir.")
    end)
end

-- ============================================================
-- DRAG - HEADER (Mobile + PC)
-- ============================================================
local dragging    = false
local dragStart   = Vector2.new()
local frameStartX = 0
local frameStartY = 0

local function beginDrag(pos)
    dragging    = true
    dragStart   = Vector2.new(pos.X, pos.Y)
    frameStartX = Main.Position.X.Offset
    frameStartY = Main.Position.Y.Offset
end

local function moveDrag(pos)
    if not dragging then return end
    local dx = pos.X - dragStart.X
    local dy = pos.Y - dragStart.Y
    Main.Position = UDim2.new(0, frameStartX + dx, 0, frameStartY + dy)
end

local function endDrag()
    dragging = false
end

-- PC (Mouse)
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        beginDrag(i.Position)
    end
end)
Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement then
        moveDrag(i.Position)
    end
end)

-- Mobile (Touch) - usando TouchMoved dedicado
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        beginDrag(i.Position)
    end
end)
Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        endDrag()
    end
end)
UserInputService.TouchMoved:Connect(function(touch, _)
    moveDrag(touch.Position)
end)

-- ============================================================
-- MINIMIZAR / FECHAR
-- ============================================================
local minimized = false

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(Main, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {
        Size = minimized and UDim2.new(0, W, 0, 50) or UDim2.new(0, W, 0, H)
    }):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.delay(0.35, function()
        ScreenGui.Enabled = false
        Main.Size = UDim2.new(0, W, 0, H)
    end)
end)

-- ============================================================
-- REABRIR COM /a  (FUNCIONA MESMO APOS FECHAR)
-- ============================================================
player.Chatted:Connect(function(msg)
    if msg:lower() ~= "/a" then return end
    ScreenGui.Enabled = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, W, 0, H)
    }):Play()
    notify("Menu reaberto!")
end)

-- ============================================================
-- ABERTURA INICIAL
-- ============================================================
task.delay(0.05, function()
    TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, W, 0, H)
    }):Play()
    task.delay(0.3, function()
        frameStartX = Main.Position.X.Offset
        frameStartY = Main.Position.Y.Offset
        setActiveTab("Player")
        buildPlayer()
    end)
end)

print("[KZX] v3 carregado | /a para reabrir")
