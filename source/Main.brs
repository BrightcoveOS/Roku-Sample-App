''
'' The starting point.  Shows the poster screen, gets playlist data,
'' and then shows the home screen.
''

sub Main()
  ' from Config, first initialize any theme settings
  initTheme()

  ' set the simple loading screen
  screenFacade = CreateObject("roPosterScreen")
  screenFacade.showMessage("Loading...")
  screenFacade.show()

  ' show the title
  screenFacade.SetBreadcrumbText(Config().appName, "")

  ' get playlist data from Brightcove
  json = UseBrightcoveMediaAPI().GetPlaylistConfig()
  if json = invalid or type(json.playlists) <> "roArray" or json.playlists.count() = 0
    '' From roku-sdk/dialogs
    ShowConnectionFailed()
  else
    ' from rok-sdk/generalUtils
    PrintAA(json)
    ' use the data from Brightcove to show the home screen
    ShowHomeScreen(Config().appName, "", json.playlists, json.thumbs)
  end if
  screenFacade.showMessage("")
  sleep(25)
end sub
