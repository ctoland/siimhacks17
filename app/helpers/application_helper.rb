module ApplicationHelper
  def get_image_url(url, seriesUID, instanceUID)

    seriesUID = seriesUID.delete("urn:oid")
    instanceUID = instanceUID.delete("urn:oid")

    "#{url}/series/#{seriesUID}/instances/#{instanceUID}/frames/1"
  end
end
