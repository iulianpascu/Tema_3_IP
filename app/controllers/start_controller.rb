class StartController < ApplicationController
  def refresh_data
    actualizeaza_grupe
    actualizeaza_profi
  end

  def generate_tokens
  end

  def set_time_frame
  end
  
  def actualizeaza_grupe
    require "net/http"
    require "uri"
    require 'securerandom'
    uri2 = URI.parse("http://dl.dropbox.com/u/74389487/sample_JSON")


  
    # build the params string
    post_args1 = { 'email' => params[:email] }
    # send the request
    resp, data = Net::HTTP.post_form(uri2, post_args1)


    # http = Net::HTTPS.new(uri.host, uri.port)
    # request = Net::HTTPS::Post.new(uri.request_uri)
    # # request.set_form_data({"email_login" => "user@email.com", "password_login" => "password"})
    # @response = http.request(request)
    # # @response = Net::HTTPS::Post. 
    @grupe = JSON.load data
    @grupe.each do |g|
      (1..g["studenti"]).each { |i| TokenUser.create( :grupa => g["grupa"], :token => SecureRandom.hex) }
    end
    @tokens = TokenUser.all
  end
  
  def actualizeaza_profi
    require "net/https"
    require "uri"
    uri = URI.parse("http://dl.dropbox.com/u/74389487/lista_profi_grupe_JSON")


  
    # build the params string
    post_args1 = { 'email' => params[:email] }
    # send the request
    resp, data = Net::HTTP.post_form(uri, post_args1)


    # http = Net::HTTPS.new(uri.host, uri.port)
    # request = Net::HTTPS::Post.new(uri.request_uri)
    # # request.set_form_data({"email_login" => "user@email.com", "password_login" => "password"})
    # @response = http.request(request)
    # # @response = Net::HTTPS::Post. 
    @cursuri = JSON.load data
  end
end
