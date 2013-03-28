class TokenUsersController < ApplicationController
  # GET /token_users
  # GET /token_users.json
  def index
    @token_users = TokenUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @token_users }
    end
  end

  # GET /token_users/1
  # GET /token_users/1.json
  def show
    @token_user = TokenUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @token_user }
    end
  end

  # GET /token_users/new
  # GET /token_users/new.json
  def new
    @token_user = TokenUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @token_user }
    end
  end

  # GET /token_users/1/edit
  def edit
    @token_user = TokenUser.find(params[:id])
  end

  # POST /token_users
  # POST /token_users.json
  def create
    @token_user = TokenUser.new(params[:token_user])

    respond_to do |format|
      if @token_user.save
        format.html { redirect_to @token_user, :notice => 'Token user was successfully created.' }
        format.json { render :json => @token_user, :status => :created, :location => @token_user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @token_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /token_users/1
  # PUT /token_users/1.json
  def update
    @token_user = TokenUser.find(params[:id])

    respond_to do |format|
      if @token_user.update_attributes(params[:token_user])
        format.html { redirect_to @token_user, :notice => 'Token user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @token_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /token_users/1
  # DELETE /token_users/1.json
  def destroy
    @token_user = TokenUser.find(params[:id])
    @token_user.destroy

    respond_to do |format|
      format.html { redirect_to token_users_url }
      format.json { head :no_content }
    end
  end
end
