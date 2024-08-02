# frozen_string_literal: true

require_relative "lib/pallycon/version"

Gem::Specification.new do |spec|
  spec.name = "pallycon"
  spec.version = Pallycon::VERSION
  spec.authors = ["Kuang Li"]
  spec.email = ["augustus0613@hotmail.com"]

  spec.summary = "PALLYCON Multi-DRM Integration Client"
  spec.description = "A Client to integrate PALLYCON Multi-DRM"
  spec.required_ruby_version = ">= 2.6.0"
  spec.require_paths = ["lib"]

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
