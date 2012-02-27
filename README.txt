APPLICATION OVERVIEW
This template provides a jump-start to getting your Brightcove content published on Roku. To begin publishing with this application, you need the following:

I. Get your accounts and dev environment ready

A. A Brightcove account 
B. A Roku Developers account
C. Set up your Roku dev environment so you have a dev box and can communicate with it as outlined 
   in the Roku guidelines


II. Getting your content ready

A. Create a custom Brightcove player using one of the multi-playlist player templates, and at 
   least one playlist for your Roku content. Each playlist will be a category section in the 
   Roku Application.
B. Make sure each playlist has a thumbnail (304x237 pixels). 


III. Configure the app

A. Manifest (this is documented in the Roku Component Reference)
	1. title: this is the name of the app that appears on the channel list
	2. subtitle: appears beneath the title on the channel list (optional)
B. Config.brs
	1. appName: this is the name of the application, appearing in the upper right corner of the app
	2. brightcoveToken: your Brightcove API key with read permission and URL access. This can be 
	   found in Account Settings > API Management on Brightcove.com
	3. playerID: the player ID of the custom player you created in step II.A
	4. alwaysShowCategories: if set to false, the app will not show the playlists screen if there 
	   is only one playlist. It will go straight to the video assets instead.
	5. initTheme settings: controls the look and feel of your application. This is well documented 
	   in the Roku documents
C. Replace Images with brand images
	1. Overhang_Background_HD.png (header images that appear at the top of the screen)
	2. Overhang_Background_SD.png
	3. mm_icon_focus_hd.png
	4. mm_icon_focus_sd.png
	5. mm_icon_side_hd.png
	6. mm_icon_side_sd.png


LICENSE
Copyright (c) 2012 Brightcove Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.