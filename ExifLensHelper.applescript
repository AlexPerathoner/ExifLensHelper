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
		if name extension of oneItem is "JPG" or "PNG" or "TIF" or "TIFF" or "BMP" or "JPEG" or "DNG" or "RAW" or "ORF" or "ARW" or "jpg" or "png" or "tif" or "tiff" or "bmp" or "jpeg" or "dng" or "raw" or "orf" or "arw" then
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
