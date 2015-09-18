#!/usr/bin/env ruby

require 'rdf'
require 'rdf/ntriples'

include RDF

graph = Graph.new
graph << [:hello, DC.title, "Hello, world!"]
puts graph.dump(:ntriples)