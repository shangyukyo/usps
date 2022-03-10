module USPS::Request
  # TODO: #send! could be made smarter to send lookup batches
  class Rate < Base
    attr_reader :service, :first_class_mail_type, :zip_origination, :zip_destination, 
      :pounds, :ounces, :container, :width, :length, :height, :girth, :machinable

    config(
      :api => 'RateV4',
      :tag => 'RateV4Request',
      :response => USPS::Response::Rate
    )

    
    def initialize(opts={})
      @service = opts[:service]
      @first_class_mail_type = opts[:first_class_mail_type]          
      @zip_origination = opts[:zip_origination]
      @zip_destination = opts[:zip_destination]
      @pounds = 0
      @ounces = opts[:ounces]
      @container = opts[:container]
      @width = opts[:width]
      @length = opts[:length]
      @height = opts[:height]
      @girth = opts[:girth]
      @signature_option = opts[:signature_option]
      if opts[:service] =~ /First/
        @machinable = true
      else
        @machinable = false
      end
        
    end

    def response_for(xml)
      self.class.response.new(xml)
    end

    def build
      super do |builder|
        builder.tag!('Revision', 2)
        builder.tag!('Package', :ID => 'IST') do 
          builder.tag!('Service', @service)
          builder.tag!('FirstClassMailType', @first_class_mail_type)          
          builder.tag!('ZipOrigination', @zip_origination)
          builder.tag!('ZipDestination', @zip_destination)
          builder.tag!('Pounds', @pounds)
          builder.tag!('Ounces', @ounces)
          builder.tag!('Container', @container)
          builder.tag!('Width', @width)
          builder.tag!('Length', @length)
          builder.tag!('Height', @height)
          builder.tag!('Girth', @girth)

          if @signature_option.present?
            builder.tag!('SpecialServices') do 
              build_signature_option_service(builder)
            end          
          end

          builder.tag!('Machinable', @machinable)
        end
      end
    end

    def build_signature_option_service(builder)
      builder.tag!('SpecialService', '108')
    end
  end

end
