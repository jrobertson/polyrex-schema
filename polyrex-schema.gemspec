Gem::Specification.new do |s|
  s.name = 'polyrex-schema'
  s.version = '0.5.3'
  s.summary = 'The polyrex-schema gem creates Polyrex XML from an ' + 
      'initial shorthand schematic string.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/polyrex-schema.rb']
  s.add_runtime_dependency('rexle', '~> 1.5', '>=1.5.7')
  s.add_runtime_dependency('rexle-builder', '~> 1.0', '>=1.0.2') 
  s.signing_key = '../privatekeys/polyrex-schema.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/polyrex-schema'
  s.required_ruby_version = '>= 2.1.0'
end
