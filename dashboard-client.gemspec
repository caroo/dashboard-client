# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dashboard-client}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pkw.de Development Team"]
  s.date = %q{2011-07-06}
  s.description = %q{This library is used to send monitoring data from the applications to the dashboard service.}
  s.email = %q{dev@pkw.de}
  s.executables = ["dashboard"]
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["Gemfile", "README.markdown", "Rakefile", "VERSION", "bin/dashboard", "dashboard-client.gemspec", "dashboardrc.sample", "lib/dashboard-client.rb", "lib/dashboard.rb", "lib/dashboard/client.rb", "lib/dashboard/config.rb", "lib/dashboard/plugin.rb", "lib/dashboard/plugins.rb", "lib/dashboard/plugins/clock.rb", "lib/dashboard/plugins/code_coverage.rb", "lib/dashboard/plugins/cpu_usage.rb", "lib/dashboard/plugins/disk_usage.rb", "lib/dashboard/plugins/hudson.rb", "lib/dashboard/plugins/load_averages.rb", "lib/dashboard/plugins/pkwde_live_data.rb", "lib/dashboard/plugins/resque_stats.rb", "lib/dashboard/plugins/yahoo_weather.rb", "lib/dashboard/report.rb", "lib/dashboard/version.rb", "lib/dashboard/xt/numeric.rb", "test/dashboard/config_test.rb", "test/dashboard/plugins/disk_usage_test.rb", "test/dashboard/plugins/hudson_test.rb", "test/dashboard/plugins/load_averages_test.rb"]
  s.homepage = %q{http://pkw.de}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Client library for the dashboard service}
  s.test_files = ["test/dashboard/config_test.rb", "test/dashboard/plugins/disk_usage_test.rb", "test/dashboard/plugins/hudson_test.rb", "test/dashboard/plugins/load_averages_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spruz>, ["~> 0.2.8"])
      s.add_runtime_dependency(%q<dslkit>, ["~> 0.2.6"])
      s.add_runtime_dependency(%q<json>, ["~> 1.5.3"])
      s.add_runtime_dependency(%q<cpu>, ["~> 0.0.1"])
      s.add_runtime_dependency(%q<yahoo_weatherman>, ["~> 1.1.3"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.9"])
      s.add_runtime_dependency(%q<resque>, ["= 1.17.1"])
      s.add_development_dependency(%q<rake>, ["= 0.9.2"])
      s.add_development_dependency(%q<sdoc>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, ["= 2.3.0"])
      s.add_development_dependency(%q<mocha>, ["= 0.9.12"])
    else
      s.add_dependency(%q<spruz>, ["~> 0.2.8"])
      s.add_dependency(%q<dslkit>, ["~> 0.2.6"])
      s.add_dependency(%q<json>, ["~> 1.5.3"])
      s.add_dependency(%q<cpu>, ["~> 0.0.1"])
      s.add_dependency(%q<yahoo_weatherman>, ["~> 1.1.3"])
      s.add_dependency(%q<activerecord>, ["~> 3.0.9"])
      s.add_dependency(%q<resque>, ["= 1.17.1"])
      s.add_dependency(%q<rake>, ["= 0.9.2"])
      s.add_dependency(%q<sdoc>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<test-unit>, ["= 2.3.0"])
      s.add_dependency(%q<mocha>, ["= 0.9.12"])
    end
  else
    s.add_dependency(%q<spruz>, ["~> 0.2.8"])
    s.add_dependency(%q<dslkit>, ["~> 0.2.6"])
    s.add_dependency(%q<json>, ["~> 1.5.3"])
    s.add_dependency(%q<cpu>, ["~> 0.0.1"])
    s.add_dependency(%q<yahoo_weatherman>, ["~> 1.1.3"])
    s.add_dependency(%q<activerecord>, ["~> 3.0.9"])
    s.add_dependency(%q<resque>, ["= 1.17.1"])
    s.add_dependency(%q<rake>, ["= 0.9.2"])
    s.add_dependency(%q<sdoc>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<test-unit>, ["= 2.3.0"])
    s.add_dependency(%q<mocha>, ["= 0.9.12"])
  end
end
