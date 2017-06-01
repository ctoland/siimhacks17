class DicomwebApi

  def self.get_studies_by_patient_id(apikey, patient_id=nil)
    options = {
      :accept => 'application/json',
      :apikey => apikey
    }

    options[:patient_id] = patient_id unless patient_id.nil?

    json = RestClient.get('http://api.hackathon.siim.org/fhir/ImagingStudy', options)

    return JSON.parse(json)
  end

end
