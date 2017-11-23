module HockeyApp
    class Statistic
      extend  ActiveModel::Naming
      include ActiveModel::Conversion
  
      ATTRIBUTES = [:crashes, :version, :shortversion]
  
      attr_accessor *ATTRIBUTES
      attr_reader :crashes, :version, :shortversion
  
  
      def self.from_hash(h, app, client)
        res = self.new app, client
        ATTRIBUTES.each do |attribute|
          res.send("#{attribute.to_s}=", h[attribute.to_s]) unless (h[attribute.to_s].nil?)
        end
        res.crashes = h['statistics']['crashes']
        res
      end
  
      def initialize app, client
        @app = app
        @client = client
      end
  
      private
  
      attr_accessor :client
  
  
    end
  end