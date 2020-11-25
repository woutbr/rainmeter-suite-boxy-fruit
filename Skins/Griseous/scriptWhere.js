// rainmeter.net/forum/viewtopic.php?f=15&t=13432
// apendx.deviantart.com/art/CMD-output-rainmeter-skin-196904603
// Version:	1.2
var pathTempFile=WScript.Arguments(0)
var arguments=WScript.Arguments(1)
// Replace / with " because WScript would have removed the double quotes.
arguments=arguments.replace(/\//g,'\"')
// WScript.Echo('cmd /C WHERE '+arguments+' > \"'+pathTempFile+'\"')
WScript.CreateObject("WScript.Shell").Run('cmd /C WHERE '+arguments+' > \"'+pathTempFile+'\"',0)