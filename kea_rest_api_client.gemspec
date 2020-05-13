Gem::Specification.new do |s|
  s.name          = 'kea_rest_api_client'
  s.version       = '1.0.0'
  s.authors       = ['Arnoud Vermeer']
  s.email         = ['a.vermeer@freshway.biz']
  s.license       = 'Apache'
  s.summary       = 'Kea DHCP Server REST API client for Ruby'
  s.description   = 'Kea DHCP Server REST API client for Ruby'
  s.homepage      = 'https://github.com/funzoneq/kea-rest-api-client'

  s.files         = `git ls-files`.split("\n")

  s.add_runtime_dependency 'httparty', "~> 0.10.0"

  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'webmock', '~> 1.22.2'
  s.add_development_dependency 'rubocop', '~> 0.49.0'
  s.add_development_dependency 'rake', '>= 12.3.3'
end
