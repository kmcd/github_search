require "rubygems"
require "bundler"
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "test/unit"
require "test_declarative"
require "turn"
require "webmock"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "github_search"

class Test::Unit::TestCase
  include WebMock::API
  
  def stub_api_request(method, path)
    stub_request(method, "http://github.com:443#{path}")
  end
  
  def user_search_result_page(number)
    File.open("./test/fixtures/user_search_results_#{number.to_s}.html").read
  end
end
