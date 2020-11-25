-- Information
-- File: 	Clock/ListPastMeasures.lua
-- Desc: 	Remembers a list of past values of a given measure. Gives back the difference between the new value and the oldest value not older than MaxAge (in seconds). Can save the list to a file.
-- Author:	Zerrick-3.deviantart.com
-- License:	Creative Commons Attribution-Non-Commercial-Share Alike 3.0
-- Version:	0.2

function Initialize()
	msMeasure = SKIN:GetMeasure(SELF:GetOption('MeasureName'))
	sDebugTitle='Clock/LPM.lua '..SELF:GetOption('MeasureName')..': '
	iMaxAge = SELF:GetNumberOption('MaxAge')
	local sSaveFile = SELF:GetOption('SaveFile')
	if sSaveFile == '' then
		tValues = List.new()
	else
		tValues = readListFromFile(SKIN:MakePathAbsolute(sSaveFile))
	end
end

function Update()
	local oNewValue = {}
	oNewValue.value, oNewValue.time = msMeasure:GetValue(), os.time()
	-- print(sDebugTitle..'oNewValue='..oNewValue.value, oNewValue.time)
	List.push(tValues, oNewValue)
	
	local oOldestValue = List.getFirst(tValues)
	-- print(sDebugTitle..'age diff='..oNewValue.time - oOldestValue.time..' > '..iMaxAge..'? oOldestValue='..os.date('d%d, %H:%M',oOldestValue.time))
	while oNewValue.time - oOldestValue.time > iMaxAge do
		List.removeFirst(tValues)
		oOldestValue = List.getFirst(tValues)
		-- print(sDebugTitle..'age diff='..oNewValue.time - oOldestValue.time..' > '..iMaxAge..'? oOldestValue='..os.date('d%d, %H:%M',oOldestValue.time))
	end
	
	-- List.print(tValues)
	return oNewValue.value - oOldestValue.value
end


-- http://www.lua.org/pil/11.4.html :Programming in Lua (1st edition): Queues and Double Queues
List = {}
function List.new ()
	return {first = 0, last = -1}
end

function List.push (list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
	
end

function List.removeFirst (list)
	if list.first < list.last then
		-- print(sDebugTitle..'removeFirst() first='..list.first..', last='..list.last..', length='..#list)
		list[list.first] = nil -- to allow garbage collection
		list.first = list.first + 1
	end
end

function List.getFirst (list)
	if list.first > list.last then return nil end
	-- print(sDebugTitle..'getFirst() first='..list.first..', last='..list.last..', length='..#list)
	return list[list.first]
end

function List.print (list)
	for i=list.first, list.last do
		print(i, list[i].value, list[i].time)
	end
end

-- Write and read tData as a csv format.
function WriteData()
	writeListToFile (tValues, SELF:GetOption('SaveFile'))
end

function writeListToFile (tData, path)
	local file = assert(io.open(path, "w"), 'Unable to open '..path)
	for i=tData.first, tData.last do
		-- print(sDebugTitle..'Write value: '..tData[i].value, tData[i].time)
		file:write(tData[i].value, ',', tData[i].time, '\n')
	end
	file:close()
	print(sDebugTitle..'Write file: '..path)
end

function readListFromFile (path)
	local newValues = List.new()
	local file = io.open(path, 'r')
	if not file then return newValues end
	
	local iCurrentTime = os.time()
	for line in file:lines() do
		-- print(sDebugTitle..'Read line: '..line)
		succes, oReadValue = pcall(splitIntoObject, line)
		if succes then
			if iCurrentTime - oReadValue.time <= iMaxAge then
				List.push(newValues, oReadValue)
				-- print(sDebugTitle..'Keep line: '..oReadValue.value, oReadValue.time)
			else
				print(sDebugTitle..'Value to old: '..oReadValue.time..'='..os.date('d%d, %H:%M',oReadValue.time))
			end
		else
			print(sDebugTitle..oReadValue)
		end
	end
	file:close()
	print(sDebugTitle..newValues.last+1 ..' lines kept')
	return newValues
end

function splitIntoObject (str)
    oLine = {}
    sValue, sTime = string.match(str, "([^,]+),([^,]+)")
	-- print(sDebugTitle..'Split line: '..sValue, sTime)
    if not sValue or not sTime then error('No match reading: '..str) end
	oLine.value, oLine.time = tonumber(sValue), tonumber(sTime)
    return oLine
end