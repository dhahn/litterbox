class UnavailabilitiesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: dates }
    end
  end

  private

  def dates
    transaction_dates | unavailability_dates
  end

  def transaction_dates
    Transaction.where('check_out >= ?', Date.today)
      .map(&:dates).reduce(:|).select { |d| d >= Date.today }
  end

  def unavailability_dates
    Unavailability.where('end_time >= ?', Date.today)
      .map(&:dates).reduce(:|).select { |d| d >= Date.today }
  end
end
