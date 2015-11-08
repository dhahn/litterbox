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

  def unavail_params
    params.permit(:litter_box_id)
  end

  def transaction_dates
    Transaction.where(unavail_params).where('check_out >= ?', Date.today)
      .map(&:dates).reduce([], :|).select { |d| d >= Date.today }
  end

  def unavailability_dates
    Unavailability.where(unavail_params).where('end_time >= ?', Date.today)
      .map(&:dates).reduce([], :|).select { |d| d >= Date.today }
  end
end
