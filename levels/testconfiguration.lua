local levelConfiguration = {}

levelConfiguration.test1 = 
{
    boardDimensions = {
        xDim = 10,
        yDim = 1
    },
    indices = {3,3,3,4,5,6,6,1,1,1},
    randomindex = 0,
    random = function(self)
        levelConfiguration.test1.randomindex = levelConfiguration.test1.randomindex + 1
        return levelConfiguration.test1.indices[levelConfiguration.test1.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, 
    }
}

levelConfiguration.test2 = 
{
    boardDimensions = {
        xDim = 1,
        yDim = 10
    },
    indices = {1,1,nil,2,2,2,2,nil,3,5},
    randomindex = 0,
    random = function()
        levelConfiguration.test2.randomindex = levelConfiguration.test2.randomindex + 1
        return levelConfiguration.test2.indices[levelConfiguration.test2.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, 
    }
}

levelConfiguration.swapTest = 
{
    boardDimensions = {
        xDim = 3,
        yDim = 3
    },
    indices = {1,1,3,2,2,2,2,4,3},
    randomindex = 0,
    random = function()
        levelConfiguration.swapTest.randomindex = levelConfiguration.swapTest.randomindex + 1
        return levelConfiguration.swapTest.indices[levelConfiguration.swapTest.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, 
    }
}

levelConfiguration.validTest = 
{
    boardDimensions = {
        xDim = 3,
        yDim = 3
    },
    indices = {
        1,4,1,
        2,4,2,
        2,3,3,
        1,1,1,
        2,1,2,
        3,1,3,
        4,4
    },
    randomindex = 0,
    random = function()
        levelConfiguration.validTest.randomindex = levelConfiguration.validTest.randomindex + 1
        return levelConfiguration.validTest.indices[levelConfiguration.validTest.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, 
    }
}

levelConfiguration.deleteMatchesTest = 
{
    boardDimensions = {
        xDim = 3,
        yDim = 3
    },
    indices = 
    {
    1,2,1,
    2,2,2,
    1,2,1
    },
    randomindex = 0,
    random = function()
        levelConfiguration.deleteMatchesTest.randomindex = levelConfiguration.deleteMatchesTest.randomindex + 1
        return levelConfiguration.deleteMatchesTest.indices[levelConfiguration.deleteMatchesTest.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, {debugSymbol = "G"}
    }
}

levelConfiguration.bombTest = 
{
    boardDimensions = {
        xDim = 3,
        yDim = 3
    },
    indices = 
    {
    1,2,1,
    2,1,7,
    1,2,1
    },
    randomindex = 0,
    random = function()
        levelConfiguration.bombTest.randomindex = levelConfiguration.bombTest.randomindex + 1
        return levelConfiguration.bombTest.indices[levelConfiguration.bombTest.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "A"}, { debugSymbol = "B"}, { debugSymbol = "C"}, { debugSymbol = "D"}, { debugSymbol = "E"}, {debugSymbol = "F"}, {debugSymbol = "G"}
    }
}

levelConfiguration.debugSymbolsTest = 
{
    boardDimensions = {
        xDim = 3,
        yDim = 3
    },
    indices = 
    {
    1,2,3,
    4,5,6,
    7,8,9
    },
    randomindex = 0,
    random = function()
        levelConfiguration.debugSymbolsTest.randomindex = levelConfiguration.debugSymbolsTest.randomindex + 1
        return levelConfiguration.debugSymbolsTest.indices[levelConfiguration.debugSymbolsTest.randomindex]
    end,
    ChipTypes =
    {
        { debugSymbol = "Q"}, { debugSymbol = "W"}, { debugSymbol = "E"},
        { debugSymbol = "R"}, { debugSymbol = "T"}, { debugSymbol = "Y"}, 
        { debugSymbol = "U"}, { debugSymbol = "I"}, { debugSymbol = "O"},  
    }
}

return levelConfiguration