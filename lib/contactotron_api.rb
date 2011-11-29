require 'open-uri'

class ContactotronApi
  def contact_for_uri(uri)
    to_ostruct data_for_uri(uri)
  end

  private
    def json_for_uri(uri)
      open(uri, 'Accept' => Mime::JSON.to_s).read
    rescue OpenURI::HTTPError
      nil
    end

    def data_for_uri(uri)
      json = json_for_uri(uri)
      ActiveSupport::JSON.decode json if json.present?
    end

    def to_ostruct(object)
      case object
      when Hash
        OpenStruct.new Hash[object.map { |key, value| [key, to_ostruct(value)] }]
      when Array
        object.map { |k| to_ostruct(k) }
      else
        object
      end
    end
end
