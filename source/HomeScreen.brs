''
'' The home screen that shows the available playlists (or if there's just
'' one, shows those videos)
''

sub HomeScreen(breadLeft, breadRight, playlists, thumbs)
  screen = CreateObject("roPosterScreen")
  screen.SetMessagePort(CreateObject("roMessagePort"))
  screen.showMessage("Loading...")
  screen.SetListStyle("flat-category")
  screen.SetListDisplayMode("zoom-to-fill")
  screen.SetBreadcrumbText(breadLeft, breadRight)
  screen.Show()

  ' get the playlist data if needed
  bcConfig = Config()
  if bcConfig.playerURL = invalid
    bc = BrightcoveMediaAPI()
    content = bc.GetPlaylists(playlists, thumbs)
    if content = invalid or content.count() = 0
      '' from roku-sdk/dialogs
      ShowConnectionFailed()
      return
    end if
  else
    content = playlists
  end if

  ' let's not show playlists if there's only one
  if content.count() = 1 and bcConfig.alwaysShowPlaylists = false
    selectedItem = content[0]
    PlaylistScreen(selectedItem, bcConfig.appName, selectedItem.shortDescriptionLine1)
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
          PlaylistScreen(selectedItem, bcConfig.appName, selectedItem.shortDescriptionLine1)
        end if
      end if
    end while
  end if
end sub
