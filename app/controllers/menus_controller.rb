# encoding: utf-8
class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
    respond_to do |format|
      format.text { render text: 'はるちゃん、そうちゃん' }
      format.html
    end
  end

  # GET /menus/select_main_menu.text
  def select_main_menu
    menus = Menu.select_main_menu.sorted_created_at
    menus.offer_count
    
    respond_to do |format|
      format.text { render text: "#{menus[0].id}:16日前に、#{menus[0].name}を作っています。今日あたりどうですか？" }
    end
  end

    # GET /menus/select_sub_menu.text
  def select_sub_menu
    in_menu = Menu.new(menu_params)
    menus = Menu.where(main_id: in_menu.main_id)
    p menus

    sub_menus = menus.map{|menu| menu.name}.join("、")
    p sub_menus

    respond_to do |format|
      format.text { render text: sub_menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu }
        format.text { render text: @menu.id }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :main_id)
    end
end
