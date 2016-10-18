# LinkedDataContentNegotation
A proxy setup for Linked Data Content Negotation

This Apache 2.4 proxy setup implements the Flemish URI strategy based on id / doc using 303. 
This implementation will be the reference implementation of this strategy so that others can quicky exploit this.

Additionally this forms a template implementation that can be applied by any Linked Data publication platform.
It will reduce the search for the good practice of implementation.

For instance, on places where a 300 Multiple Choice repons usually is suggested, this implementation will respond with a 404 providing a custom message
indicating the supported accept headers. 
This complies to the current standardization levels and best practices for implementing the HTTP responses. 
Namely the HTTP 300 respons has no standard respons body which can detail the allowed/supported options by the server.
Therefore the handling of the HTTP 300 respons cannot be automated, and it it better to force the consumer to take explicit action
in its client code.


# open port 80 for testing
docker run --rm --name=newcn -p 80:80 myproxy


