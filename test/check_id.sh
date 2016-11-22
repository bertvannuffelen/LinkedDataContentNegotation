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


C="http://data.vlaanderen.be/id "
Tval=404
no_header_check

C="http://data.vlaanderen.be/id/gebouw"
Tval=404
no_header_check

# we force currently that Accept header must be set
C="http://data.vlaanderen.be/id/adres/208562"
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

C="http://data.vlaanderen.be/id/"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/id"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/id/adres/208562"
Tval=303
ttlheader
header_check


# error case: niet bestaand 
echo "request for non-existing reference type"
echo "---------------------------------"

C="http://data.vlaanderen.be/id/bestaatniet"
Tval=404
ttlheader
header_check

C="http://data.vlaanderen.be/id/Adres/208562"
Tval=404
ttlheader
header_check

# follow redirect tests
echo "follow redirect request "
echo "------------------------"
PARAMETERS='-L --write-out %{http_code} --silent --output /dev/null'

C="http://data.vlaanderen.be/id/adres/208562"
Tval=200
ttlheader
header_check

C="http://data.vlaanderen.be/id/adres/208562"
Tval=200
htmlttllheader
header_check
