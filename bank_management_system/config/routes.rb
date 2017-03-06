Rails.application.routes.draw do

  get 'signin'=>'authentication#signin'

  get 'signup'=>'authentication#signup'

  get 'logout'=>'authorization#logout'
  get 'signupcheck'=>'authentication#signupcheck'
  get 'signincheck'=>'authentication#signincheck'
  get 'statement'=>'home#statement'
  get 'balance'=>'home#balance'
   get '/' => 'home#index'
 
end
