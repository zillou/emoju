lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "emoju/version"

Gem::Specification.new do |spec|
  spec.name          = "emoju"
  spec.version       = Emoju::VERSION
  spec.authors       = ["Derrick Zhang"]
  spec.email         = ["robot@zillou.me"]

  spec.summary       = "Softbank, docomo, Google encoded emoji to unicode emoji"
  spec.description   = "Convert softbank, docomo, google encoded emoji to unicode emoji"
  spec.homepage      = "https://github.com/zillou/emoju"

  spec.files         = Dir["README.md", "LICENSE", "lib/**/*.rb", "data/emoji.json", "emoju.gemspec"]
  spec.require_paths = ["lib"]
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
