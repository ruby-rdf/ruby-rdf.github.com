#!/usr/bin/env ruby
require 'linkeddata'
graph = RDF::Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

# Using SPARQL Gem
puts "query local graph"
query = SPARQL.parse("SELECT ?x ?y WHERE {?x ?p ?y}")
graph.query(query) do |solution|
  x = solution[:x]
  y = solution[:y]
  puts "#{x.to_ntriples}, #{y.to_ntriples}"
end

# Using a Remote endpoint
puts "query remote graph"
sparql = SPARQL::Client.new("http://dydra.com/ruby-rdf/sparql-client-test/sparql")
query = sparql.query("SELECT ?x ?y WHERE {?x ?p ?y} LIMIT 10")
query.each_solution do |solution|
  x = solution[:x]
  y = solution[:y]
  puts "#{x.to_ntriples}, #{y.to_ntriples}"
end

# Using DSL
puts "query remote graph (DSL)"
query = sparql.select(:x, :y).where([:x, :p, :y])
query.each_solution do |solution|
  x = solution[:x]
  y = solution[:y]
  puts "#{x.to_ntriples}, #{y.to_ntriples}"
end
