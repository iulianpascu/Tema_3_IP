class StaticPagesController < ApplicationController

	def home


    respond_to do |format|
      format.html # home.html.erb

      format.pdf do
				pdf = UserPdf.new()
				send_data pdf.render, filename:
					"Token_test.pdf",
				type: "application/pdf"
				#disposition: "inline"
			end
    end

	end

end
