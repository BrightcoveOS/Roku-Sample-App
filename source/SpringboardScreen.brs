''
'' Displays the video details
''

function ShowSpringboardScreen(videos, selectedVideo, leftBread, rightBread)
  screen = CreateObject("roSpringboardScreen")
  screen.SetMessagePort(CreateObject("roMessagePort"))
  screen.SetBreadcrumbText(leftBread, rightBread)
  screen.SetStaticRatingEnabled(false)
  screen.AddButton(1, "Play")
  screen.Show()

  screen.SetContent(videos[selectedVideo])
  screen.Show()

  while true
    msg = wait(0, screen.GetMessagePort())

    if msg <> invalid
      if msg.isScreenClosed()
        exit while
      else if msg.isButtonPressed()
        ShowBrightcoveVideoScreen(videos[selectedVideo])
      else if msg.isRemoteKeyPressed()
        if msg.GetIndex() = 4 ' LEFT
          if selectedVideo = 0
            selectedVideo = videos.Count() - 1
          else
            selectedVideo = selectedVideo - 1
          end if
          screen.SetContent(videos[selectedVideo])
        else if msg.GetIndex() = 5 ' RIGHT
          if selectedVideo = videos.Count() - 1
            selectedVideo = 0
          else
            selectedVideo = selectedVideo + 1
          end if
          screen.SetContent(videos[selectedVideo])
        end if
      end if
    end if
  end while

  return selectedVideo
end function
