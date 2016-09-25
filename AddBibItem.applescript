property theURL : ""
tell application "Google Chrome"
	activate
	set theURL to URL of the active tab of front window
end tell

set input to (characters 31 thru end of theURL) as string
#display dialog "Bibilographic Code: " & (adscode)
#to remove the strang url encodings
set mybibcode to do shell script "php -r 'echo trim(urldecode(" & "\"" & input & "" & "\"));'"

tell application "BibDesk"
	activate
	open "~/work/Articles/articles_pdf.bib"
	set myfile to get first document
	tell myfile
		set y to 1
		repeat with paper in publications
			set adscode to cite key of paper
			if mybibcode = adscode then
				set y to 0
			end if
		end repeat
		if y = 1 then
			display dialog "Entry for " & (mybibcode) & " not found."
			set theBibTexString to do shell script "python ~/work/Articles/getadsbib.py " & mybibcode
			make new publication with properties {BibTeX string:theBibTexString} at end of publications
		end if
		repeat with paper in publications
			set adscode to cite key of paper
			#display dialog "Bibilographic Code: " & (adscode)
			tell paper
				set fullpath to ("~/work/Articles/") & (adscode) & ".pdf"
				#set pFolder to POSIX path of fullpath
				if linked files is in {{}, {""}, ""} then
					add (POSIX file fullpath) to linked files
					#display dialog linked files
				end if
			end tell
		end repeat
	end tell
end tell

#http://adsabs.harvard.edu/cgi-bin/nph-bib_query?bibcode=%s&data_type=BIBTEX

