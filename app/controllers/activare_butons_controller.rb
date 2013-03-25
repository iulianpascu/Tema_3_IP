class ActivareButonsController < ApplicationController
  # GET /activare_butons
  # GET /activare_butons.json
  def index
    @activare_butons = ActivareButon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activare_butons }
    end
  end

  # GET /activare_butons/1
  # GET /activare_butons/1.json
  def show
    @activare_buton = ActivareButon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activare_buton }
    end
  end

  # GET /activare_butons/new
  # GET /activare_butons/new.json
  def new
    @activare_buton = ActivareButon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activare_buton }
    end
  end

  # GET /activare_butons/1/edit
  def edit
    @activare_buton = ActivareButon.find(params[:id])
  end

  # POST /activare_butons
  # POST /activare_butons.json
  def create
    @activare_buton = ActivareButon.new(params[:activare_buton])

    respond_to do |format|
      if @activare_buton.save
        format.html { redirect_to @activare_buton, notice: 'Activare buton was successfully created.' }
        format.json { render json: @activare_buton, status: :created, location: @activare_buton }
      else
        format.html { render action: "new" }
        format.json { render json: @activare_buton.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activare_butons/1
  # PUT /activare_butons/1.json
  def update
    @activare_buton = ActivareButon.find(params[:id])

    respond_to do |format|
      if @activare_buton.update_attributes(params[:activare_buton])
        format.html { redirect_to @activare_buton, notice: 'Activare buton was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activare_buton.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activare_butons/1
  # DELETE /activare_butons/1.json
  def destroy
    @activare_buton = ActivareButon.find(params[:id])
    @activare_buton.destroy

    respond_to do |format|
      format.html { redirect_to activare_butons_url }
      format.json { head :no_content }
    end
  end
end
