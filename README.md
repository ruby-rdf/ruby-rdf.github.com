# Linked Data for Ruby

This is the home of Ruby RDF. This project collects numerous gems supporting Linked Data and Semantic Web programming in Ruby.

The primary gem is [RDF.rb](http://ruby-rdf.github.com/rdf), which contains the core algorithms and classes used for doing basic programming of [RDF][], including support for `Repositories`, `Graphs`, `Statements`, `URIs`, `Literals`, and `BNodes`.

The Ruby RDF account also collects numerous gems used for reading and writing different RDF formats. At present, this includes the following:

* [JSON-LD][] (through [JSON::LD])
* [Microdata][] (through [RDF::Microdata][]),
* [N-Quads][] (through [RDF.rb][])
* [N-Triples][] (through [RDF.rb][])
* [Notation3][] (through [RDF::N3][]),
* [RDF/JSON][] (through [RDF::JSON]),
* [CSV][] (through [RDF::Tabular]),
* [RDF/XML][] (through [RDF::RDFXML][] and [RDF::Raptor][]),
* [RDFa][] (through [RDF::RDFa][] and [RDF::Raptor][]),
* [TriG][] (through [RDF::TriG][]),
* [TriX][] (through [RDF::TriX][]),
* [Turtle][] (through [RDF::Turtle][] and [RDF::Raptor][]),

In addition to basic Query mechanisms

* [LD::Patch][],
* [RDF::AggregateRepo][],
* [RDF::Isomorphic][],
* [RDF::Normalize][],
* [SPARQL::Client][],
* [SPARQL][].

Web infrastructure

* [RDF::LDP][],
* [Rack::Linkeddata][],
* [Sinatra::LinkedData][].

There are also storage adaptors for popular Triple-stores, Graph-stores SQL, and other NOSQL stores.

 * [RDF::AllegroGraph][],
 * [RDF::Blazegraph][],
 * [RDF::DO][],
 * [RDF::Mongo][],
 * [RDF::Sesame][]
 * [RDF::Virtuoso][]

There is also a [LinkedData][] gem, which combines a core set of these together.

## Gems

| Gem                | Category  | Support   | Maintainer |
| :----------------- | :-------- | :-------- | :--------- |
| json-ld            | Format    | Core      | @gkellogg  |
| ld-patch           | Format    | Community | @gkellogg  |
| linkeddata         | Format    | Core      | @ruby-rdf  |
| rack-linkeddata    | Server    | Community | @ruby-rdf  |
| rack-sesame        | Server    | Obsolete  | -          |
| rack-sparql        | Server    | Obsolete  | -          |
| rdf                | Core      | Core      | @ruby-rdf  |
| rdf-aggregate-repo | Storage   | Core      | @gkellogg  |
| rdf-agraph         | Storage   | Vendor    | @emk       |
| rdf-arq            | Query     | Obsolete  | -          |
| rdf-bert           | RPC       | Obsolete  | -          |
| rdf-blazegraph     | Storage   | Vendor    | @no-reply  |
| rdf-cassandra      | Storage   | Obsolete  | -          |
| rdf-do             | Storage   | Core      | @ruby-rdf  |
| rdf-isomorphic     | Misc      | Core      | @ruby-rdf  |
| rdf-json           | Format    | Core      | @ruby-rdf  |
| rdf-ldp            | Server    | Community | @no-reply  |
| rdf-microdata      | Format    | Core      | @ruby-rdf  |
| rdf-mongo          | Storage   | Community | @gkellogg  |
| rdf-n3             | Format    | Core      | @ruby-rdf  |
| rdf-normalize      | Extension | Core      | @gkellogg  |
| rdf-raptor         | Format    | Community | @dwbutler  |
| rdf-rasqal         | Query     | Obsolete  | -          |
| rdf-rdfa           | Format    | Core      | @ruby-rdf  |
| rdf-rdfxml         | Format    | Core      | @ruby-rdf  |
| rdf-reasoner       | Reasoner  | Core      | @gkellogg  |
| rdf-sesame         | Storage   | Community | @abrisse   |
| rdf-source         | Extension | Obsolete  | -          |
| rdf-spec           | Testing   | Core      | @ruby-rdf  |
| rdf-tabular        | Format    | Community | @gkellogg  |
| rdf-talis          | Storage   | Obsolete  | -          |
| rdf-trig           | Format    | Core      | @ruby-rdf  |
| rdf-trix           | Format    | Core      | @ruby-rdf  |
| rdf-turtle         | Format    | Core      | @ruby-rdf  |
| rdf-vcf            | Format    | Community | @bendiken  |
| rdf-virtuoso       | Storage   | Vendor    | @digibib   |
| rdf-vocab          | Extension | Core      | @ruby-rdf  |
| rdf-xsd            | Extension | Core      | @ruby-rdf  |
| rdfs               | Reasoner  | Obsolete  | @ruby-rdf  |
| sinatra-linkeddata | Server    | Core      | -          |
| sparql             | Query     | Core      | @ruby-rdf  |
| sparql-client      | Client    | Core      | @ruby-rdf  |
| spira              | ORM       | Community | @cordawyn  |
| trinity            | CMS       | Obsolete  | -          |

## Examples

    require 'linkeddata'

### Writing RDF data using the N-Triples format

    require 'rdf/ntriples'
    graph = RDF::Graph.new << [:hello, RDF::Vocab::DC.title, "Hello, world!"]
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
        RDF.type  => RDF::Vocab::FOAF.Person,
        RDF::Vocab::FOAF.name => :name,
        RDF::Vocab::FOAF.mbox => :email,
      }
    })
    
    query.execute(repo).each do |solution|
      puts "name=#{solution.name} email=#{solution.email}"
    end

A separate [SPARQL][SPARQL doc] gem builds on basic BGP support to provide full support for [SPARQL 1.1](http://www.w3.org/TR/sparql11-query/) queries and [updates](http://www.w3.org/TR/sparql11-update/).

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

## Presentations on RDF.rb and related technologies

* [Ruby SemWeb](presentations/RubySemWeb-2011-12-06/index.html) – Introduction to RDF.rb given at the [Lotico Semantic Web meetup in San Francisco on 06 December 2011](http://www.meetup.com/The-San-Francisco-Semantic-Web-Meetup/events/36879012/) by Gregg.
* [Belin Lotico](presentations/Berlin-Lotico/index.html) – Tutorial on RDF.rb given at the [Lotico Semantic Web meetup in Berlin on 18 June 2015](http://www.meetup.com/The-Berlin-Semantic-Web-Meetup-Group/events/222454444/) by Arto.
* [JSON-LD: JSON for Linking Data](presentations/JSON-LD-JSON-for-linking-data/index.html) – Introduction to JSON-LD given at the [Semantic Technologies Conference in San Francisco on 7 June 2012](http://semtechbizsf2012.semanticweb.com/agenda.cfm?confid=65&scheduleDay=PRINT) by Gregg.
* [Presenting RDF](presentations/Presenting%20RDF/index.html) – Discussion of the technology behind the [RDF Distiller](http://rdf.greggkellogg.net/) and [Structured Data Linter](http://linter.structured-data.org/) by Gregg.
* [Tabular Data on the Web](presentations/Tabular-Data-on-the-Web/index.html) - Discussion of the CSV on the Web proposed standard given at [Smart Data conference in San Jose on 18 August 2015](http://smartdata2015.dataversity.net) by Gregg.
* [Linked Data with Ruby and RDF.rb](presentations/HydraConnect2015/index.html) – Workshop given at [Hydra Connect 2015 on 21 September 2015]() by Gregg.

[RDF.rb]:             http://ruby-rdf.github.com/rdf
[RDF::AggregateRepo]: http://ruby-rdf.github.com/rdf-aggregate-repo
[RDF::AllegroGraph]:  http://ruby-rdf.github.com/rdf-agraph
[RDF::Blazegraph]:    http://ruby-rdf.github.com/rdf-blazegraph
[RDF::DO]:            http://ruby-rdf.github.com/rdf-do
[RDF::Isomorphic]:    http://ruby-rdf.github.com/rdf-isomorphic
[RDF::JSON]:          http://ruby-rdf.github.com/rdf-json
[RDF::LDP]:           http://ruby-rdf.github.com/rdf-ldp
[RDF::Microdata]:     http://ruby-rdf.github.com/rdf-microdata
[RDF::Mongo]:         http://ruby-rdf.github.com/rdf-mongo
[RDF::N3]:            http://ruby-rdf.github.com/rdf-n3
[RDF::Normalize]:     http://ruby-rdf.github.com/rdf-normalize
[RDF::Raptor]:        http://ruby-rdf.github.com/rdf-raptor
[RDF::RDFa]:          http://ruby-rdf.github.com/rdf-rdfa
[RDF::RDFXML]:        http://ruby-rdf.github.com/rdf-rdfxml
[RDF::Sesame]:        http://ruby-rdf.github.com/rdf-sesame
[RDF::Tabular]:       http://ruby-rdf.github.com/rdf-tabular
[RDF::TriG]:          http://ruby-rdf.github.com/rdf-trig
[RDF::TriX]:          http://ruby-rdf.github.com/rdf-trix
[RDF::Turtle]:        http://ruby-rdf.github.com/rdf-turtle
[RDF::Virtuoso]:      http://ruby-rdf.github.com/rdf-virtuoso
[JSON::LD]:           http://ruby-rdf.github.com/json-ld
[LD::Patch]:          http://ruby-rdf.github.com/ld-patch
[LinkedData]:         http://ruby-rdf.github.com/linkeddata
[Rack::Linkeddata]:   http://ruby-rdf.github.com/rack-linkeddata
[Sinatra::Linkeddata]:http://ruby-rdf.github.com/sinatra-linkeddata
[SPARQL gem]:         http://ruby-rdf.github.com/sparql
[SPARQL::Client]:     http://ruby-rdf.github.com/sparql-client

[CSV]:                http://www.w3.org/TR/tabular-data-model
[JSON-LD]:            http://json-ld.org/
[Linked Data]:        http://linkeddata.org/
[Microdata]:          http://en.wikipedia.org/wiki/Microdata_(HTML)
[N-Quads]:            http://sw.deri.org/2008/07/n-quads/
[N-Triples]:          http://en.wikipedia.org/wiki/N-Triples
[Notation3]:          http://en.wikipedia.org/wiki/Notation3
[Raptor]:             http://en.wikipedia.org/wiki/Redland_RDF_Application_Framework
[RDF/JSON]:           http://n2.talis.com/wiki/RDF_JSON_Specification
[RDF/XML]:            http://en.wikipedia.org/wiki/RDF/XML
[RDFa]:               http://en.wikipedia.org/wiki/RDFa
[SPARQL]:             http://en.wikipedia.org/wiki/Sparql
[TriG]:               http://dvcs.w3.org/hg/rdf/raw-file/default/trig/index.html
[TriX]:               http://www.w3.org/2004/03/trix/
[Turtle]:             http://www.w3.org/TR/turtle/
[versioning]:         http://blog.zenspider.com/2008/10/rubygems-howto
