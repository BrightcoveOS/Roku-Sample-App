''
''	NWM_Utilities.brs
''	chagedorn@roku.com
''
''

function NWM_Utilities()
	this = {
		GetStringFromURL:	NWM_UT_GetStringFromURL
		HTMLEntityDecode:	NWM_UT_HTMLEntityDecode
		HTMLStripTags:		NWM_UT_HTMLStripTags
		SimpleJSONParser:	NWM_UT_SimpleJSONParser
	}

	return this
end function

function NWM_UT_GetStringFromURL(url, userAgent = "")
	result = ""
	timeout = 10000
  print "Fetching Url: ";url
  ut = CreateObject("roURLTransfer")
  ut.SetPort(CreateObject("roMessagePort"))
  if userAgent <> ""
	  ut.AddHeader("user-agent", userAgent)
	end if
  ut.SetURL(url)
	if ut.AsyncGetToString()
		event = wait(timeout, ut.GetPort())
		if type(event) = "roUrlEvent"
				print ValidStr(event.GetResponseCode())
				result = event.GetString()
				'exit while
		elseif event = invalid
				ut.AsyncCancel()
				REM reset the connection on timeouts
				'ut = CreateURLTransferObject(url)
				'timeout = 2 * timeout
		else
				print "roUrlTransfer::AsyncGetToString(): unknown event"
		endif
	end if

	return result
end function

function NWM_UT_HTMLEntityDecode(inStr)
	result = inStr

	rx = CreateObject("roRegEx", "&#39;", "")
	result = rx.ReplaceAll(result, "'")

	rx = CreateObject("roRegEx", "&amp;", "")
	result = rx.ReplaceAll(result, "&")

	rx = CreateObject("roRegEx", "&(quot|rsquo|lsquo);", "")
	result = rx.ReplaceAll(result, Chr(34))

	rx = CreateObject("roRegEx", "&\w+;", "")
	result = rx.ReplaceAll(result, Chr(34))

	return result
end function

function NWM_UT_HTMLStripTags(inStr)
	result = inStr

	rx = CreateObject("roRegEx", "<.*?>", "")
	result = rx.ReplaceAll(result, "")

	return result
end function

'	SimpleJSONParser is adapted from code contributed by the Roku developer community
'	http://forums.roku.com/viewtopic.php?f=34&t=32208
Function NWM_UT_SimpleJSONParser( jsonString As String ) As Object
	q = chr(34)

	beforeKey  = "[,{]"
	keyFiller  = "[^:]*?"
	keyNospace = "[-_\w\d]+"
	valueStart = "[" +q+ "\d\[{]|true|false|null"
	reReplaceKeySpaces = "("+beforeKey+")\s*"+q+"("+keyFiller+")("+keyNospace+")\s+("+keyNospace+")\s*"+q+"\s*:\s*(" + valueStart + ")"

	regexKeyUnquote = CreateObject( "roRegex", q + "([a-zA-Z0-9_\-\s]*)" + q + "\:", "i" )
	regexValueQuote = CreateObject( "roRegex", "\:(\d+)([,\}])", "i" )
	regexValueUnslash = CreateObject( "roRegex", "\\/", "i" )
	regexKeyUnspace = CreateObject( "roRegex", reReplaceKeySpaces, "i" )
	regexQuote = CreateObject( "roRegex", "\\" + q, "i" )

	' setup "null" variable
	null = invalid

	' Replace escaped quotes
	jsonString = regexQuote.ReplaceAll( jsonString, q + " + q + " + q )

	while regexKeyUnspace.isMatch( jsonString )
		jsonString = regexKeyUnspace.ReplaceAll( jsonString, "\1"+q+"\2\3\4"+q+": \5" )
	end while

	jsonString = regexKeyUnquote.ReplaceAll( jsonString, "\1:" )
	jsonString = regexValueQuote.ReplaceAll( jsonString, ":" + q + "\1" + q + "\2" )
	jsonString = regexValueUnslash.ReplaceAll( jsonString, "/" )

	jsonObject = invalid
	' Eval the BrightScript formatted JSON string
	Eval( "jsonObject = " + jsonString )
	Return jsonObject
End Function
