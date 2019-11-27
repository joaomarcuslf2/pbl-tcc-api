class RanksController < ApplicationController
  def index
    @rank = {
      most_inscriptions:      RankService.rank_user_by("most_inscriptions"),
      most_recommendations:   RankService.rank_user_by("most_recommendations"),
      rate:                   RankService.rank_user_by("rate"),
      most_author:            RankService.rank_user_by("most_author"),
    }

    @rank[:min_length] = @rank[:most_author].length

    @rank[:min_length] = @rank[:most_inscriptions].length < @rank[:min_length] ? @rank[:most_inscriptions].length : @rank[:min_length]
    @rank[:min_length] = @rank[:most_recommendations].length < @rank[:min_length] ? @rank[:most_recommendations].length : @rank[:min_length]
    @rank[:min_length] = @rank[:rate].length < @rank[:min_length] ? @rank[:rate].length : @rank[:min_length]

    render json: { data: @rank }, status: :ok
  end
end
