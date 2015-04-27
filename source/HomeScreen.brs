sub ShowHomeScreen(breadLeft, breadRight)
	screen = CreateObject("roPosterScreen")
	screen.SetMessagePort(CreateObject("roMessagePort"))
	screen.showMessage("Loading...")
  	screen.SetListStyle("flat-category")
  	screen.SetListDisplayMode("zoom-to-fill")
  	screen.SetBreadcrumbText(breadLeft, breadRight)
	screen.Show()

	bc = NWM_Brightcove(m.brightcoveToken)
	content = bc.GetPlaylists(m.playlists, m.thumbs)
	if content = invalid or content.count() = 0
		ShowConnectionFailed()
		return
	end if

	' let's not show categories if there's only one
	if content.count() = 1 and Config().alwaysShowPlaylists = false
		selectedItem = content[0]
		ShowEpisodeScreen(selectedItem, Config().appName, selectedItem.shortDescriptionLine1)
	else
		screen.SetContentList(content)
		screen.Show()

		while true
			msg = wait(0, screen.GetMessagePort())

			if msg <> invalid
				if msg.isScreenClosed()
					exit while
				else if msg.isListItemSelected()
					selectedItem = content[msg.Getindex()]
					ShowEpisodeScreen(selectedItem, Config().appName, selectedItem.shortDescriptionLine1)
				end if
			end if
		end while
	end if
end sub
