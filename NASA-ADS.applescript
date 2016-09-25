property theURL : ""
tell application "Google Chrome"
	activate
	set theURL to URL of the active tab of front window
end tell

set input to (characters 31 thru end of theURL) as string
#display dialog "Bibilographic Code: " & (adscode)
#to remove the strang url encodings
set adscode to do shell script "php -r 'echo trim(urldecode(" & "\"" & input & "" & "\"));'"

set fullpath to ("~/work/Articles/") & (adscode) & ".pdf"
set pFolder to POSIX path of fullpath

tell application "Finder"
	if exists fullpath as POSIX file then
		set y to 0
	else
		set y to 1
	end if
end tell

if y is 0 then
	display dialog "A PDF file for " & (adscode) & "
EXISTS. Dont Download!!!!!!
Would you Like to Open it" with icon file "Users:vigeesh:Library:MyIcons:stop.icns" buttons {"Cancel", "Open"} default button 2
	if result = {button returned:"Open"} then
		tell application "Preview"
			activate
			open fullpath
		end tell
	end if
else
	display dialog "A PDF file for " & (adscode) & "
Does NOT Exist.
Happy Downloading.....
(Bibcode available in clipboard)" with icon file "Users:vigeesh:Library:MyIcons:Download.icns" buttons {"OK"} default button 1
	set the clipboard to adscode
end if

#http://adsabs.harvard.edu/abs/2012ApJ...761..138

