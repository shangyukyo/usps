module USPS::Response
  # Response object from a USPS::Request::TrackingLookup request. 
  # Includes a summary of the current status of the shipment, along with
  # an array of details of the shipment's progress
  class InternationalRate < Base


    def initialize(xml)
      puts xml
    end
 
  end
end
