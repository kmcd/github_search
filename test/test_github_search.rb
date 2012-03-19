require 'helper'

class TestGithubSearch < Test::Unit::TestCase
  def setup
    @search = Github::Search.new :type => :user, :query => 'location:UK'
  end
  
  test "should fetch the first page of results" do
    stub_request(:get, "http://github.com:443/search?langOverride=&language=&q=location:UK&type=user").
      with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => user_search_result_page(1), :headers => {})
    
    assert_equal [], @search.results
  end
  
  test "should paginate through all the results" do
    assert_equal 583, @search.results.size
  end
  
  test "should search for UK Rubyists" do
    assert @search.results.all? {|r| r.kind_of?  Rubyist }
    
    aslak = Rubyist.new(:name => 'Aslak')
    assert_equal aslak, @search.results.first
  end
end
