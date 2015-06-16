Gem::Specification.new do |s|
  s.name = 'wiimote_sps'
  s.version = '0.3.0'
  s.summary = 'Uses a Wiimote to publish key presses to a SimplePubSub broker.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/wiimote_sps.rb']
  s.add_runtime_dependency('sps-pub', '~> 0.4', '>=0.4.0')
  s.add_runtime_dependency('sps-sub', '~> 0.2', '>=0.2.0')
  s.add_runtime_dependency('simple_wiimote', '~> 0.3', '>=0.3.3')
  s.signing_key = '../privatekeys/wiimote_sps.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/wiimote_sps'
end
