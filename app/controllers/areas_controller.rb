class AreasController < CrudController
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

  # GET /areas/metrics
  def get_with_metrics
    areas = {}

    Event.where.not(areas: [nil, ""]).collect().each { |ev|
      begin
        areas_to_list = ev.areas.split(",")

        areas_to_list.each { |area|
          areas[area] ||= 0
          areas[area] = areas[area]+1
        }
      rescue
      end
    }

    render json: { data: areas }
  end

  # GET /areas/:username
  def get_from_username
    user = User.find_by_username(params[:username])

    areas = {}

    ids_to_find = []

    user.inscriptions.each { |evt| ids_to_find.push(evt.event_id) }

    Event.where(id: ids_to_find).collect().each { |ev|
      begin
        areas_to_list = ev.areas.split(",")

        areas_to_list.each { |area|
          areas[area] ||= 0
          areas[area] = areas[area]+1
        }
      rescue
      end
    }

    render json: { data: areas }
  end
end
