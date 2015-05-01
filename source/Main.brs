''
'' The starting point.  Shows the poster screen, gets playlist data,
'' and then shows the home screen.
''

sub Main()
  ' first initialize any theme settings
  bcConfig = Config()
  bcConfig.initTheme()

  ' set the simple loading screen
  screenFacade = CreateObject("roPosterScreen")
  screenFacade.showMessage("Loading...")
  screenFacade.show()

  ' show the title
  screenFacade.SetBreadcrumbText(bcConfig.appName, "")

  ' get playlist data from Brightcove
  if bcConfig.playerURL = invalid
    playlistData = BrightcoveMediaAPI().GetPlaylistConfig()
  else
    playlistData = BrightcovePlayerAPI().GetPlaylistData()
  end if

  ' show an error if the initial data call went wrong, which either means Config
  ' is incorrect or Brightcove is having issues
  if playlistData = invalid or type(playlistData.playlists) <> "roArray" or playlistData.playlists.count() = 0
    '' From roku-sdk/dialogs
    ShowConnectionFailed()
  else
    print "Found "; playlistData.playlists.count(); " playlists to display"
    ' PrintAA(playlistData)
    ' use the data from Brightcove to show the home screen
    HomeScreen(bcConfig.appName, "", playlistData.playlists, playlistData.thumbs)
  end if
  ' we are now able to remove the loading message
  screenFacade.showMessage("")
  sleep(25)
end sub
