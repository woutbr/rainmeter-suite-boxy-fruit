[Variables]
Color1=255,255,255,255
BackgroundColor=0,0,0,40
Diameter=60
Offset=-14
StartAngle=0
; Minus 90 degrees.
RotationAngle=-1.5707963

[StyleRoundlines]
W=#Diameter#
H=#Diameter#
X=#Offset#
LineWidth=1
LineColor=#Color1#
Solid=1
AntiAlias=1
StartAngle=#StartAngle#
RotationAngle=#RotationAngle#

[StyleChangeDevice]
FontSize=11
FontColor=#Color1#
SolidColor=0,0,0,1
X=10
Y=20
AntiAlias=1
Text="[\x25D4]"
UpdateDivider=8640000
DynamicVariables=1
ToolTipText=[MeasureAudioAction1]
ToolTipType=1
LeftMouseUpAction=[!CommandMeasure "MeasureAudioAction1" "ToggleNext"][!Update][!Update][!UpdateMeter MeterChangeDevice]