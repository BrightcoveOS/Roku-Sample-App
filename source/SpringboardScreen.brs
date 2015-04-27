function ShowSpringboardScreen(episodes, selectedEpisode, leftBread, rightBread)
	screen = CreateObject("roSpringboardScreen")
	screen.SetMessagePort(CreateObject("roMessagePort"))
  	screen.SetBreadcrumbText(leftBread, rightBread)
  	screen.SetStaticRatingEnabled(false)
	screen.AddButton(1, "Play")
	screen.Show()

	screen.SetContent(episodes[selectedEpisode])
	screen.Show()

	while true
		msg = wait(0, screen.GetMessagePort())

		if msg <> invalid
			if msg.isScreenClosed()
				exit while
			else if msg.isButtonPressed()
				ShowVideoScreen(episodes[selectedEpisode])
			else if msg.isRemoteKeyPressed()
				if msg.GetIndex() = 4 ' LEFT
					if selectedEpisode = 0
						selectedEpisode = episodes.Count() - 1
					else
						selectedEpisode = selectedEpisode - 1
					end if
					screen.SetContent(episodes[selectedEpisode])
				else if msg.GetIndex() = 5 ' RIGHT
					if selectedEpisode = episodes.Count() - 1
						selectedEpisode = 0
					else
						selectedEpisode = selectedEpisode + 1
					end if
					screen.SetContent(episodes[selectedEpisode])
				end if
			end if
		end if
	end while

	return selectedEpisode
end function
