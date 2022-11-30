# frozen_string_literal: true

module Business
  # Business::ProcessDataWithDates
  class ProcessDataWithDates
    class << self
      def call(id, date_start, date_end)
        {
          id: id,
          date_start: date_start.strftime('%s'),
          date_end: date_end.strftime('%s')
        }
      end
    end
  end
end
