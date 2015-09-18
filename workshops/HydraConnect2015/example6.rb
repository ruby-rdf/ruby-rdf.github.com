#!/usr/bin/env ruby
require 'linkeddata'

include RDF
graph = Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

q = Query.new(s: {RDF.type => FOAF.Person})
graph.query(q).count => 4

q = Query.new(s: {
  RDF.type => FOAF.Person,
  FOAF.name => :name
})

graph.query(q).to_json
