-- Information
-- File: 	HideCover.lua
-- Desc: 	Moves #MeterToMove# when #CoverMeasure# returns a string with length 0. Moves it #WidthToMove# in direction given by #Direction# (0 is left, 1 is right). Returns the length of the string.
-- Author:	Zerrick-3.deviantart.com
-- License:	Creative Commons Attribution-Non-Commercial-Share Alike 3.0
-- Version:	1.2

function Initialize()
	msCover = SKIN:GetMeasure(SELF:GetOption('CoverMeasure'))
	mtMeter = SKIN:GetMeter(SELF:GetOption('MeterToMove'))
	local iWidthToMove = SKIN:GetVariable('CoverWidth')
	local iDirection = SELF:GetNumberOption('Direction')
	iXCover = mtMeter:GetX(true)
	iXNoCover = iXCover + (((iDirection*2)-1) * iWidthToMove)
	print('Griseous/HideCover.lua: width:'..iWidthToMove..",dir:"..iDirection..", Xcover:"..iXCover..", XnoCover:"..iXNoCover.."; getX(F,T):("..mtMeter:GetX(false)..","..mtMeter:GetX(true)..")")
end -- function Initialize

function Update()
	local iLength = string.len(msCover:GetStringValue())
	if iLength == 0 then
		-- print('Griseous/HideCover.lua: length:'..iLength..', XnoCover:'..iXNoCover)
		mtMeter:SetX(iXNoCover)
	else
		-- print('Griseous/HideCover.lua: length:'..iLength..', Xcover:'..iXCover)
		mtMeter:SetX(iXCover)
	end
	return iLength
end -- function Update