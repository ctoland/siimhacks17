class FhirApi

  def self.get_studies_by_patient_id(apikey, patient_id=nil)
    url = 'http://api.hackathon.siim.org/fhir/ImagingStudy'
    options = {
      :accept => 'application/json',
      :apikey => apikey
    }

    options[:patient_id] = patient_id unless patient_id.nil?

    json = RestClient.get(url, options)

    return JSON.parse(json)
  end

end
