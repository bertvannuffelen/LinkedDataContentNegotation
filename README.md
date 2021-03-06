# LinkedDataContentNegotation
A proxy setup for Linked Data Content Negotation

This Apache 2.4 proxy setup implements the Flemish Government URI strategy based on id / doc using 303. 
This implementation will be the reference implementation of this strategy so that others within the Flemish Government can quicky exploit this.
Additionally the default pages are also according to the Flemish Government webstyle rules.

Despite the tailoring towards the Flemish Government look&feel and some URI decisions, this forms still a template implementation that can be applied by any Linked Data publication platform.
Therefore the design choices are documented here so that others organisations which like to deploy a Linked Data publishing platform can move forward quicker.


## Deployment structure
The service based upon the [official Docker Container for Apache2 webserver](https://github.com/docker-library/httpd).

The service is organized as follows:

@build-time
* /config  : the configuration files
* /scripts : the cgi-scripts
* /www     : the document root

@runtime
* /logs    : the logs


## Architectural embedding
The service connects to other services, which should be declared as accessible hosts:

* ldsb-service            : Linked Data Subject Block service
* subjectpages-service    : HTML subject pages service
* sparql-endpoint-service : SPARQL endpoint

The service URLs are given by the following environment variables

| Environment variable | default value |
| -------------------- | ------------- |
| ENV_LDSB_SERVICE_URL    | http://ldsb-service:81 |
| ENV_SUBJECTPAGES_SERVICE_URL    | http://subjectpages-service |
| ENV_SPARQL_ENDPOINT_SERVICE_URL    | http://sparql-endpoint-service:8890/sparql |

## Configuration

| Environment variable | default value |
| -------------------- | ------------- |
| ENV_URI_DOMAIN | data.vlaanderen.be |

## Execution
A typical start in production setting will be

```
docker run -d -p 80:80 
    --add-host sparql-endpoint-service:<ip/hostname>
    --add-host ldsb-service:<ip/hostname>
    --add-host subjectpages-service:<ip/hostname> 
    -e ENV_LDSB_SERVICE_URL=http://ldsb-service
    --name=cn 
    -v /persistentstorage/logs/LinkedDataContentNegotation/:/logs
    bertvannuffelen/linkeddatacontentnegotation
```

Note the public exposure of the logs on persistent storage. It is a good practice to ensure that the logs are stored on
a safe location. If the service has to change, the logs are kept for future problem resolution.

# Design decisions

For instance, on places where a 300 Multiple Choice repons usually is suggested, this implementation will respond with a 404 providing a custom message
indicating the supported accept headers. 
This complies to the current standardization levels and best practices for implementing the HTTP responses. 
Namely the HTTP 300 respons has no standard respons body which can detail the allowed/supported options by the server.
Therefore the handling of the HTTP 300 respons cannot be automated, and it it better to force the consumer to take explicit action
in its client code.

## sparql endpoint
This proxy activates a sparql-endpoint at the url $ENV_URI_DOMAIN/sparql. This sparql interface has a web interface and a machine readable interface.
Via content negotation the machine readable interface is reachable. The Accept header is one of the following values defined according to W3C:

| ACCEPT header | description format |
| -------------------- | ------------- |
|application/sparql-results+json| [https://www.w3.org/TR/sparql11-results-json/] |
|application/sparql-results+xml | [https://www.w3.org/TR/rdf-sparql-XMLres/] |
|text/csv                       | [https://www.w3.org/TR/sparql11-results-csv-tsv/] |
|text/tab-separated-values      | [https://www.w3.org/TR/sparql11-results-csv-tsv/] |


## content negotation
This proxy activates content negotation. The table below describes the implemented accept headers.


| document format | corresponding accept-header | corresponding extension |
| --------------- | --------------------------- | ----------------------- |
| HTML | text/html | .html|
| RDF  | application/rdf+xml | .rdf|
| TURTLE | text/turtle | .ttl|
| NTRIPLES | text/ntriples | .nt|
| jsonld | application/ld+json| .jsonld|
| json | application/json| .json|

## Notes
a) https://pwc-technology-be.github.io/oslo/dienst/dienst.jsonld is used instead of the github version. This is a manual update for now.
