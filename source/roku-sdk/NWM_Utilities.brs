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
	}
	
	return this
end function

function NWM_UT_GetStringFromURL(url, userAgent = "")
	result = ""
	timeout = 10000
	
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
