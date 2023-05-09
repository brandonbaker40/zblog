class CheckCsvHeadersService
  include CsvHeaderValidator

  require 'csv'
  require 'open-uri'

  def initialize(s3_url, report)
    @report = report
    @s3_url = s3_url
  end

  def call
    CSV.parse(URI.open(@s3_url), liberal_parsing: true, headers: true, header_converters: :symbol).each_with_index do |row, index|
      if index == 0

        valid_headers = {
          :webpt_documented_units => CsvHeaderValidator::WEBPT_DOCUMENTED_UNITS_REPORT_CSV_HEADERS,
          :ais_visit_history => CsvHeaderValidator::AIS_VISIT_HISTORY_REPORT_CSV_HEADERS
        }

        if valid_headers[@report.to_sym] == row.to_h.keys
          return true
        else
          return false
        end

      end
    end
  end
end
