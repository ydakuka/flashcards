# For more information about the algorithm SM-2 please visit the website: http://supermemo.com/english/ol/sm2.htm

class SuperMemo
  class << self
    NOT_FALL_BELOW = 1.3
    DISTANCE_LIMIT = 1

    def algorithm(interval, repeat, efactor, attempt, distance)
      quality = set_quality(attempt, distance)
      efactor = set_efactor(efactor, quality)
      sm_hash = if quality >= 3
                  set_interval(interval, repeat + 1, efactor)
                else
                  set_interval(interval, 1, efactor)
                end
      sm_hash.merge!(quality: quality)
    end

    private

    def set_quality(attempt, distance)
      if distance <= DISTANCE_LIMIT
        set_value(attempt, 5, 4, 3)
      else
        set_value(attempt, 2, 1, 0)
      end
    end

    def set_value(value, value_is_equal_one, value_is_equal_two, otherwise_value_is)
      case value
      when 1 then value_is_equal_one
      when 2 then value_is_equal_two
      else otherwise_value_is
      end
    end

    def set_efactor(efactor, quality)
      efactor = efactor + formula_modify_efactor(quality)
      efactor < NOT_FALL_BELOW ? NOT_FALL_BELOW : efactor
    end

    def formula_modify_efactor(quality)
      0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)
    end

    def set_interval(interval, repeat, efactor)
      interval = set_value(repeat, 1, 6, (interval * efactor).round)
      { interval: interval, efactor: efactor, repeat: repeat }
    end
  end
end
