class FhirApi

  def self.get_studies_by_patient_id(apikey, patient_id)
    json = RestClient.get( 'http://api.hackathon.siim.org/fhir/ImagingStudy', 
				{:accept => 'application/json', 
				:params => { :apikey => apikey, 'patient_id' => 51 }}
			)
    return JSON.parse(json)
  end

end
