''
'' Simple wrapper around roku-sdk/appVideoScreen
''

Function BrightcoveVideoScreen(video As Object)
  if Config().useSmartPlayer and video.streams.Count() = 0
    BrightcoveMediaAPI().GetRenditionsForVideo(video)
  end if
  showVideoScreen(video)
End Function

