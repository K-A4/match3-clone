require("src.chip")
Board = {}

function Board:new()
    local dirTable = 
    {
        ["r"] = {x = 1, y = 0},
        ["l"] = {x = -1, y = 0},
        ["u"] = {x = 0, y = -1},
        ["d"] = {x = 0, y = 1}
    }

    local public  = 
    {
        xDim = 0, 
        yDim = 0, 
        chips = {}, 
        matches = {}
    }

    function Board:init(levelConfig)
        self.chips = {}
        self.matches = {}
        self.levelConfiguration = levelConfig
        self.xDim = self.levelConfiguration.boardDimensions.xDim
        self.yDim = self.levelConfiguration.boardDimensions.yDim
    end


    function public:randomMix()
        for y = 1, self.yDim do
            self.chips[y] = {}
            for x = 1, self.xDim do
                self.chips[y][x] = Chip:createChip(y, x, self.levelConfiguration:random())
            end
        end
    end

    function public:generateValid()
        local done = false

        while not done do 
            self:randomMix()
            self:resolveMatches()

            if self:isValid() then
                done = true
            end
        end 
    end

    function public:resolveMatches()
        self:checkMatches()
        while #self.matches > 0 do 
            self:unmatchMatches()

            self:moveDownChips()

            self:fillEmptyTiles()
            self:checkMatches()
        end 
    end

    function public:unmatchMatches()
        self:checkMatches()

        for i = 1, #self.matches, 3 do
            self:deleteChip(self.matches[i].yPosition, self.matches[i].xPosition)
        end
    end

    function public:isValid()
        for y = 1, self.yDim do
            for x = 1, self.xDim do
                local horValid = self:isSwapValid(y, x, "r")

                if horValid then
                    return true
                end

                local verValid = self:isSwapValid(y, x, "d")
                
                if verValid then
                    return true
                end
            end
        end
        return false
    end

    function public:isSwapValid(y, x, dir)
        if not dirTable[dir] then
            return false
        end
        local xSwapPos = x + dirTable[dir].x
        local ySwapPos = y + dirTable[dir].y
        local horPas, verPas
        
        if dir == "r" or dir == "l" then
            verPas = true
        end

        if dir == "u" or dir == "d"  then
            horPas = true
        end
        
        local inBounds = self:inBounds(ySwapPos, xSwapPos)
        if not inBounds then
            return false
        end

        self:swap(y, x, ySwapPos, xSwapPos)

        local horMatches = self:checkHorizontalMatches(y)
        local verMatches = self:checkVerticalMatches(x)
        local secondMatches
        local matches = {}

        for i = 1, #horMatches do
            table.insert(matches, horMatches[i])
        end

        for i = 1, #verMatches do
            table.insert(matches, verMatches[i])
        end

        if verPas then
            secondMatches = self:checkVerticalMatches(xSwapPos)
        end
        
        if horPas then
            secondMatches = self:checkHorizontalMatches(ySwapPos)
        end

        for i = 1, #secondMatches do
            table.insert(matches, secondMatches[i])
        end

        self:swap(y, x, ySwapPos, xSwapPos)

        if #matches > 0 then
            return true
        else
            return false
        end
    end

    function public:swap(y1, x1, y2, x2)
        if not self:inBounds(y1, x1) or not self:inBounds(y2, x2) then
            return false
        end

        local tempChip = self.chips[y2][x2]
        self.chips[y2][x2] = self.chips[y1][x1]
        self.chips[y1][x1] = tempChip

        self.chips[y1][x1].xPosition = x1
        self.chips[y1][x1].yPosition = y1

        self.chips[y2][x2].xPosition = x2
        self.chips[y2][x2].yPosition = y2
    end

    function public:swapByDir(y, x, dir)
        local xSwapPos = x + dirTable[dir].x
        local ySwapPos = y + dirTable[dir].y

        self:swap(y,x,ySwapPos,xSwapPos)
    end

    function public:inBounds(y, x)
        return (y > 0 and y <=  self.yDim) and (x > 0 and x <=  self.xDim)
    end

    function public:deleteMatches()
        for i = 1, #self.matches do
            local chip = self.matches[i]
            if self.chips[chip.yPosition][chip.xPosition] then
                chip:activate(self)
            end
        end
        self.matches = {}
    end

    function public:deleteChip(y, x)
        if self.chips[y][x] then
            self.chips[y][x] = nil
        end
        
    end

    function public:fillEmptyTiles()
        for y = 1, self.yDim do
            for x = 1, self.xDim do
                if not self.chips[y][x] then
                    self.chips[y][x] = Chip:createChip(y, x, self.levelConfiguration:random())
                end
            end
        end
    end

    function public:moveDownChips()
        for x = 1, self.xDim do
            y = self.yDim
            local newYPosition
            local wasEmpty = false
            while y > 0 do
                local fruit = self.chips[y][x]
                if fruit then
                    if wasEmpty then
                        fruit.yPosition = newYPosition
                        self.chips[newYPosition][x] = fruit
                        self.chips[y][x] = nil
                        y = newYPosition
                        newYPosition = nil
                        wasEmpty = false
                    end
                else
                    wasEmpty = true
                    if not newYPosition then
                        newYPosition = y
                    end
                end
                y = y-1
            end 
        end
    end

    function public:checkMatches()
        local matches = {}
        for y = 1, self.yDim do
            local hormatch = self:checkHorizontalMatches(y)
            for i = 1, #hormatch do
                table.insert(matches, hormatch[i])
            end
        end

        for x = 1, self.xDim do
            local vermatch = self:checkVerticalMatches(x)
            for i = 1, #vermatch do
                table.insert(matches, vermatch[i])
            end
        end
        self.matches = matches
        return #matches > 0
    end

    function public:checkHorizontalMatches(y)
        local matches = {}
        local lastMatchedChip = self.chips[y][1].id
        local matchNum = 1
        for x = 2, self.xDim do
            if lastMatchedChip == self.chips[y][x].id then
                matchNum = matchNum+1
            else
                if matchNum >=  3 then
                    for i = 1, matchNum do 
                        table.insert(matches, self.chips[y][x-i])
                    end
                end
                lastMatchedChip = self.chips[y][x].id
                matchNum = 1
            end
        end
        if matchNum >=  3 then
			for i = 1, matchNum do 
                table.insert(matches, self.chips[y][self.xDim+1-i]) 
            end
		end
        return matches
    end

    function public:checkVerticalMatches(x)
        local matches = {}
        local lastMatchedChip = self.chips[1][x].id
        local matchNum = 1
        for y = 2, self.yDim do
            if lastMatchedChip == self.chips[y][x].id then
                matchNum = matchNum+1
            else
                if matchNum >=  3 then
                    for i = 1, matchNum do 
                        table.insert(matches, self.chips[y-i][x])
                    end
                end
                lastMatchedChip = self.chips[y][x].id
                matchNum = 1
            end
        end
        if matchNum >=  3 then
			for i = 1, matchNum do 
                table.insert(matches, self.chips[self.yDim+1-i][x])
            end
		end
        return matches
    end

    function public:toString()
        local str = "  "
        for i = 0, self.xDim-1 do
            str = str.." "..i
        end
        str = str.."\n"
        for y = 1, self.yDim do
            str = str..string.format("%2.0f", y-1).." "
            str = self:collectRow(y, str).."\n"
        end
        return str
    end

    function public:debugString()
        local str = ""
        for y = 1, self.yDim do
            str = self:collectRow(y, str).."\n"
        end
        return str
    end

    function public:collectRow(y,str)
        for x = 1, self.xDim do
            if self.chips[y][x] then
                local chipString = self.levelConfiguration.ChipTypes[self.chips[y][x].id].debugSymbol
                str = str..chipString.." "
            else
                str = str.."  "
            end
        end
        return str
    end

    setmetatable(public, {__index = self})
    return public
end