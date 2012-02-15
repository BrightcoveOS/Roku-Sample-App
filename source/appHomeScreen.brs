'*****************************************************************
'**  Video Player Example Application -- Home Screen
'**  November 2009
'**  Copyright (c) 2009 Roku Inc. All Rights Reserved.
'*****************************************************************

'******************************************************
'** Perform any startup/initialization stuff prior to 
'** initially showing the screen.  
'******************************************************
Function preShowHomeScreen(breadA=invalid, breadB=invalid) As Object

    if validateParam(breadA, "roString", "preShowHomeScreen", true) = false return -1
    if validateParam(breadA, "roString", "preShowHomeScreen", true) = false return -1

    port=CreateObject("roMessagePort")
    screen = CreateObject("roPosterScreen")
    screen.SetMessagePort(port)
    if breadA<>invalid and breadB<>invalid then
        screen.SetBreadcrumbText(breadA, breadB)
    end if

    screen.SetListStyle("flat-category")
    screen.setAdDisplayMode("scale-to-fit")
    return screen

End Function


'******************************************************
'** Display the home screen and wait for events from 
'** the screen. The screen will show retreiving while
'** we fetch and parse the feeds for the game posters
'******************************************************
Function showHomeScreen(screen) As Integer

    if validateParam(screen, "roPosterScreen", "showHomeScreen") = false return -1

	initCategoryList()
	screen.SetListNames(m.CategoryNames)
	
	m.curCategory = 0
	screen.SetContentList(getContentForCategory(m.curCategory))	
	
    screen.SetFocusedListItem(0)
    screen.Show()

    while true
        msg = wait(0, screen.GetMessagePort())
        if type(msg) = "roPosterScreenEvent" then
            print "showHomeScreen | msg = "; msg.GetMessage() " | index = "; msg.GetIndex()
            if msg.isListFocused() then
                print "list focused | index = "; msg.GetIndex() 
					m.curCategory = msg.GetIndex()
					screen.SetContentList(getContentForCategory(m.curCategory))
            else if msg.isListItemSelected() then
                print "list item selected | index = "; msg.GetIndex()
               	showVideoScreen(getContentForCategory(m.curCategory)[msg.GetIndex()])
            else if msg.isScreenClosed() then
                return -1
            end if
        end If
    end while

    return 0

End Function




'************************************************************
'** initialize the category list.  We fetch a category list
'** from the server, and parse it into a list of filter
'** categories
'************************************************************
Function initCategoryList() As Void

    conn = InitCategoryFeedConnection()

    m.JSONObj 		= conn.LoadCategoryFeed(conn)
    m.CategoryNames = conn.GetCategoryNames(m.JSONObj)
	m.ContentList 	= conn.GetContentList(m.JSONObj) 

End Function



'********************************************************************
'** Return the list of content corresponding the currently selected
'** category in the filter banner.  As the user highlights a
'** category on the top of the poster screen, the list of posters
'** displayed should be refreshed to correspond to the highlighted
'** item.  This function returns the list of content for that category
'********************************************************************
Function getContentForCategory(index As Integer) As Object
    list = []
	For each item in m.ContentList
		if item.Category = index
				list.push(item)
		end if
	end for
    return list
End Function
