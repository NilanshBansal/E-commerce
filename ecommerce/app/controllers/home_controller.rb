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
	
    
	
	def personal
		userid=session[:userid]
		@curuser=User.find_by_id(userid)
		@len1=@curuser.password.length
		@curaccount=Account.find_by_userid(@curuser.id)
		@len2=@curaccount.password.length


	end

	def changeaccountinfo

		flash[:notice]="Changes done successfully"
		
		return redirect_to '/personal'
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
		@curuserid=session[:userid]
		@products=[]
		@shoppings=[]
		status="added"
		
		@products= Product.where(:category=>@category).where.not(:sellerid=>@curuserid).where.not(:qty=>0)

		if @products.length!=0
			@products.each do |curpro| 
				
			temp=Shopping.find_by_userid_and_productid_and_status(@curuserid,curpro.id,status)

		
			if temp
			@shoppings.push(temp)

		    end

		   end	
		else
			@products=[]
			@shoppings=[]
		end	
		
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
		@userid=session[:userid]
		status="added"
		@products=[]
		@shoppings=Shopping.where(:userid=>@userid,:status=>status)
		@accountdetails=Account.find_by_userid(@userid)
		
		
		@shoppings.each do |curshop|

			@products+=Product.where(:id=>curshop.productid)

	    end
	end	



	def edit
		
		qty=params[:qty]
		userid=session[:userid]
		editorder=params[:editorder]
		productid=params[:productid]
		shopping=Shopping.find_by_userid_and_productid(userid,productid)
		
		if shopping
			if editorder=="save edited qty"
				 shopping.qty=qty
				shopping.save

			return redirect_to '/mycart'
			elsif editorder=="remove item"

				shopping.destroy
					
			return redirect_to '/mycart'
			end	
		end	
	end	


	def buy

		@products=params[:products]
		@availbal=params[:availbal]
		@shoppings=params[:shoppings]

	end	

	def buyauthentication
		username=params[:username]
		txnpassword=params[:txnpassword]
		userid=session[:userid]
		
		@availbal=params[:availbal]
		

		curaccount=Account.find_by_userid(userid)


		status="added"
		@products=[]
		@shoppings=Shopping.where(:userid=>userid,:status=>status)
		
		
		
		@shoppings.each do |curshop|

			@products+=Product.where(:id=>curshop.productid)

	    end





		if curaccount.username==username && curaccount.password==txnpassword
			curaccount.balance=@availbal
			curaccount.save
			
			@products.each do |curpro|
				curshop = Shopping.find_by_userid_and_productid_and_status(userid,curpro.id,status)
				curshop.buydate = Time.now
				curshop.status = "bought"
				curpro.qty = curpro.qty-curshop.qty
				curshop.save
				curpro.save	
				
			end

			flash[:notice] = "Transaction Sucessful.."
			
			return redirect_to '/purchasecomplete'
		else
			flash[:notice] = "Transaction Unsucessful..Wrong Username or password"
			
			return redirect_to '/purchasecomplete'
		end	

	end	

	def purchasecomplete

	end	

	def orders
		userid=session[:userid]
		status="bought"	
		@products=[]

		@shoppings=Shopping.where(:userid=>userid,:status=>status)

		@shoppings.each do |curshop|

			@products+=Product.where(:id=>curshop.productid)

	    end
	end

	def solditems
		userid=session[:userid]
		@products=[]

		@products=Product.where(:sellerid=>userid)

	end	

end
