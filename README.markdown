#APPLICATION OVERVIEW
This template provides a jump-start to getting your Brightcove content published on Roku. To begin publishing with this application, you need the following:

## I Get your accounts and dev environment ready

A. A Brightcove account 
B. A Roku Developers account
C. Set up your Roku dev environment so you have a dev box and can communicate with it as outlined 
   in the Roku guidelines


## II Getting your content ready

A. Create a custom Brightcove player using one of the multi-playlist player templates, and at 
   least one playlist for your Roku content. Each playlist will be a category section in the 
   Roku Application.
B. Make sure each playlist has a thumbnail (304x237 pixels). 


## III Configure the app

### A. Manifest (this is documented in the Roku Component Reference)
	- title: this is the name of the app that appears on the channel list
	- subtitle: appears beneath the title on the channel list (optional)

### B. Config.brs
 	- appName: this is the name of the application, appearing in the upper right corner of the app
	- brightcoveToken: your Brightcove API key with read permission and URL access. This can be 
	   found in Account Settings > API Management on Brightcove.com
	- playerID: the player ID of the custom player you created in step II.A
	- alwaysShowCategories: if set to false, the app will not show the playlists screen if there 
	   is only one playlist. It will go straight to the video assets instead.
	- initTheme settings: controls the look and feel of your application. This is well documented 
	   in the Roku documents

### C. Replace Images with brand images
	- Overhang_Background_HD.png (header images that appear at the top of the screen)
 	- Overhang_Background_SD.png
	- mm_icon_focus_hd.png
	- mm_icon_focus_sd.png
	- mm_icon_side_hd.png
	- mm_icon_side_sd.png