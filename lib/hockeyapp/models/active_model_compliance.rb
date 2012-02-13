module HockeyApp
  module ActiveModelCompliance
    def to_model
      self
    end
    def persisted?
      true
    end
  end
end