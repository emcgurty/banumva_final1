require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(:default, Rails.env) if defined?(Bundler)
end


module Petitions

  class Application < Rails::Application
        require 'collaborator_values'
    include CollaboratorValues
    CollaboratorMethods.load_values
config.secret_token = ''
    
  end
end
