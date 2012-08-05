
# author: Konstantin Gredeskoul © 2008
# license: public domain
#
require 'net/http'
require 'uri'

module KBB
  MODELS_URL = "http://scripts.kbb.com/kbb/ymmData.axd?VehicleClass=UsedCar"

  class Models
    def initialize(js)   
      @models = {}
      @makes = {}
      n = /ymUsed_\[\d{4}\]\s*=\s*'([^'']+)'/
        m = /ymmUsed_\["(\d+)~(\d+)"\]\s*=\s*"([^""]+)"/
        js.split(/\n/).each do |line|
        next if line.strip.blank?
        if matched = n.match(line)
          matched[1].split(/,/).each do |token|
            id, name = token.split('|')
            @makes[id.to_i] = name
          end
        end

        if matched = m.match(line)
          year, make_id, models = matched[1], matched[2], matched[3]
          models.split(/,/).each do |t| 
            id, model_name = t.split('|')
            make_name = @makes[make_id.to_i]
            @models[make_name] ||= {}
            @models[make_name][model_name] ||= []
            @models[make_name][model_name] << year
          end
        end
        end
    end

    def to_hash
      @models
    end
  end

  class Parser
    def initialize
      @m = Models.new(Net::HTTP.get(URI.parse(MODELS_URL)))
    end
    def to_hash
      @m.to_hash
    end
  end

end
