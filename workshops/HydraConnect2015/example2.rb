#!/usr/bin/env ruby
require 'linkeddata'

alice = RDF::URI("http://example.org/people/alice")
name = RDF::URI("http://example.org/ongology/name")
person = RDF::URI("http://example.org/ontology/Person")

repo = RDF::Repository.new do |repo|
  repo << [alice, RDF.type, person]
  repo << [alice, name, "Alice"]
end

puts repo.dump(:ttl)