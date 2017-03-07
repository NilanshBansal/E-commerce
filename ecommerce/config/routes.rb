Rails.application.routes.draw do

  get 'signin'=>'authentication#signin'

  get 'signup'=>'authentication#signup'

  get 'logout'=>'authentication#logout'
  get 'signupcheck'=>'authentication#signupcheck'
  get 'signincheck'=>'authentication#signincheck'
  get 'statement'=>'home#statement'
  get 'balance'=>'home#balance'
  get 'dashboard'=>'home#dashboard'
  get 'accountdetails'=>'home#accountdetails'
  get 'accountdetailscheck'=>'home#accountdetailscheck'
  get 'personal'=>'home#personal'
  get 'sell'=>'home#sell'
  get 'sellstore'=>'home#sellstore'
  get '/' => 'home#index'
  put '/dispproducts'=>'home#dispproducts'
end
