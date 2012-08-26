Linked Data for Ruby
====================

This is the home of Ruby RDF. This project collects numerous gems supporting Linked Data and Semantic Web programming in Ruby.

The primary gem is [RDF.rb](http://ruby-rdf.github.com/rdf), which contains the core algorithms and classes used for doing basic programming of [RDF][], including support for `Repositories`, `Graphs`, `Statements`, `URIs`, `Literals`, and `BNodes`.

The Ruby RDF account also collects numerous gems used for reading and writing different RDF formats. At present, this includes the following:

* [N-Triples][] (through [RDF.rb][])
* [N-Quads][] (through [RDF.rb][])
* [Turtle][] (through [RDF::Turtle][] and [RDF::Raptor][]),
* [Notation3][] (through [RDF::N3][]),
* [RDFa][] (through [RDF::RDFa][] and [RDF::Raptor][]),
* [Microdata][] (through [RDF::Microdata][]),
* [RDF/XML][] (through [RDF::RDFXML][] and [RDF::Raptor][]),
* [RDF/JSON][] (through [RDF::JSON]),
* [JSON-LD][] (through [JSON::LD])

In addition to basic Query mechanisms

* [RDF::Isomorphic][],
* [SPARQL::Client][],
* [SPARQL][].

There are also storage adaptors for popular Triple-stores, Graph-stores SQL, and other NOSQL stores.

 * [RDF::DO][],
 * [RDF::Mongo][],
 * [RDF::Sesame][]

There is also a [LinkedData][] gem, which combines a core set of these together.

## Examples

    require 'linkeddata'

### Writing RDF data using the N-Triples format

    require 'rdf/ntriples'
    graph = RDF::Graph.new << [:hello, RDF::DC.title, "Hello, world!"]
    graph.dump(:ntriples)
    
or

    RDF::Writer.open("hello.nt") { |writer| writer << graph }

### Reading RDF data in the N-Triples format

    require 'rdf/ntriples'
    graph = RDF::Graph.load("http://ruby-rdf.github.com/rdf/etc/doap.nt")
    
or

    RDF::Reader.open("http://ruby-rdf.github.com/rdf/etc/doap.nt") do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Reading RDF data in other formats
{RDF::Reader.open} and {RDF::Repository.load} use a number of mechanisms to determine the appropriate reader
to use when loading a file. The specific format to use can be forced using, e.g. `:format => :ntriples`
option where the specific format symbol is determined by the available readers. Both also use
MimeType or file extension, where available.

    require 'linkeddata'
    
    repo = RDF::Repository.load("http://ruby-rdf.github.com/rdf-turtle/etc/doap.ttl")

A specific sub-type of Reader can also be invoked directly:

    require 'rdf/turtle'
    
    RDF::Reader.open("http://ruby-rdf.github.com/rdf-turtle/etc/doap.ttl") do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Writing RDF data using other formats
`RDF::Writer.open`, `RDF::Enumerable#dump`, `RDF::Writer.dump` take similar options to `RDF::Reader.open` to determine the
appropriate writer to use.

    require 'linkeddata'

    RDF::NTriples::Writer.open("doap.nt") do |writer|
      writer << RDF::Reader.open("http://ruby-rdf.github.com/rdf/etc/doap.nt")
    end

A specific sub-type of Writer can also be invoked directly:

    require 'rdf/nquads'

    graph.dump(:nquads)

### Querying RDF data using basic graph patterns (BGPs)

    require 'rdf/nquads'
    
    repo = RDF::Repository.load("http://ruby-rdf.github.com/rdf/etc/doap.nq")
    query = RDF::Query.new({
      :person => {
        RDF.type  => RDF::FOAF.Person,
        RDF::FOAF.name => :name,
        RDF::FOAF.mbox => :email,
      }
    })
    
    query.execute(repo).each do |solution|
      puts "name=#{solution.name} email=#{solution.email}"
    end

A separate [SPARQL][SPARQL doc] gem builds on basic BGP support to provide full support for [SPARQL 1.0](http://www.w3.org/TR/rdf-sparql-query/) queries.

### Using pre-defined RDF vocabularies

    DC.title      #=> RDF::URI("http://purl.org/dc/terms/title")
    FOAF.knows    #=> RDF::URI("http://xmlns.com/foaf/0.1/knows")
    RDF.type      #=> RDF::URI("http://www.w3.org/1999/02/22-rdf-syntax-ns#type")
    RDFS.seeAlso  #=> RDF::URI("http://www.w3.org/2000/01/rdf-schema#seeAlso")
    RSS.title     #=> RDF::URI("http://purl.org/rss/1.0/title")
    OWL.sameAs    #=> RDF::URI("http://www.w3.org/2002/07/owl#sameAs")
    XSD.dateTime  #=> RDF::URI("http://www.w3.org/2001/XMLSchema#dateTime")

### Using ad-hoc RDF vocabularies

    foaf = RDF::Vocabulary.new("http://xmlns.com/foaf/0.1/")
    foaf.knows    #=> RDF::URI("http://xmlns.com/foaf/0.1/knows")
    foaf[:name]   #=> RDF::URI("http://xmlns.com/foaf/0.1/name")
    foaf['mbox']  #=> RDF::URI("http://xmlns.com/foaf/0.1/mbox")

[RDF.rb]:         http://ruby-rdf.github.com/rdf
[RDF::DO]:        http://ruby-rdf.github.com/rdf-do
[RDF::Mongo]:     http://ruby-rdf.github.com/rdf-mongo
[RDF::Sesame]:    http://ruby-rdf.github.com/rdf-sesame
[RDF::JSON]:      http://ruby-rdf.github.com/rdf-json
[RDF::Microdata]: http://ruby-rdf.github.com/rdf-microdata
[RDF::N3]:        http://ruby-rdf.github.com/rdf-n3
[RDF::RDFa]:      http://ruby-rdf.github.com/rdf-rdfa
[RDF::RDFXML]:    http://ruby-rdf.github.com/rdf-rdfxml
[RDF::TriX]:      http://ruby-rdf.github.com/rdf-trix
[RDF::Turtle]:    http://ruby-rdf.github.com/rdf-turtle
[RDF::Raptor]:    http://ruby-rdf.github.com/rdf-raptor
[LinkedData]:     http://ruby-rdf.github.com/linkeddata
[JSON::LD]:       http://gkellogg.github.com/json-ld
[SPARQL gem]:     http://ruby-rdf.github.com/sparql
[SPARQL::Client]: http://ruby-rdf.github.com/sparql-client
[JSON-LD]:        http://json-ld.org/
[Linked Data]:    http://linkeddata.org/
[Microdata]:      http://en.wikipedia.org/wiki/Microdata_(HTML)
[N-Quads]:        http://sw.deri.org/2008/07/n-quads/
[N-Triples]:      http://en.wikipedia.org/wiki/N-Triples
[Notation3]:      http://en.wikipedia.org/wiki/Notation3
[RDF/JSON]:       http://n2.talis.com/wiki/RDF_JSON_Specification
[RDF/XML]:        http://en.wikipedia.org/wiki/RDF/XML
[RDFa]:           http://en.wikipedia.org/wiki/RDFa
[Raptor]:         http://en.wikipedia.org/wiki/Redland_RDF_Application_Framework
[SPARQL]:         http://en.wikipedia.org/wiki/Sparql
[TriX]:           http://www.w3.org/2004/03/trix/
[Turtle]:         http://www.w3.org/TR/turtle/
[versioning]:     http://blog.zenspider.com/2008/10/rubygems-howto-preventing-cata.html
