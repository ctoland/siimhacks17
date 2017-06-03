require 'digest/sha1'

class FhirApi

  PATIENTMAPPINGS = {
    'siimandy' => 'TCGA-50-5072',
    'siimjoe' => 'TCGA-17-Z058',
    'siimneela' => 'TCGA-BA-4077',
    'siimravi' => 'LIDC-IDRI-0132',
    'siimsally' => 'BreastDx-01-0003'
  }

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
          "View Images" => lambda {|entry| get_images_button(entry)}
        }
      },
      "Patient" => {
        short_view: ["ID","Last Name","First Name", "Birth Date"],
        accessors: {
          "Last Name" => lambda {|entry| (((entry["name"] || []).first  || {})["family"] || []).join(" ")},
          "First Name" => lambda {|entry| (((entry["name"] || []).first || {})["given"] || []).join(" ")}
        }
      },
      "Appointment" => {
        short_view: ["Status", "Start", "Description"],
        accessors: {}
      },
      "BodySite" => {
        short_view: ["Title", "Description"],
        accessors: {
          "Title" => lambda {|entry| (entry["code"] || {})["text"]}
        }
      },
      "Encounter" => {
        short_view: ["Identifier", "Class", "Type A","Type B", "Code"],
        accessors: {
          "Identifier" => lambda {|entry| ((entry["identifier"]||[]).first|| {})["value"]},
          "Type A" => lambda {|entry| ((entry["type"]||[]).first|| {})["text"]},
          "Type B" => lambda {|entry| ((((entry["type"]||[]).first|| {})["coding"]|| []).first ||{})['display']},
          "Code" => lambda {|entry|((((entry["type"]||[]).first|| {})["coding"]|| []).first ||{})['code']}
        }
      },
      "DiagnosticOrder" => {
        short_view: ["Patient", "Ordered By", "Status", "Reason", "Item"],
        accessors: {
          "Patient" => lambda {|entry| self.extract_mrn(entry["subject"]) },
          "Ordered By" => lambda {|entry| (entry["orderer"] || {})["display"]},
          "Reason" => lambda {|entry| (entry["reason"] || {}).map{|r| r["text"]}.join(", ") },
          "Item" => lambda {|entry| entry["item"].map{|r| (r["code"] || {})["text"]}.join(", ") }
        }
      }
    }
  end

  def self.extract_mrn(item={})
    (item["reference"] || "").split("/").last
  end

  def self.get_images_button(entry)
    link = get_link(entry)

    if link
      "<div class='btn btn-default launch-images' data-link=#{link} data-studyuid= data-mrn=#{((entry["patient"] || {})["reference"] || "").split("/").last} data-acc=#{(entry["accession"] || {})["value"]}>View Images</div>".html_safe
    else
      ""
    end
  end

  def self.get_link(entry)
    mrn = extract_mrn(entry["patient"])
    patient_id = PATIENTMAPPINGS[mrn]

    #exit early if no patient id. no way to load images.
    return nil unless patient_id

    #study_uuid = Digest::SHA1.hexdigest "#{patient_id}"
    #attempt to generate study uuids
    study_uuid = Digest::SHA1.hexdigest "#{patient_id}#{entry["uid"].delete("urn:oid:")}"
    study_uuid = study_uuid.scan(/.{1,8}/).join('-')

    #"http://api.hackathon.siim.org/vna/app/explorer.html#patient?uuid=#{study_uuid}"
    #link to the study uuid
    "http://api.hackathon.siim.org/vna/app/explorer.html#study?uuid=#{study_uuid}"
  end

end
