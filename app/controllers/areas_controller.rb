class AreasController < ApplicationController
  before_action :authorize_request
  # GET /areas
  def index
    areas = []

    Event.where.not(areas: [nil, ""]).collect().each { |ev|
      begin
        areas_to_list = ev.areas.split(",")

        areas_to_list.each { |area|
          if !areas.include? area
            areas.push area
          end
        }
      rescue
      end
    }

    render json: { data: areas }
  end
end
