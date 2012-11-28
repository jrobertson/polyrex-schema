Gem::Specification.new do |s|
  s.name = 'polyrex-schema'
  s.version = '0.1.7'
  s.summary = 'The polyrex-schema gem creates Polyrex XML from an initial shorthand schematic string.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('rexle')
end
