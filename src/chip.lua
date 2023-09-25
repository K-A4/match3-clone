Chip = {}

function Chip:new(y, x, index)
    if not index then
        return nil
    end

    local public =
    {
        yPosition = y,
        xPosition = x,
        id = index
    }

    function Chip:activate(board)
        board:deleteChip(self.yPosition, self.xPosition)
    end

    setmetatable(public, {__index = self})
    return public
end

function Chip:createChip(y, x, index)
    if not index then
        return nil
    end

    if index > 0 and index < 7 then
        return self:new(y, x, index)
    elseif index == 7 then
        return BombChip:new(y, x, index)
    end
end

BombChip = {}

setmetatable(BombChip,{__index = Chip})

function BombChip:activate(board)
    for y=-1,1 do
        for x=-1,1 do
            board:deleteChip(self.yPosition+y, self.xPosition+x)
        end
    end
    
    print("BombExplodes")
end