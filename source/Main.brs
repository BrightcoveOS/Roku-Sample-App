sub Main()
	initTheme()
	screenFacade = CreateObject("roPosterScreen")
	screenFacade.showMessage("Loading...")
	screenFacade.show()
	screenFacade.SetBreadcrumbText(Config().appName,"")
	json = GetPlaylistConfig()

	if json = invalid or type(json.playlists) <> "roArray" or json.playlists.count() = 0
		ShowConnectionFailed()
	else
		printAA(json)
		m.brightcoveToken = Config().brightcoveToken
		m.playlists = json.playlists
		m.thumbs = json.thumbs
		ShowHomeScreen(Config().appName, "")
	end if
	screenFacade.showMessage("")
	sleep(25)
end sub
