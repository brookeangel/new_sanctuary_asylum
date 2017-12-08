# frozen_string_literal: true
class ActivityReport < Report

  def csv_string
    column_headers = ['Event', 'Date', 'Location Name', 'Judge', 'No. of Accompaniments']

    CSV.generate(headers: true) do |csv|
      csv << column_headers

      data.each do |activity|
        row = []
        row << activity.event
        row << activity.occur_at.to_s
        row << activity.location.name
        row << activity.judge.name
        row << activity.accompaniments.count.to_s
        csv << row
      end
    end
  end
 

  private

  def data
    Activity.includes(:location, :judge)
					  .between_dates(start_date, end_date)
					  .order(:occur_at)
  end
end
