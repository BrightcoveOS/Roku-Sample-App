sub ShowEpisodeScreen(show, leftBread, rightBread)
	screen = CreateObject("roPosterScreen")
	screen.SetMessagePort(CreateObject("roMessagePort"))
  	screen.SetListStyle("flat-category")
	screen.SetListDisplayMode("zoom-to-fill")
  	screen.SetBreadcrumbText(leftBread, rightBread)
	screen.Show()
	
	bc = NWM_Brightcove(m.brightcoveToken)
	content = bc.GetEpisodesForPlaylist(show.playlistID)
	if content = invalid or content.count() = 0
		ShowConnectionFailed()
		return
	end if
	selectedEpisode = 0
	screen.SetContentList(content)
	screen.Show()

	while true
		msg = wait(0, screen.GetMessagePort())
		
		if msg <> invalid
			if msg.isScreenClosed()
				exit while
			else if msg.isListItemFocused()
				selectedEpisode = msg.GetIndex()
			else if msg.isListItemSelected()
				selectedEpisode = ShowSpringboardScreen(content, selectedEpisode, leftBread, rightBread)
				screen.SetFocusedListItem(selectedEpisode)
				'screen.Show()
			else if msg.isRemoteKeyPressed()
        if msg.GetIndex() = 13
					ShowVideoScreen(content[selectedEpisode])
				end if
			end if
		end if
	end while
end sub
