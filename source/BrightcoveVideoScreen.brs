''
'' Simple wrapper around roku-sdk/appVideoScreen
''

Function ShowBrightcoveVideoScreen(episode As Object)
  if episode.streams.Count() = 0
    UseBrightcoveMediaAPI().GetRenditionsForEpisode(episode)
  end if
  showVideoScreen(episode)
End Function

