ArgumentReader = {}

local validCommands =
{
    ["m"] = "m",
    ["q"] = "q"
}

function ArgumentReader:new()
    local public = 
    {
        arguments ={}
    }

    function public:read(input)
        self.arguments = {}
        for argument in input:gmatch("%S+")  do
            table.insert(self.arguments, tonumber(argument) or argument)
        end
    end

    function public:isValid()
        if validCommands[self.arguments[1]] then
            return true
        end
        return false
    end

    function public:isQuit()
        if validCommands[self.arguments[1]] == "q" then
            return true
        end
        return false
    end

    function public:isMove()
        if validCommands[self.arguments[1]] == "m" and self.arguments[2] and self.arguments[3] and self.arguments[4] then
            return true
        end
        
        return false
    end

    function public:move()
        return self.arguments[2],self.arguments[3],self.arguments[4]
    end

    setmetatable(public,{__index = self})
    return public
end