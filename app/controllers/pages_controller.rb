class PagesController < ApplicationController 
    def home
        redirect_to articles_path if blogger_signed_in?
    end

    def about
    end

end