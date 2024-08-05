class TaxesController < ApplicationController
  def transform
    tax_service = TaxIdentificationNumberServices.new(country_code: params['country_code'], identification_number: params['identification_number'])
    tax_service.perform

    render json: tax_service.generate_response, status: :ok
  rescue StandardError => error
    render json: { valid: false, errors: [error.class], message: error.message }, status: :bad_request
  end
end
