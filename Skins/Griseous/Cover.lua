-- Information
-- File: 	Griseous/Cover.lua
-- Desc: 	Searches for a cover. When the album changes it will check mCover for a string. When this is empty and there is an album it will search for a cover using the FileView plugin.
-- 			When there is no cover it moves #MeterToMove# a distance of #WidthToMove# in direction given by #Direction# (0 is left, 1 is right).
--			It returns the path to a cover image.
-- Author:	Zerrick-3.deviantart.com
-- License:	Creative Commons Attribution-Non-Commercial-Share Alike 3.0
-- Version:	1.4

function Initialize()
	msAlbum = SKIN:GetMeasure('mAlbum')
	msCover = SKIN:GetMeasure('mCover')
	msFile = SKIN:GetMeasure('mFile')
	msFileView = SKIN:GetMeasure('mCoverSearch')
	msFileChild = SKIN:GetMeasure('mCoverResult')
	mtAnchor = SKIN:GetMeter(SELF:GetOption('MeterAnchor'))
	mtAlbum = SKIN:GetMeter('MeterAlbum')
	local iWidthToMove = SKIN:GetVariable('CoverWidth')
	iDirection = SELF:GetNumberOption('Direction')
	iXCover = mtAnchor:GetX(true)
	iXNoCover = iXCover + (((iDirection*2)-1) * iWidthToMove)
	sCurrentAlbum = ""
	sCurrentCover = ""
	bSearchingFileView = false
	iCurrentXCover = iXCover
	-- print("Griseous/Cover.lua Position: width:"..iWidthToMove..",dir:"..iDirection..", Xcover:"..iXCover..", XnoCover:"..iXNoCover.."; getX(F,T):("..mtAnchor:GetX(false)..","..mtAnchor:GetX(true)..")")
end -- function Initialize

function Update()
	-- print('Griseous/Cover.lua: Update: '..msFile:GetStringValue())
	local sAlbum = msAlbum:GetStringValue()
	if not bSearchingFileView or sAlbum ~= sCurrentAlbum then
		if sAlbum ~= sCurrentAlbum or sAlbum == "" then
			-- Album has changed
			print('Griseous/Cover.lua: Album has changed: '..sAlbum..' <-'..sCurrentAlbum)
			SetMeterYearPos()
			sCurrentAlbum = sAlbum
			sCurrentCover = msCover:GetStringValue()
			if sCurrentCover ~= "" then
				-- Cover found by the NowPlaying plugin.
				print('Griseous/Cover.lua: NowPlaying cover: '..sCurrentCover)
				MoveAnchorMeter(iXCover)
			else
				if sCurrentAlbum == "" then
					-- No album: no cover can be found
					MoveAnchorMeter(iXNoCover)
					-- sCurrentCover = ""
				else
					-- Search for a cover using '*cover*'
					local sPath = msFile:GetStringValue():match("(.+)\\")
					print('Griseous/Cover.lua: Searching in '..sPath)
					SKIN:Bang('[!SetOption "mCoverSearch" "Path" "'..sPath..'"][!SetOption "mCoverSearch" "WildcardSearch" "*cover*"][!CommandMeasure "mCoverSearch" "Update"]')
					-- Read mFileCover on the next update 
					bSearchingFileView = true
				end
			end
		end
	else
		-- A search using mCoverSearch is going on
		-- print('Griseous/Cover.lua: bSearchingFileView='..bSearchingFileView)
		sCurrentCover = msFileChild:GetStringValue()
		if sCurrentCover ~= "" then
			-- Cover found
			print('Griseous/Cover.lua: Cover found: '..sCurrentCover)
			MoveAnchorMeter(iXCover)
		else
			local sCurrentWildcard = msFileView:GetOption('WildcardSearch')
			-- print('Griseous/Cover.lua: sCurrentWildcard: '..sCurrentWildcard)
			if sCurrentWildcard == '*front*' then
				-- Already searched with '*front*': no cover can be found
				print('Griseous/Cover.lua: No cover found')
				MoveAnchorMeter(iXNoCover)
				SKIN:Bang('!SetOption "mCoverSearch" "WildcardSearch" "*cover*"')
			else
				-- Search for a cover using '*front*'
				print("Griseous/Cover.lua: Search again using '*front*'")
				SKIN:Bang('[!SetOption "mCoverSearch" "WildcardSearch" "*front*"][!CommandMeasure "mCoverSearch" "Update"]')
			end
		end
	end
	if not bSearchingFileView then
		-- This script can be disabled if no searching has to be done any more
		SELF:Disable()
		-- print('Griseous/Cover.lua: Disabled')
	end
	return sCurrentCover
end -- function Update

function MoveAnchorMeter(iX1)
	if iCurrentXCover ~= iX1 then
		mtAnchor:SetX(iX1)
		iCurrentXCover = iX1
	end
	bSearchingFileView = false
end

function SetMeterYearPos()
	SKIN:Bang('!UpdateMeter MeterAlbum')
	local iWidth = mtAlbum:GetW()
	SKIN:Bang('!SetOption "MeterTime" "X" "'..(((iDirection*2)-1) * iWidth)..'r"')
	if iDirection == 1 then
		SKIN:Bang('[!SetOption "MeterYear" "X" "'..(-iWidth)..'r"][!UpdateMeterGroup MetersYearRelative]')
	end
end