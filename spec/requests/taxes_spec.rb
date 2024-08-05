require 'rails_helper'

RSpec.describe "Taxes", type: :request do
  describe "GET /transform" do
    context "when Australian number" do
      context "with a valid input string unformatted" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '12345678912', country_code: 'AU' }

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to eq('12 345 678 912')
        end
      end

      context "with a valid input string formatted" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '12 345 678 912', country_code: 'AU' }

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to eq('12 345 678 912')
        end
      end

      context "with an invalid input string" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '1234567892', country_code: 'AU' }

          expect(response).to have_http_status(:bad_request)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to be_nil
        end
      end
    end

    context "when Canadian number" do
      context "with a valid input string unformatted" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '123456789', country_code: 'CA' }

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to eq('123456789RT00001')
        end
      end

      context "with a valid input string formatted" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '123456789RT00001', country_code: 'CA' }

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to eq('123456789RT00001')
        end
      end

      context "with an invalid input string" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '12345679', country_code: 'CA' }

          expect(response).to have_http_status(:bad_request)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to be_nil
        end
      end
    end

    context "when Indian number" do
      context "with a valid input string formatted" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '22AAAAA0000A1Z5', country_code: 'IN' }

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to eq('22AAAAA0000A1Z5')
        end
      end

      context "with an invalid input string" do
        it "returns the transformed string" do
          get '/transform', params: { identification_number: '22AAAA00001Z', country_code: 'IN' }

          expect(response).to have_http_status(:bad_request)
          expect(response.content_type).to include('application/json')
          expect(JSON.parse(response.body)['formatted_tin']).to be_nil
        end
      end
    end
  end
end
