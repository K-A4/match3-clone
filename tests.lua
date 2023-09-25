require("src.board")
local testLevelConfig = require("levels.testconfiguration")

local testBoard = Board:new()
testBoard:init(testLevelConfig.test1)
testBoard:randomMix()

print(testBoard:debugString())

local matches = testBoard:checkHorizontalMatches(1)
local checkMatch = "333111"

str = ""

for i=1,#matches do
    str = str..matches[i].id
end

assert(checkMatch == str, "Test 1 not passed")
print("Test 1 passed")



testBoard:init(testLevelConfig.test2)
testBoard:randomMix()

testBoard:moveDownChips()
checkMatch = 
[[
  
  
A 
A 
B 
B 
B 
B 
C 
E 
]]
print(testBoard:debugString())
print(checkMatch)
assert(checkMatch == testBoard:debugString(),"moveDown test not passed")
print("moveDown test passed")



testBoard:init(testLevelConfig.swapTest)
testBoard:randomMix()
print("SwapTest: \n"..testBoard:debugString())
testBoard:swap(1,2,2,2)
checkMatch = 
[[
A B C 
B A B 
B D C 
]]
print(checkMatch)

assert(checkMatch == testBoard:debugString(),"swap test not passed")
print("SwapTest passed")



testBoard:init(testLevelConfig.validTest)
testBoard:generateValid()
print("Valid Board: \n"..testBoard:debugString())
checkMatch = 
[[
A D D 
B A B 
C A C 
]]
print(checkMatch)
assert(testBoard:debugString() == checkMatch,"Valid test not passed")
print("Valid Test passed")



testBoard:init(testLevelConfig.deleteMatchesTest)
testBoard:randomMix()
print("board: \n"..testBoard:debugString())
testBoard:checkMatches()
testBoard:deleteMatches()
print("board after deletes: \n"..testBoard:debugString())

checkMatch = 
[[
A   A 
      
A   A 
]]
print(checkMatch)
assert(testBoard:debugString() == checkMatch,"deletes matches test not passed")
print("delete Matches test passed")



testBoard:init(testLevelConfig.bombTest)
testBoard:randomMix()
print("board: \n"..testBoard:debugString())
testBoard:checkMatches()
testBoard:deleteMatches()
testBoard.chips[2][3]:activate(testBoard)
print("board after bomb: \n"..testBoard:debugString())

checkMatch = 
[[
A     
B     
A     
]]
print(checkMatch)
assert(testBoard:debugString() == checkMatch,"bomb test not passed")
print("bombs test passed")


print("All tests passed")
