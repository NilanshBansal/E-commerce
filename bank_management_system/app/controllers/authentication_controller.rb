class AuthenticationController < ApplicationController
  def signin

  end

  def signup

  end
  
  def signupcheck
    name =params[:name]
  	email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)

     
	if not user
	    	

		  	user=User.create(:name=>params[:name],:email=>params[:email],:password=>params[:password])
		   
		    session[:userid]=user.id

		    flash[:notice] = "User Created!!! ..Redirected to login page!!!"

		    return redirect_to '/signin'
		else
			 flash[:notice] = "User with this email already exists!!! please enter diff email ..Redirected to signup page again!!!"
			return redirect_to '/signup'    
	    end	


	  end  

  def signincheck
 	email=params[:email]
  	password=params[:password]
    
    newuser=User.find_by_email(email)

    if newuser
    	if newuser.password==password
    		session[:userid]=newuser.id
    		return redirect_to '/'  
    	else
    		flash[:notice] = "Enter correct password!!!"
    		return redirect_to '/signin'
    	end	
    else
    	flash[:notice] = "Wrong login email !!! please signup..."
    	return redirect_to '/signup'	
    end

  end
  	
  def logout
  	session[:userid]=nil
  	return redirect_to '/'
  end

end


