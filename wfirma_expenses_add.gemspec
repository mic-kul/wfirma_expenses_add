$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'wfirma_expenses_add'
  s.version     = '0.0.2'
  s.date        = '2015-10-18'
  s.summary     = "WFirma missing expenses add method"
  s.require_paths = ["lib"]
  s.description = "WFirma missing expenses add method"
  s.authors     = ["Michal Kulesza"]
  s.email       = 'mk@trou.pl'
  s.files       = `git ls-files`.split("\n")
  s.homepage    =
    'http://gitub.com/mic-kul/wfirma_expenses_add'
  s.license       = 'MIT'
  s.add_runtime_dependency 'capybara'
  s.add_runtime_dependency 'poltergeist'
end
