Gem::Specification.new do |s|
  s.name = 'polyrex-schema'
  s.version = '0.5.0'
  s.summary = 'The polyrex-schema gem creates Polyrex XML from an ' + 
      'initial shorthand schematic string.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/polyrex-schema.rb']
  s.add_runtime_dependency('rexle', '~> 1.4', '>=1.4.12')
  s.add_runtime_dependency('rexle-builder', '~> 0.3', '>=0.3.8') 
  s.signing_key = '../privatekeys/polyrex-schema.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/polyrex-schema'
  s.required_ruby_version = '>= 2.1.0'
end
