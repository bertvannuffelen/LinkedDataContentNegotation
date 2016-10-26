#!/bin/bash

PARAMETERS='--write-out %{http_code} --silent --output /dev/null'

function nl {
	echo -e "\n"
}

function check {
   echo $CCall 
   if [ "$Cexec" = "$Tval" ] ; then
	echo "ok"
   else 
	echo "NOK: recieved $Cexec expected $Tval"
   fi
   nl
};


echo "check without headers" 
echo "---------------------" 

function no_header_check {
   CCall="curl $PARAMETERS $C"
   Cexec="$(curl $PARAMETERS $C)"
   check
}


C="http://data.vlaanderen.be/ns "
Tval=404
no_header_check

C="http://data.vlaanderen.be/ns/gebouw"
Tval=404
no_header_check

# we force currently that Accept header must be set
C="http://data.vlaanderen.be/ns/gebouw.ttl"
Tval=200
no_header_check

# we force currently that Accept header must be set
C="http://data.vlaanderen.be/ns/gebouw.rdf"
Tval=200
no_header_check

# we force currently that Accept header must be set
C="http://data.vlaanderen.be/ns/gebouw.html"
Tval=200
no_header_check


echo "check with headers" 
echo "------------------"

function header_check {
   CCall="curl $PARAMETERS -H \"$Header\" $C"
   Cexec="$(curl $PARAMETERS -H "$Header" $C)"
   check
}

function htmlheader {
   Header="Accept: text/html"
}
function ttlheader {
   Header="Accept: text/turtle"
}

function htmlttllheader {
   Header="Accept: text/html, text/turtle"
}

C="http://data.vlaanderen.be/ns/"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/ns"
Tval=200
ttlheader
header_check

C="http://data.vlaanderen.be/ns/gebouw"
Tval=200
ttlheader
header_check

C="http://data.vlaanderen.be/ns/gebouw.ttl"
Tval=200
ttlheader
header_check

# ignore accept header if file extension is present
C="http://data.vlaanderen.be/ns/gebouw.ttl"
Tval=200
htmlheader
header_check


# error case: niet bestaand 
echo "request for non-existing ontology"
echo "---------------------------------"

C="http://data.vlaanderen.be/ns/bestaatniet"
Tval=404
ttlheader
header_check

# bestaand urls
# http://data.vlaanderen.be/id/straatnaam/10189
