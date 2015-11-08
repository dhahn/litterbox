class LitterBoxesController < ApplicationController
  before_action :set_litter_box, only: [:show, :edit, :update, :destroy]

  # GET /litter_boxes
  # GET /litter_boxes.json
  def index
    @litter_boxes = LitterBox.all
  end

  # GET /litter_boxes/1
  # GET /litter_boxes/1.json
  def show
  end

  # GET /litter_boxes/new
  def new
    @litter_box = LitterBox.new
  end

  # GET /litter_boxes/1/edit
  def edit
  end

  # POST /litter_boxes
  # POST /litter_boxes.json
  def create
    @litter_box = LitterBox.new(special_litter_box_params)
    @litter_box.user = current_user

    respond_to do |format|
      if @litter_box.save
        format.html { redirect_to @litter_box, notice: 'Litter box was successfully created.' }
        format.json { render :show, status: :created, location: @litter_box }
      else
        format.html { render :new }
        format.json { render json: @litter_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /litter_boxes/1
  # PATCH/PUT /litter_boxes/1.json
  def update
    respond_to do |format|
      if @litter_box.update(special_litter_box_params)
        format.html { redirect_to @litter_box, notice: 'Litter box was successfully updated.' }
        format.json { render :show, status: :ok, location: @litter_box }
      else
        format.html { render :edit }
        format.json { render json: @litter_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /litter_boxes/1
  # DELETE /litter_boxes/1.json
  def destroy
    @litter_box.destroy
    respond_to do |format|
      format.html { redirect_to litter_boxes_url, notice: 'Litter box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_litter_box
      @litter_box = LitterBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def litter_box_params
      params.require(:litter_box).permit(:price, :capacity, :description, :city, :state,
        :address_line_1, :address_line_2, :zip, :number_of_adults,
        :number_of_children, :number_of_pets, :name, :photo,
        unavailabilities_attributes: [:id, :start_time, :end_time, :_destroy])
    end

    def special_litter_box_params
      temp = litter_box_params
      temp.fetch(:unavailabilities_attributes) { [] }.each do |_, hash|
        if /\d{2}\/\d{2}\/\d{4}/ =~ hash[:start_time]
          hash[:start_time] = Date.strptime(hash[:start_time], '%m/%d/%Y')
        end

        if /\d{2}\/\d{2}\/\d{4}/ =~ hash[:end_time]
          hash[:end_time] = Date.strptime(hash[:end_time], '%m/%d/%Y')
        end
      end
      temp
    end
end
