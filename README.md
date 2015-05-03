#Roku Sample App for Brightcove
This template provides a jump-start to getting your Brightcove content published on Roku.

## Trying out the sample

To use the sample, you just need a Roku device that is set in "dev" mode:

1. Using the Roku remote, press `Home-Home-Home-Up-Up-Right-Left-Right-Left-Right`
2. Choose to Enable the Installer

You only need to do this once, and then it will remain in dev mode.

To build and install the source, there's a Makefile that should take care of everything for you. You just need to set an environment variable with the IP address of your Roku.  You can find the IP address in the Network settings on the device.  Then to build and install:

1. `export ROKU_DEV_TARGET=192.168.1.2` (substituting your IP address...)
2. `make install`

Once complete, you should now see the Roku application running.

You may also want to set the DEVPASSWORD as an environment variable if you have a password set for your account.  This will stop the prompt for a password in "make install".

### Not working?

If the above doesn't work, and the application is not showing up with 'make install', you can usually see what's going wrong in the Roku console.  Dev channels are able to write messages to a console that you can tail using telnet. Accessing is as simple as:

    telnet $ROKU_DEV_TARGET 8085

## Setting up accounts

To start changing the sample, you should have two accounts:

1. [A Brightcove VideoCloud account](https://register.brightcove.com/)
2. [A Roku Developers account](https://developer.roku.com/developer)

The Roku developers account gives you access to the full SDK source, helpful forums, and information on publishing a finished channel.  The Brightcove VideoCloud account will be used for editing the playlists and videos in use.

## Configure the app

You can change a lot in the sample application without changing too much code.  There's ways to change not only the content but also the images, text, and themes.  Below are the files you can change and what to change in them.

#### A. manifest
- title: this is the name of the app that appears on the channel list
- subtitle: appears beneath the title on the channel list (optional)

#### B. source/Config.brs
1. appName: this is the name of the application, appearing in the upper right corner of the app
2. useSmartPlayer: whether to use a Smart Player or Brightcove Player to retrieve playlist and video information.  Two sections below describe in detail the specific settings you need to then set for the player in use.
3. alwaysShowPlaylists: if set to false, the app will not show the playlists screen if there is only one playlist. It will go straight to the video assets instead.
4. initTheme settings: controls the look and feel of your application. This is well documented in the Roku SDK documents

#### C. source/Config.brs for Smart Players

The smart player is most people are using for their players in Brightcove (as of early 2015).  If this is what you are used to using, you can set up one of these players for use with this application:

1. Create a custom smart player using one of the multi-playlist player templates, and at
   least one playlist for your Roku content.  You can add as many playlists as you'd like
2. You can use a thumbnail for each playlist (304x237 pixels), or the poster image of the first video in the playlist will be used for the playlist thumbnail.

Once the above is set up, you can set up the player in source/Config.brs using the following settings:

1. brightcoveToken: your Brightcove API key with read permission and URL access. This can be       found in Account Settings > API Management in [VideoCloud](https://videocloud.brightcove.com)
2. playerID: the player ID of the smart player you created

#### B. source/Config.brs for Brightcove Players

Brightcove players are the new player from Brightcove (as of early 2015).  If you are using these players, you can also set one of them up for use with this application:

1. Create a custom Brightcove player and make sure it is enabled for playlists.  In the media module, find the playlist you would like to use with it.  Copy the URL embed code for use.

Once the above is set up, you can set up the player in source/Config.brs using the following settings:

1. playerURL: the URL as described above which has a playlist associated with it

Currently multiple playlists are not support in the Brightcove Player, and only one playlist is possible using this setup.  There is nearly-completed code in source/BrightcovePlayerAPI.brs to allow for multiple playlists using a config specific for Roku.  If you get this working, please send in a pull request!

#### C. images/*.png

Replace any of the following sample images with brand images:

1. Overhang_Background_HD.png (header images that appear at the top of the screen)
2. Overhang_Background_SD.png
3. mm_icon_focus_hd.png
4. mm_icon_focus_sd.png
5. mm_icon_side_hd.png
6. mm_icon_side_sd.png

## Making more changes ##

A lot more is possible with Roku that this app doesn't do.  Consider this just a starting point for your Roku experience!  If you have changes you've made that you think are generally useful, we'd love to have them in here.  Just open a pull request.  If you are in need of a lot more that isn't provided here, you can always contact Brightcove's [Global Services](https://www.brightcove.com/en/services), which has made much more complicated Roku apps for customers.

## Credits ##

As pretty much all Roku apps do, some of the code is from the Roku SDK.  Files that are completely from the SDK can be found in source/roku-sdk.

Parts of the README were taken from https://github.com/plexinc/roku-client-public

SimpleJSON is thanks to "TheEndless" in the Roku forums.

And most importantly, all of the [contributors you can see in github](https://github.com/BrightcoveOS/Roku-Sample-App/graphs/contributors).  Thank you!

## License ##
Copyright (c) 2015 Brightcove Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
