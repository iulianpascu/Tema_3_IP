class UserPdf < Prawn::Document

	def initialize(token)
		super()
		text "This is an order token"
		@token = token

		text "Token #{@token.id}"
	end

end
