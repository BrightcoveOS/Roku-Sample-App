'
' Calls the given URL and returns its result as a string.
' Modified from NWM_Utilities.brs in the Roku SDK
'

function GetStringFromURL(url, bcovPolicy = "")
  ut = CreateObject("roURLTransfer")

  ' allow for https
  ut.SetCertificatesFile("common:/certs/ca-bundle.crt")
  ut.AddHeader("X-Roku-Reserved-Dev-Id", "")
  ut.InitClientCertificates()

  if bcovPolicy <> ""
    ut.AddHeader("BCOV-Policy", bcovPolicy)
  end if
  ut.SetURL(url)
  return ur.GetToString()
end function
