Rails.application.routes.draw do

  get 'signin'=>'authentication#signin'

  get 'signup'=>'authentication#signup'

  get 'logout'=>'authentication#logout'
  post 'signupcheck'=>'authentication#signupcheck'
  post 'signincheck'=>'authentication#signincheck'
  
  
  get 'dashboard'=>'home#dashboard'
  get 'accountdetails'=>'home#accountdetails'
  post 'accountdetailscheck'=>'home#accountdetailscheck'
  get 'personal'=>'home#personal'
  get 'sell'=>'home#sell'
  post 'sellstore'=>'home#sellstore'
  get '/' => 'home#index'
  post '/dispproducts'=>'home#dispproducts'
  get '/mycart'=>'home#mycart'
  post '/addtocart'=>'home#addtocart'
  post '/edit'=>'home#edit'
  post '/buy'=>'home#buy'
  post '/buyauthentication'=>'home#buyauthentication'
  get '/purchasecomplete'=>'home#purchasecomplete'
  get '/orders'=>'home#orders'
  get '/solditems'=>'home#solditems'
  post '/changeaccountinfo'=>'home#changeaccountinfo'
end
