# Algorithm SM-2 used in the computer-based variant of the SuperMemo method and
# involving the calculation of easiness factors for particular items:
# http://www.supermemo.com/english/ol/sm2.htm

class SuperMemo
  class << self
    def algorithm(interval, repeat, efactor, attempt, distance, distance_limit)
      quality = set_quality(attempt, distance, distance_limit)
      efactor = set_efactor(efactor, quality)
      sm_hash = if quality >= 3
                  set_interval(interval, repeat + 1, efactor)
                else
                  set_interval(interval, 1, efactor)
                end
      sm_hash.merge!(quality: quality)
    end

    def set_interval(interval, repeat, efactor)
      interval = case repeat
                 when 1 then 1
                 when 2 then 6
                 else (interval * efactor).round
                 end
      { interval: interval, efactor: efactor, repeat: repeat }
    end

    def set_efactor(efactor, quality)
      efactor = efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      efactor < 1.3 ? 1.3 : efactor
    end

    def set_quality(attempt, distance, distance_limit)
      if distance <= distance_limit
        case attempt
        when 1 then 5
        when 2 then 4
        else 3
        end
      else
        case attempt
        when 1 then 2
        when 2 then 1
        else 0
        end
      end
    end
  end
end
