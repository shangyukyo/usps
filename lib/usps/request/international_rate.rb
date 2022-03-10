module USPS::Request
  # TODO: #send! could be made smarter to send lookup batches
  class InternationalRate < Base
    attr_reader :zip_origination, :zip_destination, :country,
      :pounds, :ounces, :container, :width, :length, :height, :girth, :machinable,
      :mail_type, :value_of_contents, :acceptance_datetime

    config(
      :api => 'IntlRateV2',
      :tag => 'IntlRateV2Request',
      :response => USPS::Response::InternationalRate
    )

    #TODO class id
    CLASSID_MAIL_SERVICES = {
      '1' => 'Priority Mail Express International',
      '2' => 'Priority Mail International',
      '15'  => 'First-Class Package International Service'
    }
    #TODO international rate
    
    def initialize(opts={})
      @zip_origination = opts[:zip_origination]
      @zip_destination = opts[:zip_destination]
      @country = opts[:country]
      @pounds = opts[:pounds]
      @ounces = opts[:ounces]
      @container = opts[:container]
      @width = opts[:width]
      @length = opts[:length]
      @height = opts[:height]
      @girth = opts[:girth]
      @machinable = false  
      @mail_type = opts[:mail_type]      
      @value_of_contents = opts[:value_of_contents]
      @acceptance_datetime = opts[:acceptance_datetime]
    end

    def response_for(xml)
      self.class.response.new(xml)
    end

    def build
      super do |builder|
        builder.tag!('Revision', 2)
        builder.tag!('Package', :ID => 'IST') do           
                         
          builder.tag!('Pounds', @pounds)
          builder.tag!('Ounces', @ounces)
          builder.tag!('Machinable', @machinable)
          builder.tag!('MailType', @mail_type)               
          builder.tag!('ValueOfContents', @value_of_contents)
          builder.tag!('Country', @country)
          builder.tag!('Container', @container)
          builder.tag!('Width', @width)
          builder.tag!('Length', @length)
          builder.tag!('Height', @height)
          builder.tag!('Girth', @girth)
          builder.tag!('OriginZip', @zip_origination)
          builder.tag!('CommercialFlag', 'Y')
          builder.tag!('AcceptanceDateTime', @acceptance_datetime)
          builder.tag!('DestinationPostalCode', @zip_destination)                                        
        end
      end
    end

  end

end
