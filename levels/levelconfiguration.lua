levelConfiguration = {}

local randomseed = os.time()
math.randomseed(randomseed)

levelConfiguration.boardDimensions = 
{
    xDim = 10,
    yDim = 10
}

levelConfiguration.ChipTypes =
{
    {
        debugSymbol = "A",
    },
    {
        debugSymbol = "B",
    },
    {
        debugSymbol = "C",
    },
    {
        debugSymbol = "D",
    },
    {
        debugSymbol = "E",
    },
    {
        debugSymbol = "F",
    }, 
}

levelConfiguration.random = function()
    return math.random(#levelConfiguration.ChipTypes)
end


return levelConfiguration