Function simpleJSONParser( jsonString As String ) As Object
        q = chr(34)

        beforeKey  = "[,{]"
        keyFiller  = "[^:]*?"
        keyNospace = "[-_\w\d]+"
        valueStart = "[" +q+ "\d\[{]|true|false|null"
        reReplaceKeySpaces = "("+beforeKey+")\s*"+q+"("+keyFiller+")("+keyNospace+")\s+("+keyNospace+")\s*"+q+"\s*:\s*(" + valueStart + ")"

        regexKeyUnquote = CreateObject( "roRegex", q + "([a-zA-Z0-9_\-\s]*)" + q + "\:", "i" )
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

        jsonObject = invalid
        ' Eval the BrightScript formatted JSON string
        Eval( "jsonObject = " + jsonString )
        Return jsonObject
End Function