'
' Retrieves playlist and video information that begin with a Brightcove Player.
' If you are using a Smart Player instead, see BrightcoveMediaAPI
'
' FIXME: handle multiple playlists (once the Brightcove Player supports this and/or
' by handling the FIXME listed below for custom support)

function BrightcovePlayerAPI()
  this = {
    GetPlaylistData: GetPlaylistData
  }
  return this
end function

function GetPlaylistData()
  playerURL = Config().playerURL

  ' find the account/publisher ID in the URL
  accountStart = Instr(1, playerURL, "brightcove.net/") + 15
  accountEnd = Instr(accountStart, playerURL, "/")
  accountId = Mid(playerURL, accountStart, accountEnd - accountStart)
  print "Using account ID "; accountId

  ' find the playlist ID in the URL, if it's there
  playlistStart = Instr(1, playerURL, "playlistId=") + 11
  playlists = []
  if playlistStart > 11
    playlists.push(Mid(playerURL, playlistStart))
  end if

  ' find the config.json URL where we can get more player details.  This is always
  ' located at the same folder level where index.html can be found.
  repoEnd = Instr(accountEnd + 1, playerURL, "/")
  shortenedURL = Left(playerURL, repoEnd)
  configURL = shortenedURL + "config.json"
  print "Getting data from " ; configURL

  ' retrieve config.json
  configData = GetStringFromURL(configURL)
  configJson = ParseJSON(configData)
  PrintAA(configJson)

  ' get the policy key used for getting more playlist/video info
  policyKey = configJson.video_cloud.policy_key

  ' FIXME: get playlists stored in config.json working.  Since the Brightcove Player
  ' does not currently have multiple playlist support, I tried to add a special
  ' section in the config specific to Roku for this.  The playlists info comes
  ' through, but the string is in an exponent form that I can't seem to convert
  ' to a normal string.  Once this works, using the following two commands can
  ' update a player to use multiple playlists:
  ' curl -XPATCH --user $EMAIL --data '{ "roku_configuration": { "playlists": [ $PLAYLISTS ] } }' --header 'Content-Type: application/json' "https://players.api.brightcove.com/v1/accounts/$ACCOUNT/players/$PLAYER/configuration"
   'curl -XPOST --user $EMAIL --header 'Content-Type: application/json' "https://players.api.brightcove.com/v1/accounts/$ACCOUNT/players/$PLAYER/publish"

  ' get the playlists stored in our special section
  'if configJson.roku_configuration <> invalid
  '  for each playlist in configJson.roku_configuration.playlists
  '    playlists.push(Str(playlist))
  '  next
  'end if

  ' now we have enough information to start getting the playlist data and converting
  ' it to the Roku data format
  out = {
    playlists: []
  }
  for each playlistId in playlists
    out.playlists.push(GeneratePlaylist(accountId, playlistId, policyKey))
  next

  return out
end function

' Generate the needed Roku playlist information for the given account and playlist
' using the given policyKey to retrieve the needed information from Brightcove
function GeneratePlaylist(accountId, playlistId, policyKey)
  print "Getting playlist data for " ; playlistId
  playbackUrl = "https://edge.api.brightcove.com/playback/v1/accounts/" + accountId + "/playlists/" + playlistId
print playbackUrl
  playlistData = GetStringFromURL(playbackUrl, policyKey)
  playlist = ParseJSON(playlistData)
  'PrintAA(playlist)

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
      ' FIXME: allow HLS streams here?  They all may just work, but this still needs to be
      ' tried out.  RTMP streams would still need to be excluded.
      if UCase(ValidStr(source.container)) = "MP4" and UCase(ValidStr(source.codec)) = "H264" and source.src <> invalid
        newStream = {
          url:  ValidStr(source.src)
          bitrate: Int(StrToI(ValidStr(source.avg_bitrate)) / 1000)
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

  return rokuPlaylist
end function
