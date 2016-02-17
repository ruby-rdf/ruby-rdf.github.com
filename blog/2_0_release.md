# Ruby RDF 2.0

We are preparing for the 2.0 release of RDF.rb and related gems. This announces the general availability of [RDF.rb 2.0.0.beta1][] along with other gems collected in the [linkeddata][] meta-gem. Note that this release introduces breaking changes from the 1.* version; in most cases, these are highlighted using deprecation messages if using 1.99.

## New Features

* Readers and Writers now using `RDF::Util::Logger` for managing error, warning, information, and debug messages, which allow them to be managed more flexibly and consistently.
* Introduced `RDF::Dataset` and `RDF::Changeset`. Transactions are substantially changed, including read-only and read/write transactions. Collected changes are held in a `Changeset`, which is applied to a `Repository` (actually `Transactable`).
* `Dataset` is a read-only super-class of `Repository`, which can be provided by using `Repository#snapshot`, among other methods.
* Repository implementations now have more control for defining snapshots and transaction atomicity.
* The in-memory `Repository` implementation now uses [Hamster::Hash][] to implement a fully functional interface for updating repositories, saving a number of explicit `dup` operations. As a result, there is no guarantee on insert order of statements in a Graph or Repository being maintained.

## Deprecated Interfaces in 1.99

These changes result in a DEPRECATION warning in 1.99, and errors in 2.*:

* Minimum Ruby version no MRI 2.0 or equivalent 2.3 or greater preferred.
* Numerous vocabularies have been moved to the [rdf-vocab][] gem, for example `RDF::Vocab::FOAF` instead of `RDF::FOAF`.
* Many interfaces would take a `:context` option, this has been replaced with `:graph_name` to more properly correspond to RDF 1.1 concepts. This also includes `#context` and `#context=`, `#has_context?`, and `#each_context` methods in various modules and classes.
* `Vocabulary.label_for` is replaced with `Vocabulary::Term#label`* `Vocabulary.comment_for` is replaced with `Vocabulary::Term#comment`
* `#write_graph` and `#write_statementes` are replaced with `RDF::Writable#insert`
* `Writer#format_value` is deprecated in favor of `Writer#format_term`
* `NTriples::Reader` no longer supports [Surrogate Pairs](https://en.wikipedia.org/wiki/UTF-16).
* Many interfaces now use [keyword arguments][https://robots.thoughtbot.com/ruby-2-keyword-arguments] instead of positional arguments.

## Deprecated interfaces in 2.0

* `List#initialize` now uses keyword arguments instead of positional arguments. This is a breaking change which cannot support backwards compatibility, but shouldn't affect most normal use.
* `Graph#initialize` now uses keyword arguments instead of positional arguments. Positional arguments are accepted with a deprecation message until 2.0.0 is released.
* `Transaction` is completely changed, and existing use from 1.* is unlikely to work without modification in 2.*.

Ruby gems will not automatically load beta gems via `gem update`. To get these gems you must explicitly include them using `gem install --pre linkeddata`.

[RDF.rb 2.0.0.beta1]: https://rubygems.org/gems/rdf/versions/2.0.0.beta1
[linkeddata]:         https://rubygems.org/gems/linkeddata
[rdf-vocab]:          https://rubygems.org/gems/rdf-vocab