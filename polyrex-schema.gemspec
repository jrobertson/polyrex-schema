Gem::Specification.new do |s|
  s.name = 'polyrex-schema'
  s.version = '0.1.8'
  s.summary = 'The polyrex-schema gem creates Polyrex XML from an initial shorthand schematic string.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('rexle') 
  s.signing_key = '../privatekeys/polyrex-schema.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
