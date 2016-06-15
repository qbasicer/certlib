require 'rake'

Gem::Specification.new do |s|
  s.name        = 'certlib'
  s.version     = '0.0.4'
  s.date        = '2016-06-13'
  s.summary     = 'Easily deal with certificates'
  s.authors     = ['Cody Harris']
  s.email       = 'qbasicer@gmail.com'
  s.files       = FileList['lib/*.rb', 'lib/certlib/*']
  s.homepage    = 'https://github.com/qbasicer/certlib'
  s.license       = 'MIT'
  s.executables = ['certlib-quickcert']
end
