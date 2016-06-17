$Snoverisms = Invoke-WebRequest -Uri http://snoverisms.com/ | 
Select -ExpandProperty images | 
Select -ExpandProperty src |
foreach { start-bitstransfer $("http://snoverisms.com/{0}" -f $_) $ENV:PUBLIC\Downloads}

