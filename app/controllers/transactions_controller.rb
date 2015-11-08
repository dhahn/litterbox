class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_page_title

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = current_user.transactions.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = current_user.transactions.new(transaction_params)
    @transaction.check_in = Date.strptime(transaction_params[:check_in], '%m/%d/%Y')
    @transaction.check_out = Date.strptime(transaction_params[:check_out], '%m/%d/%Y')
    @transaction.price = @transaction.litter_box.price * @transaction.dates.length

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction.litter_box, notice: 'Successful request. Waiting on purrmission from owner.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        raise @transaction.errors.inspect
        format.html { redirect_to @transaction.litter_box, notice: "You've cat to be kitten me. Those dates are unavailable." }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :litter_box_id, :check_in, :check_out, :price)
    end

    def set_page_title
      @page_title = 'Litterbox - Transaction'
    end
end
