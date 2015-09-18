#!/bin/sh

# Parse query

sparql parse query.query
# => 
# (prefix
#  ((foaf: <http://xmlns.com/foaf/0.1/>) (doap: <http://usefulinc.com/ns/doap#>))
#  (project
#   (?project ?resource ?name)
#   (bgp
#    (triple ?project a doap:Project)
#    (triple ?project doap:developer ?person)
#    (triple ?person a foaf:Person)
#    (triple ?person foaf:name ?name)) ))

# Execute a query against a dataset
sparql execute query.sparql --dataset doap.ttl
# => 
# project: http://rubygems.org/gems/rdf
# name: Arto Bendiken
# project: http://rubygems.org/gems/rdf
# name: Ben Lavender
# project: http://rubygems.org/gems/rdf
# name: Gregg Kellogg

# Execute a query against a remote endpoint
sparql query https://ruby-rdf.github.io/workshops/HydraConnect/2015/doap.ttl query.sparql

# Run a local SPARQL server
sparql server --dataset doap.ttl &
sparql query http://localhost:8080 query.sparql
