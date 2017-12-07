require 'parse.rb'

class EmailsController < ApplicationController
  
  	def index
      @emails = Email.all
   	end

    def show
    	@email = Email.find(params[:id])
    	parse_this = Email.find(@email.id).attachment.file.file
    	@parse = Parser.new(parse_this)
 	end
 
   
   def new
      @email = Email.new
   end
   
   def create
      @email = Email.new(email_params)
      
      if @email.save
         redirect_to emails_path, notice: "The file #{@email.name} has been uploaded."
      else
         render "new"
      end
      
   end
   
   def destroy
      @email = Email.find(params[:id])
      @email.destroy
      redirect_to emails_path, notice:  "The file #{@email.name} has been deleted."
   end
   
   private
      def email_params
      params.require(:email).permit(:name, :attachment)
   end
end
