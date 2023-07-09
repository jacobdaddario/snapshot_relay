# frozen_string_literal: true

require_relative "lib/snapshot_relay/version"

Gem::Specification.new do |spec|
  spec.name = "snapshot_relay"
  spec.version = SnapshotRelay::VERSION
  spec.authors = ["Jacob Daddario"]
  spec.email = ["jacob.d@hey.com"]

  spec.summary = "Get reporting logic out of your business logic with Snapshot Relay."
  spec.description = "Sending data to third-party services, emails to support entities, and webhooks to Slack aren't business logic. Still, often times lots of boilerplate code is written to handle these tasks. Snapshot Relay aims to get this reporting logic out of your business logic and into a single place."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport", "~> 7.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
