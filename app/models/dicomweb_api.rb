class DicomwebApi

  def self.get_studies_by_patient_id(apikey, patient_id)
    json = RestClient.get( 'http://api.hackathon.siim.org/dicomweb/studies', 
				{:accept => 'application/json', 
				:params => { :apikey => apikey, 'patient_id' => 51 }}
			)
    return JSON.parse(json)
  end

end
