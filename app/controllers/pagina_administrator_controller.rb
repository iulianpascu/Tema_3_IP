class PaginaAdministratorController < ApplicationController

	def pagAdmin
		@cursuri = Curs.all
	end
end
