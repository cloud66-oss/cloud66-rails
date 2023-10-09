require_relative "lib/cloud66/version"

Gem::Specification.new do |spec|
  spec.name        = "cloud66"
  spec.version     = Cloud66::VERSION
  spec.authors     = ["Cloud 66"]
  spec.email       = ["eng@cloud66.com"]
  spec.homepage    = "https://www.cloud66.com"
  spec.summary     = "Cloud 66 Ruby plugin"
  spec.description = "Cloud 66 Ruby plugin"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cloud66-oss/cloud66-rails"
  spec.metadata["changelog_uri"] = "https://github.com/cloud66-oss/cloud66-rails/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.add_dependency "rails", ">= 2.3"
end
