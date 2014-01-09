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
config.secret_token = 'c7ddjhdu5b6374e8a08639411cf95f9722b7e115849ae902fbe0c8a80bc26d0871d1c5a24439555sdfsddf5d21369'
    
  end
end
