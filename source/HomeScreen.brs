''
'' The home screen that shows the available playlists (or if there's just
'' one, shows those videos)
''

sub ShowHomeScreen(breadLeft, breadRight, playlists, thumbs)
  screen = CreateObject("roPosterScreen")
  screen.SetMessagePort(CreateObject("roMessagePort"))
  screen.showMessage("Loading...")
  screen.SetListStyle("flat-category")
  screen.SetListDisplayMode("zoom-to-fill")
  screen.SetBreadcrumbText(breadLeft, breadRight)
  screen.Show()

  bc = UseBrightcoveMediaAPI()
  content = bc.GetPlaylists(playlists, thumbs)
  if content = invalid or content.count() = 0
    '' from roku-sdk/dialogs
    ShowConnectionFailed()
    return
  end if

  ' let's not show playlists if there's only one
  if content.count() = 1 and Config().alwaysShowPlaylists = false
    selectedItem = content[0]
    ShowPlaylistScreen(selectedItem, Config().appName, selectedItem.shortDescriptionLine1)
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
          ShowPlaylistScreen(selectedItem, Config().appName, selectedItem.shortDescriptionLine1)
        end if
      end if
    end while
  end if
end sub
