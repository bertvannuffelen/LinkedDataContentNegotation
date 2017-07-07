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


C="http://data.vlaanderen.be/doc "
Tval=404
no_header_check

C="http://data.vlaanderen.be/doc/gebouw"
Tval=404
no_header_check

# we force currently that Accept header must be set
C="http://data.vlaanderen.be/doc/adres/208562"
Tval=200
no_header_check

# with document extensions
C="http://data.vlaanderen.be/doc/adres/208562.nt"
Tval=200
no_header_check

C="http://data.vlaanderen.be/doc/adres/208562.ttl"
Tval=200
no_header_check

C="http://data.vlaanderen.be/doc/adres/208562.rdf"
Tval=200
no_header_check

C="http://data.vlaanderen.be/doc/adres/208562.json"
Tval=200
no_header_check

C="http://data.vlaanderen.be/doc/adres/208562.html"
Tval=200
no_header_check


# event ends with .nt so it should go to the html representation
C="http://data.vlaanderen.be/doc/adres/event"
Tval=404
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
function rdfheader {
   Header="Accept: application/rdf+xml"
}
function ntheader {
   Header="Accept: text/ntriples"
}

function htmlttllheader {
   Header="Accept: text/html, text/turtle"
}

C="http://data.vlaanderen.be/doc/"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/doc"
Tval=404
ttlheader
header_check

  # only with header
C="http://data.vlaanderen.be/doc/adres/208562"
Tval=200
ntheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562"
Tval=200
ttlheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562"
Tval=200
rdfheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562"
Tval=200
htmlheader
header_check

# header & extensions
C="http://data.vlaanderen.be/doc/adres/208562.nt"
Tval=200
ntheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562.ttl"
Tval=200
ttlheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562.rdf"
Tval=200
rdfheader
header_check

C="http://data.vlaanderen.be/doc/adres/208562.html"
Tval=200
htmlheader
header_check


# error case: niet bestaand 
echo "request for non-existing reference type"
echo "---------------------------------"

C="http://data.vlaanderen.be/doc/bestaatniet"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/doc/Adres/208562"
Tval=404
ttlheader
header_check

