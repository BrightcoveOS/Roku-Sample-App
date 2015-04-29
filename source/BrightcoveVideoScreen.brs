''
'' Simple wrapper around roku-sdk/appVideoScreen
''

Function ShowBrightcoveVideoScreen(video As Object)
  if video.streams.Count() = 0
    UseBrightcoveMediaAPI().GetRenditionsForVideo(video)
  end if
  showVideoScreen(video)
End Function

