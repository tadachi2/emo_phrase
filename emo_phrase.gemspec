# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emo_phrase/version'

Gem::Specification.new do |spec|
  spec.name          = "emo_phrase"
  spec.version       = EmoPhrase::VERSION
  spec.authors       = ["tadachi2"]
  spec.email         = ["tadachi2@tadachi2.com"]

  spec.summary       = %q{Collecting a emotional phrase.}
  spec.description   = %q{}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

=begin
  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
=end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rubyXL"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "twitter"
  spec.add_development_dependency "fb_graph"

end
