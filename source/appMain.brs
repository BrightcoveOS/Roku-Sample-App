'********************************************************************
'**  brightcoverplayer - Main
'**  October 2010
'**  Copyright (c) 2010 A Different Engine. All Rights Reserved.
'********************************************************************

Sub Main()

    'initialize theme attributes like titles, logos and overhang color
    initTheme()

    'prepare the screen for display and get ready to begin
    screen=preShowHomeScreen("", "")
    if screen=invalid then
        print "unexpected error in preShowHomeScreen"
        return
    end if

    'set to go, time to get started
   showHomeScreen(screen)

End Sub


'*************************************************************
'** Set the configurable theme attributes for the application
'** 
'** Configure the custom overhang and Logo attributes
'** Theme attributes affect the branding of the application
'** and are artwork, colors and offsets specific to the app
'*************************************************************

Sub initTheme()

    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")

    theme.OverhangPrimaryLogoOffsetHD_X = "79"
    theme.OverhangPrimaryLogoOffsetHD_Y = "25"
    theme.OverhangSliceHD = 		"pkg:/images/background_hd.png"
    theme.OverhangPrimaryLogoHD  = 	"pkg:/images/logo_hd.png"

    theme.OverhangPrimaryLogoOffsetSD_X = "75"
    theme.OverhangPrimaryLogoOffsetSD_Y = "15"
    theme.OverhangSliceSD = "pkg:/images/background_sd.png"
    theme.OverhangPrimaryLogoSD  = "pkg:/images/logo_sd.png"

    app.SetTheme(theme)

End Sub
