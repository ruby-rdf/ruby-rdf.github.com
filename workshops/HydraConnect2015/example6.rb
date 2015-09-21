#!/usr/bin/env ruby
require 'linkeddata'

include RDF
graph = Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

q = Query.new(s: {RDF.type => FOAF.Person})
puts graph.query(q).count #s=> 4

q = Query.new(s: {
  RDF.type => FOAF.Person,
  FOAF.name => :name
})

puts graph.query(q).to_json
