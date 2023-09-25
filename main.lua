require("src.gameModel")
require("src.argumentReader")

local game = GameModel:new()
local argumentReader = ArgumentReader:new()

game:init()
game:dump()
while true do
    while game:tick() do
        game:dump()
    end
    local input = io.read()
    argumentReader:read(input)

    if argumentReader:isValid() then
        if argumentReader:isQuit() then
            break
        elseif argumentReader:isMove() then
            game:move(argumentReader:move())
        end
    else
        print("input not valid")
    end
end