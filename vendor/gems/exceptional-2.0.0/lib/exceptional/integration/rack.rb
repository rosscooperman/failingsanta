module Exceptional
  class Rack
    def initialize(app, api_key)
      @app = app
      @api_key= api_key
    end

    def call(env)
      @app.call(env)
    rescue Exception => e
      raise e
    end
  end
end