Function fetch_JSON(url as string) as Object
	print "fetching JSON"
	timer = CreateObject("roTimespan")

	timer.Mark()	
	http = NewHttp(url)
	
	rsp = http.GetToStringWithTimeout(config().requestTimeOut)
	
	print "Response: ";rsp
	
	print "JSON Download time: ";itostr(timer.TotalMilliseconds())
	
	timer.mark()
	print "Parsing JSON"
	parsedResponse = simpleJSONParser(rsp)
	print "Parsing JSON time: ";itostr(timer.TotalMilliseconds());" Response Size: ";Len(rsp)
	
	if parsedResponse.error <> invalid
		print "Got error with JSON results: ";parsedResponse.message
		parsed = invalid
	end if
	
	return parsedResponse
End Function