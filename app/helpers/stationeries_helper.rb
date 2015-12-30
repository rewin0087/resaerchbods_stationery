module StationeriesHelper
  def options_for_stationeries
    Stationery.in_stocks.map{|s| ["#{s.name} - #{s.stationery_type}", s.id]}.unshift(['',''])
  end
end
