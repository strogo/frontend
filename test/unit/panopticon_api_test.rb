require 'test_helper'
require 'webmock/test_unit'
require 'panopticon_api'

class PanopticonApiTest < ActiveSupport::TestCase
  ENDPOINT = 'http://panopticon.example'

  def api
    PanopticonApi.new(ENDPOINT)
  end

  test 'Given a slug, should fetch artefact from panopticon' do
    slug = 'an-artefact'
    artefact_json = { name: 'An artefact' }.to_json
    stub_request(:get, "#{ENDPOINT}/artefacts/#{slug}.js").to_return(body: artefact_json) # TODO change to .json in panopticon

    artefact = api.artefact_for_slug(slug)
    assert_equal 'An artefact', artefact.name
  end

  test 'Should fetch and parse JSON into hash' do
    url = "#{ENDPOINT}/some.json"
    stub_request(:get, url).to_return(body: {}.to_json)

    assert_equal Hash, api.get_json(url).class
  end

  test 'Should return nil if 404 returned from endpoint' do
    url = "#{ENDPOINT}/some.json"
    stub_request(:get, url).to_return(status: Rack::Utils.status_code(:not_found))

    assert_nil api.get_json(url)
  end

  test 'Should construct correct URL for a slug' do
    assert_equal "#{ENDPOINT}/artefacts/slug.js", api.url_for_slug('slug') # TODO change to .json in panopticon
  end
end
