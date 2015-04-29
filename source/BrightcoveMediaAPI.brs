''
'' Calls to the Brightcove media API
''

function UseBrightcoveMediaAPI()
  this = {
    GetPlaylistConfig: GetPlaylistConfig
    GetPlaylists: GetPlaylists
    GetVideosForPlaylist: GetVideosForPlaylist
    GetRenditionsForVideo: GetRenditionsForVideo
  }
  return this
end function

function GetPlaylistConfig() as Object
  configUrl = "http://api.brightcove.com/services/library?command=find_playlists_for_player_id&player_id=" + Config().playerID +"&playlist_fields=id,name,thumbnailURL&token=" + Config().brightcoveToken
  print "configUrl: " ; configUrl
  out = {
    playlists: [], thumbs: {}
  }
  util = NWM_Utilities()
  raw = util.GetStringFromURL(configUrl)
  playlists = SimpleJSONParser(raw)

  ' Brightcove does not have multiple thumbnails for playlists, so we'll use the HD one and scale down
  for each list in playlists.items
    print "List: " ; list.id
    out.playlists.push(list.id)
    out.thumbs[list.id]  = list.thumbnailurl
  next
  return out
End Function

function GetPlaylists(playlists = [], thumbs = [])
  result = []
  util = NWM_Utilities()

  playlistFilter = {}
  lists = ""
  for each playlist in playlists
    playlistFilter.AddReplace(playlist, "")
    lists = lists + playlist + ","
  next
  lists = Left(lists, Len(lists) - 1 )
  print lists
  ' Can we just grab the correct playlists?
  raw = util.GetStringFromURL("http://api.brightcove.com/services/library?command=find_playlists_by_ids&playlist_ids="+lists+"&playlist_fields=name,id,thumbnailurl,shortdescription,videos&video_fields=thumbnailurl,longdescription,VIDEOSTILLURL&sort_by=publish_date&sort_order=DESC&get_item_count=true&token=" + Config().brightcoveToken)

  ' print "Getting Playlists\n";raw
  json = SimpleJSONParser(raw)

  if json = invalid then
    return false
  end if

  for each item in json.items
    'PrintAA(item)

    if item <> invalid and (playlists.Count() = 0 or playlistFilter.DoesExist(ValidStr(item.id)))

    transportAgnosticUrl = strReplace(thumbs[item.id], "https", "http")

      newPlaylist = {
        playlistID:              ValidStr(item.id)
        shortDescriptionLine1:  ValidStr(item.name)
        shortDescriptionLine2:  Left(ValidStr(item.shortdescription), 60)
        sdPosterURL:            ValidStr(transportAgnosticUrl)
        hdPosterURL:            ValidStr(transportAgnosticUrl)
      }

      if newPlaylist.sdPosterURL = ""
        newPlaylist.sdPosterURL = ValidStr(item.videos[0].videostillurl)
        newPlaylist.hdPosterURL = ValidStr(item.videos[0].videostillurl)
      end if

      'PrintAA(newPlaylist)
      result.Push(newPlaylist)
    end if
  next

  return result
end function

function GetVideosForPlaylist(playlistID)
  result = []
  util = NWM_Utilities()

  ' grabbing all the data for the playlist at once can result in a huge chunk of JSON and processing that into a BS structure can crash the box
  ' "http://api.brightcove.com/services/library?command=find_playlist_by_id&media_delivery=http&video_fields=publisheddate,tags,length,name,thumbnailurl,renditions,longdescription&playlist_id=" + playlistID + "&token=" + Config().brightcoveToken

  raw = util.GetStringFromURL("http://api.brightcove.com/services/library?command=find_playlist_by_id&media_delivery=http&video_fields=id,publisheddate,tags,length,name,thumbnailurl,shortdescription,videostillurl&playlist_id=" + playlistID + "&token=" + Config().brightcoveToken)
  ' print "Getting Videos";raw

  json = SimpleJSONParser(raw)

  if json = invalid then
    return false
  end if

  for each video in json.videos
    'PrintAA(video)

    transportAgnosticUrl = strReplace(video.videostillurl, "https", "http")

    newVid = {
      id:                  ValidStr(video.id)
      shortDescriptionLine1:        ValidStr(video.name)
      title:                ValidStr(video.name)
      description:            ValidStr(video.shortdescription)
      synopsis:              ValidStr(video.shortdescription)
      sdPosterURL:            ValidStr(transportAgnosticUrl)
      hdPosterURL:            ValidStr(transportAgnosticUrl)
      length:                Int(StrToI(ValidStr(video.length)) / 1000)
      streams:              []
      streamFormat:            "mp4"
      contentType:            "episode"
      categories:              []
    }

    date = CreateObject("roDateTime")
    date.FromSeconds(StrToI(Left(ValidStr(video.publisheddate), Len(ValidStr(video.publisheddate)) - 3)))
    newVid.releaseDate = date.asDateStringNoParam()
    print "New Categories List"
    for each tag in video.tags
      ' print "Adding Tag ";tag
      newVid.categories.Push(ValidStr(tag))
    next

    result.Push(newVid)
  next

  return result
end function

sub GetRenditionsForVideo(video)
  util = NWM_Utilities()

  ' grabbing all the data for the playlist at once can result in a huge chunk of JSON and processing that into a BS structure can crash the box
  ' "http://api.brightcove.com/services/library?command=find_playlist_by_id&media_delivery=http&video_fields=publisheddate,tags,length,name,thumbnailurl,renditions,longdescription&playlist_id=" + playlistID + "&token=" + Config().brightcoveToken

  print ("http://api.brightcove.com/services/library?command=find_video_by_id&media_delivery=http&video_fields=renditions&video_id=" + video.id + "&token=" + Config().brightcoveToken)
  raw = util.GetStringFromURL("http://api.brightcove.com/services/library?command=find_video_by_id&media_delivery=http&video_fields=renditions&video_id=" + video.id + "&token=" + Config().brightcoveToken)
  print raw
  json = SimpleJSONParser(raw)
  PrintAA(json)

  if json = invalid then
    return
  end if

  for each rendition in json.renditions
    if UCase(ValidStr(rendition.videocontainer)) = "MP4" and UCase(ValidStr(rendition.videocodec)) = "H264"
      newStream = {
        url:  ValidStr(rendition.url)
        bitrate: Int(StrToI(ValidStr(rendition.encodingrate)) / 1000)
      }

      if StrToI(ValidStr(rendition.frameheight)) > 720
        video.fullHD = true
      end if
      if StrToI(ValidStr(rendition.frameheight)) > 480
        video.isHD = true
        video.hdBranded = true
        newStream.quality = true
      end if

      video.streams.Push(newStream)
    end if
  next
end sub
