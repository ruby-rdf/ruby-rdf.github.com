#!/usr/bin/env ruby
require 'linkeddata'

# Classic Reading
graph = RDF::Graph.new do |g|
  RDF::Reader.open("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl") do |reader|
    g << reader
  end
end

puts graph.count

# Load
graph = RDF::Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

puts graph.count
