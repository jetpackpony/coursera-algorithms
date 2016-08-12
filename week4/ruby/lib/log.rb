module GraphSearch
  class Log
    def initialize(output)
      @output = output
      @prev_time = Time.now
    end

    def log(text)
      case @output
      when "puts"
        puts text
      else
      end
      @prev_time = Time.now
    end

    def prev_time
      @prev_time
    end
  end
end
