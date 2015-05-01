'
' Retrieves playlist and video information that begin with a Brightcove Player.
' If you are using a Smart Player instead, see BrightcoveMediaAPI
'
' FIXME: handle multiple playlists (once the Brightcove Player supports this)

function BrightcovePlayerAPI()
  this = {
    GetPlaylistData: GetPlaylistData
  }
  return this
end function

' FIXME: break this horribly long function into multiple functions
function GetPlaylistData()
  playerURL = Config().playerURL

  ' find the account/publisher ID in the URL
  accountStart = Instr(1, playerURL, "brightcove.net/") + 15
  accountEnd = Instr(accountStart, playerURL, "/")
  accountId = Mid(playerURL, accountStart, accountEnd - accountStart)
  print "Using account ID "; accountId

  ' find the playlist ID in the URL
  ' FIXME: allow this to not be there, and then get the playlist data from config.json instead
  playlistStart = Instr(1, playerURL, "playlistId=") + 11
  playlistId = Mid(playerURL, playlistStart)

  ' find the config.json URL where we can get more player details
  repoEnd = Instr(accountEnd + 1, playerURL, "/")
  shortenedURL = Left(playerURL, repoEnd)
  configURL = shortenedURL + "config.json"
  print "Getting data from " ; configURL

  ' retrieve config.json
  configData = GetStringFromURL(configURL)
  configJson = ParseJSON(configData)
  'PrintAA(configJson)

  ' all we use is the policy key right now from this data
  policyKey = configJson.video_cloud.policy_key

  ' and now finally, time to get the playlist
  print 'Getting playlist data for ' ; playlistId
  playbackUrl = "https://edge.api.brightcove.com/playback/v1/accounts/" + accountId + "/playlists/" + playlistId
  playlistData = GetStringFromURL(playbackUrl, policyKey)
  playlist = ParseJSON(playlistData)
  'PrintAA(playlist)

  ' we only have one playlist, but we follow the format to allow for more playlists
  out = {
    playlists: []
  }

  ' construct the playlist details
  rokuPlaylist = {
    playlistID: ValidStr(playlist.id)
    shortDescriptionLine1: ValidStr(playlist.name)
    shortDescriptionLine2: Left(ValidStr(playlist.description), 60)
    ' we have to choose the first video instead of using the playlist poster,
    ' since the playlist poster is not exposed in the playback API currently
    ' FIXME: use the https logic in BrightcoveMediaAPI for poster URLs?
    sdPosterURL: ValidStr(playlist.videos[0].poster)
    hdPosterURL: ValidStr(playlist.videos[0].poster)
    content: []
  }

  ' add in the video and sources details
  for each video in playlist.videos
    'PrintAA(video)

    newVid = {
      id:                      ValidStr(video.id)
      contentId:               ValidStr(video.id)
      shortDescriptionLine1:   ValidStr(video.name)
      title:                   ValidStr(video.name)
      description:             ValidStr(video.description)
      synopsis:                ValidStr(video.description)
      sdPosterURL:             ValidStr(video.poster)
      hdPosterURL:             ValidStr(video.poster)
      length:                  Int(video.duration / 1000)
      ' filled in below
      streams:                 []
      streamFormat:            "mp4"
      contentType:             "episode"
      ' filled in below
      categories:              []
    }
print "VID"
    date = CreateObject("roDateTime")
    ' work around Roku parsing bug
    tLoc = Instr(1, video.published_at, "T")
    pubLen = Len(video.published_at)
    fixedPubAt = Left(video.published_at, tLoc - 1) + " " + Mid(video.published_at, tLoc + 1, pubLen - tLoc - 1)
    ' this function is bad and should feel bad about it
    date.FromISO8601String(fixedPubAt)
    newVid.releaseDate = date.asDateStringNoParam()
    for each tag in video.tags
      ' print "Adding Tag ";tag
      newVid.categories.Push(ValidStr(tag))
    next
    for each source in video.sources
      if UCase(ValidStr(source.container)) = "MP4" and UCase(ValidStr(source.codec)) = "H264" and source.src <> invalid
        newStream = {
          url:  ValidStr(source.src)
          ' bitrate is unfortunately not available current in the API we are using
        }

        if StrToI(ValidStr(source.height)) > 720
          video.fullHD = true
        end if
        if StrToI(ValidStr(source.height)) > 480
          video.isHD = true
          video.hdBranded = true
          newStream.quality = true
        end if
        newVid.streams.Push(newStream)
      end if
    next
    rokuPlaylist.content.Push(newVid)
  next

  out.playlists.push(rokuPlaylist)
  return out
end function