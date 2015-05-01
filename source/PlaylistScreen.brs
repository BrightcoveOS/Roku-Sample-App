''
'' Displays the videos in a playlist
''

sub PlaylistScreen(show, leftBread, rightBread)
  screen = CreateObject("roPosterScreen")
  screen.SetMessagePort(CreateObject("roMessagePort"))
  screen.SetListStyle("flat-category")
  screen.SetListDisplayMode("zoom-to-fill")
  screen.SetBreadcrumbText(leftBread, rightBread)
  screen.Show()

  ' get the playlist content if needed
  bcConfig = Config()
  if bcConfig.useSmartPlayer
    bc = BrightcoveMediaAPI()
    content = bc.GetVideosForPlaylist(show.playlistID)
    if content = invalid or content.count() = 0
      ShowConnectionFailed()
      return
    end if
  else
    content = show.content
  end if

  selectedVideo = 0
  screen.SetContentList(content)
  screen.Show()

  while true
    msg = wait(0, screen.GetMessagePort())

    if msg <> invalid
      if msg.isScreenClosed()
        exit while
      else if msg.isListItemFocused()
        selectedVideo = msg.GetIndex()
      else if msg.isListItemSelected()
        selectedVideo = SpringboardScreen(content, selectedVideo, leftBread, rightBread)
        screen.SetFocusedListItem(selectedVideo)
      else if msg.isRemoteKeyPressed()
        if msg.GetIndex() = 13
          BrightcoveVideoScreen(content[selectedVideo])
        end if
      end if
    end if
  end while
end sub
