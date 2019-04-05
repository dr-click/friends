require 'uri'

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid_url?(value)
      record.errors.add(attribute, "is not a valid URI")
    end
  end

  #######
  private
  #######

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

end
