module USPS::Response
  # Response object from a USPS::Request::TrackingLookup request. 
  # Includes a summary of the current status of the shipment, along with
  # an array of details of the shipment's progress
  class Rate < Base

  	attr_accessor :detail

    def initialize(xml)
      @details = []
      xml.search("Postage").each do |detail|
      	@details << parse(detail)
      end
      
    end
 
		private
		def parse(node)
		 	{
		   :mail_service => node.search('MailService').text,
		   :rate => node.search('Rate').text,
		   :commercial_rate => node.search('CommercialRate').text
		 }
		end
  end
end
