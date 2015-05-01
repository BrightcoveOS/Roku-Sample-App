''
'' Used to manage account settings and theme
''

Function Config() As Object
  this = {
    ' the name to show on top of screens
    appName: "Test Application"
    ' whether to use the Smart Player or Brightcove player settings below
    useSmartPlayer: false,
    ' whether to show the playlist screen, even if there is only one playlist
    alwaysShowPlaylists: true

    '' Smart Player setup: this block of config is needed when using a Smart Player.
    ' the media API token, which MUST be a Brightcove read token with URL access
    brightcoveToken: "1haf2aFRHkf2j4_cfBV3O0EOYDKs-0K1M-nqUT6qM1JY4zNaAvab4w.."
    ' the smart player is used for its attached playlists
    playerID: "4201806590001"

    '' Brightcove Player setup: this block of config is needed when using a Brightcove
    '' Player, the latest player system
    playerURL: "http://players.brightcove.net/2549849259001/0e39f135-a34c-490d-8a3f-631e55a60926_default/index.html?playlistId=4201918719001"

    initTheme: initTheme
  }
  return this

End Function

Function initTheme()

  '' Theme setup, adjust to your needs.
  app = CreateObject("roAppManager")
  theme = CreateObject("roAssociativeArray")

  theme.OverhangOffsetSD_X = "72"
  theme.OverhangOffsetSD_Y = "31"
  theme.OverhangSliceSD = "pkg:/images/Overhang_Background_SD.png"
  theme.OverhangSliceHD = "pkg:/images/Overhang_Background_HD.png"

  theme.OverhangOffsetHD_X = "125"
  theme.OverhangOffsetHD_Y = "35"
  theme.OverhangLogoSD  = "pkg:/images/Overhang_Logo_SD.png"
  theme.OverhangLogoHD  = "pkg:/images/Overhang_Logo_HD.png"

  theme.BackgroundColor = "#272626"
  theme.BreadcrumbTextLeft = "#d6d6d6"
  theme.BreadcrumbTextRight = "#d6d6d6"
  theme.BreadcrumbDelimeter = chr(46)

  '' Note these are actually buttons NOT on Springboard
  theme.ButtonMenuNormalText = "#a1a1a1"
  theme.ButtonMenuHighlightText = "#765F4D"
  ' theme.ButtonHighlightColor = "#FDFF00"
  ' theme.ButtonMenuNormalColor = "#cc0000"
  ' theme.ButtonNormalColor = "#00cc00"
  ' theme.ButtonMenuNormalOverlayColor = "#0000cc"
  ' theme.ButtonMenuHighlightColor = "#00ECFF"
  ' theme.ButtonNormalColor = "#a1a1a1"
  theme.ParagraphBodyText = "#a1a1a1"
  theme.ParagraphHeaderText = "#a1a1a1"
  theme.PosterScreenLine1Text = "#a1a1a1"
  theme.PosterScreenLine2Text = "#a1a1a1"
  theme.EpisodeSynopsisText = "#a1a1a1"
  theme.SpringboardTitleText = "#a1a1a1"
  theme.SpringboardActorColor = "#a1a1a1"
  theme.SpringboardSynopsisText = "#a1a1a1"
  theme.SpringboardGenreColor = "#a1a1a1"
  theme.SpringboardButtonNormalColor = "#cc0000"
  theme.SpringboardButtonHighlightColor = "#00cc00"

  app.SetTheme(theme)

End Function
