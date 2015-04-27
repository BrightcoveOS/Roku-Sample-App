'******************************************************
' Set up the category feed connection object
' This feed provides details about top level categories
'******************************************************
Function InitCategoryFeedConnection() As Object

    conn = CreateObject("roAssociativeArray")

    conn.URL   = "http://api.brightcove.com/services/library?command=find_playlists_for_player_id&and_tags=H264&playlist_fields=name,shortdescription,videos,THUMBNAILURL&video_fields=name,shortdescription,THUMBNAILURL,renditions&player_id=31021593001&token=z9Jp-c3-KhWc4fqNf1JWz6SkLDlbO0m8UAwOjDBUSt0."


    conn.Timer = CreateObject("roTimespan")

    conn.LoadCategoryFeed   = load_category_feed
    conn.GetCategoryNames   = get_category_names
	conn.GetContentList		= get_content_list

    print "created feed connection for " + conn.URL
    return conn

End Function

'******************************************************************
'** Given a connection object for a category feed, fetch,
'** parse and build the tree for the feed.  the results are
'** stored hierarchically with parent/child relationships
'** with a single default node named Root at the root of the tree
'******************************************************************
Function load_category_feed(conn As Object) As Dynamic

    JSONObject = fetch_JSON(conn.URL)

	return JSONObject

End Function

'*********************************************************
'** Create an array of categories. This is useful
'** for filling in the filter banner with the names of
'** all the categories in the hierarchy
'*********************************************************
Function get_category_names(JSONObj As Object) As Dynamic

    categoryNames = CreateObject("roArray", 100, true)

	for each item in JSONObj.items
		print item.name
		categoryNames.push(item.name)
	next

    return categoryNames

End Function

'*********************************************************
'** Create an array of content.
'*********************************************************
Function get_content_list(JSONObj As Object) As Dynamic

    contentList = CreateObject("roArray", 10, true)

	idx = 0
	for each item in JSONObj.items
		for each vitem in item.videos
			o = parseContentItem(vitem, idx)
			contentList.push(o)
		next
		idx = idx + 1
	next

    return contentList

End Function

'***********************************************************
'Parse JSONObj into Roku Object
'***********************************************************
Function parseContentItem(vitem As Object, i AS Integer) As dynamic

	o = init_content_item()
	o.Title = vitem.name
	o.ShortDescriptionLine1 = vitem.name
	o.ShortDescriptionLine2 = vitem.shortDescription

	o.SDPosterUrl =	fixSlashes(vitem.thumbnailURL)
	o.HDPosterUrl =	fixSlashes(vitem.thumbnailURL)

	rList = CreateObject("roArray", 10, true)
	for each item in vitem.renditions
		e = parseRendition(item)
		rList.push(e)
	next
	'o.Streams.push(renditionList)
	o.Category = i

    return o
End Function

'******************************************************
'Initialize a Content Item
'******************************************************
Function init_content_item() As Object
   	o = {
		Title: invalid,
		ContentType: "movie",
		ShortDescriptionLine1: invalid,
		ShortDescriptionLine2: invalid,
		Category: invalid,
		description: invalid,
		SDPosterUrl: invalid,
		HDPosterUrl: invalid,

		Streams: [{	url: invalid,
					encodingRate: invalid
				}]
	}
	return o
End Function

'******************************************************
'Parse Rendition
'******************************************************

Function parseRendition(item As Object) As Dynamic
	r = init_rendition()
	r.url = fixSlashes(item.url)
	r.encodingRate = item.encodingRate
	return r
End Function

'******************************************************
'Initialize a Rendition Item
'******************************************************
Function init_rendition() As Object
   	r = {
		url: invalid,
		encodingRate: invalid
	}
	return r
End Function


