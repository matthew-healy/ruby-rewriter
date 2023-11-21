# frozen_string_literal: true

require_relative "lib/ruby-rewriter/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-rewriter"
  spec.version = RubyRewriter::VERSION
  spec.authors = ["Matthew Healy"]
  spec.email = ["matthew@liamhealy.xyz"]

  spec.summary = "A tool for rewriting Ruby files automatically"
  spec.homepage = "https://github.com/matthew-healy/ruby-rewriter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby_parser", "~> 3.20"
  spec.add_dependency "ruby2ruby", "~> 2.5"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
