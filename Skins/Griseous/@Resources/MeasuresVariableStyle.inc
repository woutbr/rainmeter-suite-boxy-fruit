; This inclusion file contains all the measures, the style for the text and the variables CoverWidth and FontSize.
; Version: 1.7
[Variables]
CoverWidth=220
FontSize=11

; Main measure
[mPlayer]
Measure=NowPlaying
; Enter the name of a supported media player: docs.rainmeter.net/manual/plugins/nowplaying#playerlist
PlayerName=CAD
PlayerType=TITLE
DisableLeadingZero=1
TrackChangeAction=[!EnableMeasure "mLuaCover" "#CURRENTCONFIG#"]
; Secondary measures
[mState]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=STATE
IfAboveValue=1
IfAboveAction=[!SetOption "MeterCover" "Greyscale" "1"][!SetOption "MeterCover" "ImageAlpha" "175"][!Show #CURRENTCONFIG#]
IfEqualValue=1
IfEqualAction=[!SetOption "MeterCover" "Greyscale" "0"][!SetOption "MeterCover" "ImageAlpha" "235"][!ShowFade #CURRENTCONFIG#]
IfBelowValue=1
IfBelowAction=[!Hide #CURRENTCONFIG#]

[mCover]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=COVER

[mFile]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=FILE

[mAlbum]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=ALBUM

[mLuaCover]
Measure=Script
ScriptFile=#@#Cover.lua
MeterAnchor=#MeterAnchor#
Direction=#NoCoverMoveDirection#

[mCoverSearch]
Measure=Plugin
Plugin=FileView
ShowDotDot=0
ShowFolder=0
Extensions="jpg;png;gif"
WildcardSearch="*cover"
FinishAction=!Log "FileView in mCoverSearch finished" Notice

[mCoverResult]
Measure=Plugin
Plugin=FileView
Path=[mCoverSearch]
Type=FilePath

[mProgress]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=PROGRESS

[mArtist]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=ARTIST

[mYear]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=YEAR
UpdateDivider=3
IfAboveValue=0
IfAboveAction=!SetOption MeterAlbum Text "#sAlbumYearText#"
IfEqualValue=0
IfEqualAction=!SetOption MeterAlbum Text "%1"

[mPosition]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=POSITION

[mDuration]
Measure=NowPlaying
PlayerName=[mPlayer]
PlayerType=DURATION

;Style for the text
[StyleText]
Y=(#FontSize#*2.5)r
X=r
H=(#FontSize#*1.7)
FontColor=255,255,255
FontFace=Trebuchet MS
FontSize=#FontSize#
AntiAlias=1
StringEffect=SHADOW
StringStyle=BOLD
; SolidColor=255,0,0,128