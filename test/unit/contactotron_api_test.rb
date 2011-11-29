require 'test_helper'
require 'webmock/test_unit'
require 'contactotron_api'

class ContactotronApiTest < ActiveSupport::TestCase
  def api
    ContactotronApi.new
  end

  test 'Given a URI, should fetch contact from contact-o-tron' do
    uri = 'http://contactotron.example/contacts/42'
    contact_json = { name: 'A contact' }.to_json
    stub_request(:get, uri).with(:headers => { 'Accept' => 'application/json' }).to_return(body: contact_json)

    contact = api.contact_for_uri(uri)
    assert_equal 'A contact', contact.name
  end

  test 'Should return nil if 404 returned from endpoint' do
    uri = 'http://contactotron.example/contacts/42'
    stub_request(:get, uri).with(:headers => { 'Accept' => 'application/json' }).to_return(status: Rack::Utils.status_code(:not_found))

    assert_nil api.contact_for_uri(uri)
  end

  def contact_with_phone_numbers_json
    {
      name: 'A contact',
      phone_numbers: [
        { kind: 'phone', value: '01234 567890' },
        { kind: 'fax', value: '01234 567000' }
      ]
    }.to_json
  end

  test 'Phone numbers should be deserialised into whole objects' do
    uri = 'http://contactotron.example/contacts/42'
    contact_json = contact_with_phone_numbers_json
    stub_request(:get, uri).with(:headers => { 'Accept' => 'application/json' }).to_return(body: contact_json)

    contact = api.contact_for_uri(uri)
    assert_equal 'phone', contact.phone_numbers.first.kind
    assert_equal '01234 567000', contact.phone_numbers.second.value
  end
end
