// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function main(){

	var balance_form = document.getElementById("change_balance");
	var removeitemcartbtn=document.getElementsByClassName("removeitemcartbtn");
	var addtocartform=document.getElementsByClassName("addtocartform");
	var itemsdisplay=document.getElementsByClassName("itemsdisplay");
	var makepaymentbtn=document.getElementById("makepaymentbtn");
	var editqtyform=document.getElementsByClassName("editqtyform");
	var grandtotaldiv=document.getElementById("grandtotaldiv");
					
	if(balance_form){
		balance_form.addEventListener("submit", function(event){
			event.preventDefault();
			var container = document.getElementById("balance")
			if(container.children.length == 0)
			{	var input_box = document.createElement("input")
				input_box.placeholder = "Enter Transaction Password";
				input_box.type="password"
				input_box.style.width="200px"
				var submit_button = document.createElement('button')
				submit_button.style.height = '25px'
				submit_button.style.width = '100px'
				submit_button.innerHTML = "Submit"
				container.appendChild(input_box)
				container.appendChild(submit_button)
			}
			var status = document.getElementById("balance_notice")
			submit_button.addEventListener('click', function(){
				var url = '/changeaccountinfo'
				var info = {
					balance: balance_form[0].value,
					password: input_box.value
				}

				$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(data){
						
						balance_form[0].value = data.newBalance
						while (container.hasChildNodes()) {
   						 container.removeChild(container.lastChild);
						}
						
						if(data.status == false)
							status.innerHTML = "Wrong Passoword"
						else
							status.innerHTML = "Changes Done Succesfully"
					},
					error: function(){	
						alert("Error");
					}
				})	
			})
			
		})
	}

	if(removeitemcartbtn){
		for(var i =0;i<removeitemcartbtn.length;i++)
		{
			removeitemcartbtn[i].addEventListener("click", function(event){
			
			event.preventDefault();
			
			var liitem = this.parentElement.parentElement
			var parent = liitem.parentElement
			var item_id = this.id
			var currentitemtotal=parseInt(liitem.childNodes[20].innerHTML);
			var grandtotal=parseInt(grandtotaldiv.innerHTML);
			if(makepaymentbtn)
				var hiddencontainer=makepaymentbtn.nextElementSibling.nextElementSibling.nextElementSibling;

			var  url='/removeitemcart/ajax'
			var info={
				itemid:item_id
			}

			$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(data){
						
						parent.removeChild(liitem);	
						grandtotal=grandtotal-currentitemtotal;
						
						grandtotaldiv.innerHTML=grandtotal;
						availbal=data.accountbal-grandtotal;
						
						if(makepaymentbtn)
						hiddencontainer.value=availbal;


						
					},
					error: function(){	
						alert("Error");
					}
				})
			})
		}
		
			
		
	}

	if(addtocartform){
		for(var i=0;i<addtocartform.length;i++)
		{
			addtocartform[i].addEventListener("submit",function(event){
			event.preventDefault();	
			
			var appendgotocartajaxcontainer=this.nextElementSibling;
			var gotocartlink = document.createElement('a');
			appendgotocartajaxcontainer.id="dispproductsgotocartbtn";
			var linkText = document.createTextNode("GO TO CART");
			gotocartlink.appendChild(linkText);
			gotocartlink.href= "/mycart";
			gotocartlink.title="GO TO CART";
			
			appendgotocartajaxcontainer.appendChild(gotocartlink);
			var item_id = this.id;
			var qty=this.childNodes[1].value;
			var child = this.parentElement;
			var parent = child.parentElement
			var form=child.childNodes[19];
			



			
			var  url='/addtocart/ajax'
			var info={
				itemid:item_id,
				qty:qty
			}
			

			$.ajax({
					url: url,
					method: 'post',
					data: info,
					success: function(data){
					
						form.parentElement.removeChild(form);
						
					},
					error: function(){	
						alert("Error");
					}
				})
			})		
		}
	}

	if(editqtyform)
	{
		for(var i=0;i<editqtyform.length;i++)
		{
			editqtyform[i].addEventListener("submit",function(event){
				event.preventDefault();
				console.log("through ajax");
				var parent=this.parentElement;
				var qtyadded=this.firstElementChild.value;
				var item_id=this.lastElementChild.value;
				var priceofitem=parseInt(parent.childNodes[5].innerHTML);
				var grandtotal=parseInt(grandtotaldiv.innerHTML);
				var oldtotalcuritem=parseInt(parent.childNodes[20].innerHTML);
				var totalcuritemcontainer=parent.childNodes[20];
				var oldqty;
				var diffqty;
				var availbal;
				if(makepaymentbtn)
				{	var hiddencontainer=makepaymentbtn.nextElementSibling.nextElementSibling.nextElementSibling;
					availbal=parseInt(hiddencontainer.value);
					
				}
				var  url='/saveeditedqty/ajax'
				var info={
				itemid:item_id,
				qtyadded:qtyadded
				}

				$.ajax({
					url:url,
					method:'post',
					data:info,
					success: function(data){
						
						oldqty=data.oldqty;
						
						diffqty=oldqty-qtyadded;
						
						grandtotal=grandtotal-(diffqty*priceofitem);
						
						grandtotaldiv.innerHTML=grandtotal;
						totalcuritemcontainer.innerHTML=priceofitem*qtyadded;
						availbal=data.accountbal-grandtotal;
						if(makepaymentbtn)
						hiddencontainer.value=availbal;


					},
					error: function(){
						alert("error");
					}
				})

			})

		}
	}	


}	



window.addEventListener("load", function(){
	main();
})