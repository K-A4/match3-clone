GameModel = {}
local levelconfiguration = require("levels.levelconfiguration")
require("src.board")

function GameModel:new()
    local public =
    {
        board = {},
    }

    function public:init()
        self.board = Board:new()
        self.board:init(levelConfiguration)
        self.board:generateValid()
    end

    function public:tick()
        if self.board:checkMatches() then
            
            self.board:deleteMatches()
            self.board:moveDownChips()
            self.board:fillEmptyTiles()
        else
            if self.board:isValid() then
                return false
            else
                self:mix()
            end
        end
        
        return true
    end

    function public:move(x, y, dir)
        if self.board:isSwapValid(y+1,x+1,dir) then
            self.board:swapByDir(y+1,x+1,dir)
            self:dump()
        else
            print("move not valid")
        end
    end

    function public:mix()
        self.board:generateValid()
    end

    function public:dump()
        print(self.board:toString())
    end

    setmetatable(public,{__index = self})
    return public
end