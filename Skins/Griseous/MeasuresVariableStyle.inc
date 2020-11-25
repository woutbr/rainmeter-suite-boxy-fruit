; This inclusion file contains all the measures, the style for the text and the variables CoverWidth and FontSize.
; Version: 1.4
[Variables]
CoverWidth=220
FontSize=11

; Main measure
[mPlayer]
Measure=Plugin
Plugin=NowPlaying
; Enter the name of a supported media player: docs.rainmeter.net/manual/plugins/nowplaying#playerlist
PlayerName=CAD
PlayerType=TITLE
DisableLeadingZero=1
TrackChangeAction=[!EnableMeasure "mLuaCover" "#CURRENTCONFIG#"]
; Secondary measures
[mState]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=STATE
IfAboveValue=1
IfAboveAction=[!SetOption "MeterCover" "Greyscale" "1"][!SetOption "MeterCover" "ImageAlpha" "175"][!Show #CURRENTCONFIG#]
IfEqualValue=1
IfEqualAction=[!SetOption "MeterCover" "Greyscale" "0"][!SetOption "MeterCover" "ImageAlpha" "235"][!ShowFade #CURRENTCONFIG#]
IfBelowValue=1
IfBelowAction=[!Hide #CURRENTCONFIG#]

[mCover]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=COVER

[mFile]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=FILE

[mAlbum]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=ALBUM

[mLuaCover]
Measure=Script
ScriptFile=#CURRENTPATH#Cover.lua
MeterAnchor=#MeterAnchor#
Direction=#NoCoverMoveDirection#

[mCoverSearch]
Measure=Plugin
Plugin=FileView
ShowDotDot=0
ShowFolder=0
Extensions="jpg;png;gif"
WildcardSearch="*cover*"
FinishAction=!Log "Griseous: FileView in mCoverSearch finished" Notice

[mCoverResult]
Measure=Plugin
Plugin=FileView
Path=[mCoverSearch]
Type=FilePath

[mProgress]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=PROGRESS

[mArtist]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=ARTIST

[mYear]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=Year
UpdateDivider=3
IfAboveValue=0
IfAboveAction=[!ShowMeter "MeterYear"]
IfEqualValue=0
IfEqualAction=[!HideMeter "MeterYear"]

[mPosition]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[mPlayer]
PlayerType=POSITION

[mDuration]
Measure=Plugin
Plugin=NowPlaying
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