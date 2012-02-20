module HockeyApp
  module Config
    extend self

    ATTRIBUTES = [:token, :base_uri]

    attr_accessor *ATTRIBUTES

    def configure
      yield self
    end

    def to_h
      Hash[ATTRIBUTES.map{|a|[a, self.send("#{a.to_s}")]}]
    end

  end
end