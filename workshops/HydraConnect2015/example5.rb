#!/usr/bin/env ruby
require 'linkeddata'

graph = RDF::Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

puts graph.query([:s, RDF::Vocab::FOAF.name, :o]).to_ttl
