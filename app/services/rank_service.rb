class RankService
  class << self
    def rank_user_by(rank_key, max = 5)
      case rank_key
      when "most_inscriptions"
        return get_by_inscriptions(max)
      when "most_recommendations"
        return get_by_recommended(max)
      when "most_author"
        return get_by_authored(max)
      when "rate"
        return get_by_rate(max)
      else
        return []
      end
    end

    def get_by_inscriptions(max = 5)
      data = []

      User
        .left_joins(:inscriptions)
        .group(:id)
        .order('COUNT(inscriptions.id) DESC')
        .limit(max)
        .each { |user|
          data.push({
            user: user,
            count: user.inscriptions.length
          })
        }

      sort_dec(data, max)
    end

    def get_by_recommended(max = 5)
      data = []

      User
        .left_joins(:recommendations)
        .group(:id)
        .order('COUNT(recommendations.id) DESC')
        .limit(max)
        .each { |user|
          data.push({
            user: user,
            count: user.recommendations.length
          })
        }

      sort_dec(data, max)
    end

    def get_by_authored(max = 5)
      data = []

      Recommendation.all.group_by(&:author).each { |key, value|
        user = User.find_by_username!(key)

        data.push({
          user: user,
          count: value.length
        })
      }

      sort_dec(data, max)
    end

    def get_by_rate(max = 5)
      data = []

      User.order('rate DESC').limit(max).each { |user|
        data.push({
          user: user,
          count: user.rate
        })
      }

      sort_dec(data, max)
    end

    def sort_dec(data, max)
      data.sort_by { |hsh| -(hsh[:count]) }.take(max)
    end
  end
end
