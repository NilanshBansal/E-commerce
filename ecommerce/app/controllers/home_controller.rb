class HomeController < ApplicationController

	def index
		
	end	

	def accountdetailscheck
		username=params[:username]
		txnpassword=params[:txnpassword]
		balance=params[:balance]
		newaccount=Account.find_by_username(username)

		if not newaccount
			Account.create(:username=>username,:password=>txnpassword,:userid=>session[:userid],:balance=>balance)
			return redirect_to '/dashboard'
		else

			flash[:notice] = "User with this username already exists!!! please enter diff email ..Redirected to signup page-2 again!!!"
			return redirect_to '/accountdetails'   

		end	
	end 

	def accountdetails

	end 		
		
	def dashboard
	end
	
    def statement
	end

	def balance
	end
	
	def personal
		userid=session[:userid]
		@curuser=User.find_by_id(userid)
		@len1=@curuser.password.length
		@curaccount=Account.find_by_userid(@curuser.id)
		@len2=@curaccount.password.length


	end

	def sell


	end

	def sellstore
		name=params[:name]
		price=params[:price]
		color=params[:color]
		category=params[:category]
		qty=params[:qty]
		sellerid=session[:userid]
		description=params[:description]

		oldproduct=Product.find_by(category: category,name: name, color: color)

		Product.create(:name=>name,:color=>color,:price=>price,:category=>category,:qty=>qty,:sellerid=>sellerid,:description=>description)
		
		return redirect_to '/dashboard'		
	end
	
	def dispproducts
		
		@category=params[:category]
		@products=Product.where(:category=>@category) 
	end	

	def addtocart
		userid=session[:userid]
		status="added"
		qty=params[:qty]
		productid=params[:productid]
		addtocartdate=Time.now

		Shopping.create(:userid=>userid,:status=>status,:qty=>qty,:productid=>productid,:addtocartdate=>addtocartdate)

		return redirect_to '/dashboard'
	end	


	def mycart

	end	
end
