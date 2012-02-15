Function GetVideos() as Object
	animals = CreateObject("roArray", 10, true)
	animals.push({
		Title: "JellyFish",
		ShortDescriptionLine1: "JellyFish",
		description: "Channel 1 Description",
		ShortDescriptionLine2: "Jellyfish (also known as jellies or sea jellies) are ..."
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_0_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_0_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 0
	
	})
	animals.push({
		Title: "SeaHorse",
		ShortDescriptionLine1: "SeaHorse",
		description: "Channel 1 Description",
		ShortDescriptionLine2: "SeaHorse"
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_0_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_0_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 0
	
	})
	animals.push({
		Title: "Bee",
		ShortDescriptionLine1: "Bee",
		description: "Channel 2 Description",
		ShortDescriptionLine2: "Bee"
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_1_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_1_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 1	
	})
	animals.push({
		Title: "Butterfly",
		ShortDescriptionLine1: "Butterfly",
		description: "Channel 2 Description",
		ShortDescriptionLine2: "Butterfly"
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_1_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_1_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 1	
	})
	animals.push({
		Title: "Common Redpoll",
		ShortDescriptionLine1: "Common Redpoll",
		description: "Channel 3 Description",
		ShortDescriptionLine2: "Common Redpoll"
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_2_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_2_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 2	
	})
	animals.push({
		Title: "Magpie",
		ShortDescriptionLine1: "Magpie",
		description: "Channel 3 Description",
		ShortDescriptionLine2: "In Europe, 'magpie' is often used by English speakers as .."
		SDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_2_177x90.png",
		HDPosterUrl: "http://public.adifferentengine.com/tv2moro/dummyimages/Channel_2_269x152.png",
		streamMeta: {
			Stream: {
				url : "http://iphone.kitd.com/livetest/playlists/live.m3u8",
			}
			streamFormat: "hls"
		}
		Category: 2	
	})

	return animals
End Function




