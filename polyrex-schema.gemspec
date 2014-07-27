Gem::Specification.new do |s|
  s.name = 'polyrex-schema'
  s.version = '0.1.18'
  s.summary = 'The polyrex-schema gem creates Polyrex XML from an initial shorthand schematic string.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_runtime_dependency('rexle', '~> 1.0', '>=1.0.11') 
  s.signing_key = '../privatekeys/polyrex-schema.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/polyrex-schema'
  s.required_ruby_version = '>= 2.1.2'
end
