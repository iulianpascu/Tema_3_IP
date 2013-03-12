class GrupasController < ApplicationController
  # GET /grupas
  # GET /grupas.json
  def index
    @grupas = Grupa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grupas }
    end
  end

  # GET /grupas/1
  # GET /grupas/1.json
  def show
    @grupa = Grupa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grupa }
    end
  end

  # GET /grupas/new
  # GET /grupas/new.json
  def new
    @grupa = Grupa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grupa }
    end
  end

  # GET /grupas/1/edit
  def edit
    @grupa = Grupa.find(params[:id])
  end

  # POST /grupas
  # POST /grupas.json
  def create
    @grupa = Grupa.new(params[:grupa])

    respond_to do |format|
      if @grupa.save
        format.html { redirect_to @grupa, notice: 'Grupa was successfully created.' }
        format.json { render json: @grupa, status: :created, location: @grupa }
      else
        format.html { render action: "new" }
        format.json { render json: @grupa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grupas/1
  # PUT /grupas/1.json
  def update
    @grupa = Grupa.find(params[:id])

    respond_to do |format|
      if @grupa.update_attributes(params[:grupa])
        format.html { redirect_to @grupa, notice: 'Grupa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @grupa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupas/1
  # DELETE /grupas/1.json
  def destroy
    @grupa = Grupa.find(params[:id])
    @grupa.destroy

    respond_to do |format|
      format.html { redirect_to grupas_url }
      format.json { head :no_content }
    end
  end
end
