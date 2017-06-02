class AppConfiguration < ActiveRecord::Base

  DEFAULTS = {
    :fhir_url => "http://api.hackathon.siim.org/fhir/",
    :dicomweb_url => "http://api.hackathon.siim.org/dicomweb/",
    :apikey => ENV["APIKEY"] || "your-key-here"
  }

  def self.get_value(key)
    self.get_configuration.get_value(key)
  end

  def get_value(key)
    value = JSON.parse(configuration_json)[key]

    if value.blank? && DEFAULTS.include?(key.to_sym)
      value = DEFAULTS[key.to_sym]
    end

    value
  end


  def self.get_configuration
    self.last || self.load_default_configuration
  end

  private
  def self.load_default_configuration
      config = self.new
      config.configuration_json = JSON.generate(DEFAULTS)
      config.save
      return config
  end
end
