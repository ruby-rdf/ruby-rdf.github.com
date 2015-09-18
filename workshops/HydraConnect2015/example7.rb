require 'linkeddata'
graph = RDF::Graph.load("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")

# Using SPARQL Gem
query = SPARQL.parse("SELECT ?x ?y WHERE {?x ?p ?y}")
graph.query(query) do |solution|
  x = solution[:x]
  y = solution[:y]
end

# Using a Remote endpoint
sparql = SPARQL::Client.new("https://ruby-rdf.github.io/workshops/HydraConnect2015/doap.ttl")
query = sparql.query("SELECT ?x ?y WHERE {?x ?p ?y}")
query.each_solution do |solution|
  x = solution[:x]
  y = solution[:y]
end

# Using DSL
query = sparql.select(:x, :y).where([:x, :p, :y])
