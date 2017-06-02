class FhirApi

  def self.get_generic(url=nil, options={}, json=true)
    result = RestClient.get(url, options)

    if json
      JSON.parse(result)
    else
      result
    end
  end

  def self.get_studies_by_patient_id(patient_id=nil)
    url = AppConfiguration.get_value("fhir_url") + '/ImagingStudy'
    options = {
      :accept => 'application/json',
      :apikey => AppConfiguration.get_value("apikey"),
      :params => { patient: '51' }
    }

    options[:patient_id] = patient_id unless patient_id.nil?

    json = RestClient.get(url, options)

    return JSON.parse(json)
  end

  def self.get_resource(name)
    FhirApi.resources[params["resource"]][:cols]
  end

  def self.resources
    {
      "ImagingStudy" => {
        short_view: ["Accession", "MRN", "Started", "Procedure Description", "Image Count", "View Images"],
        long_view: [],
        accessors: {
          "Accession" => lambda {|entry| (entry["accession"] || {})["value"]},
          "MRN" => lambda {|entry| ((entry["patient"] || {})["reference"] || "").split("/").last},
          "Procedure Description" => lambda {|entry| entry["description"]},
          "Image Count" => lambda {|entry| entry["numberOfInstances"]},
          "View Images" => lambda {|entry| "<div class='btn btn-default launch-images' data-mrn=#{((entry["patient"] || {})["reference"] || "").split("/").last} data-acc=#{(entry["accession"] || {})["value"]}>View Images</div>".html_safe}
        }
      },
      "Patient" => {
        short_view: ["ID", "Birth Date"],
        accessors: {}
      },
      "Appointment" => {
        short_view: ["Status", "Start", "Description"],
        accessors: {}
      },
      "BodySite" => {
        short_view: ["Title"],
        accessors: {
          "Title" => lambda {|entry| (entry["code"] || {})["text"]}
        }
      }
    }
  end
end
