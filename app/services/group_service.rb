class GroupService
    attr_reader :computed

    def initialize(data)
      @raw = data

      @computed = self.process_data()
    end

    def process_data
        self.get_groups(
            @raw.sort { |a, b| b.user.rate<=>a.user.rate },
            self.get_group_number
        )
    end

    def get_groups(arr, max, balance_count = 0)
      groups = []

      asc_index = 0
      dec_index = arr.length - 1

      flow = 'asc'

      while(asc_index < max) do
        item = arr[asc_index]

        groups.push(OpenStruct.new({
          rate: item.user.rate,
          members: [item]
        }))

        asc_index += 1
      end

      should_run_again = true

      flow = 'dec'

      while (should_run_again) do
        for index in 0..groups.length-1 do
          if dec_index < asc_index
            break
          elsif flow === 'dec'
            groups[index].members.push(arr[dec_index])
            dec_index-=1
          else
            groups[index].members.push(arr[asc_index])
            asc_index+=1
          end

          groups[index].rate = self.get_medium_rate(groups[index])
        end

        flow = flow === 'dec' ? 'asc' : 'dec'

        balance_result = self.check_balance_rate(groups, 400)

        if (balance_result.is_unbalanced && balance_count < 3)
          groups = self.balance_groups(
            groups,
            balance_result.bigger,
            balance_result.lesser,
            balance_result.balance_count
          )
        end

        should_run_again = !(dec_index < asc_index)
      end

      groups
    end

    def balance_groups(groups_raw, biggerIndex, lesserIndex, balance_count = 0)
      groups = groups_raw

      bigger = groups[bigger_index]
      lesser = groups[lesser_index]

      if (bigger.members.length === lesser.members.length)
        lesser.members = lesser.members.sort { |a, b| b.user.rate<=>a.user.rate }

        bigger_popped = bigger.members.pop()
        lesser_popped = lesser.members.pop()

        bigger.members.push(lesser_popped)
        lesser.members.push(bigger_popped)

        groups[bigger_index] = bigger
        groups[lesser_index] = lesser

        groups[bigger_index] = self.get_medium_rate(groups[bigger_index])
        groups[lesser_index] = self.get_medium_rate(groups[lesser_index])
      else
        concated_array = lesser.members
                               .concat(bigger.members)
                               .sort { |a, b| a.user.rate<=>b.user.rate }

        balanced_result = self.get_groups(concated_array, 2, balance_count + 1)

        groups[bigger_index] = balance_result[0]
        groups[lesser_index] = balance_result[1]
      end

      groups
    end

    def check_balance_rate(groups, rate_rule)
      bigger = nil
      lesser = nil

      for count in 1..groups.length do
        index = count - 1

        if bigger.class == NilClass || groups[bigger].rate < groups[index].rate
          bigger = index
        end

        if lesser.class == NilClass || groups[lesser].rate > groups[index].rate
          lesser = index
        end
      end

      return OpenStruct.new({
        is_unbalanced: (groups[bigger].rate - groups[lesser].rate) > rate_rule,
        bigger: bigger,
        lesser: lesser,
      })
    end

    def get_group_number
        len = @raw.length.even? ? @raw.length : @raw.length - 1

        magic_number = len <= 10 ? len : (len/2) - 1

        while ((len/magic_number).to_i < 2) do
            magic_number -= 1
        end

        magic_number.to_i
    end

    def get_medium_rate(group)
      new_group = group.clone

      rate = 0

      for inscription in group.members
        rate += inscription.user.rate
      end

      new_group.rate = rate/group.members.length
    end
end
