tell application "Finder"
	--this script is going to OVERRIDE existing infos. I therefore added this confirm dialog at the start
	display dialog "Are you sure" buttons {"Yeah", "Nop!"} default button "Nop!"
	if button returned of result is "Nop!" then
		return
	end if
	
	--getting only images selected
	set myImages to {}
	set theSelection to selection
	repeat with oneItem in theSelection
		--only files with these extensions will be used
		set ext to name extension of oneItem
		if ext is "JPG" or ext is "ARW" or ext is "TIF" or ext is "TIFF" or ext is "BMP" or ext is "JPEG" or ext is "DNG" or ext is "RAW" or ext is "ORF" or ext is "PNG" or ext is "jpg" or ext is "png" or ext is "tif" or ext is "tiff" or ext is "bmp" or ext is "jpeg" or ext is "dng" or ext is "raw" or ext is "orf" or ext is "arw" then
			set end of myImages to oneItem
		end if
	end repeat
	
	--setting up my most used presets
	set presets to {"AF Nikkor 35-80mm", "AF Nikkor 70-210mm"}
	
	--asking user to select which preset to apply
	--there will a button for every preset created in the list before
	display dialog "Choose preset" buttons presets
	set theLens to quoted form of button returned of result
	
	--applying changes for each file
	repeat with oneImage in myImages
		set thePath to quoted form of POSIX path of (oneItem as alias)
		--building the command. Note that exiftool needs to be installed. In this case we're going to modify the lens
		set theCommand to "/usr/local/bin/exiftool -lens=" & theLens & " " & thePath
		do shell script theCommand
	end repeat
end tell
