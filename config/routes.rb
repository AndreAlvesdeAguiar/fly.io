Rails.application.routes.draw do
  get 'moon', to: 'moon#index'
  get 'dados/:codigo_serie', to: 'dados#index'
  get 'dados/:codigo_serie/grafico', to: 'dados#grafico'
  root 'dados#home'

end
