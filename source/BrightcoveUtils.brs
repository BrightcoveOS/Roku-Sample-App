''
''  Config.brs
''	A Different Engine, LLC, 2011
''  http://www.adifferentengine.com
''
''	Used to grab playlists by player ID
''

Function GetPlaylistConfig() as Object
	configUrl = "http://api.brightcove.com/services/library?command=find_playlists_for_player_id&player_id=" + Config().playerID +"&playlist_fields=id,name,thumbnailURL&token=" + Config().brightcoveToken
	print ">>>>>> configUrl: " ; configUrl
	out = {
		playlists: [], thumbs: {}
	}
	util = NWM_Utilities()
	raw = util.GetStringFromURL(configUrl)
	playlists = util.SimpleJSONParser(raw)
	
	' At the time of authoring this app, Brightcove does not have multiple thumbnails for playlists, so we'll use the HD and scale down
	for each list in playlists.items
		print "List: " ; list.id
		out.playlists.push(list.id)
		out.thumbs[list.id]  = list.thumbnailurl
	next
	return out
End Function

