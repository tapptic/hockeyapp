module HockeyApp
  module ActiveModelCompliance
    def to_model
      self
    end
    def persisted?
      true
    end
    def to_key
      [public_identifier] if persisted?
    end
    def valid?()      true end


    def errors
      obj = Object.new
      def obj.[](key)         [] end
      def obj.full_messages() [] end
      obj
    end
  end
end