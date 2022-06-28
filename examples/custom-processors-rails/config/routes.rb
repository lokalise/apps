Rails.application.routes.draw do
  post '/preprocess', to: 'processors#preprocess'
  post '/postprocess', to: 'processors#postprocess'
end
