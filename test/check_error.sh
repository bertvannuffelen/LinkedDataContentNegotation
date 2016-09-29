#!/bin/bash

curl http://data.vlaanderen.be

curl http://data.vlaanderen.be/

curl http://data.vlaanderen.be/id

curl http://data.vlaanderen.be/id/

curl http://data.vlaanderen.be/bestaatniet/

curl http://data.vlaanderen.be/id/Address/12324

curl -H "Accept:" http://data.vlaanderen.be/id/Address/12324

curl -H "Accept: ikke/ikee" http://data.vlaanderen.be/id/Address/12324

curl -H "Accept: ikke/ikee, text/html" http://data.vlaanderen.be/id/Address/12324

curl -H "Accept: ikke/ikee, ikke/keek" http://data.vlaanderen.be/id/Address/12324

# valid
curl -H "Accept: text/html, text/turtle" http://data.vlaanderen.be/id/Address/12324
# valid
curl -H "Accept: text/turtle, text/html" http://data.vlaanderen.be/id/Address/12324



