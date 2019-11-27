class RateService
    attr_reader :points_acquired

    def initialize(user, group)
      @points_acquired = self.process_data((group - user).abs)
    end

    def process_data(diff)
      self.get_diff(diff)
    end

    def get_diff(diff)
      ranges = [
        [  0,   3, 50],
        [  4,  10, 51],
        [ 11,  17, 52],
        [ 18,  25, 53],
        [ 26,  32, 54],
        [ 33,  39, 55],
        [ 40,  46, 56],
        [ 47,  53, 57],
        [ 54,  61, 58],
        [ 62,  68, 59],
        [ 69,  76, 60],
        [ 77,  83, 61],
        [ 84,  91, 62],
        [ 92,  98, 63],
        [ 99, 106, 64],
        [107, 113, 65],
        [114, 115, 66],
        [116, 129, 67],
        [130, 137, 68],
        [138, 145, 69],
        [146, 153, 70],
        [154, 162, 71],
        [163, 170, 72],
        [171, 179, 73],
        [180, 197, 74],
        [189, 197, 75],
        [198, 206, 76],
        [207, 215, 77],
        [216, 225, 78],
        [226, 235, 79],
        [236, 245, 80],
        [246, 256, 81],
        [257, 267, 82],
        [268, 278, 83],
        [279, 290, 84],
        [291, 302, 85],
        [303, 315, 86],
        [315, 328, 87],
        [329, 344, 88],
        [345, 357, 89],
        [358, 374, 90],
        [375, 391, 91],
        [392, 411, 92],
        [412, 432, 93],
        [433, 456, 94],
        [457, 484, 95],
        [485, 517, 96],
        [518, 559, 97],
        [560, 619, 98],
        [620, 735, 99],
      ]

      for range in ranges do
        puts "diff: #{diff} range[0]: #{range[0]} range[1]: #{range[1]}"
        if diff.between?(range[0], range[1])
          return range[2]
        end
      end

      return 100
    end
end
