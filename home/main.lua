-- imports

dofile("lib/import.lua")

local Grid = import("grid")
local draw = import("draw")
import("linalg")
-- import("vec2")

-- globals

local res = {}
local tres = {}
local key
local debugMode = false
local gameLoop = true
local FPS = 60
local framesElapsed = 0
local particles = {}
local scale = 1

-- side functions

local function userInput()
    local event, is_held
    while true do
---@diagnostic disable-next-line: undefined-field
        event, key, is_held = os.pullEvent("key")
        if key == keys.space then
            gameLoop = false
        end
        event, is_held = nil, nil
    end
end

local function setVertices()
    local a = {}
    local mult = .1
    local yRange = 5
    local xRange = 5
    for x=-xRange,xRange,mult do
        for y = -yRange, yRange,mult do
            table.insert(a,vec({x+0.1,y+0.1}))
        end
    end
    particles = a
end

-- main functions

local function Init()
    tres.x, tres.y = term.getSize(1)
    res.x = math.floor(tres.x / draw.PixelSize)
    res.y = math.floor(tres.y / draw.PixelSize)
    Grid.init(res.x,res.y)
    term.clear()
    term.setGraphicsMode(1)
    draw.setPalette()
    term.drawPixels(0,0,1,tres.x,tres.y)
end

local function Start()
    setVertices()
end

local gd = {}

local function Update()
    local dt = 1/100
    for i, v in ipairs(particles) do
        local new = dt * vec({
            v[2]^3-9*v[2],
            v[1]^3-9*v[1]
        })
        particles[i] = v + new 
    end
end
 
local function Render()
    scale = 50
    for i, v in ipairs(particles) do
        Grid.SetlightLevel(math.floor((v[1]*scale)+res.x/2),math.floor((v[2]*scale)+res.y/2),1)
    end
    draw.drawFromArray2D(0,0,Grid)
end

local function Closing()
    term.clear()
    term.setGraphicsMode(0)
    draw.resetPalette()
    if debugMode then
    else
        term.clear()
        term.setCursorPos(1,1)
    end
end

-- main structure

local function main()
    Init()
    Start()
    while gameLoop do
        Grid.init(res.x,res.y)
        Update()
        Render()
        sleep(1/FPS)
        framesElapsed = framesElapsed + 1;
    end
    Closing()
end

-- execution

parallel.waitForAny(main,userInput)
